# DusiDash

A professional business management dashboard built with Flutter and Microsoft's Fluent UI design system.

**Live Demo**: [https://dusidash.surge.sh](https://dusidash.surge.sh)

## Overview

DusiDash demonstrates the capabilities of Fluent UI as a robust alternative to Material Design for enterprise web applications. This project showcases advanced Flutter web development with a focus on professional UI/UX patterns and scalable architecture.

## Technical Stack

- **Frontend**: Flutter 3.0+ with Fluent UI
- **State Management**: Provider pattern
- **Routing**: GoRouter with protected routes
- **Data**: Mock generation with Faker Dart
- **Persistence**: Shared Preferences
- **Deployment**: Surge.sh

## Key Features

### Authentication System

- Complete login, registration, and password recovery flows
- Form validation with Fluent UI components
- Session persistence and protected routing

### Dashboard Analytics

- Real-time statistics and performance metrics
- Interactive data visualization
- Quick actions and recent activity tracking

### Business Management

- User management with role-based access control
- Company profiles with detailed information
- Report generation and analytics
- Multi-view navigation patterns

### Fluent UI Implementation

- Responsive NavigationPane with hierarchical menus
- Acrylic effects and modern visual design
- Professional form components and validation
- Theme management (dark/light modes)

## Project Structure

```
lib/
├── app/                    # Application configuration
├── core/data/              # Data layer and model factories
├── layouts/                # Auth and non-auth layouts
├── models/                 # Data models (User, Company, Report)
├── providers/              # State management
├── screens/                # Feature screens
└── widgets/                # Reusable UI components
```

## Fluent UI Advantages

This project highlights Fluent UI's strengths for business applications:

- Enterprise-grade component library
- Professional aesthetics familiar to business users
- Advanced navigation patterns with expandable sections
- Comprehensive form controls with built-in validation
- Modern visual effects like acrylic and reveal animations

## Development Status

This is a work-in-progress demonstration project focusing on:

- Fluent UI component implementation and customization
- Scalable state management architecture
- Responsive web design patterns
- Professional authentication flows
- Mock data integration and management

## Getting Started

```bash
git clone https://github.com/benitoanagua/DusiDash.git
cd DusiDash
flutter pub get
flutter run -d chrome
```

Demo credentials:

- Email: `admin@dusidash.com`
- Password: `password123`

## Build and Deploy

```bash
flutter build web
surge build/web
```

## Purpose

DusiDash serves as a technical demonstration of building professional web applications with Flutter and Fluent UI. It showcases modern development practices, component composition, and enterprise-ready UI patterns.

---

**Repository**: https://github.com/benitoanagua/DusiDash  
**Live Demo**: https://dusidash.surge.sh
