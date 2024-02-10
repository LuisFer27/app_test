import 'package:flutter/material.dart';

class DataBottomSheetTemplate extends StatelessWidget {
  final List<Widget> fields;

  const DataBottomSheetTemplate({
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
        left: 15,
        right: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...fields,
        ],
      ),
    );
  }
}
