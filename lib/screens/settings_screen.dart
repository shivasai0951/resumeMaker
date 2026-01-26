import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resumemaker/bloc/settings_bloc.dart';
import 'package:resumemaker/bloc/settings_event.dart';
import 'package:resumemaker/bloc/settings_state.dart';
import 'package:resumemaker/utilities/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('settings'))),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.translate('font_size'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('${state.fontSize.toInt()}'),
                          Expanded(
                            child: Slider(
                              value: state.fontSize,
                              min: 10,
                              max: 24,
                              divisions: 14,
                              label: state.fontSize.toInt().toString(),
                              onChanged: (value) {
                                context.read<SettingsBloc>().add(
                                  ChangeFontSize(value),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.translate('language'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      RadioListTile<String>(
                        title: Text(localizations.translate('english')),
                        value: 'en',
                        groupValue: state.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(
                              ChangeLanguage(value),
                            );
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(localizations.translate('hindi')),
                        value: 'hi',
                        groupValue: state.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(
                              ChangeLanguage(value),
                            );
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(localizations.translate('telugu')),
                        value: 'te',
                        groupValue: state.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(
                              ChangeLanguage(value),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: SwitchListTile(
                  title: Text(localizations.translate('dark_mode')),
                  subtitle: Text(
                    state.isDarkMode ? 'On' : 'Off',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: state.isDarkMode,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(ToggleDarkMode(value));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
