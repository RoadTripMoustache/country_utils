# Country Code Utils

![Pub Version](https://img.shields.io/pub/v/country_utils) [![GitHub stars](https://img.shields.io/github/stars/RoadTripMoustache/country_utils?style=social)](https://github.com/psk907/fluttermoji/stargazers)

A Flutter package providing easy access to country names, ISO codes *(alpha-2, alpha-3, numeric)*, and more. Streamline your development with convenient functions for country data retrieval and manipulation.

---

## Usage
If you want to have ready-to-use examples of the library, please check [`example/README.md`](./example/README.md). You will find there all the example projects for all the services, widgets...

### Prerequisites
To use one of the **69 supported languages** when using a widget from this library, you need to add `CountryLocalizations.delegate` in the list of your app delegates.

```dart
return new MaterialApp(
      supportedLocales: [
         Locale("en"),
         Locale("es"),
         ...
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        ...
      ],
      ...
);
```

### Call the services
```dart
// To get all the countries
final List<Country> countries = CountryService.getCountries();

// To get a country by its ISO Code
final Country country = CountryService.getCountryByCode("FR");
```

### Use a widget
```dart
// Display the japanese flag
RTMCountryFlag(countryCode: "JP")

// Display a customizable button to select a country
RTMCountryPicker()

// Display a customizable button to select multiple countries
RTMCountriesPicker()
```

---

## Features
### Models
#### Country
Currently a `Country` object contains :
- the localized name
- the ISO Code Alpha 2 *(ex: "US" for the United-States)*
- the ISO Code Alpha 3 *(ex: "FRA" for France)*
- the dial code

### Services
#### CountryService
|Method|Params|Returned type|Description|
|---|---|---|---|
|getCountryByCode|String countryCode|Country?|Retrieve the country with the [countryCode] given in parameter. It can be the ISO code Alpha 2 or 3 which can be used. If no countries are find, returns `null`.|
|getCountries|*/*|List<Country>|Returns the list of countries.|

### Widgets
#### RTMCountryFlag
Displays the flag of a selected country. The country is defined by the ISO code given to the widget. It can be the ISO Code Alpha 2 or Alpha 3 which can be used.

*Both of the following examples will display the japanese flag.*
```dart
// ISO Code Alpha 2 example
RTMCountryFlag(countryCode: "JP")

// ISO Code Alpha 3 example
RTMCountryFlag(countryCode: "JPN")
```

To have more information on all the other parameters of this widget, please check the [widget class here](./lib/src/widgets/country_flag.dart).

#### RTMCountryPicker
Fully customizable widget which displays a button which opens a dialog allowing the user to select a country. In the dialog, a text field is available to let the user filter countries on the name, ISO code or dial code.

```dart
// Default country picker which display the selected country on change
RTMCountryPicker(onChanged: (Country c) => print(c))

// Picker with a custom widget to display the selector and/or the selection. The widget will be wrapped in an InkWell
RTMCountryPicker(
    builder: (Country c) => Text("Select a country"),
    onChanged: (Country c) => print(c),
)

// Picker with a custom widget to display the selector and/or the selection which will trigger the dialog opening on calling the VoidCallback parameter
RTMCountryPicker(
    buttonBuilder: (Country? country, VoidCallback onTap) =>
        TextButton(
            onPressed: onTap,
            child: Text("Select a country"),
        ),
    onChanged: (Country c) => c.name,
),
```

#### RTMCountriesPicker
Fully customizable widget which displays a button which opens a dialog allowing the user to select a list of country. In the dialog, a text field is available to let the user filter countries on the name, ISO code or dial code.

```dart
// Default countries picker which display the selected country on change
RTMCountriesPicker(onChanged: (List<Country> c) => print(c))

// Picker with a custom widget to display the selector and/or the selection. The widget will be wrapped in an InkWell
RTMCountriesPicker(
    builder: (List<Country> countryList) => Text("Select countries"),
    onChanged: (List<Country> c) => print(c),
)

// Picker with a custom widget to display the selector and/or the selection which will trigger the dialog opening on calling the VoidCallback parameter
RTMCountriesPicker(
    buttonBuilder: (List<Country> countryList, VoidCallback onTap) =>
        TextButton(
            onPressed: onTap,
            child: Text("Select countries"),
        ),  
    onChanged: (List<Country> c) => print(c),
),
```

---

## Supported languages
- af - Afrikaans
- am - Amharic
- ar - Arabic
- az - Azerbaijani
- be - Belarusian
- bg - Bulgarian
- bn - Bengali
- bs - Bosnian
- ca - Catalan
- cs - Czech
- da - Danish
- de - German
- el - Greek
- en - English
- es - Spanish
- et - Estonian
- fa - Persian
- fi - Finnish
- fr - French
- gl - Galician
- ha - Hausa
- he - Hebrew
- hi - Hindi
- hr - Croatian
- hu - Hungarian
- hy - Armenian
- id - Indonesian
- is - Icelandic
- it - Italian
- ja - Japanese
- ka - Georgian
- kk - Kazakh
- km - Central Khmer
- ko - Korean
- ku - Kurdish
- ky - Kyrgyz
- lt - Lithuanian
- lv - Latvian
- mk - Macedonian
- ml - Malayalam
- mn - Mongolian
- ms - Malay
- nb - Bokmal
- nl - Dutch
- nn - Norwegian Nynorsk
- no - Norwegian
- pl - Polish
- ps - Pushto
- pt - Portuguese
- ro - Romanian
- ru - Russian
- sd - Sindhi
- sk - Slovak
- sl - Slovenian
- so - Somali
- sq - Albanian
- sr - Serbian
- sv - Swedish
- ta - Tamil
- tg - Tajik
- th - Thai
- tr - Turkish
- tt - Tatar
- ug - Uighur
- ur - Urdu
- uz - Uzbek
- vi - Vietnamese
- zh - Chinese


---

## Contributing

Wants to contribute to this project ? And don't know where to start ? Please check our [contributing](./CONTRIBUTING.md) documentation to explain how the code is structured and how to proceed.

Any help is heartily appreciated, whatever if you code or open issues. 😀

--- 

## Credits

- [imtoori/CountryCodePicker](https://github.com/imtoori/CountryCodePicker.git) - For countries names translations, flags, `CountryLocalizations` and the widgets.