part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
class SettingsIsLoadingState extends SettingsState{}
class SettingsLoadedState extends SettingsState{}
class SettingsErrorState extends SettingsState{}
