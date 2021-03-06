
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';
import 'package:salla/features/settings/data/repositories/settings_repo_imp.dart';
import 'package:salla/features/settings/domain/repositories/settings_repo.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepo settingsRepo;

  SettingsBloc({required this.settingsRepo}) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is GetSettingsEvent) {
        emit(SettingsIsLoadingState());
        try {
          SettingsModel settingsModel = await settingsRepo.getSetting();
          settings = settingsModel;
          emit(SettingsLoadedState());
        } catch (error) {
          emit(SettingsErrorState());
        }
      }
      if (event is ChangeThemeModeEvent) {
        try {
          emit(ChangeModeIsLoadingState());

          await SharedPreferencesCache.setValue(key: 'mode', value: event.value)
              .then((value) {
            UserData.themeMode =
                (SharedPreferencesCache.getValue(key: 'mode') == null) ||
                        (SharedPreferencesCache.getValue(key: 'mode') == false)
                    ? ThemeModeSetting.light
                    : ThemeModeSetting.dark;
          // ignore: avoid_print
          }).then((value) => print(UserData.themeMode.toString()));

          emit(ChangeModeSuccessState());
        } catch (error) {
          emit(ChangeModeErrorState());
        }
      }
      if (event is ChangeLanguageEvent) {
        try {
          emit(ChangeLanguageIsLoadingState());

          await SharedPreferencesCache.setValue(key: 'lang', value: event.value)
              .then((value) {
            UserData.language =
                (SharedPreferencesCache.getValue(key: 'lang') == null) ||
                        (SharedPreferencesCache.getValue(key: 'lang') == 'en')
                    ? Language.english
                    : Language.arabic;
          // ignore: avoid_print
          }).then((value) => print(UserData.language.toString()));
          emit(ChangeLanguageSuccessState());
        } catch (error) {
          emit(ChangeLanguageErrorState());
        }
      }
      if (event is UpdateProfileEvent) {
        emit(UpdateProfileIsLoadingState());
        try {
          SettingsModel settingsModel = await settingsRepo.updateSetting(
              event.name, event.email, event.phoneNum);
          if (settingsModel.status) {
            settings = settingsModel;
            emit(UpdateProfileSuccessState(message: settings!.message));
          } else {
            emit(UpdateProfileErrorState(error: settingsModel.message.toString()));
          }
        } catch (error) {
          emit(UpdateProfileErrorState(error: error.toString()));
        }
      }

      // TODO: implement event handler
    });
  }

  static SettingsBloc get(context) => BlocProvider.of(context);
  SettingsModel? settings;
}
