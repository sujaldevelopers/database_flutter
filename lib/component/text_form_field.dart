import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constrain.dart';

class MyTextFormField extends StatelessWidget {
  final String? lable;
  final List<TextInputFormatter>? textinputformater;
  final TextEditingController controller;
  final String? Function(String?)? validater;
  final int? maxLength;
  final int? maxLine;
  final TextInputType? keybordtype;
  final String? hintText;
  final bool abscorbing;
  final void Function()? onTap;

  const MyTextFormField({
    super.key,
    this.lable,
    this.textinputformater,
    required this.controller,
    this.validater,
    this.maxLength,
    this.maxLine,
    this.keybordtype,
    this.hintText,
    this.abscorbing=false,
    this.onTap,
  });

  OutlineInputBorder border({
    Color color = primary,
    double width = 1.0,
  }) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: color,
          width: width,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "$lable",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
        InkWell(
          onTap: abscorbing ? onTap : null,
          child: AbsorbPointer(
            absorbing: abscorbing,
            child: TextFormField(
              controller: controller,
              cursorColor: primary,
              validator: validater,
              maxLength: maxLength,
              maxLines: maxLine,
              keyboardType: keybordtype,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: primary,
              ),
              inputFormatters: textinputformater,
              decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  hintText: hintText,
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                  border: border(
                    width: 0.75,
                  ),
                  focusedBorder: border(
                      color: primary,
                      width: 1.2
                  ),
                  disabledBorder: border(
                    width: 0.75,
                  ),
                  enabledBorder: border(
                    width: 0.75,
                  )
              ),
            ),
          ),
        )
      ],
    );
  }
}
