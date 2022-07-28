import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  List<String?> items;
  String? dropDownValue;
  MyDropDown({required this.items, required this.dropDownValue, Key? key})
      : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: widget.dropDownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: widget.items.map((String? items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items!),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.dropDownValue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
