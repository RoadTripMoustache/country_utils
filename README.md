# Country Code Utils

A Flutter package providing easy access to country names, ISO codes (alpha-2, alpha-3, numeric), and more. Streamline your development with convenient functions for country data retrieval and manipulation.

---

## How to use it ?
### Prerequisites
#### i18n
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

---

## Contributing

Wants to contribute to this project ? And don't know where to start ? Please check our [contributing](./CONTRIBUTING.md) documentation to explain how to proceed.

Any help is heartly appreciated, whatever if you code or open issues. 😀

--- 

## Credits

- [imtoori/CountryCodePicker](https://github.com/imtoori/CountryCodePicker.git) - For countries names translations, flags and `CountryLocalizations`.