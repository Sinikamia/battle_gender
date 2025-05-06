import 'package:battle_gender/features/settings/presentation/state/settings_bloc/settings_event.dart';
import 'package:battle_gender/features/settings/presentation/state/settings_bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsEvent>((event, emit) {});
  }
}
