# Inqvine Starter

This is the starter template for the Inqvine system.

## Before

1) Make sure the application name is correct in `application_constants`
2) Add the Firebase plist and json files for each flavor into the Android and iOS folders
3) Remove references to Inqvine Starter for the project name, include Android folder paths in src

## Documentation

Each section of documentation is self contained within their own README files.  
to get started, make sure you have the Mermaid diagram extension for your browser and then view the below links.  

Chrome Extension URL: `https://chrome.google.com/webstore/detail/github-%20-mermaid/goiiopgdnkogdbjmncgedmgpoajilohe`  
Firefox Extension URL: `https://addons.mozilla.org/en-GB/firefox/addon/github-mermaid/`

If you plan to preview these within your development environment, I would recommend also installing the Mermaid VSCode extension: `https://marketplace.visualstudio.com/items?itemName=vstirbu.vscode-mermaid-preview`

## Getting Started

The client code is built on the Google Flutter stack.  
Before you attempt to run the code, make sure you have this installed by following Googles documentation at: `https://flutter.dev/docs/get-started/install`

Run the following command to start the application: `flutter run --flavor %PROJECT_FLAVOUR%`

Where `%PROJECT_FLAVOUR%` is either `local`, `dev`, or `prod`.

## Compiling Proto

All the database objects are created and scoped using the protobuf templating language.  
This allows for easy use between different programming languages, as well as statically typed condition checks against the objects.  

Before you can compile, please follow the documentation at `https://developers.google.com/protocol-buffers/docs/darttutorial` to get protoc installed for your system.

Then run the following from the root of your project: `protoc --dart_out=grpc:lib -Ipb proto/*.proto --proto_path .`

## Building Localizations

The application is localized to work across multiple languages.  
In order to run the generator once a config file has been updated in `resources/langs` run the following commands:  

1) `flutter pub run easy_localization:generate`  
2) `flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart`  