# prompt_result

Проект создан на Flutter 3.35.3

#### Проверить, какая версия флаттера у вас установлена, в терминале из корня проекта
```shell 
flutter --version 
```
скачать установить фреймворк можно по гайду в документации флаттер https://docs.flutter.dev/get-started/quick

#### После установки окружения, установите зависимости
```shell 
flutter pub get 
```

#### Сгенерируйте файлы
```shell 
dart run build_runner build --delete-conflicting-outputs 
```

#### Если устанавливаете новые локали (переводы) или просто новые тексты, сгенерируйте локазизацию intl
```shell 
dart run intl_utils:generate 
```

#### Чтобы заменить иконку приложения, разместите в assets/app_icon.png картинку без прозрачных полей и закруглений, а затем сгенерируйте иконки приложения командой
```shell 
dart run flutter_launcher_icons
```

#### Запустить код можно на iOS-симуляторе для этого нужно установить Xcode 16.2 (на других версиях Xcode запуск не тестировался)
```shell 
flutter run
```

#### Короткое видео с основными функциями:
[Demo](https://github.com/user-attachments/assets/1b2d3d33-1d4f-40cf-be1d-73545570ea47)