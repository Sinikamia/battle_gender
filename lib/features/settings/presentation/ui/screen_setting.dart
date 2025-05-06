import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/settings/presentation/state/settings_bloc/settings_bloc.dart';
import 'package:battle_gender/features/settings/presentation/ui/screen_settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ScreenSetting extends StatelessWidget {
  const ScreenSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SettingsBloc(), child: const ScreenSettingsContent());
  }
}
