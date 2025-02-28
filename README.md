# Whereabouts 

Whereabouts is a real-time location-sharing app built with Flutter for the frontend and powered by Firebase and Cloud Functions on the backend. It allows users to share their live location with friends, see others on a map, and manage privacy settings seamlessly.

## Features

- Real-time location sharing
- Interactive map view with friend markers
- Privacy controls (choose who can see your location)
- Notifications for location updates
- Firebase Authentication
- Backend powered by Firebase Firestore and Cloud Functions

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase
    - Firestore (Database)
    - Firebase Authentication
    - Cloud Functions (Node.js)
    - Google maps API

## Getting Started

### Prerequisites

- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- Firebase project set up ([Firebase Console](https://console.firebase.google.com/))
- Node.js for Cloud Functions

### Setup

1. **Clone the repo:**

```bash
git clone https://github.com/your-repo/whereabouts.git
cd whereabouts
```

1. **Set up Firebase:**

- Create a new Firebase project
- Enable Firestore, Firebase Authentication, and Cloud Functions
- Download your `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place them in the respective folders

1. **Install dependencies:**

```bash
flutter pub get
```

1. **Run the app:**

```bash
flutter run
```

### Deploy Cloud Functions

1. Navigate to the `functions` directory:

```bash
cd functions
```

1. Install dependencies:

```bash
npm install
```

1. Deploy functions:

```bash
firebase deploy --only functions
```

## Screenshots
You can find the screenshots in the screenshots folder in the root directory
## Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.
## License
MIT License
Hello