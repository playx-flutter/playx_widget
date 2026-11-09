# Contributing

1. Fork and create a branch from `qa`.
2. `flutter pub get`
3. Make your change, add or update tests in `test/`.
4. Run the checks CI runs:
   ```sh
   dart format --set-exit-if-changed .
   flutter analyze
   flutter test
   ```
5. Update `CHANGELOG.md` and open a pull request targeting `qa`.

Releases: merging `qa` into `main` triggers the publish workflow, so bump `version` in `pubspec.yaml`
and add a changelog entry first.

## API docs

```sh
dart pub global activate dartdoc
dart pub global run dartdoc
```

Docs are published to GitHub Pages automatically when `main` changes.
