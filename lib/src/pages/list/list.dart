import 'package:app_test/core/route.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});
  final String title;
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  late ListController _listController;

  void _refreshData() async {
    final data = await DBTest.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    _listController = ListController(context, _refreshData);
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
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => DataBottomSheetTemplate(
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
          Row(
            children: [
              Btns(
                onTap: () async {
                  if (id == null) {
                    await _listController.addData(
                        _titleController.text, _descController.text);
                  } else {
                    await _listController.updateData(
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
            ],
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
                return Dismissible(
                  key: ValueKey(_allData[index]),
                  onDismissed: (direction) {
                    _listController.deleteData(rowData['id']);
                  },
                  child: ListData(
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
                  ),
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
