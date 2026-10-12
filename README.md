# CallBackShoppingCart

A lightweight iOS shopping cart application built with **Swift and SwiftUI**, demonstrating MVVM architecture, protocol-oriented programming, dependency injection, and asynchronous completion handlers.

## Features

- Add products to a shopping cart
- Increase, decrease, and remove item quantities
- Automatically calculate the cart subtotal
- Persist cart data between app launches using `UserDefaults` and `Codable`
- Navigate to a mock payment screen with an order summary
- Display loading, success, and error states

## Architecture

The project separates responsibilities across four layers:

- **View:** SwiftUI interface and user interactions
- **ViewModel:** Cart state and business logic
- **Repository:** Data access and persistence
- **Service:** Mock product data and asynchronous operations

Protocols and dependency injection keep components loosely coupled and testable.

## Technologies

Swift · SwiftUI · MVVM · Combine · Codable · UserDefaults · Completion Handlers

## Getting Started

1. Clone or download this repository.
2. Open `CallBackShoppingCart.xcodeproj` in Xcode.
3. Select an iOS Simulator and run the application.

**Note:** This is a demonstration project. The payment screen is simulated, and no real transactions are processed.
