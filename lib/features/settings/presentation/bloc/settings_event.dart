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
