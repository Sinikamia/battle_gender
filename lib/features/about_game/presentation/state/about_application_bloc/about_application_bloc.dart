import 'package:battle_gender/features/about_game/presentation/state/about_application_bloc/about_application_event.dart';
import 'package:battle_gender/features/about_game/presentation/state/about_application_bloc/about_application_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutApplicationBloc
    extends Bloc<AboutApplicationEvent, AboutApplicationState> {
  AboutApplicationBloc() : super(const AboutApplicationState()) {
    on<AboutApplicationEvent>((event, emit) {});
  }
}
