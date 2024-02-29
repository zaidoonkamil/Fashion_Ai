import 'package:fashion/core/styles/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
        this.hintText,
        this.onTap,
        this.textInputType,
        this.width,
        this.height,
        this.validate,
        this.controller,
        this.onTapp,
        this.enabledBorder,
        this.onChanged,
        this.textAlign,
        this.prefixIcon,
        this.colorBorderContent,
        this.textStyleHint,
        this.circleDecouration,
        this.validationPassed,
        this.obscureText = false
      }) : super(key: key);

  void Function(String)? onTapp;
  void Function()? onTap;
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  double? width;
  double? height;
  double? circleDecouration=6;
  bool? obscureText;
  TextInputType? textInputType;
  TextAlign? textAlign;
  TextStyle? textStyleHint;
  Color? enabledBorder;
  Color? colorBorderContent;
  Widget? prefixIcon;
  void Function(String)? onChanged;
  bool? validationPassed=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:validationPassed==false? 46:88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circleDecouration??6),
            color: colorBorderContent?? lightFormFieldBackColor,
          ),
          child: TextFormField(
            onChanged: onChanged,
            onFieldSubmitted: onTapp,
            onTap: onTap,
            controller: controller,
            keyboardType:textInputType?? TextInputType.text ,
            textAlign:textAlign?? TextAlign.left,
            textAlignVertical: TextAlignVertical.bottom,
            obscureText: obscureText!,
            validator: validate,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: textStyleHint?? TextStyle(
                color: hintTextFormColor,
              ),
              disabledBorder: InputBorder.none,
              fillColor:  Theme.of(context).primaryColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0), // Border when focused
                borderRadius: BorderRadius.circular(circleDecouration??6),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(circleDecouration ??6),
                borderSide: BorderSide(
                    color:enabledBorder?? Theme.of(context).iconTheme.color!, width: 1.0), // Border when not focused
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:Theme.of(context).primaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
