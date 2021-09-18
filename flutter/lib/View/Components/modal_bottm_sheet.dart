import 'package:flutter/material.dart';
import 'package:flutter3/View/Components/button.dart';


modalBottomSheet({BuildContext context, VoidCallback onConfirmed}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      context: context,
      builder: (context) => Container(
            height: 120,
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        splashRadius: 18,
                        icon: Icon(
                          Icons.circle,
                          size: 18,
                          color: Color(0xfff03e3e).withOpacity(0.95),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        text: 'تایید',
                        buttonColor: Colors.teal,
                        onPressed: onConfirmed,
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Button(
                        text: 'لغو',
                        buttonColor: Colors.red,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
}
