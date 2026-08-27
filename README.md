<div align="center">

# 🧪 Rick and Morty Explorer
<p align="center">
  <img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/cover.png" alt="rickandmorty cover" width="720"/>
</p>

<p align="center">
  <a href="#screenshots">
    <img src="https://img.shields.io/badge/View_All_Screenshots-02569B?style=for-the-badge&logo=image&logoColor=white" alt="View all screenshots"/>
  </a>
</p>

**Browse the multiverse — search, filter & explore every Rick and Morty character.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter&logoColor=white&color=02569B)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white&color=02569B)](https://dart.dev)
[![API](https://img.shields.io/badge/API-Rick%20%26%20Morty%20API-00B4D8?style=for-the-badge)]
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

---

## ✨ About the Project

**Rick and Morty Explorer** is a slick Flutter app that brings the **Rick and Morty API** to life:

- 👽 **Browse characters** across the multiverse with smooth pagination
- 🔎 **Search & filter** characters by name
- 🗂️ **List / Grid view** toggle with a floating action button
- 🧬 **Rich details** — status, species, gender, origin, location & episodes
- 🌀 **Living portal UI** — animated multiverse background, responsive to reduced-motion preferences
- 📡 **Offline‑aware** — banner, retryable network errors and informative empty states

Built with **Clean Architecture** (data → repository → BLoC → UI), animated cards, shimmer placeholders, offline banners, and even a *click* sound effect for that interactive touch. 🎵

---

## 🚀 Features

| Feature | Description |
|---|---|
| 👽 **Character Browsing** | Paginated list across the Rick and Morty universe |
| 🔎 **Search** | Live search by character name |
| 🗂️ **List / Grid Toggle** | Switch layouts with a floating action button |
| 🧬 **Details Page** | Status, species, type, gender, origin, location, episode count |
| 🟢🔴 **Status Colors** | Color‑coded Alive / Dead / Unknown states |
| 🖼️ **Precaching** | Smart image caching for a buttery scroll |
| 📵 **Offline Support** | `flutter_offline` banner + cached content |
| 💀 **Shimmer & Skeleton** | Beautiful loading placeholders |
| 🎵 **Sound Effects** | Interactive click sounds |
| 🌀 **Portal Background** | Animated, repaint-isolated portal backdrop that respects reduced-motion preferences |
| 📶 **Network Feedback** | Offline banner, dedicated no-connection screen with retry, and search-empty state |
| 🔍 **Character Preview** | Quick preview modal before diving into full details |
| ⏭️ **Pagination Bar** | Clear next/previous navigation through the multiverse |
| 🎨 **Custom Theme** | Dark theme with the iconic Rick & Morty palette |

---

## 🧱 Tech Stack

<div align="center">

| 🛠️ Tool | Purpose |
|---|---|
| [Flutter](https://flutter.dev) | Cross‑platform UI framework |
| [Dio](https://pub.dev/packages/dio) | Networking & API calls |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | Image caching |
| [skeletonizer](https://pub.dev/packages/skeletonizer) | Skeleton loading effects |
| [flutter_offline](https://pub.dev/packages/flutter_offline) | Connectivity detection |
| [audioplayers](https://pub.dev/packages/audioplayers) | Sound effects |
| [provider](https://pub.dev/packages/provider) | Lightweight state helpers |
| [auto_size_text](https://pub.dev/packages/auto_size_text) | Responsive labels across character cards |

</div>

---

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry point
├── app_routes.dart              # Named routes + DI for repository/cubit
├── constant/
│   └── string.dart              # App constants & colors
├── data/
│   ├── API_services/            # Character web service (Dio)
│   ├── model/                   # Character model
│   └── repository/              # Character repository
└── presentation/
    ├── bloc/                    # Character cubit & state
    ├── screens/                 # List & details screens
    └── widgets/                 # Cards, header, loading & shared feedback widgets
        └── shared/              # Portal, offline banner, retry/error, preview & pagination
```

---

## ✅ Getting Started

### Prerequisites
- 🦋 **Flutter SDK** `>= 3.10`

### Installation

```bash
# 1️⃣ Clone the repository
git clone https://github.com/moaz-nassef/rickandmorty.git
cd rickandmorty

# 2️⃣ Install dependencies
flutter pub get

# 3️⃣ Run the app
flutter run
```

> No API key needed — the app uses the public **Rick and Morty API** endpoints for free. 🌐

---

## 🧭 Roadmap

- [x] Paginated character list + search
- [x] List / grid layout toggle
- [x] Rich detail page & status colors
- [x] Offline banner + skeleton loading
- [x] Animated portal background + reduced-motion support
- [x] Search-empty, no-network and retry experiences
- [x] Character preview modal + pagination controls
- [ ] 🏡 Episodes & locations tabs
- [ ] ⭐ Favorites & watchlist
- [ ] 🔔 Character alerts (Alive/Dead changes)

---

## 🤝 Contributing

Contributions are always welcome! 🎉

1. 🍴 Fork the repository
2. 🌿 Create your feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add some amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🔀 Open a Pull Request

---

## 📞 Contact

**Moaz Nassef** — [GitHub](https://github.com/moaz-nassef)

---

<div align="center">

Made with 💜 using Flutter & the Rick and Morty API

⭐ **Don't forget to star this repo if you like it!** ⭐

</div>

<!-- SCREENSHOTS-AUTO-START -->
## Screenshots

Below are all the app screenshots. The cover image is shown above; tap the button under it to jump back here.

<p align="center"><img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/WhatsApp%20Image%202026-08-27%20at%207.00.14%20PM%20(1).jpeg" alt="WhatsApp Image 2026-08-27 at 7.00.14 PM (1)" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/WhatsApp%20Image%202026-08-27%20at%207.00.14%20PM%20(2).jpeg" alt="WhatsApp Image 2026-08-27 at 7.00.14 PM (2)" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/WhatsApp%20Image%202026-08-27%20at%207.00.14%20PM.jpeg" alt="WhatsApp Image 2026-08-27 at 7.00.14 PM" width="200"/></p>
<p align="center"><img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%201.jpeg" alt="صورة 1" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%202.jpeg" alt="صورة 2" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/rickandmorty/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A93.jpeg" alt="صورة3" width="200"/></p>
<!-- SCREENSHOTS-AUTO-END -->
