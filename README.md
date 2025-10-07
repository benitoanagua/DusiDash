# DusiDash

A modern, responsive business management dashboard built with Flutter and the Fluent UI framework. DusiDash provides comprehensive tools for managing users, companies, reports, and analytics in a single, elegant interface.

## Features

### 🚀 Core Functionality

- **User Management**: Complete CRUD operations for user accounts with role-based permissions
- **Company Management**: Track and manage company profiles with detailed information
- **Reports & Analytics**: Generate and manage various types of business reports
- **Dashboard Overview**: Real-time statistics and performance metrics
- **Settings & Preferences**: Customizable themes, notifications, and user preferences

### 🎨 UI/UX Features

- **Modern Fluent Design**: Clean, professional interface inspired by Microsoft Fluent UI
- **Dark/Light Theme**: Toggle between themes with persistent preferences
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Smooth Animations**: Fluid transitions and micro-interactions
- **Intuitive Navigation**: Easy-to-use sidebar navigation with breadcrumbs

### 📊 Dashboard Capabilities

- **Real-time Statistics**: Live metrics for users, companies, reports, and revenue
- **Performance Metrics**: Growth rates, engagement rates, and conversion metrics
- **Quick Actions**: Fast access to common tasks and operations
- **Recent Activity**: Track user activities and system events
- **Top Companies**: Overview of leading companies by revenue

### 🔐 Security & Authentication

- **Secure Login**: Form validation and secure authentication flow
- **Role-based Access**: Different permission levels for Admin, Manager, User, and Viewer roles
- **Session Management**: Proper authentication state handling
- **Protected Routes**: Automatic redirection for unauthenticated users

## Screenshots

_Dashboard Overview_

- Real-time statistics cards with key metrics
- Performance indicators with growth trends
- Recent user activity feed
- Quick action buttons for common tasks

_User Management_

- Comprehensive user list with search functionality
- Role-based color coding
- User detail view with complete profile information
- Activity history and permissions management

_Company Management_

- Company profiles with industry classification
- Revenue tracking and employee counts
- Location-based filtering
- Detailed company information with tags

_Reports & Analytics_

- Multiple report types (financial, performance, audit, analytics, compliance)
- Report generation and export capabilities
- Analytics dashboard with key performance indicators
- Filter and search functionality

_Settings_

- User profile management
- Appearance customization (themes, colors)
- Notification preferences
- Data management options

## Tech Stack

- **Framework**: Flutter
- **UI Library**: Fluent UI (Microsoft Design System)
- **State Management**: Provider pattern
- **Navigation**: Go Router
- **Data Generation**: Faker Dart
- **Persistence**: Shared Preferences
- **Architecture**: Clean Architecture with Provider pattern

## Installation

1. Clone the repository:

```bash
git clone https://github.com/benitoanagua/DusiDash.git
cd DusiDash
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the application:

```bash
flutter run
```

## Project Structure

```
lib/
├── app/                    # Main application setup
├── core/                   # Core utilities and services
│   └── data/              # Data generation and models
├── layouts/               # Layout components (Auth/Non-Auth)
├── models/                # Data models (User, Company, Report)
├── providers/             # State management providers
├── screens/               # Application screens
└── widgets/               # Reusable UI components
```

## Key Components

### Data Models

- **User**: Complete user profile with permissions and activity tracking
- **Company**: Detailed company information with financial data
- **Report**: Comprehensive report structure with metrics and metadata

### Providers

- **AuthProvider**: Handles authentication state and user sessions
- **ThemeProvider**: Manages theme preferences and persistence
- **DashboardProvider**: Centralized data management for dashboard content

### Screens

- **DashboardScreen**: Main overview with statistics and metrics
- **UsersScreen**: User management interface
- **CompaniesScreen**: Company management with detailed profiles
- **ReportsScreen**: Report generation and analytics
- **SettingsScreen**: User preferences and system settings
- **LoginScreen**: Authentication interface

## Demo Credentials

For testing purposes, you can use:

- **Username**: `admin@dusidash.com`
- **Password**: `password`

## Features in Development

- Export functionality for reports and data
- Advanced analytics and charting
- Real-time data synchronization
- Multi-language support
- Advanced user permissions
- Integration with external APIs

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.

## Support

For support, please open an issue in the GitHub repository or contact the development team.

---

Built with ❤️ using Flutter and Fluent UI
