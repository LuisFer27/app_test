import 'package:app_test/core/templates/modal.dart';
import 'package:app_test/core/route.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({super.key, required this.title});
  final String title;
  @override
  State<ListProductsPage> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProductsPage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  late ListProductsController _listProductsController;

  void _refreshData() async {
    final data = await DBProducts.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    _listProductsController = ListProductsController(context, _refreshData);
  }

  void _clearListProducts() {
    _descController.clear();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final QrBarcodeController _barcodeScannerController = QrBarcodeController();

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
            readOnly: true,
          ),
          TextInput(
            controller: _descController,
            labelText: 'Descripción',
            hintText: "Descripción",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBtns(
                onTap: () async {
                  String result = await _barcodeScannerController.scanQR();
                  setState(() {
                    _titleController.text = result;
                  });
                },
                icon: Icons.qr_code,
              ),
              IconBtns(
                onTap: () async {
                  String result =
                      await _barcodeScannerController.scanBarcodeNormal();
                  setState(() {
                    _titleController.text = result;
                  });
                },
                icon: Icons.barcode_reader,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Btns(
              onTap: () async {
                if (id == null) {
                  await _listProductsController.addData(
                      _titleController.text, _descController.text);
                } else {
                  await _listProductsController.updateData(
                      id, _titleController.text, _descController.text);
                }
                _titleController.text = "";
                _descController.text = "";
                Navigator.of(context).pop();
                print("Datos agregados correctamente");
              },
              menuText: id == null ? "Agregar Datos" : "Actualizar Datos",
            ),
            Btns(menuText: 'Limpiar', onTap: _clearListProducts)
          ])
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
                final rowData =
                    _allData[index]; // Aquí debes declarar la variable
                return Dismissible(
                  key: ValueKey(_allData[index]),
                  onDismissed: (direction) {
                    _listProductsController.deleteData(rowData['id']);
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
