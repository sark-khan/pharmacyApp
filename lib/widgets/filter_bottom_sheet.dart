import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';

class FiltersBottomSheet extends StatefulWidget {
  @override
  _FiltersBottomSheetState createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  Map<String, bool> departments = {
    'Orthopedics': false,
    'Cardiology': false,
    'Ophthalmology': false,
    "abc": false
  };

  Map<String, bool> treatmentAreas = {
    'Orthopedics': false,
    'Cardiology': false,
    'Ophthalmology': false,
  };

  String selectedSort = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.doctorScreenBackgroudColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fixed Header
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Filters & Sorting",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: _buildFilterSections(),
                ),
              ),
            ],
          ),
        ),

        // Close Button positioned 20px above the top border, outside the clipped area
        Positioned(
          top: -62,
          left: (MediaQuery.of(context).size.width / 2) - 24,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/close_icon.png",
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSections() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        children: [
          _buildFilterSection("Departments", [
            _buildCheckbox("Orthopedics", departments['Orthopedics']!),
            _buildCheckbox("Cardiology", departments['Cardiology']!),
            _buildCheckbox("abc", departments['abc']!),
            _buildCheckbox("abc", departments['abc']!),
            _buildCheckbox("Ophthalmology", departments['Ophthalmology']!),
          ]),
          SizedBox(height: 10),
          _buildFilterSection("Treatment Areas", [
            _buildCheckbox("Orthopedics", treatmentAreas['Orthopedics']!),
            _buildCheckbox("Cardiology", treatmentAreas['Cardiology']!),
            _buildCheckbox("Ophthalmology", treatmentAreas['Ophthalmology']!),
          ]),
          SizedBox(height: 10),
          _buildFilterSection("Sort", [
            _buildRadio(
                "Doctor’s Rating: High to low", "Doctor’s Rating: High to low"),
            _buildRadio("Hospital’s Rating: High to low",
                "Hospital’s Rating: High to low"),
            _buildRadio("Price: High to low", "Price: High to low"),
          ]),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<Widget> childrens) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _buildSectionTitle(title),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: childrens,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        )),
      ),
    );
  }

  Widget _buildCheckbox(String label, bool isSelected) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxTheme(
            data: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4), // Rounded square corners
              ),
              side: BorderSide(
                color: Color.fromRGBO(
                    208, 218, 227, 1), // Border color to match your image
                width: 1, // Border width
              ),
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary;
                }
                return Colors.transparent;
              }), // Transparent fill when unchecked
              checkColor:
                  WidgetStateProperty.all(Colors.white), // Color when checked
            ),
            child: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  departments[label] = value!;
                });
              },
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.5))),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String label, String value) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedSort,
          focusColor: Colors.transparent,
          onChanged: (newValue) {
            setState(() {
              selectedSort = newValue!;
            });
          },
          activeColor: AppColors.primary,
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.5))),
        ),
      ],
    );
  }
}
