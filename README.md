# Exam System App

This is a Flutter app that serves as an Exam System. The app includes features like a splash screen, user authentication, and different functionalities based on user types (student or teacher). It integrates with Firebase for authentication and database operations.

## Features

### 1. Splash Screen

- The app includes a splash screen that displays for a few seconds.
- During this time, it checks if the user is logged in.

### 2. Authentication

- If the user is logged in, the app retrieves the user's type from the Firebase database.
- If the user is a student, it shows a list of exams uploaded by the teacher.
- If the user is a teacher, it displays all student results and allows the creation of new exams.
- If no user is logged in, it shows a login screen for authentication or the option to create a new account.

### 3. Student Functionality

- Students can view a list of exams uploaded by teachers.
- Clicking on an exam opens the exam page, where they can submit answers and view results.

### 4. Teacher Functionality

- Teachers can view results of all students.
- Teachers can create new exams to be taken by students.

## Dependencies

- [Firebase](https://pub.dev/packages/firebase) - for authentication and database operations.
- [Flutter](https://flutter.dev) - the UI toolkit used to build the app.

## Getting Started

1. Clone the repository.

```bash
git clone https://github.com/your-username/exam_system_app.git
cd exam_system_app
