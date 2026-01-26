import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ChangeFontSize extends SettingsEvent {
  final double fontSize;

  const ChangeFontSize(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}

class ChangeLanguage extends SettingsEvent {
  final String languageCode;

  const ChangeLanguage(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class ToggleDarkMode extends SettingsEvent {
  final bool isDark;

  const ToggleDarkMode(this.isDark);

  @override
  List<Object?> get props => [isDark];
}
