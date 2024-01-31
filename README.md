# Speech to Text

A Terms and Conditions Displaying App

### For get_id and injectable, run either of the commands:

If you want the generator to run one time and exits use

```
dart run build_runner build --delete-conflicting-outputs
```

Make sure you always Save your files before running the generator, if that does not work you can
always try to clean and rebuild.

```
dart run build_runner clean
```

### For running in ios devices

Navigate to ios directory, then run

```
pod deintegrate
pod install
```

For M1 devices, install ffi first

```
sudo arch -x86_64 gem install ffi
```

then

```
pod deintegrate
arch -x86_64 pod install
```

### For checking unused files

```
dart run dart_code_metrics:metrics check-unused-files lib 
``````

### For static analyser

```
flutter analyze 
```


