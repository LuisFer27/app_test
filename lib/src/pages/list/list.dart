import 'package:app_test/core/templates/modal.dart';
import 'package:flutter/material.dart';
import 'package:app_test/model/db_helper.dart';
import 'package:app_test/src/widgets/List/listData.dart';
import 'package:app_test/src/widgets/TextField/textField.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';
import 'package:app_test/src/widgets/Buttons/iconBtns.dart';
import 'package:app_test/src/widgets/LabelText/labelText.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});
  final String title;
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
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
    await SQLHelper.createData(_titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(id, _titleController.text, _descController.text);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
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
    );
  }

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
