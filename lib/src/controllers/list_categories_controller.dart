import 'package:app_test/core/route.dart';

class ListCategoriesController {
  final BuildContext context;
  final Function() refreshCallback;

  ListCategoriesController(this.context, this.refreshCallback);

  Future<void> addData(String title, String description) async {
    await DBCategories.createData(title, description);
    refreshCallback();
  }

  Future<void> updateData(int id, String title, String description) async {
    await DBCategories.updateData(id, title, description);
    refreshCallback();
  }

  void deleteData(int id) async {
    await DBCategories.deleteData(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Datos eliminados correctamente"),
      ),
    );
  }
}
