import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/theme.dart';

// Events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

// States
class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(AppTheme.lightTheme));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ToggleTheme) {
      if (state.themeData == AppTheme.lightTheme) {
        yield ThemeState(AppTheme.darkTheme);
      } else {
        yield ThemeState(AppTheme.lightTheme);
      }
    }
  }
}

