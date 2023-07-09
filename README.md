# Todo - Flutter & Firebase

A Todo application with CRUD operations & Google Authentication built using Flutter and Firebase.

![](/.github/images/screenshots.png)

> **Note**: This project has two versions with different state management and routing techniques. [version 1.0](https://github.com/alvisjerome/todo-flutter-firebase/tree/version-1.0) is built using Provider and Navigator 1.0, while [version 2.0](https://github.com/alvisjerome/todo-flutter-firebase/tree/version-2.0) utilizes Riverpod and Go Router.

The architecture of the application is based on the [Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/).

## Firebase setup

To run the project, you'll need to set up Firebase. Refer to the [official documentation](https://firebase.google.com/docs/flutter/setup?platform=ios) for detailed instructions.

## Features

- **Google Authentication**
- **CRUD**: Users can create, view, edit, and delete their todos. Each todo consists of a title, description, and date.

## Packages in-use

These are some main packages used in the app:

#### v1.0

- [provider](https://pub.dev/packages/provider)
- [get_it](https://pub.dev/packages/get_it)
- [equatable](https://pub.dev/packages/equatable)
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [google_fonts](https://pub.dev/packages/google_fonts)

#### v2.0

Most of the packages are the same in v2.0, except for the following two added in place of `provider` and `get_it`:

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [go_router](https://pub.dev/packages/go_routert)
