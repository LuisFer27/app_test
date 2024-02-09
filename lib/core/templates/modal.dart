import 'package:flutter/material.dart';

class DataBottomSheet extends StatelessWidget {
  final List<Widget> fields;
  final Function()? addData;
  final Function(int)? updateData;
  final bool isNewData;
  final BuildContext? context;

  DataBottomSheet({
    required this.fields,
    this.context,
    this.addData,
    this.updateData,
    this.isNewData = true,
  });

  void _showBottomSheet() {
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context!,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context!).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...fields,
            const SizedBox(height: 20),
            // Aquí puedes agregar cualquier widget que necesites,
            // dependiendo de la lógica de tu aplicación
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _showBottomSheet();
    return Container();
  }
}
