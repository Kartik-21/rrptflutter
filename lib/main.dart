import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rrptflutter/blocs/FavouriteScreenBloc/favouritescreen_bloc.dart';
import 'package:rrptflutter/blocs/HomeScreenBloc/homescreen_bloc.dart';
import 'package:rrptflutter/screens/drawer_screen/AboutScreen.dart';
import 'package:rrptflutter/screens/DrawerHomeScreen.dart';
import 'package:rrptflutter/screens/drawer_screen/FavouriteScreen.dart';
import 'package:rrptflutter/screens/FirstScreen.dart';
import 'package:rrptflutter/screens/drawer_screen/HomeScreen.dart';
import 'package:rrptflutter/screens/drawer_screen/NotificationScreen.dart';
import 'package:rrptflutter/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rrptflutter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeScreenBloc(),
          child: HomeScreen(),
        ),
        BlocProvider(
          create: (context) => FavouriteScreenBloc(),
          child: FavouriteScreen(),
        )
      ],
      child: MaterialApp(
          title: "RRPT",
          debugShowCheckedModeBanner: true,
          home: FirstScreen(),
          theme: ThemeData(
              primaryColor: Colors.indigo,
              accentColor: Colors.indigoAccent,
              brightness: Brightness.dark,
              fontFamily: "ManropSemiBold"),
          initialRoute: '/',
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routes: <String, WidgetBuilder>{
            "/login": (context) => LoginScreen(),
            "/favourite": (context) => FavouriteScreen(),
            "/notification": (context) => NotificationScreen(),
            "/about": (context) => AboutScreen(),
          }),
    );
  }
}
