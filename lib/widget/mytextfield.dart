import 'package:flutter/material.dart';
import 'package:yourlist1/util/color.dart';

class Mytextfield extends StatelessWidget {
  late String titleTextField;
  late String hintTextField;
  late TextEditingController controller;
  late bool isshow;
  Mytextfield({
    super.key,
    required this.titleTextField,
    required this.hintTextField,
    required this.controller,
    required this.isshow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: GetSize().getWidth(context) * 0.8,
      height: GetSize().getHeight(context) * 0.09,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(titleTextField),
          ),
          TextField(
            obscureText: isshow,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintTextField,
              hintStyle: const TextStyle(color: Colors.grey, letterSpacing: 1),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Viền bo tròn
                borderSide: BorderSide.none, // Không có đường viền
              ),
            ),
          ),
        ],
      ),
    );
  }
}
