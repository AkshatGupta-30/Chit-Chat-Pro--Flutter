# Chit Chat Pro [![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/LICENSE)  


Chit Chat Pro is a cutting-edge application designed to emulate the functionalities of chat GPT, focusing on seamless communication and content creation. It integrates advanced features such as text-to-speech, speech-to-text, and image-to-text conversion, all wrapped in an efficient and user-friendly interface.

----

# Screenshots
| Home Screen | Text From Image Screen | Chat Screen | Details Screen |
| --- | --- | --- | --- |
| <img src="https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/assets/screenshots/home_view.jpg" alt="Home Screen" height="300"> | <img src="https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/assets/screenshots/text_from_image_view.jpg" alt="ext From Image Screen" height="300" width="135"> |  <img src="https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/assets/screenshots/chat_view.jpg" alt="Chat Screen" height="300"> | <img src="https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/assets/screenshots/details_screen.jpg" alt="Details Screen" height="300" width="135"> |

----

# Gif
| <img src="https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/assets/gifs/working.gif" height="600"> |
| --- |

----

<details>
<summary>Table of content</summary>

# Table of contents  
- [Features](#features)
- [Technical Stack](#technical-stack)
- [Dependencies](#dependencies-used)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Clone the Repository](#clone-the-repository)
  - [Configuration](#install-dependencies)
  - [Build and Run](#build-and-run)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [Special Thanks](#special-thanks)
- [License](#license)
- [Conclusion](#conclusion)
</details>

----

## Features
- **Conversational AI :** Leveraging the power of OpenAI's GPT, Chit Chat Pro offers users an engaging conversational AI experience. Users can have natural, flowing conversations with the app, receiving responses that are contextually relevant and surprisingly human-like.
- **Text to Speech :** Integrating ChatGPT features, the app can read out responses or any text input by the user in a natural-sounding voice, enhancing the interactive experience and accessibility for all users.
- **Speech to Text :** Users can speak directly to Chit Chat Pro, and leveraging speech recognition technologies alongside ChatGPT, the app converts spoken words into text, allowing for hands-free operation and a seamless conversational flow.
- **Image to Text with Contextual Understanding :** Beyond simple OCR, Chit Chat Pro can analyze images provided by the user, extract text, and understand the context or content of the image, thanks to the integration with advanced AI models. This allows for richer interactions, such as discussing the content of a book page or analyzing information from a screenshot.
- **Efficient and Intuitive UI :** The app's user interface is designed to be both efficient and intuitive, ensuring that users can easily navigate through its features and enjoy a seamless experience. The integration of ChatGPT features is done in a way that feels natural and enhances the overall usability of the app.

----

## Technical Stack
- **Flutter :** Chit Chat Pro is built using Flutter, Google's UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Flutter's widget-based architecture allows for the creation of a highly responsive and visually appealing user interface.
- **MVVM Architecture** The app adheres to the Model-View-ViewModel (MVVM) architecture, which facilitates a clear separation of concerns. This architecture enhances the maintainability and scalability of the app by dividing the user interface (View) from the business logic and data (ViewModel and Model), making it easier to manage and test.
- **GetX State Management :** For state management, Chit Chat Pro utilizes GetX, one of the most efficient and powerful state management solutions in Flutter. GetX not only manages state but also offers dependency injection and route management, contributing to the app's performance and reducing boilerplate code.
- **OpenAI API :** At the core of Chit Chat Pro's functionality is the integration with OpenAI's API, which powers the app's advanced features such as text-to-speech, speech-to-text, and image-to-text conversions. This integration allows Chit Chat Pro to leverage cutting-edge AI technologies to provide users with a seamless and intelligent communication experience.

----

## Dependencies Used
| [animated_text_kit](https://pub.dev/packages/animated_text_kit) | [circular_countdown](https://pub.dev/packages/circular_countdown) | [clipboard](https://pub.dev/packages/clipboard) | [fluentui_emoji_icon](https://pub.dev/packages/fluentui_emoji_icon)  | [flutter_tts](https://pub.dev/packages/flutter_tts)  | [get](https://pub.dev/packages/get) |
| --- | --- | --- | --- | --- | --- |
| [**google_mlkit_text_recognition**](https://pub.dev/packages/google_mlkit_text_recognition) | [**http**](https://pub.dev/packages/http) | [**image_cropper**](https://pub.dev/packages/image_cropper) | [**image_picker**](https://pub.dev/packages/image_picker) | [**speech_to_text**](https://pub.dev/packages/speech_to_text) | [**text_to_speech**](https://pub.dev/packages/text_to_speech) |

----

## Installation
Follow these steps to install and run Chit Chat Pro on your system.

### Prerequisites
Before you begin, ensure you have the following dependencies and tools installed:
- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK
- [Dependencies](#dependencies-used)

### Clone the Repository
1. Open your terminal or command prompt.
2. Use the following command to clone the ProjectName repository:
```git clone https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter.git```

### Install Dependencies
- Run the following command to install the required dependencies:
~~~bash
flutter pub get
~~~

### Build and Run
1. Connect your device or start an emulator.
2. To build and run the project, use the following command:
~~~bash
flutter run
~~~

This will build the project and install it on your connected device or emulator.

----

## Folder Structure
#### Here is the core folder structure which flutter provides.
```
chit_chat_pro/
|- android
|- assets
|- ios
|- lib
|- linux
|- macos
|- web
|- windows
```

#### Now, lets dive into the lib folder which has the main code for the application.
```
lib/
|- src/
|- utils/
|- main.dart
```

#### Src
This directory contains all the application level constants. The folder structure is as follows: 
```
src/
|- controllers/
|- models/
|- pages/
|- services/
```
- **controllers** - This folder containes Getx Controllers for different views.
- **models** - Contains all the models of the applications. For example, Song, Album, Artist, Playlist etc.
- **pages** - This folder is the main folder that contains the ui for the pages.
- **services** - Contains all the files for api calls.

#### Utils
This directory contains the common file(s) and utilities used in a project. The folder structure is as follows: 
```
utils/
|- constants/
|- sections/
|- widgets/
```
- **constants** - This directory contains all the application level constants.
- **enums** - This directory contains all the enums required in application.
- **sections** - Contains sections that are shared in one screen to make code compact.
- **widgets** - Contains the common widgets that are shared across multiple screens. For example, ListTile, Pop Up Buttons, Shimmers, etc.

----

## Contributing
We welcome contributions to ProjectName. If you would like to contribute to the development or report issues, please follow these guidelines:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them with descriptive messages.
4. Push your changes to your fork.
5. Submit a pull request to the main repository.

----

## Special Thanks
We extend our heartfelt gratitude to OpenAI for their exceptional APIs, which have been instrumental in empowering Chit Chat Pro with advanced conversational AI capabilities.

----

## License
Chit Chat Pro is licensed under the [**MIT License**](https://github.com/AkshatGupta-30/Chit-Chat-Pro--Flutter/blob/main/LICENSE)

----

## Conclusion
Chit Chat Pro leverages the power of OpenAI's APIs within a robust technical framework comprising Flutter, MVVM architecture, and GetX state management, to offer a superior AI-driven communication experience. Features like conversational AI, text-to-speech, and real-time translation are just the tip of the iceberg. We extend our deepest gratitude to OpenAI for their pivotal role in enabling these capabilities. As we look forward, Chit Chat Pro remains committed to innovation, aiming to continuously enhance user experience by harnessing the latest advancements in AI technology.