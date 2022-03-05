part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class GetSettingsEvent extends SettingsEvent {}

class ChangeThemeModeEvent extends SettingsEvent {
  final bool value;

  ChangeThemeModeEvent({required this.value});
}

class ChangeLanguageEvent extends SettingsEvent {
  final String value;

  ChangeLanguageEvent({required this.value});
}

class UpdateProfileEvent extends SettingsEvent {
  final String email;
  final String name;
  final String phoneNum;

  UpdateProfileEvent(
      {required this.email, required this.name, required this.phoneNum});
}
