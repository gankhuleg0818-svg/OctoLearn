import 'dotenv/config';
import { z } from 'zod';

const DB_REQUIRED = 'DATABASE_URL is required — a PostgreSQL connection string (see .env.example)';

const EnvSchema = z.object({
  NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),
  PORT: z.coerce.number().int().positive().default(4000),
  /** PostgreSQL connection string, e.g. postgres://user:pass@localhost:5432/octolearn */
  DATABASE_URL: z.string({ error: DB_REQUIRED }).min(1, DB_REQUIRED),
  JWT_SECRET: z.string().min(8).default('dev-only-secret-change-me'),
  JWT_EXPIRES_IN: z.string().default('30d'),
  /** Encrypts secrets stored in app_settings; defaults to JWT_SECRET. */
  SETTINGS_SECRET: z.string().min(8).optional(),
  CORS_ORIGIN: z.string().default('*'),
  APP_TIMEZONE: z.string().default('Asia/Ulaanbaatar'),
});

const env = EnvSchema.parse(process.env);

if (env.NODE_ENV === 'production' && env.JWT_SECRET === 'dev-only-secret-change-me') {
  throw new Error('JWT_SECRET must be set in production');
}

export const config = {
  env: env.NODE_ENV,
  port: env.PORT,
  databaseUrl: env.DATABASE_URL,
  jwtSecret: env.JWT_SECRET,
  jwtExpiresIn: env.JWT_EXPIRES_IN,
  settingsSecret: env.SETTINGS_SECRET ?? env.JWT_SECRET,
  corsOrigin: env.CORS_ORIGIN === '*' ? '*' : env.CORS_ORIGIN.split(',').map((s) => s.trim()),
  timezone: env.APP_TIMEZONE,
} as const;
