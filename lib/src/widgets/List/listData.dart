import 'package:app_test/core/libraries.dart';

class ListData extends StatelessWidget {
  final List<Map<String, dynamic>> allData;
  final List<Widget> additionalWidgets;

  const ListData({
    required this.allData,
    this.additionalWidgets = const [], // Widget adicional opcional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var rowData in allData) ...[
          Card(
            margin: const EdgeInsets.all(15),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: additionalWidgets,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
