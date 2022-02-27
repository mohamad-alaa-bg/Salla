import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/features/settings/data/models/settings_model.dart';
import 'package:salla/features/settings/data/repositories/settings_repo_imp.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepoImp settingsRepoImp;
  SettingsBloc({required this.settingsRepoImp}) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async{
      if(event is GetSettingsEvent){
        emit(SettingsIsLoadingState());
        try{
          SettingsModel settingsModel = await settingsRepoImp.getSetting();
          settings =settingsModel;
          emit(SettingsLoadedState());
        }catch(error){
          print(error);
          emit(SettingsErrorState());
        }
      }
      // TODO: implement event handler
    });
  }

  static SettingsBloc get(context) => BlocProvider.of(context);
  SettingsModel? settings;
}
