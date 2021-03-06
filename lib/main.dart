import 'package:flutter/material.dart';
import 'package:flutter_app/locale/translations_delegate.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/rxdart/bloc_provider.dart';
import 'package:flutter_app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    //AppModel appModel = AppModel();
    final themeSelect = BlocProvider.of(context);
    return StreamBuilder(
      builder: _builder,
      stream: themeSelect.value,
      initialData: false,
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    return MaterialApp(
      title: 'Welcome to Flutter_study',
      theme: snapshot.data ? AppTheme().darkTheme : AppTheme().lightTheme,
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("zh"), Locale("en")],
      initialRoute: '/',
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [
        Ob1(),
      ],
    );
  }
}

class Ob1 extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    print('从${previousRoute?.settings?.name}到${route?.settings?.name}');
  }
}
