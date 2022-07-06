# justap

A new Flutter project.

## Getting Started

To run in a local environment:

**Make sure you have flutter installed**
> If not, refer to this document first to install flutter: https://docs.flutter.dev/get-started/install

In command line / terminal:

```
  cd justap
  flutter run lib/main.dart
```

> For other useful flutter command-line tools, check this document: https://docs.flutter.dev/reference/flutter-cli

### Android

#### How to build the production appbundle


```
$ flutter build appbundle --release --flavor prod -t lib/main_prod.dart --obfuscate --split-debug-info=/Users/dennis/Github/HiFive/build/app/outputs/bundle
```