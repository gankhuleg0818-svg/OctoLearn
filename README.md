# OctoLearn

OctoLearn нь тоглоомын элементүүдийг ашиглан суралцах үйл явцыг илүү сонирхолтой, үр дүнтэй болгох зорилготой видео сургалтын платформын prototype юм.

Платформ нь богино хэмжээний видео хичээл, шаталсан сургалтын зам, тогтмол мэдлэг шалгах тест болон XP, Streak зэрэг gamification системийг нэгтгэсэн.

## Live Demo
- **Backend / Admin Web:** [OctoLearn админ панел](https://octolearn-api.onrender.com/)
- **App:** <a href="[https://.....](https://drive.google.com/drive/folders/1OVW2IF0vMejKr6BDimeotgX80PQ8uF_E?usp=sharing)" target="_blank" rel="noopener noreferrer">OctoLearn APK</a>

## Технологи

| Хэсэг | Технологи | Дэлгэрэнгүй |
|---|---|---|
| [`mobile/`](mobile/) | React Native (Expo SDK 58) + TypeScript, Expo Router, Zustand, expo-video, Reanimated | [mobile/README.md](mobile/README.md) |
| [`backend/`](backend/) | Node.js + TypeScript + Express 5, PostgreSQL, JWT, zod | [backend/README.md](backend/README.md) |

Backend нь **app REST API** болон **админ веб панел** (хэрэглэгч хянах, XP чансаа, бүлэг/хичээл/шалгалт удирдах) хоёрыг агуулна.

## Ажиллуулах

```bash
cd backend && npm install && npm run dev

cd mobile && npm install && npm start      # npx expo start, эсвэл `npm run web`
```

## Хийсэн зүйлс

- **P0:** pathway (zigzag, 3 төлөв, шалгалтын цэг, түгжээний мэдэгдэл), прогресс бар + XP, видео хичээл (тоглуулах/гүйлгэх, ≥ 90% үзсэний дараа "Дуусгах", +XP feedback), MCQ шалгалт (ногоон/улаан, үр дүн, дахин өгөх, ≥ 60% тэнцэнэ), профайлын статистик, доод навигаци, ахиц хадгалалт
- **P1:** идэвхтэй хичээл рүү автоматаар гүйлгэх, streak, бүтэн дэлгэцийн видео, түвшин, ахиц reset
- **P2:** Node.js API + PostgreSQL, нэвтрэлт (имэйл + нууц үг, JWT), streak/түвшний логик, dark mode, вэб хувилбар (Expo Web), backend unit/integration тест, офлайн үед кэшээр харуулах, Zustand state management, XP чансаа, 7 хоногийн идэвхийн график, админ панел

## Хөгжүүлэлтийн явц

OctoLearn хөгжүүлэлтийн явцад Claude AI-г голлох AI туслах хэрэгсэл болгон өргөн ашигласан бөгөөд төслийг бүхэлд нь AI-д даатган бүтээсэн бус, AI-ийн тусламж болон хүний оролцоо, шийдвэр гаргалт, хяналт дор хамтран хөгжүүлсэн.
