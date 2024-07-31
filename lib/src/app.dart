import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gophermart/const/app_colors.dart';
import 'package:gophermart/const/app_ui.dart';
import 'package:gophermart/src/authPage/auth_page.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      cardTheme: CardTheme(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      primaryColor: AppColors.appColor,
      primarySwatch: AppColors.appColor,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor:
              AppColors.mainPageBannerBackgroundColor, //сделать цветом баннера
          titleSpacing: 0.0,
          shadowColor: Colors.transparent,
          foregroundColor: AppColors.textColorDarkGray,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          )),
      textTheme: Theme.of(context).textTheme.copyWith(
          titleMedium: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w500)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(minimumSize: AppUi.buttonMinSize)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: AppUi.buttonMinSize)),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(minimumSize: AppUi.buttonMinSize)),
    );

    // Glue the SettingsController to the MaterialApp.

    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',
          theme: theme,

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.

          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          home: _getSplash(),

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },
        );
      },
    );
  }

  _getSplash() {
    return FlutterSplashScreen.gif(
      gifPath: 'assets/images/gopher.gif',
      gifWidth: 269,
      nextScreen: AuthPage(),
      backgroundColor: AppColors.mainPageBannerBackgroundColor,
      gifHeight: 474,
      duration: const Duration(milliseconds: 3515),
      onInit: () async {
        debugPrint("onInit");
      },
      onEnd: () async {
        debugPrint("onEnd 1");
      },
    );
  }
}
