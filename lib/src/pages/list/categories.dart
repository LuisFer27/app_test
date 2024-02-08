import 'package:flutter/material.dart';
import 'package:app_test/model/db_categories.dart';
import 'package:app_test/src/widgets/List/listData.dart';

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

  void _deleteData(int id) async {
    await DBCategories.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Datos eliminados correctamente"),
      ),
    );
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
                  Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListData(
              allData: _allData,
              showBottomSheet: showBottomSheet,
              deleteData: _deleteData,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
