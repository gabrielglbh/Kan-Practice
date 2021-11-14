# KanPractice

A simple app for studying the japanese vocabulary you will learn in your japanese learning journey based on cards with meaning, pronunciation and kanji.

Build your own word or sentences lists and study them whenever you want.

## Code Structure for Contributing

Code is based on 2 main folders: `ui` and `core`, with self explanatory meanings. On `main.dart` you will find the main `Widget` that runs the app with all of its configuration.

### `Core`

Subdivided in:

- `database`: related code for database management (creation of db, queries, db models and helper constants).
- `firebase`: related code for firebase and backup management (services of back up and authentication, queries and firebase models).
- `preferences`: related code for the Shared Preferences helper to store key-value data in the device.
- `routing`: related code for managing the routing of the pages of the app.
- `utils`: code that is purely functional and that is used across the app.

Please, refer to the comments to better understand the code.

### `UI`

Subdivided in:

- `pages`: the different pages are subdivided in their respective folder, each one having their own bloc management (when needed).
- `theme`: purely UI code as colors, theming, heights...
- `widgets`: UI components with functional elements that are reused across the app.

## Firebase replica

If you want to replicate this app on your device with a custom back-end, fork the repo and include your own Google Services files for iOS or Android. 

Make sure your back-end matches the models described in code, although you can also change them to match yours!

## Don't Forget It

Feel free to contribute with PRs maintaining and respecting the code structure :)

