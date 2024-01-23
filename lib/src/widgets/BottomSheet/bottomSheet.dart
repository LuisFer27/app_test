import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
  final int? id;
  final TextEditingController titleController;
  final TextEditingController descController;
  final void Function() onAdd;

  const BottomSheet({
    required this.id,
    required this.titleController,
    required this.descController,
    required this.onAdd,
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
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Titulo",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Descripción",
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: onAdd,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  id == null ? "Agregar Datos" : "Actualizar Datos",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
