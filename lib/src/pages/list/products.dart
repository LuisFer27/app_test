import 'package:app_test/core/templates/modal.dart';
import 'package:app_test/src/widgets/Buttons/iconBtns.dart';
import 'package:app_test/src/widgets/LabelText/labelText.dart';
import 'package:app_test/src/widgets/SelectButton/selectButton.dart';
import 'package:flutter/material.dart';
import 'package:app_test/model/db_products.dart';
import 'package:app_test/src/widgets/List/listData.dart';
import 'package:app_test/src/widgets/TextField/textField.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({super.key, required this.title});
  final String title;
  @override
  State<ListProductsPage> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProductsPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await DBCategories.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
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
    // ignore: use_build_context_synchronously
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
      builder: (_) => DataBottomSheetTemplate(
        fields: [
          TextInput(
            controller: _titleController,
            labelText: 'Titulo',
            hintText: "Titulo",
          ),
          const SizedBox(height: 10),
          ReusableDropdown<String>(
            items: ['Apple', 'Banana', 'Orange'],
            selectedValue: 'Apple',
            onChanged: (value) {
              print('Selected fruit: $value');
            },
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) {
                final rowData = _allData[index];
                return ListData(
                  allData: [rowData],
                  additionalWidgets: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: LabelText(
                        rowData['title'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    LabelText(
                      rowData['desc'],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconBtns(
                          onTap: () {
                            showBottomSheet(rowData['id']);
                          },
                          icon: Icons.edit,
                          color: Colors.indigo,
                        ),
                        IconBtns(
                          onTap: () {
                            _deleteData(rowData['id']);
                          },
                          icon: Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
