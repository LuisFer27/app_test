import 'package:app_test/core/routes/libraries.dart';
import 'package:app_test/model/db_products.dart';

class ListProductsController {
  final BuildContext context;
  final Function() refreshCallback;

  ListProductsController(this.context, this.refreshCallback);

  Future<void> addData(String title, String description) async {
    await DBProducts.createData(title, description);
    refreshCallback();
  }

  Future<void> updateData(int id, String title, String description) async {
    await DBProducts.updateData(id, title, description);
    refreshCallback();
  }

  void deleteData(int id) async {
    await DBProducts.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Datos eliminados correctamente"),
      ),
    );
  }
}
