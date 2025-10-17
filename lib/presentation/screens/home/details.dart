import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/widgets/auth/custommaterialbutton.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';
import 'package:ordering_app/presentation/widgets/details/textformfield.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late TextEditingController weightController;
  late TextEditingController heightController;
  late TextEditingController ageController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double bmr = 0.0;

  String? selectedGender;
  final List<String> genders = ["Male", "Female"];

  void checkCurrentPage() {
    if (myBox!.get("bmr") != null) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    checkCurrentPage();
    weightController = TextEditingController();
    heightController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      if (selectedGender == "Male") {
        bmr =
            (666.47 +
            (13.75 * double.parse(weightController.text)) +
            (5.00 * double.parse(heightController.text)) -
            (6.75 * double.parse(ageController.text)));
        log("BMR: $bmr");
      } else {
        bmr =
            (655.1 +
            (9.56 * double.parse(weightController.text)) +
            (1.85 * double.parse(heightController.text)) -
            (4.67 * double.parse(ageController.text)));
        log("BMR: $bmr");
      }

      myBox!.delete("bmr");

      setState(() {
        myBox!.put("bmr", bmr.toStringAsFixed(2));
      });

      // Navigator.of(context).pushReplacementNamed(AppRoutes.menuScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 50.0,
        bottom: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      child: customBodyDetails(
        screenSize.width,
        theme.textTheme.headlineSmall!,
      ),
    );
  }

  Widget customBodyDetails(double? minWidth, TextStyle textStyle) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            "Gender",
            MyColors.greyDark,
            EdgeInsets.only(bottom: 15.0),
          ),
          customDropDownButtonMenu("Choose Your Gender"),
          SizedBox(height: 30.0),
          customText(
            "Weight",
            MyColors.greyDark,
            EdgeInsets.only(bottom: 15.0),
          ),
          CustomTextFormFieldDetails(
            style: textStyle,
            hintText: "Enter your weight",
            prefixText: "Kg",
            controller: weightController,
            onChanged: (value) {
              setState(() {});
              weightController.text = value;
            },
          ),
          SizedBox(height: 20.0),
          customText(
            "Height",
            MyColors.greyDark,
            EdgeInsets.only(bottom: 15.0),
          ),
          CustomTextFormFieldDetails(
            style: textStyle,
            hintText: "Enter your Height",
            prefixText: "Cm",
            controller: heightController,
            onChanged: (value) {
              setState(() {
                heightController.text = value;
              });
            },
          ),
          SizedBox(height: 20.0),
          customText("Age", MyColors.greyDark, EdgeInsets.only(bottom: 15.0)),
          CustomTextFormFieldDetails(
            style: textStyle,
            hintText: "Enter your Age",
            prefixText: "",
            controller: ageController,
            onChanged: (value) {
              setState(() {
                ageController.text = value;
              });
            },
          ),

          SizedBox(height: 50.0),
          (myBox!.get("bmr") != null)
              ? Center(
                  child: customText(
                    "You Score ${myBox!.get("bmr")} Calories",
                    MyColors.orange,
                    EdgeInsets.only(bottom: 15.0),
                  ),
                )
              : Center(
                  child: customText(
                    "You Score 0 Calories",
                    MyColors.orange,
                    EdgeInsets.only(bottom: 15.0),
                  ),
                ),

          Spacer(),
          CustomMaterialButton(
            color:
                weightController.text.isNotEmpty &&
                    heightController.text.isNotEmpty &&
                    ageController.text.isNotEmpty
                ? MyColors.orange
                : MyColors.grey03,
            height: 60.0,
            minWidth: minWidth,
            onPressed: () {
              login();
            },
            radius: 12.0,
            child: customText(
              "Calculate", //"Next",
              weightController.text.isNotEmpty &&
                      heightController.text.isNotEmpty &&
                      ageController.text.isNotEmpty
                  ? MyColors.whiteObasity
                  : MyColors.greyDark,
              EdgeInsets.all(0.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget customDropDownButtonMenu(String text) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(text),
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
          log("selectedGender: ${selectedGender.toString()}");
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

  Widget customText(
    String text,
    Color color,
    EdgeInsetsGeometry? padding, {
    TextAlign? textAlign,
  }) {
    return CustomText(
      textAlign: textAlign,
      title: text,
      padding: padding,
      textStyle: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
