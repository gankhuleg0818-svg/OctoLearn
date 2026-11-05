# OctoLearn — Backend (Админ веб + App API)

Node.js + TypeScript + Express 5 + PostgreSQL. Хоёр хэсэгтэй:

- **Админ веб панел** (`/`) — зөвхөн `admin` эрхтэй хэрэглэгч нэвтэрнэ. Хэрэглэгч хянах, XP чансаа, бүлэг/хичээл/шалгалт удирдах.
- **App REST API** (`/api/*`) — Expo mobile app ашиглана.

## Ажиллуулах

```bash
cd backend
npm install
cp .env.example .env     # шаардлагатай бол засна
npm run dev              # http://localhost:4000 
```

Сервер асахдаа migration-ийг ажиллуулна. Demo контентыг **зөвхөн DB хоосон үед** оруулна, иймээс админ панелд хийсэн засвар restart хийхэд алга болохгүй.

**Өгөгдлийн сан**: PostgreSQL (14+). `.env`-д `DATABASE_URL=postgres://...` заавал байна.

- Локал дээр суулгасан Postgres-д сан үүсгэх:
  ```bash
  psql -U postgres -c "CREATE USER octolearn WITH PASSWORD 'octolearn';" -c "CREATE DATABASE octolearn OWNER octolearn;"
  ```
- Эсвэл Docker: `docker compose up -d` (ижил хэрэглэгч, нууц үгтэй Postgres асна).