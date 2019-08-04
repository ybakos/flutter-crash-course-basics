# Flutter Crash Course 1: Basics

My implementation of Nick Manning's app from the [Flutter Crash Course 1: Basics](https://fluttercrashcourse.com) and [Course 2](https://fluttercrashcourse.com). **If you are new to Flutter development, you should absolutely buy his courses**, they are very good.

## Development

The app uses some codegen a la json_serializable, json_annotation, and build_runner.
These generated files are not in the repo, so be sure to generate them:

```
flutter pub run build_runner build
```

The app also relies on two web service endpoints:

- http://fluttercrashcourse.com/api/v1/locations
- http://fluttercrashcourse.com/api/v1/locations/&lt;id&gt;

