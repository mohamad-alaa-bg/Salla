import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';
import 'package:salla/features/settings/data/repositories/settings_repo_imp.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepoImp settingsRepoImp;

  SettingsBloc({required this.settingsRepoImp}) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is GetSettingsEvent) {
        emit(SettingsIsLoadingState());
        try {
          SettingsModel settingsModel = await settingsRepoImp.getSetting();
          settings = settingsModel;
          emit(SettingsLoadedState());
        } catch (error) {
          print(error);
          emit(SettingsErrorState());
        }
      }
      if (event is ChangeThemeModeEvent) {
        try {
          emit(ChangeModeIsLoadingState());
          print(event.value);

          await SharedPreferencesCache.setValue(key: 'mode', value: event.value)
              .then((value) {
            UserData.themeMode =
                (SharedPreferencesCache.getValue(key: 'mode') == null) ||
                        (SharedPreferencesCache.getValue(key: 'mode') == false)
                    ? ThemeModeSetting.light
                    : ThemeModeSetting.dark;
          }).then((value) => print(UserData.themeMode.toString()));

          emit(ChangeModeSuccessState());
        } catch (error) {
          emit(ChangeModeErrorState());
        }
      }
      if (event is ChangeLanguageEvent) {
        try {
          emit(ChangeLanguageIsLoadingState());
          print(event.value);

          await SharedPreferencesCache.setValue(key: 'lang', value: event.value)
              .then((value) {
            UserData.language =
            (SharedPreferencesCache.getValue(key: 'lang') == null) ||
                (SharedPreferencesCache.getValue(key: 'lang') == 'en')
                ? Language.english
                : Language.arabic;
          }).then((value) => print(UserData.language.toString()));
          emit(ChangeLanguageSuccessState());
        } catch (error) {
          emit(ChangeLanguageErrorState());
        }
      }
      // TODO: implement event handler
    });
  }

  static SettingsBloc get(context) => BlocProvider.of(context);
  SettingsModel? settings;
}
