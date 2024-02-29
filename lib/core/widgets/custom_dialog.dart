import 'package:flutter/material.dart';

import 'custom_button.dart';

Future<void> customDialog(BuildContext context,String title,String text,) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon:Image.asset(
          'assets/images/img.png',
          width: double.maxFinite,
          height: 120,),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              Text(title,textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyText2,),
              const SizedBox(height:10),
              Text(text,style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.end),
              const SizedBox(height:26),
              Row(
                children: [
                  Expanded(child: CustomBottom(text: 'الغاء', colorBottom: Theme.of(context).bottomNavigationBarTheme.backgroundColor!)),
                  const SizedBox(width:14),
                  Expanded(child: CustomBottom(text: 'تاكيد', colorBottom: Theme.of(context).dividerColor)),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
