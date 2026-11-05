import 'dotenv/config';
import { randomBytes } from 'node:crypto';
import pg from 'pg';
import { createDb, type Db } from '../src/db/index.js';

/**
 * A database for one test file: a throwaway schema in the PostgreSQL from
 * TEST_DATABASE_URL (or DATABASE_URL), dropped again on close. Files run in
 * parallel without seeing each other's data, and real tables are untouched.
 */
export async function createTestDb(): Promise<Db> {
  const url = process.env.TEST_DATABASE_URL || process.env.DATABASE_URL;
  if (!url) throw new Error('Tests need PostgreSQL: set TEST_DATABASE_URL or DATABASE_URL (see .env.example).');

  const schema = `test_${randomBytes(6).toString('hex')}`;
  const admin = new pg.Client({ connectionString: url });
  await admin.connect();
  await admin.query(`CREATE SCHEMA ${schema}`);
  await admin.end();

  const db = createDb(url, { schema });
  return {
    ...db,
    async close() {
      await db.exec(`DROP SCHEMA ${schema} CASCADE`);
      await db.close();
    },
  };
}
