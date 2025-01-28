import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/settings_repository.dart';
import '/models/settings.dart';

// Events
abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  final Settings settings;
  UpdateSettings(this.settings);
}

// States
abstract class SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Settings settings;
  SettingsLoaded(this.settings);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}

// BLoC
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc({required this.repository}) : super(SettingsLoading()) {
    on<LoadSettings>((event, emit) async {
      emit(SettingsLoading());
      try {
        final settings = await repository.getSettings();
        emit(SettingsLoaded(settings));
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    });

    on<UpdateSettings>((event, emit) async {
      emit(SettingsLoading());
      try {
        await repository.updateSettings(event.settings);
        emit(SettingsLoaded(event.settings));
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    });
  }
}

