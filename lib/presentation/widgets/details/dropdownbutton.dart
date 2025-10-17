import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordering_app/constants/colors.dart';

class CustomDropDownButtonMenu extends StatefulWidget {
  final String text;
  const CustomDropDownButtonMenu({super.key, required this.text});

  @override
  State<CustomDropDownButtonMenu> createState() =>
      _CustomDropDownButtonMenuState();
}

class _CustomDropDownButtonMenuState extends State<CustomDropDownButtonMenu> {
  String? selectedGender;
  final List<String> genders = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(widget.text),
        style: GoogleFonts.questrial(
          textStyle: const TextStyle(
            color: MyColors.greyLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        value: selectedGender,
        items: genders.map((gender) {
          final isSelected = gender == selectedGender;
          return DropdownMenuItem<String>(
            value: gender,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    // ignore: deprecated_member_use
                    ? MyColors.white.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gender,
                    style: TextStyle(
                      color: isSelected ? MyColors.secondColor : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: MyColors.secondColor,
                      size: 18,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.white,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
      ),
    );
  }
}
