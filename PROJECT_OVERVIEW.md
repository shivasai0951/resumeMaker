# Resume Maker App - Project Overview

## ✅ Completed Features

### 1. **Splash Screen**
- Displays app icon (document icon) in center
- Shows app name "Resume Maker"
- Shows version number (1.0.0)
- 3-second loading animation before navigating to dashboard

### 2. **Dashboard Screen**
- **Sidebar Navigation:**
  - Dashboard option
  - Settings option
  - Version number displayed at bottom
- **Main Content:**
  - Lists all saved resumes
  - Shows resume cards with name and contact
  - Empty state message when no resumes exist
  - Edit and Delete options for each resume
- **Floating Action Button:**
  - "Create Resume" button to add new resume

### 3. **Resume Form Screen**
- **Basic Information Fields:**
  - Full Name (required)
  - Contact (required)
  - Address (required)
  - LinkedIn (optional)
  - Website (optional)
  - Description (required)

- **Dynamic Sections with Add/Remove:**
  - **Education:** Institution, Degree, Field of Study, Start Date, End Date, Grade
  - **Experience:** Company, Position, Start Date, End Date, Description, Currently Working checkbox
  - **Skills:** Skill Name, Skill Level (Beginner/Intermediate/Advanced/Expert)
  - **Certificates:** Name, Issuer, Date, Credential ID

- **Action Buttons:**
  - **Save:** Saves resume to local storage (Hive database)
  - **Create PDF:** Shows template selection dialog with 3 options:
    - Classic Template
    - Modern Template
    - Minimal Template
  - PDF saved as `{fullname}_resume.pdf` in device documents folder

### 4. **Settings Screen**
- **Font Size Control:**
  - Slider to adjust font size (10-24)
  - Real-time preview of changes
  
- **Language Selection:**
  - English
  - Hindi (हिंदी)
  - Telugu (తెలుగు)
  - Full app localization support
  
- **Dark Mode Toggle:**
  - Switch between light and dark themes
  - Persisted across app restarts

### 5. **PDF Generation Service**
Three professional templates:
- **Classic:** Traditional resume layout with clear sections
- **Modern:** Contemporary design with colored accents and modern styling
- **Minimal:** Clean, minimalist design with elegant typography

### 6. **Data Persistence**
- **Hive Database:** Stores all resume data locally
- **SharedPreferences:** Stores user settings (font size, language, dark mode)
- All data persists across app restarts

### 7. **App Configuration**
- Centralized configuration file (`app_config.dart`)
- Customizable colors, themes, and app constants
- Easy to modify app version and branding

## 📁 Project Structure

```
lib/
├── bloc/
│   ├── resume_bloc.dart          # Resume state management
│   ├── resume_event.dart
│   ├── resume_state.dart
│   ├── settings_bloc.dart        # Settings state management
│   ├── settings_event.dart
│   └── settings_state.dart
├── screens/
│   ├── splash_screen.dart        # Splash screen with icon & version
│   ├── dashboard_screen.dart     # Main dashboard with sidebar
│   ├── resume_form_screen.dart   # Form with all fields & dynamic sections
│   └── settings_screen.dart      # Settings for font, language, theme
├── service/
│   └── pdf_service.dart          # PDF generation with 3 templates
├── utilities/
│   ├── app_config.dart           # App colors, version, theme config
│   ├── app_localizations.dart    # Multi-language support
│   ├── models.dart               # Data models (Resume, Education, etc.)
│   └── models.g.dart             # Generated Hive adapters
└── main.dart                     # App initialization & setup
```

## 🎨 Features Breakdown

### Multi-Language Support
- English, Hindi, and Telugu translations
- All UI elements localized
- Easy to add more languages

### State Management
- BLoC pattern for clean architecture
- Separate BLoCs for resumes and settings
- Reactive UI updates

### Local Storage
- Hive for structured resume data
- SharedPreferences for user settings
- Fast and efficient data access

### PDF Templates
1. **Classic:** Professional traditional layout
2. **Modern:** Contemporary with blue accents
3. **Minimal:** Clean and elegant design

## 🚀 How to Run

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📱 App Flow

1. **Splash Screen** (3 seconds) → **Dashboard**
2. **Dashboard** → Click "Create Resume" → **Resume Form**
3. **Resume Form** → Fill details → Click "Save" → Back to **Dashboard**
4. **Resume Form** → Fill details → Click "Create PDF" → Select Template → PDF Generated
5. **Dashboard** → Open Sidebar → Click "Settings" → **Settings Screen**
6. **Settings** → Adjust font size, change language, toggle dark mode

## 🎯 Key Technologies

- **Flutter** - UI Framework
- **BLoC** - State Management
- **Hive** - Local Database
- **SharedPreferences** - Settings Storage
- **PDF Package** - PDF Generation
- **Flutter Localizations** - Multi-language Support

## 📝 Notes

- All resumes are stored locally on the device
- PDF files are saved in the device's documents directory
- Settings persist across app restarts
- App supports both light and dark themes
- Fully responsive design

## 🔧 Customization

To customize the app:
- **Colors:** Edit `lib/utilities/app_config.dart`
- **Version:** Edit `lib/utilities/app_config.dart` (appVersion)
- **Languages:** Add translations in `lib/utilities/app_localizations.dart`
- **PDF Templates:** Modify `lib/service/pdf_service.dart`

## ✨ All Requirements Met

✅ Splash screen with icon, name, and version
✅ Dashboard with bottom "Create Resume" button
✅ Complete form with all requested fields
✅ Dynamic sections for education, experience, skills, certificates
✅ Save functionality (local storage with Hive)
✅ Create PDF with 3 template options
✅ PDF naming as `{username}_resume.pdf`
✅ Resume list display on dashboard
✅ Sidebar with Settings and Version
✅ Settings: Font size adjustment
✅ Settings: Language selection (Telugu, Hindi, English)
✅ Settings: Dark mode toggle
✅ Centralized configuration file for colors and version
