# Multi-Store App (`bobde6_multi_store`)

A multi-vendor e-commerce buyer platform built with Flutter and Firebase.

---

## 📊 Current Project Status

| Module | Status | Description |
| :--- | :--- | :--- |
| **Authentication System** | 🟢 Complete | Signup, Login, persistent auth state listener (`StreamBuilder`), profile view, and logout control implemented. |
| **Main Layout & Navigation** | 🟢 Complete | Bottom navigation bar set up with 6 primary tabs (`Home`, `Categories`, `Store`, `Cart`, `Search`, `Account`). |
| **Home Screen** | 🟢 Complete | Banners, dynamic Firestore category chips, and live marketplace product grid. |
| **Category Screen** | 🟢 Complete | Dynamic grid displaying categories live from Firestore. |
| **Store Screen** | 🟢 Complete | Multi-vendor list & store detail view displaying vendor profiles and store products. |
| **Search Screen** | 🔴 Placeholder | Displays static text placeholder. |
| **Cart Screen** | 🔴 Static UI | Shows empty cart view. State management and checkout integration planned. |
| **Account Screen** | 🟢 Complete | Profile avatar, full name, email, phone number, address view, and Logout action button. |
| **Product System** | 🟢 Complete | Product & Category models, product card items, home marketplace grid, and full Product Detail View. |
| **Checkout & Payments** | 🔴 Missing | Address input, order creation, and payment gateway integration planned. |

---

## 🚀 Implementation Roadmap

### Phase 1: Authentication & Session Management
- [x] **Auth Gate (`main.dart`)**: Wrapped `MaterialApp` with a `StreamBuilder<User?>` (`FirebaseAuth.instance.authStateChanges()`) to automatically route logged-in users to `MainScreen` and guest users to `LoginScreen`.
- [x] **Logout & Session Control**: Implemented `signOut()` in `AuthController` and added profile data view with a Logout button to `AccountScreen`.

### Phase 2: Dynamic Category & Product Data Architecture
- [x] **Data Models (`lib/models/`)**: Created models for `ProductModel`, `CategoryModel`, and `OrderModel`.
- [x] **Dynamic Categories**: Updated `CategoryText` widget and `CategoryScreen` to fetch categories live from Firestore (`categories` collection).
- [x] **Product Display Widgets**: Created `ProductCardWidget` and `HomeProductWidget` displaying marketplace products dynamically from Firestore on `HomeScreen`.

### Phase 3: Product Detail & Multi-Store (Vendor) Screen
- [x] **Product Detail Screen**: Created [`ProductDetailScreen`](file:///C:/Users/AlaBob/StudioProjects/https-github.com-bobde_multi_store/lib/views/buyers/inner_screens/product_detail_screen.dart) with product image carousel, price, title, category tag, quantity selector (+/-), full description, vendor info card, and "Add to Cart" action bar.
- [x] **Store Screen**: Implemented [`StoreScreen`](file:///C:/Users/AlaBob/StudioProjects/https-github.com-bobde_multi_store/lib/views/buyers/nav_screen/store_screen.dart) streaming vendors from Firestore, and [`StoreDetailScreen`](file:///C:/Users/AlaBob/StudioProjects/https-github.com-bobde_multi_store/lib/views/buyers/inner_screens/store_detail_screen.dart) displaying store profile headers and vendor-specific product catalogs.

### Phase 4: Cart State Management & Checkout Flow
- [ ] **Cart State Management (`CartProvider`)**: Integrate state management to handle adding items, quantity updates, item removal, and subtotal/total calculations.
- [ ] **Cart Screen Enhancement**: Connect `CartScreen` to cart state provider.
- [ ] **Checkout Screen**: Shipping address input, order summary review, payment method selection, and committing orders to Firestore (`orders` collection).

### Phase 5: Search & Account Features
- [ ] **Search Screen**: Real-time keyword filtering against Firestore products.
- [ ] **Account & Profile Screen**: Display profile picture, full name, email, and shipping address, with profile edit capability and past order history.

### Phase 6: Order Tracking & Polish
- [ ] **My Orders Screen**: Display buyer's order history from Firestore (`orders` collection) with status badges (`Pending`, `Processing`, `Delivered`, `Cancelled`).
- [ ] **Push Notifications**: Integrate `firebase_messaging` for order status updates.
- [ ] **UI Polish**: Add shimmer loading placeholders and fallback images.

---

## 🛠️ Getting Started & Prerequisites

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or higher)
- [Android Studio](https://developer.android.com/studio) / VS Code with Dart & Flutter plugins
- Firebase account with configured `google-services.json`

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/bobde6/multi_store.git
   cd multi_store
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
