part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsIsLoadingState extends SettingsState {}

class SettingsLoadedState extends SettingsState {}

class SettingsErrorState extends SettingsState {}

class ChangeModeIsLoadingState extends SettingsState {}

class ChangeModeSuccessState extends SettingsState {}

class ChangeModeErrorState extends SettingsState {}

class ChangeLanguageIsLoadingState extends SettingsState {}

class ChangeLanguageSuccessState extends SettingsState {}

class ChangeLanguageErrorState extends SettingsState {}
