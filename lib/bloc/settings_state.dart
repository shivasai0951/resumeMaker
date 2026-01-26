import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final double fontSize;
  final String languageCode;
  final bool isDarkMode;

  const SettingsState({
    this.fontSize = 14.0,
    this.languageCode = 'en',
    this.isDarkMode = false,
  });

  SettingsState copyWith({
    double? fontSize,
    String? languageCode,
    bool? isDarkMode,
  }) {
    return SettingsState(
      fontSize: fontSize ?? this.fontSize,
      languageCode: languageCode ?? this.languageCode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object?> get props => [fontSize, languageCode, isDarkMode];
}
