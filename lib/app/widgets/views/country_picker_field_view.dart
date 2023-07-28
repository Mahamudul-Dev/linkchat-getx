// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';

class CountryPickerFieldView extends StatefulWidget {
  const CountryPickerFieldView({super.key, required this.controller});
  final controller;

  @override
  State<CountryPickerFieldView> createState() => _CountryPickerFieldViewState();
}

class _CountryPickerFieldViewState extends State<CountryPickerFieldView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: ThemeProvider().isSavedLightMood().value ? white : blackAccent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
            color:
                ThemeProvider().isSavedLightMood().value ? white : transparentBlack),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (Country country) => setState(() {
                      widget.controller.selectedCountry = country;
                    }),
                    showPhoneCode: false,
                    favorite: ['US', 'CA'],
                  );
                },
                child: Text (widget.controller.selectedCountry != null
                        ? widget.controller.selectedCountry!.flagEmoji +' '+ widget.controller.selectedCountry!.name
                        : 'No Country Selected')
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
