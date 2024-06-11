# PiggyBank Project

## Project Overview

"PiggyBank" is a mobile application developed using Flutter, a popular open-source UI software development kit created by Google. The app is designed to help users manage their personal finances efficiently. Firebase serves as the backend for this application, providing robust, scalable, and real-time database functionalities along with authentication and cloud storage capabilities.

## Key Features

1. **User Authentication**:
   - Implemented using Firebase Authentication.
   - Supports email/password sign-up and login, ensuring secure user access.
   
2. **Expense Tracking**:
   - Users can add, edit, and delete expenses.
   - Categorize expenses (e.g., groceries, entertainment, utilities) for better tracking.

3. **Budget Management**:
   - Set monthly budgets and monitor spending against these budgets.
   - Visual feedback provided via progress bars and alerts when budgets are nearing limits.

4. **Real-time Data Synchronization**:
   - Firebase Firestore used to store user data.
   - Real-time synchronization across devices, ensuring data consistency and availability.

5. **Data Visualization**:
   - Use charts and graphs to represent spending patterns and budget adherence.
   - Provides insights into financial habits, helping users make informed decisions.

## Technical Implementation

- **Frontend (Flutter)**:
  - Utilized Flutter’s widget-based architecture for building a responsive and intuitive user interface.
  - Implemented state management using Bloc for structured and predictable state handling.

- **Backend (Firebase)**:
  - **Firebase Firestore**: A NoSQL cloud database used to store and sync data in real-time.
    - Structured the database to separate user-specific data ensuring data privacy and scalability.
  - **Firebase Authentication**: Simplified user authentication processes, enhancing security and user management.
  - **Firebase Cloud Storage**: Used for storing user-uploaded receipts and other documents.
  - **Firebase Cloud Functions**: Implemented server-side logic such as sending email notifications for budget alerts.

- **Architecture**:
  - Employed a four-layer architecture for code organization and maintainability:
    1. **Presentation Layer**: Handles the UI using Flutter widgets.
    2. **Application Layer**: Manages application logic and state using Bloc.
    3. **Domain Layer**: Defines business logic and entities.
    4. **Data Layer**: Manages data retrieval and storage, integrating with Firebase.

## Challenges and Solutions

- **Real-time Data Handling**:
  - **Challenge**: Ensuring real-time synchronization without performance lags.
  - **Solution**: Leveraged Firebase Firestore's real-time listeners, which automatically update the UI upon data changes.
  
- **State Management**:
  - **Challenge**: Managing complex states across various parts of the app.
  - **Solution**: Adopted Bloc for state management, which allowed for efficient state handling and improved performance.

- **Code Organization**:
  - **Challenge**: Maintaining a clean and organized codebase as the project grew.
  - **Solution**: Implemented a four-layer architecture to separate concerns, making the codebase more modular and maintainable.

- **User Authentication and Data Security**:
  - **Challenge**: Implementing secure authentication and ensuring data privacy.
  - **Solution**: Utilized Firebase Authentication for secure user sign-in methods and Firestore’s built-in security rules to protect user data.

## Learning Outcomes

- **Flutter Development**:
  - Gained hands-on experience in building cross-platform mobile applications.
  - Improved understanding of Flutter’s widget tree and state management using Bloc.

- **Backend Integration**:
  - Learned to integrate and leverage Firebase services for real-time data handling and user authentication.
  - Enhanced skills in structuring and managing a NoSQL database.

- **Problem-Solving**:
  - Developed problem-solving skills by addressing real-world issues such as real-time data sync and state management.
  - Improved ability to debug and optimize app performance.

- **Code Organization**:
  - Learned the importance of a structured codebase using a four-layer architecture, which facilitated better code management and scalability.

## Conclusion

The "PiggyBank" project showcases my ability to develop a fully-functional, user-friendly mobile application using Flutter and Firebase. It highlights my skills in frontend development, backend integration, state management with Bloc, and code organization using a four-layer architecture. This project demonstrates my technical capabilities and project management skills effectively.
