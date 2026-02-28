import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:in_app_update/in_app_update.dart';
import 'package:resumemaker/bloc/resume_bloc.dart';
import 'package:resumemaker/bloc/resume_state.dart';
import 'package:resumemaker/bloc/resume_event.dart';
import 'package:resumemaker/utilities/app_config.dart';
import 'package:resumemaker/utilities/app_localizations.dart';
import 'package:resumemaker/screens/resume_form_screen.dart';
import 'package:resumemaker/screens/settings_screen.dart';
import 'package:resumemaker/screens/about_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    //_checkForUpdate();
  }

/*
Future<void> _checkForUpdate() async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (mounted) {
          _showUpdateDialog();
        }
      }
    } catch (e) {
      // Silently fail - update check is not critical
    }
  }*/

 /* void _showUpdateDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Update Available'),
            content: const Text(
              'A new version of Resume Maker is available on Play Store. Update now for the latest features and improvements!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Later'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  InAppUpdate.performImmediateUpdate();
                },
                child: const Text('Update Now'),
              ),
            ],
          ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          localizations.translate('dashboard'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(height: 50, color: Theme.of(context).colorScheme.primary),
            // 🔹 Modern Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        "assets/ic_launcher.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppConfig.appName}",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Version - ${AppConfig.appVersion}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Menu Items
            _DrawerItem(
              icon: Icons.dashboard_rounded,
              title: localizations.translate('dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _DrawerItem(
              icon: Icons.settings_rounded,
              title: localizations.translate('settings'),
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

            _DrawerItem(
              icon: Icons.info_rounded,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),

            const Spacer(),

            // 🔹 Divider + Version
            const Divider(thickness: 0.6),

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
              final isDarkMode =
                  Theme.of(context).brightness == Brightness.dark;
              return Center(
                child: Image.asset(
                  isDarkMode
                      ? "assets/emptyDraftDarkmode.png"
                      : "assets/emptyDraft.png",
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

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}
