# Chit Chat Pro [![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/AkshatGupta-30/Sonicity--Flutter/blob/main/LICENSE)  


Chit Chat Pro is a cutting-edge application designed to emulate the functionalities of chat GPT, focusing on seamless communication and content creation. It integrates advanced features such as text-to-speech, speech-to-text, and image-to-text conversion, all wrapped in an efficient and user-friendly interface.

----

details>
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
| [**google_ml_kit**](https://pub.dev/packages/google_ml_kit) | [**http**](https://pub.dev/packages/http) | [**image_cropper**](https://pub.dev/packages/image_cropper) | [**image_picker**](https://pub.dev/packages/image_picker) | [**speech_to_text**](https://pub.dev/packages/speech_to_text) | [**text_to_speech**](https://pub.dev/packages/text_to_speech) |