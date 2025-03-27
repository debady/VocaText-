
import 'package:flutter/material.dart';
import 'package:vocatext/pages/page_accueil.dart';
import 'package:vocatext/pages/page_choix_type_identifie.dart';
import 'package:vocatext/pages/profile_setup_page.dart';
import 'package:vocatext/pages/record_screen.dart';
import 'package:vocatext/pages/splash_screen.dart';
import 'package:vocatext/pages/import_screen.dart';
import 'package:vocatext/pages/settings_screen.dart';

/// Class that handles all the routes in the application
class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String profileSetuppage = '/profileSetuppage';
  static const String record = '/record';
  static const String import = '/import';
  static const String settings = '/settings';

  /// Function to generate routes with the required parameters
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == splash) {
      return MaterialPageRoute(
        builder: (_) => SplashScreen(),
      );
    } else if (routeSettings.name == home) {
      return MaterialPageRoute(
        builder: (_) => HomeScreen(),
      );
    } else if (routeSettings.name == record) {
      return MaterialPageRoute(
        builder: (_) => RecordScreen(),
      );
    } else if (routeSettings.name == import) {
      return MaterialPageRoute(
        builder: (_) => ImportScreen(),
      );
    } 
    
    else if (routeSettings.name == settings) {
      return MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      );
    } 
    
    else if (routeSettings.name == login) {
      return MaterialPageRoute(
        builder: (_) => LoginMethodPage(),
      );
    } 
    
    else if (routeSettings.name == profileSetuppage) {
      return MaterialPageRoute(
        builder: (_) => ProfileSetupPage(),
      );
    } 
    
    else {
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${routeSettings.name}'),
          ),
        ),
      );
    }
  }
}

