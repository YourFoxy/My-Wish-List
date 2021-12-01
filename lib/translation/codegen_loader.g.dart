// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "Age": "Age",
    "City": "City",
    "SAVE": "SAVE",
    "Nickname": "Nickname",
    "Search": "Search",
    "Name": "Name",
    "Description": "Description",
    "CANCEL": "CANCEL",
    "creating_a_category": "creating a category",
    "EMAIL": "EMAIL",
    "PASSWORD": "PASSWORD",
    "Login": "Login",
    "Not_registered_yet_Register": "Not registered yet? Register!",
    "Already_registered_Login": "Already registered? Login!",
    "Name_of_new_category": "Name of new category",
    "Image": "Image",
    "Video": "Video",
    "REGISTER": "REGISTER",
    "Check_SingIn_email_password":
        "Can't SignIn you! Please check your email/password",
    "Check_Register_email_password":
        "Can't Register you! Please check your email/password"
  };
  static const Map<String, dynamic> ru = {
    "Age": "Возраст",
    "City": "Город",
    "SAVE": "СОХРАНИТЬ",
    "Nickname": "Имя",
    "Search": "Поиск",
    "Name": "Название",
    "Description": "Описание",
    "CANCEL": "ОТМЕНА",
    "creating_a_category": "создание категории",
    "EMAIL": "ПОЧТА",
    "PASSWORD": "ПАРОЛЬ",
    "Login": "Войти",
    "Not_registered_yet_Register":
        "Ещё не зарегистрировался(-ась)? Регистрируйся!",
    "Already_registered_Login": "Уже зарегистрирован? Войди!",
    "Name_of_new_category": "Название новой категории",
    "Image": "Картинка",
    "Video": "Видео",
    "REGISTER": "Зарегистрироваться",
    "Check_SingIn_email_password":
        "Вы не можете войти! Проверьте свою почту/пароль",
    "Check_Register_email_password":
        "Вы не можете зарегистрироваться! Проверьте свою почту/пароль"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "ru": ru
  };
}
