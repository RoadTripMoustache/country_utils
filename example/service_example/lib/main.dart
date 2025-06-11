import "package:country_utils/country_utils.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: [CountryLocalizations.delegate],
    supportedLocales: [Locale("en"), Locale("es")],
    title: "country_utils - Services",
    locale: Locale("es"),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Country? country = CountryService.getCountryByCode("JPN");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(country?.name ?? "Country not found")],
        ),
      ),
    );
  }
}
