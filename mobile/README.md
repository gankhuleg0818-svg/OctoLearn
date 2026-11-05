# OctoLearn — Mobile app

React Native (Expo SDK 58) + TypeScript + Expo Router. Pathway, видео хичээл, шалгалт, XP, статистиктай video course апп.

## Ажиллуулах

```bash
cd mobile
npm install
npm start          # Expo Go-оор QR уншуулна (компьютертэй нэг Wi-Fi)
npm run web        # эсвэл браузерт
```


## Дэлгэцүүд

| Route | Юу хийдэг |
|---|---|
| `login`, `register` | Нэвтрэх / бүртгүүлэх, клиент талын validation, demo нэвтрэлт |
| `(tabs)/index` | **Pathway — газрын зураг**: градиент дээд бар (прогресс "5/15 хичээл · 33%", XP, streak), бүлэг бүр өөр газар нутаг (тал 🌳 / тосгон 🏡 / эрэг ⛰️ / хаант улс 🏰), түгжээтэй бүлэг үүлэн дор, цэгүүдийг холбосон SVG зам (явсан хэсэг алтлаг), 3 төлөвтэй цэгүүд, цомтой шалгалтын цэг, түгжээтэй цэг дээр toast, идэвхтэй цэг рүү автоматаар гүйлгэх, pull-to-refresh, офлайн баннер |
| `lesson/[id]` | `expo-video` тоглуулагч (тоглуулах/зогсоох, гүйлгэх, бүтэн дэлгэц), "Бүлэг 2 · Хичээл 3 / 5", тайлбар, үзсэн хувь; **"Дуусгах"** нь ≥ 90% үзсэний дараа идэвхжинэ → "+10 XP" overlay |
| `quiz/[id]` | Нэг дэлгэцэнд нэг асуулт, ахицын бар, "Шалгах" → ногоон/улаан + зөв хариулт, үр дүнгийн дэлгэц (4 / 5, XP, "Үргэлжлүүлэх" / "Дахин өгөх") |
| `(tabs)/leaderboard` | XP чансаа, өөрийн байр |
| `(tabs)/profile` | Аватар, түвшин + ахиц, XP, streak, хичээл, тэнцсэн шалгалт, дундаж оноо, курсын ахиц, 7 хоногийн XP график, **харагдах байдал: Цайвар / Бараан / Систем** (төхөөрөмж дээр хадгалагдана), ахиц reset, гарах |

## Архитектур

```
src/
  app/          Expo Router дэлгэцүүд (Stack + Stack.Protected → auth / (tabs) / lesson / quiz)
  api/          fetch client (timeout, Монгол алдааны мессеж), endpoints, хариуны төрлүүд
  store/        Zustand: auth (SecureStore session), learning (pathway/profile, AsyncStorage кэш)
  components/   ui/ (Button, Text, ProgressBar, Toast, …), pathway/, lesson/, quiz/, profile/
  lib/          цэвэр туслах функцууд (pathway flatten / optimistic update), платформын storage
  constants/    дизайны токенууд (light/dark өнгө, фонт, зай, radius)
```
