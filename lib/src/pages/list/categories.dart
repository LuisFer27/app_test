import 'package:flutter/material.dart';
import 'package:app_test/model/db_categories.dart';
import 'package:app_test/src/widgets/List/listData.dart';
import 'package:app_test/src/widgets/TextField/textField.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';
//import 'package:app_test/core/templates/modal.dart';

class ListCategoriesPage extends StatefulWidget {
  const ListCategoriesPage({super.key, required this.title});
  final String title;
  @override
  State<ListCategoriesPage> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategoriesPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _createTablesAndRefreshData();
  }

  Future<void> _createTablesAndRefreshData() async {
    final db = await DBCategories.db();
    await DBCategories.createTables(
        db); // Asegúrate de llamar a createTables con la base de datos
    await _refreshData();
  }

  Future<void> _refreshData() async {
    final categories = await DBCategories.getAllData();
    setState(() {
      _allData = categories;
      _isLoading = false;
    });
  }

  Future<void> _addData() async {
    await DBCategories.createData(_titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await DBCategories.updateData(
        id, _titleController.text, _descController.text);
    _refreshData();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descController.text = existingData['desc'];
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
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
            TextInput(
              controller: _titleController,
              labelText: 'Titulo',
              hintText: "Titulo",
            ),
            const SizedBox(height: 10),
            TextInput(
              controller: _descController,
              labelText: 'Descripción',
              hintText: "Descripción",
            ),
            const SizedBox(height: 20),
            Center(
              child: Btns(
                onTap: () async {
                  if (id == null) {
                    await _addData();
                  }
                  if (id != null) {
                    await _updateData(id);
                  }
                  _titleController.text = "";
                  _descController.text = "";
                  //hide bottom sheet
                  Navigator.of(context).pop();
                  print("Datos agregados correctamente");
                },
                menuText: id == null ? "Agregar Datos" : "Actualizar Datos",
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListData(
              allData: _allData,
              showBottomSheet: showBottomSheet,
              fieldsToShow: ['id', 'title', 'desc'],
              showDeleteButton: false,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
