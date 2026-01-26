import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences prefs;

  SettingsBloc(this.prefs) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeFontSize>(_onChangeFontSize);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ToggleDarkMode>(_onToggleDarkMode);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final fontSize = prefs.getDouble('fontSize') ?? 14.0;
    final languageCode = prefs.getString('languageCode') ?? 'en';
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;

    emit(
      SettingsState(
        fontSize: fontSize,
        languageCode: languageCode,
        isDarkMode: isDarkMode,
      ),
    );
  }

  Future<void> _onChangeFontSize(
    ChangeFontSize event,
    Emitter<SettingsState> emit,
  ) async {
    await prefs.setDouble('fontSize', event.fontSize);
    emit(state.copyWith(fontSize: event.fontSize));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    await prefs.setString('languageCode', event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode));
  }

  Future<void> _onToggleDarkMode(
    ToggleDarkMode event,
    Emitter<SettingsState> emit,
  ) async {
    await prefs.setBool('isDarkMode', event.isDark);
    emit(state.copyWith(isDarkMode: event.isDark));
  }
}
