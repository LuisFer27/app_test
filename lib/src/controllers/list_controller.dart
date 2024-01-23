import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_test/model/db_helper.dart';
import 'package:path/path.dart';

class ListController {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  Future<void> _refreshData() async {
    final data = await SQLHelper.getAllData();

    _allData = data;
    _isLoading = false;
  }

  Future<void> _addData() async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    await SQLHelper.createData(_titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    await SQLHelper.updateData(id, _titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Datos eliminados correctamente"),
      ),
    );
  }

  Future<void> showBottomSheet(int? id) async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descController.text = existingData['desc'];
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context as BuildContext,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context as BuildContext).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Titulo",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Descripción",
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData();
                  }
                  if (id != null) {
                    await _updateData(id);
                  }
                  _titleController.text = "";
                  _descController.text = "";
                  //hide bottom sheet
                  Navigator.of(context as BuildContext).pop();
                  print("Datos agregados correctamente");
                },
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
      ),
    );
  }
}
