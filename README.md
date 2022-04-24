# Blitz GUI

This repository contains apps and libraries related to the Blitz GUI project. This a frontend application to be used with the [blitz_api](https://github.com/fusion44/blitz_api) backend.  

The user interface is realized using the [Flutter](https://www.flutter.dev) framework and [flutter-pi](https://github.com/ardera/flutter-pi) to make it run natively on a Raspberry PI.  

## Disclaimer

This is very much under development and might contain serious bugs. Don't use it in production, yet.

## Develop

### Repository information
This is a monorepo which contains multiple apps and libraries. The shell app in `lib/main.dart` currently does nothing but exit when run. Currently there are two apps available:

* `setup_app`: An app to help setting up a new RaspiBlitz. Located in `packages/apps/setup_app`
* `blitz_app`: The main RaspiBlitz Desktop app. Located in `packages/apps/setup_app`

### Dependencies

* **Blitz API**

  To develop this application, make sure you have an instance of [blitz_api](https://github.com/fusion44/blitz_api) running and reachable.

* **Flutter**

  If you are new to Flutter follow the install instructions for your OS: [Flutter Docs](https://flutter.dev/docs/get-started/install).

  > :information_source: Flutter has opt-out analytics which can be disabled by running `flutter config --no-analytics`.

### Run the apps
* Run an app locally:
  * With make: `make run-linux`
     * Use `make` without any arguments to print a help message with all available options 
  * With flutter directly `flutter run -d linux` (or windows, or macosx, or chrome). Make sure to run this not in the base folder but in each apps specific folder in `packages/apps/app_name`  

## Contribute

If you find any issues, please report them via the [Github issue tracker](https://github.com/fusion44/blitz_api/issues).
If you are interested in helping developing the software, you are very welcome to submit ideas to the issue tracker and help by opening pull requests.

## LICENSE

MIT - See the [LICENSE](LICENSE) file.
