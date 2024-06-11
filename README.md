# PiggyBank Project

## Project Overview

"PiggyBank" is a mobile application developed using Flutter, a popular open-source UI software development kit created by Google. The app is designed to help users achieve their financial goal, by keeping track of their saving. Firebase serves as the backend for this application, providing robust, scalable, and real-time database functionalities along with authentication and cloud storage capabilities.

## Key Features

1. **User Authentication**:
   - Implemented using Firebase Authentication.
   - Supports email/password sign-up and login, ensuring secure user access.
   
2. **Progress Tracking**:
   - Users can record adding to or withdrawing from their piggy bank.
   - For each piggy bank, users can set a target amount or save without a target.

3. **Real-time Data Synchronization**:
   - Firebase Firestore is used to store user data.
   - Real-time synchronization across devices, ensuring data consistency and availability.

4. **Data Visualization**:
   - Uses charts and graphs to represent saving patterns for each piggy bank.
   - Provides insights into financial habits, helping users stay on track with their saving goals.

## Technical Implementation

- **Frontend (Flutter)**:
  - Utilized Flutter’s widget-based architecture for building a responsive and intuitive user interface.
  - Implemented state management using Bloc for structured and predictable state handling.

- **Backend (Firebase)**:
  - **Firebase Firestore**: A NoSQL cloud database used to store and sync data in real-time.
    - Structured the database to separate user-specific data ensuring data privacy and scalability.
  - **Firebase Authentication**: Simplified user authentication processes, enhancing security and user management.

- **Architecture**:
  - Employed a four-layer architecture for code organization and maintainability:
    1. **Presentation Layer**: Handles the UI using Flutter widgets.
    2. **Application Layer**: Manages application logic and state using Bloc.
    3. **Domain Layer**: Defines business logic and entities.
    4. **Data Layer**: Manages data retrieval and storage, integrating with Firebase.

## Challenges and Solutions
  
- **State Management**:
  - **Challenge**: Managing complex states across various parts of the app.
  - **Solution**: Adopted Bloc for state management, which allowed for efficient state handling and improved performance.

- **Code Organization**:
  - **Challenge**: Maintaining a clean and organized codebase as the project grew.
  - **Solution**: Implemented a four-layer architecture to separate concerns, making the codebase more modular and maintainable.

## Learning Outcomes

- **Flutter Development**:
  - Gained hands-on experience in building cross-platform mobile applications.
  - Improved understanding of Flutter’s widget tree and state management using Bloc.

- **Backend Integration**:
  - Learned to integrate and leverage Firebase services.

- **Problem-Solving**:
  - Improved ability to debug and optimize app performance.

- **Code Organization**:
  - Learned the importance of a structured codebase using a four-layer architecture, which facilitated better code management and scalability.

## Conclusion

The "PiggyBank" project showcases my ability to develop a fully-functional, user-friendly mobile application using Flutter and Firebase. It highlights my skills in frontend development, backend integration, state management with Bloc, and code organization using a four-layer architecture.
