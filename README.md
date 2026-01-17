<div align="center">

  <img src="https://github.com/dev-ajijul-islam/car_landa/blob/main/assets/images/logo.jpg" alt="CarLanda Logo" width="300" />

# 🏎️ CarLanda
**The Ultimate Automotive Marketplace App**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Flutter](https://img.shields.io/badge/dart-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://dart.dev/)
[![Flutter](https://img.shields.io/badge/Provider-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://provider.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)](https://www.mongodb.com/)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
[![Express](https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white)](https://expressjs.com/)


</div>



## 🌟 App Description

**Car Hub** is a modern car marketplace mobile app built with **Flutter**, **Firebase**, and **MongoDB/Express backend**.  
Users can explore cars by category, type, featured deals, and hot deals. The app includes:

- Secure authentication (Email/Password & Google Sign-In)
- Multi-language support (English & Bangla)
- Full user profile management
- Favorite cars and advanced search with filters
- Integrated **SSLCommerz payment gateway**
- Real-time help chat system

This app is designed to give users a **smooth, intuitive, and feature-rich experience** for buying and exploring cars.

---


## 📱 App Gallery

<div align="center">
  <table style="border: none;">
    <tr>
      <td align="center"><strong>Home Screen</strong></td>
      <td align="center"><strong>Car Details</strong></td>
      <td align="center"><strong>Payment Checkout</strong></td>
    </tr>
    <tr>
      <td><img src="screenshots/home.jpg" width="220" /></td>
      <td><img src="screenshots/car_details.jpg" width="220" /></td>
      <td><img src="screenshots/payment.jpg" width="220" /></td>
    </tr>
    <tr>
      <td align="center"><strong>Favorites</strong></td>
      <td align="center"><strong>Profile</strong></td>
      <td align="center"><strong>Track car</strong></td>
    </tr>
    <tr>
      <td><img src="screenshots/favorite.jpg" width="220" /></td>
      <td><img src="screenshots/profile.jpg" width="220" /></td>
      <td><img src="screenshots/tracking.jpg" width="220" /></td>
    </tr>
    <tr>
      <td align="center"><strong>Language</strong></td>
      <td align="center"><strong>Hiistory</strong></td>
      <td align="center"><strong>Track car</strong></td>
    </tr>
    <tr>
      <td><img src="screenshots/language.jpg" width="220" /></td>
      <td><img src="screenshots/history.jpg" width="220" /></td>
      <td><img src="screenshots/tracking.jpg" width="220" /></td>
    </tr>
  </table>
</div>
---



## ✨ Features

### 🔐 Authentication & Security
- Email/Password authentication with **mandatory email verification**
- Google Sign-In (Firebase Authentication)
- Forgot & Reset password via email
- Secure JWT-based session handling
- **Backend user verification using Firebase Admin SDK**
    - Firebase ID Token decoded & validated on Express server
    - Ensures only authenticated users can access protected APIs
- Profile verification with Passport / ID upload
- Protected routes (unverified users cannot access core features)

---

### 🏠 Home & Discovery
- Featured Cars showcase on home screen
- Hot Deals & promotional cars carousel
- Category-wise & car-type based car listings
- Advanced search with multiple filters:
    - Brand
    - Car type
    - Price range
- Smooth pagination & optimized loading
- Add / remove cars from Favorites

---

### 🚗 Car Listing & Details
- View all available cars in a dedicated listing screen
- Detailed car information:
    - Multiple car images
    - Specifications & features
    - Price & availability
- Similar / recommended cars suggestion
- Favorite state persisted across sessions

---

### ❤️ Favorites
- Save favorite cars for quick access
- Favorites synced with MongoDB backend
- Instant UI update using Provider state management

---

### 💳 Payments
- Integrated **SSLCommerz** secure payment gateway
- Safe & reliable checkout flow
- Payment status handling:
    - Success
    - Failed
    - Cancelled

---

### 👤 Profile & Settings
- View and update personal profile information
- Upload profile picture
- Upload Passport / ID images for verification
- Secure password change
- Multi-language support:
    - English 🇬🇧
    - Bangla 🇧🇩
- Persistent login session

---

### 💬 Help & Support
- Real-time in-app chat system
- Direct communication with admin/support
- Chat history preserved
- Notifications for replies & updates

---

### 🌐 General App Features
- Clean & modern UI following Material Design
- State management using Provider
- REST API communication with Express.js backend
- Scalable MongoDB database structure
- Optimized performance & smooth UX
- Fully production-ready application flow

---

### 🧑‍💻 Developer & Architecture
- Flutter frontend with clean architecture
- Express.js backend with MongoDB
- Firebase Authentication integration
- **Firebase Admin SDK used on backend to decode and verify user tokens**
- JWT-secured APIs
- Modular, scalable & maintainable codebase
- Ready for deployment and future expansion
___

## ⚡ Tech Stack

| Technology | Usage |
|------------|-------|
| ![Flutter](https://img.icons8.com/color/48/flutter.png) | Frontend UI development |
| ![Firebase](https://img.icons8.com/color/48/firebase.png) | Authentication, cloud storage, push notifications |
| ![Node.js](https://img.icons8.com/color/48/nodejs.png) | Backend server runtime |
| ![Express.js](https://img.icons8.com/color/48/express.png) | REST API & server management |
| ![MongoDB](https://img.icons8.com/color/48/mongodb.png) | Database |
| ![Provider](https://img.icons8.com/color/48/flutter.png) | State management in Flutter (Provider) |
| ![SSLCommerz](https://sslcommerz.com/images/logo.svg) | Payment gateway |

---

## 🗄️ Backend / Server Repository

This project follows a **clean separation of frontend and backend** architecture.

### 🔧 Backend Technology Overview
- **Node.js + Express.js** REST API
- **MongoDB** as primary database
- **Firebase Admin SDK** for authentication verification
- **JWT-secured APIs**
- **SSLCommerz** payment integration
- Modular & scalable server structure

### 🔐 Authentication Flow (Backend)
- Frontend authenticates users via **Firebase Authentication**
- Firebase ID Token is sent with each protected request
- **Firebase Admin SDK** is used on the Express server to:
    - Decode Firebase ID Token
    - Verify user authenticity
    - Attach verified user info to request
- Ensures secure access to protected routes only

### 📂 Server Repository
👉 **Backend Source Code:**  
🔗 https://github.com/dev-ajijul-islam/car_landa_server_express.git  


