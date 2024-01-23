import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final List<Map<String, dynamic>> allData;
  final Function(int) showBottomSheet;
  final Function(int) deleteData;

  const ListData({
    required this.allData,
    required this.showBottomSheet,
    required this.deleteData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allData.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(15),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              allData[index]['title'],
              style: const TextStyle(fontSize: 20),
            ),
          ),
          subtitle: Text(
            allData[index]['desc'],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showBottomSheet(allData[index]['id']);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.indigo,
                ),
              ),
              IconButton(
                onPressed: () {
                  deleteData(allData[index]['id']);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
