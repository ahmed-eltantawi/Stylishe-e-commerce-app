<![CDATA[<h1 align="center">🛍️ Stylish — E-Commerce Mobile App</h1>

<p align="center">
  <img src="assets/images/app_icon.png" alt="Stylish App Icon" width="160"/>
</p>

<p align="center">
  A polished, full-featured e-commerce mobile application built with <strong>Flutter</strong>.<br/>
  Follows <strong>Clean Architecture</strong>, uses <strong>Cubit / Bloc</strong> for state management,<br/>
  and integrates <strong>Stripe</strong> & <strong>Paymob</strong> for real payment processing.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/State_Mgmt-Cubit%20%2F%20Bloc-6C63FF?style=for-the-badge" alt="Cubit"/>
  <img src="https://img.shields.io/badge/API-Platzi_Fake_Store-22C55E?style=for-the-badge" alt="API"/>
  <img src="https://img.shields.io/badge/Payments-Stripe%20%7C%20Paymob-635BFF?style=for-the-badge&logo=stripe&logoColor=white" alt="Payments"/>
</p>

---

## 📸 Screenshots

| Splash Screen | Onboarding 1 | Onboarding 2 | Onboarding 3 |
|:---:|:---:|:---:|:---:|
| <img src="assets/screens/Splash_screen.png" width="180"/> | <img src="assets/screens/onboarding_screen_1.png" width="180"/> | <img src="assets/screens/onboarding_screen_2.png" width="180"/> | <img src="assets/screens/onboarding_20screen_3.png" width="180"/> |

| Get Started | Sign In | Sign Up | Forgot Password |
|:---:|:---:|:---:|:---:|
| <img src="assets/screens/Get_Started.png" width="180"/> | <img src="assets/screens/Sign_In.png" width="180"/> | <img src="assets/screens/Sign_Up.png" width="180"/> | <img src="assets/screens/Forgot_password.png" width="180"/> |

| Home Page | Shop Page | Trending Products | Profile |
|:---:|:---:|:---:|:---:|
| <img src="assets/screens/Home_page.png" width="180"/> | <img src="assets/screens/Shop_page.png" width="180"/> | <img src="assets/screens/Trending_Products.png" width="180"/> | <img src="assets/screens/Profile.png" width="180"/> |

| Checkout | Shipping | Place Order | Order Success |
|:---:|:---:|:---:|:---:|
| <img src="assets/screens/Checkout.png" width="180"/> | <img src="assets/screens/Shipping.png" width="180"/> | <img src="assets/screens/Place_Order.png" width="180"/> | <img src="assets/screens/Sucessfully.png" width="180"/> |

---

## ✨ Features

### Authentication
- 🔐 Sign In / Sign Up with email & password (JWT)
- 🔄 Automatic access-token refresh via Dio interceptor
- 🔒 Credentials stored in **Flutter Secure Storage**
- 📧 Email availability check before registration

### Shopping Experience
- 🏠 **Home** — Promotional banners, category bar, trending & new-arrival product carousels
- 🗂️ **Categories** — Browse & filter products by category
- 🔎 **Products** — Full product listing with search, price-range filtering, and pagination
- 📄 **Product Details** — Image slider, description, pricing, add-to-cart / wishlist
- ❤️ **Wishlist** — Local wishlist with persistent storage
- 🛒 **Cart** — Add / remove items, quantity adjustment, order summary

### Product Management (CRUD)
- ➕ Add new products (with image upload)
- ✏️ Edit existing products
- 🗑️ Delete products

### Payments
- 💳 **Stripe** — Payment Intent flow with payment sheet
- 💰 **Paymob** — Intention-based payment integration

### Settings & Personalisation
- 🎨 **Theming** — Light & Dark mode with persisted preference
- 🌍 **Localization** — English & Arabic (RTL-aware)
- 👤 **Profile** — View & manage authenticated user data

### UX Polish
- 🚀 Native splash screen with smooth animated intro
- 📱 Responsive layouts powered by **ScreenUtil**
- 💀 Shimmer / skeleton loading placeholders
- 🖼️ Cached network images for fast, offline-friendly browsing
- 🌐 Internet connectivity monitoring

---

## 🎨 Design

The UI is based on a community Figma design kit:

🔗 **Figma:** [eCommerce App UI Kit – Case Study Mobile App](https://www.figma.com/design/sxXKvqYly0rE9ADt8zy3QI/eCommerce-App-UI-Kit---Case-Study-Ecommerce-Mobile-App-UI-kit--Community-?node-id=0-1&t=T0KNTENLLfHDl9fe-1)

---

## 🏗️ Architecture

The project follows **Clean Architecture** with a **feature-first** folder structure:

```text
Feature/
├── data/
│   ├── datasources/        → Local / remote data sources
│   ├── models/              → Data models & request/response DTOs
│   └── repositories/        → Repository implementations
├── domain/                  → (where applicable) Repository interfaces
└── presentation/
    ├── manager/ (cubits)    → State management (Cubit + States)
    ├── views/               → Screen-level widgets
    └── widgets/             → Reusable UI components
```

| Layer | Responsibility |
|-------|---------------|
| **Data** | API calls, local storage, model serialisation |
| **Domain** | Repository contracts (interfaces) |
| **Presentation** | UI, state management via Cubit |

**Dependency Injection** — GetIt service locator for decoupled, testable code.

**Networking** — Dio HTTP client with custom interceptors for auth headers, automatic token refresh, and centralised error handling.

---

## 📁 Project Structure

```text
lib/
├── main.dart
│
├── config/
│   ├── routing/
│   │   ├── app_router.dart              # GoRouter route definitions
│   │   └── app_routes.dart              # Route name constants
│   ├── services/
│   │   ├── secure_storage_service.dart  # Flutter Secure Storage wrapper
│   │   ├── services_locator.dart        # GetIt DI setup
│   │   └── shared_preferences_service.dart
│   └── theme/
│       ├── app_theme.dart               # Theme mode switcher
│       ├── dark_theme.dart
│       └── light_theme.dart
│
├── core/
│   ├── cache/                           # Cache helpers & key constants
│   ├── errors/                          # Unified error model, exceptions, failures
│   ├── functions/                       # Dialogs, snackbars, shimmer helpers
│   ├── networking/
│   │   ├── api_consumer.dart            # Abstract API consumer
│   │   ├── api_end_points.dart          # Endpoints, API keys, headers
│   │   ├── api_interceptor.dart         # Auth, refresh-token & logging interceptors
│   │   └── dio_consumer.dart            # Dio HTTP client implementation
│   ├── payment/
│   │   ├── payment_interface.dart       # Payment abstraction
│   │   ├── paymob/                      # Paymob integration & models
│   │   ├── stripe/                      # Stripe integration & models
│   │   └── presentation/               # Checkout bottom sheet
│   ├── utils/                           # Colors, text styles, constants, assets
│   └── widgets/                         # Shared buttons (filled, outlined, square)
│
├── features/
│   ├── Auth/                            # Sign In, Sign Up, Forgot Password, User Data
│   ├── cart/                            # Shopping cart management
│   ├── categories/                      # Category browsing
│   ├── home/                            # Home screen, product carousels, banners
│   ├── onboarding/                      # Onboarding flow
│   ├── products/                        # Product list, details, add, edit, delete
│   ├── settings/                        # Theme & language preferences
│   ├── splash/                          # Animated splash screen
│   └── wishlist/                        # Wishlist (local persistence)
│
├── generated/                           # Auto-generated l10n
└── l10n/                                # intl_en.arb, intl_ar.arb
```

---

## 🌐 API Reference

**Backend:** [Platzi Fake Store API](https://fakeapi.platzi.com/)

**Base URL:**
```
https://api.escuelajs.co/api/v1/
```

### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/login` | Login → `{ access_token, refresh_token }` |
| `POST` | `/auth/refresh-token` | Refresh expired access token |
| `GET`  | `/auth/profile` | Authenticated user profile (Bearer) |

### Users

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/users/` | Register a new user |
| `GET`  | `/users/{id}` | Get user by ID |
| `PUT`  | `/users/{id}` | Update user data |
| `POST` | `/users/is-available` | Check email availability |

### Products

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET`    | `/products` | List products (supports `offset`, `limit`, filters) |
| `GET`    | `/products/{id}` | Get single product |
| `POST`   | `/products` | Create a new product |
| `PUT`    | `/products/{id}` | Update a product |
| `DELETE` | `/products/{id}` | Delete a product |

### Categories

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/categories` | List all categories |
| `GET` | `/categories/{id}/products` | Products by category |

### Files

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/files/upload` | Upload file (multipart/form-data) |
| `GET`  | `/files/{fileName}` | Retrieve uploaded file |

### Auth Flow

```
1. POST /auth/login          → { access_token, refresh_token }
2. GET  /auth/profile        → User profile (Bearer token)
3. POST /auth/refresh-token  → New tokens (when access token expires)
```

> **Note:** Access token validity — **20 days** · Refresh token validity — **10 hours**.

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^9.1.1 | State management (Cubit / Bloc) |
| `bloc` | ^9.2.1 | Bloc core library |
| `dio` | ^5.9.2 | HTTP client |
| `go_router` | ^17.2.3 | Declarative routing |
| `get_it` | ^9.2.1 | Service locator / DI |
| `dartz` | ^0.10.1 | Functional programming (`Either` type) |
| `flutter_secure_storage` | ^10.3.1 | Encrypted credential storage |
| `shared_preferences` | ^2.5.5 | Local key-value storage |
| `jwt_decoder` | ^2.0.1 | JWT token parsing |
| `flutter_screenutil` | ^5.9.3 | Responsive UI scaling |
| `flutter_svg` | ^2.3.0 | SVG rendering |
| `smooth_page_indicator` | ^2.0.1 | Onboarding page indicator |
| `internet_connection_checker_plus` | ^3.0.0 | Connectivity monitoring |
| `cached_network_image` | ^3.4.1 | Image caching & placeholders |
| `shimmer` | ^3.0.0 | Skeleton loading effects |
| `redacted` | ^1.0.13 | Redacted text placeholders |
| `flutter_stripe` | ^13.0.0 | Stripe payment integration |
| `flutter_paymob_sdk` | git | Paymob payment integration |
| `intl` | ^0.20.2 | Internationalisation utilities |
| `flutter_native_splash` | ^2.4.7 | Native splash screen |
| `flutter_launcher_icons` | ^0.14.4 | App icon generation |
| `flutter_localizations` | SDK | Multi-language support |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.10.8`
- **Dart SDK** `^3.10.8`

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/ahmed-eltantawi/Stylishe-e-commerce-app.git

# 2. Navigate to the project
cd stylish

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### Environment Setup

The app requires API keys for payment integrations. Copy the example file and fill in your keys:

```bash
cp lib/core/utils/constants.example.dart lib/core/utils/constants.dart
```

Then update `constants.dart` with your **Stripe** and **Paymob** credentials.

### Generate Assets

```bash
# Native splash screen
dart run flutter_native_splash:create

# Launcher icons
dart run flutter_launcher_icons

# Localisation files (if modified)
flutter gen-l10n
```

---

## 📝 License

This project is for educational and internship purposes.

---

<p align="center">
  Made with ❤️ using Flutter
</p>
]]>
