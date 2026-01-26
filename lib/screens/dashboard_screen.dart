import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resumemaker/bloc/resume_bloc.dart';
import 'package:resumemaker/bloc/resume_state.dart';
import 'package:resumemaker/bloc/resume_event.dart';
import 'package:resumemaker/utilities/app_config.dart';
import 'package:resumemaker/utilities/app_localizations.dart';
import 'package:resumemaker/screens/resume_form_screen.dart';
import 'package:resumemaker/screens/settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.translate('dashboard'))),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppConfig.primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.description, size: 60, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    AppConfig.appName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text(localizations.translate('dashboard')),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(localizations.translate('settings')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${localizations.translate('version')} ${AppConfig.appVersion}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ResumeBloc, ResumeState>(
        builder: (context, state) {
          if (state is ResumeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResumeLoaded) {
            if (state.resumes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.translate('no_resumes'),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.resumes.length,
              itemBuilder: (context, index) {
                final resume = state.resumes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(resume.fullName),
                    subtitle: Text(
                      '${localizations.translate('contact')}: ${resume.contact}',
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  const Icon(Icons.edit, size: 20),
                                  const SizedBox(width: 8),
                                  Text(localizations.translate('edit')),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    localizations.translate('delete'),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ResumeFormScreen(resume: resume),
                            ),
                          );
                        } else if (value == 'delete') {
                          _showDeleteDialog(context, resume.id, localizations);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ResumeFormScreen(resume: resume),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ResumeError) {
            return Center(
              child: Text(
                '${localizations.translate('error')}: ${state.message}',
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ResumeFormScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(localizations.translate('create_resume')),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String id,
    AppLocalizations localizations,
  ) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(localizations.translate('delete_resume')),
            content: Text(localizations.translate('delete_confirmation')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(localizations.translate('cancel')),
              ),
              TextButton(
                onPressed: () {
                  context.read<ResumeBloc>().add(DeleteResume(id));
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  localizations.translate('delete'),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
