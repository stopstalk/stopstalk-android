# StopStalk App

Being made using flutter.

## Documentation and prerequisites
Download the flutter SDK from the sources below

* [Install Flutter](https://flutter.dev/get-started/)
* [Flutter documentation](https://flutter.dev/docs)

1. Follow the official docs to download flutter and set up Android Studio
2. In the official docs, the editor used is Android Studio, but VSCode can also be used.
3. Few sample apps are bundled along when you download flutter. You can try running those first to see if the editor and flutter are all set up fine. 

## Getting Started

A few resources to get you started and give a basic understanding with examples of how flutter works:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view [online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Deployment

1. Open the stopstalk_app folder in Android Studio.
2. It will detect that execution will begin at the main.dart file (present inside the lib folder).
3. Download an android emulator in the android studio or connect it to your phone(in debug mode) to run the app.
4. Copy .env.sample to .env
5. When the app builds for the first time it might take a while for it to get launched.
6. All the code that we have to work with is present in the lib folder.
7. To install any additional packages, first write its name under dependencies in file "pubspec.yaml". Then, run the command `flutter pub get`. The packages will be installed.
8. To upgrade any package version, run the command `flutter pub upgrade`.
9. The screens folder contains the basic layout of each individual page. We add more widgets and make up the UI of the page.
10. The widgets folder has individual widgets which can be used on multiple pages or are large in size and would reduce the readabilty and make a single page's code too long. 
11. Before making a pull request, format the code with `Ctrl+Alt+L`. Add a comma after all the closing brackets as it will help the IDE in aligning the brackets and formatting the code. For more on this checkout [Code Formatting](https://flutter.dev/docs/development/tools/formatting) .



