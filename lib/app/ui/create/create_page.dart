import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? selectedValue;
  final List<String> items = ['Apple', 'Banana', 'Grapes', 'Mango'];
  bool isFindlocation = true;
  @override
  void initState() {
    selectedValue = items.first; // ค่าเริ่มต้น
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Create Location'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      isFindlocation = !isFindlocation;
                      log("isFindlocation:$isFindlocation");
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isFindlocation ? Colors.amber : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_city),
                          SizedBox(width: 8),
                          CustomText(text: "Find Location", size: 16),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isFindlocation = !isFindlocation;
                      log("isFindlocation:$isFindlocation");
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isFindlocation ? Colors.white : Colors.amber,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_city),
                          SizedBox(width: 8),
                          CustomText(text: "Find Location", size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2 * 255),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    isExpanded: true,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items:
                        items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
