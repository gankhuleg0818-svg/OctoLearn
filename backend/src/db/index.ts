import pg from 'pg';

/** Minimal query surface shared by the pool and a transaction client. */
export interface Queryable {
  query<T = Record<string, unknown>>(sql: string, params?: unknown[]): Promise<T[]>;
}

export interface Db extends Queryable {
  /** Runs `fn` inside a transaction; rolls back if it throws. */
  tx<T>(fn: (q: Queryable) => Promise<T>): Promise<T>;
  /** Executes a multi-statement SQL script (migrations). */
  exec(sql: string): Promise<void>;
  close(): Promise<void>;
}

export interface CreateDbOptions {
  /** Schema to work in instead of public (tests use a throwaway one each). */
  schema?: string;
}

export function createDb(connectionString: string, opts: CreateDbOptions = {}): Db {
  // Return int8 (e.g. count(*)) as JS numbers — our values are far below 2^53.
  pg.types.setTypeParser(pg.types.builtins.INT8, (v) => Number(v));
  const pool = new pg.Pool({
    connectionString,
    max: 10,
    ...(opts.schema ? { options: `-c search_path=${opts.schema}` } : {}),
  });

  return {
    async query(sql, params) {
      const res = await pool.query(sql, params as unknown[]);
      return res.rows;
    },
    async tx(fn) {
      const client = await pool.connect();
      try {
        await client.query('BEGIN');
        // Repositories may Promise.all() over one client; a single connection runs
        // one query at a time, so chain them instead of overlapping calls.
        let last: Promise<unknown> = Promise.resolve();
        const result = await fn({
          async query(sql, params) {
            const run = last.then(() => client.query(sql, params as unknown[]));
            last = run.catch(() => undefined);
            return (await run).rows;
          },
        });
        await client.query('COMMIT');
        return result;
      } catch (err) {
        await client.query('ROLLBACK');
        throw err;
      } finally {
        client.release();
      }
    },
    async exec(sql) {
      await pool.query(sql);
    },
    async close() {
      await pool.end();
    },
  };
}
