import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminInventoryTextfeildWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String? label;
  final String? hint;
  final GlobalKey<FormState>? lol;

  AdminInventoryTextfeildWidget({
    this.hint,
    required this.controller,
    Key? key,
    this.label,
    this.lol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Offset in x and y direction
            ),
          ],
        ),
        child: Form(
          key: lol,
          child: TextFormField(
            minLines: 1,
            maxLines: 5,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return null;
            },
            controller: controller,
            textDirection:
                TextDirection.rtl, // Ensures RTL text direction for Arabic.
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: Theme.of(context).textTheme.displaySmall,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5), // Add border radius
                borderSide: BorderSide.none, // Remove the border
              ), // Remove the border
              filled: true, // Ensure the background is filled
              fillColor: Colors.white, // Background color
            ),
          ),
        ),
      ),
    );
  }
}
