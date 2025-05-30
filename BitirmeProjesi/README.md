# BitirmeProjesi

A fitness and nutrition tracking application built with SwiftUI and SwiftData.

## Project Structure

### Models
- `Food.swift` - Food item model
- `SporData.swift` - Exercise data model
- `KullanciBilgileri.swift` - User information model
- `DailyNutrition.swift` - Daily nutrition tracking model

### ViewModels
- `registerViewModel.swift` - Handles user registration and profile management
- `CalorieTracker.swift` - Manages calorie and nutrition tracking
- `SearchViewModel.swift` - Handles food search functionality

## Architecture

The app follows MVVM architecture with SwiftData for persistence:

1. **Models**: SwiftData `@Model` classes for data persistence
2. **ViewModels**: `@MainActor` classes that handle business logic
3. **Views**: SwiftUI views that display the UI

## Dependencies

- SwiftUI
- SwiftData
- Firebase
- Combine

## Setup

1. Clone the repository
2. Open `BitirmeProjesi.xcodeproj`
3. Build and run the project

## Features

- User registration and authentication
- Food tracking and nutrition monitoring
- Exercise tracking
- Daily calorie and nutrition goals
- Profile management 