// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
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
  "Already_registered_Login": "Already registered? Login!"
};
static const Map<String,dynamic> ru = {
  "Age": "Возраст",
  "City": "Город",
  "SAVE": "CОХРАНИТЬ",
  "Nickname": "Имя",
  "Search": "Поиск",
  "Name": "Название",
  "Description": "Описание",
  "CANCEL": "ОТМЕНА",
  "creating_a_category": "создание категории",
  "EMAIL": "ПОЧТА",
  "PASSWORD": "ПАРОЛЬ",
  "Login": "Войти",
  "Not_registered_yet_Register": "Ещё не зарегистрировался(-ась)? Регистрируйся!",
  "Already_registered_Login": "Уже зарегистрирован? Войди!"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
