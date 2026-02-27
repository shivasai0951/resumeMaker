import 'package:flutter/material.dart';
import 'package:resumemaker/utilities/app_config.dart';
import 'package:resumemaker/utilities/app_localizations.dart';
import 'package:resumemaker/widgets/modern_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: ModernAppBar(title: localizations.translate('about')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Icon
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.description,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // App Name
          Center(
            child: Text(
              AppConfig.appName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // App Version
          Center(
            child: Text(
              'Version ${AppConfig.appVersion}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 32),

          // App Description
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About This App',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Resume Maker is a professional resume builder app that helps you create beautiful resumes with multiple templates. Choose from Basic, Classic, or Modern templates and customize them to your needs.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // App Link
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text('App Link'),
            subtitle: const Text('View on Play Store'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchUrl(AppConfig.appLink),
          ),
          const Divider(),

          // More Apps Link
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('More Apps'),
            subtitle: const Text('Explore our other apps'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchUrl(AppConfig.moreAppsLink),
          ),
          const Divider(),

          // Privacy Policy Link
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            subtitle: const Text('Read our privacy policy'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchUrl(AppConfig.privacyPolicyLink),
          ),
          const Divider(),

          const SizedBox(height: 32),

          // Developer Info
          Center(
            child: Text(
              '© 2024 Resume Maker',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Made with ❤️',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
