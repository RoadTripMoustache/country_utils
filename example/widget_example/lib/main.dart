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
    title: "country_utils - Widgets",
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
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RTMCountryFlag(countryCode: "JPN"),
          RTMCountryFlag(countryCode: "au"),
          RTMCountryFlag(countryCode: "De"),
          RTMCountryPicker(onChanged: (Country c) => c.name),
          RTMCountryPicker(
            builder:
                (Country? country) => Container(
                  width: 400,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Select a country"),
                ),
            onChanged: (Country c) => c.name,
          ),
          RTMCountryPicker(
            buttonBuilder:
                (Country? country, VoidCallback onTap) => TextButton(
                  onPressed: onTap,
                  child: Text("Select a country"),
                ),
            onChanged: (Country c) => c.name,
          ),
          RTMCountriesPicker(onChanged: (List<Country> c) => c.length),
          RTMCountriesPicker(
            builder: (List<Country> countryList) => Text("Select a country"),
            onChanged: (List<Country> c) => c.length,
          ),
          RTMCountriesPicker(
            buttonBuilder:
                (List<Country> countryList, VoidCallback onTap) => TextButton(
                  onPressed: onTap,
                  child: Text("Select a country"),
                ),
            onChanged: (List<Country> c) => c.length,
          ),
        ],
      ),
    ),
  );
}
