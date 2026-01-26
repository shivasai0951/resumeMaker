import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resumemaker/bloc/resume_bloc.dart';
import 'package:resumemaker/bloc/resume_event.dart';
import 'package:resumemaker/bloc/settings_bloc.dart';
import 'package:resumemaker/bloc/settings_event.dart';
import 'package:resumemaker/bloc/settings_state.dart';
import 'package:resumemaker/screens/splash_screen.dart';
import 'package:resumemaker/utilities/app_config.dart';
import 'package:resumemaker/utilities/app_localizations.dart';
import 'package:resumemaker/utilities/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(EducationAdapter());
  Hive.registerAdapter(ExperienceAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(CertificateAdapter());
  Hive.registerAdapter(ResumeAdapter());

  final resumeBox = await Hive.openBox<Resume>('resumes');
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(resumeBox: resumeBox, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final Box<Resume> resumeBox;
  final SharedPreferences prefs;

  const MyApp({super.key, required this.resumeBox, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResumeBloc(resumeBox)..add(LoadResumes()),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(prefs)..add(LoadSettings()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            theme: AppConfig.getLightTheme(settingsState.fontSize),
            darkTheme: AppConfig.getDarkTheme(settingsState.fontSize),
            themeMode:
                settingsState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            locale: Locale(settingsState.languageCode),
            supportedLocales: const [Locale('en'), Locale('hi'), Locale('te')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
