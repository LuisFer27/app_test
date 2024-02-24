import 'package:app_test/core/templates/modal.dart';
import 'package:app_test/core/route.dart';

class ListCategoriesPage extends StatefulWidget {
  const ListCategoriesPage({super.key, required this.title});
  final String title;
  @override
  State<ListCategoriesPage> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategoriesPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  late ListCategoriesController _listCategoriesController;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _listCategoriesController = ListCategoriesController(context, _refreshData);
  }

  Future<void> _refreshData() async {
    final categories = await DBCategories.getAllData();
    setState(() {
      _allData = categories;
      _isLoading = false;
    });
  }

  void _clearList() {
    _titleController.clear();
    _descController.clear();
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
                Row(children: [
                  Btns(
                    onTap: () async {
                      if (id == null) {
                        await _listCategoriesController.addData(
                            _titleController.text, _descController.text);
                      } else {
                        await _listCategoriesController.updateData(
                            id, _titleController.text, _descController.text);
                      }
                      _titleController.text = "";
                      _descController.text = "";
                      Navigator.of(context).pop();
                      print("Datos agregados correctamente");
                    },
                    menuText: id == null ? "Agregar Datos" : "Actualizar Datos",
                  ),
                  Btns(menuText: 'Limpiar', onTap: _clearList),
                ])
              ],
            ));
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
