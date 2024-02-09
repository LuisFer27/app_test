import 'package:flutter/material.dart';
import 'package:app_test/src/widgets/Buttons/iconBtns.dart';

class ListData extends StatelessWidget {
  final List<Map<String, dynamic>> allData;
  final Function(int) showBottomSheet;
  final Function(int)? deleteData; // Hacer deleteData opcional
  final List<String> fieldsToShow; // Nuevos campos a mostrar
  final bool showEditButton;
  final bool showDeleteButton;

  const ListData({
    required this.allData,
    required this.showBottomSheet,
    this.deleteData, // Hacer deleteData opcional
    required this.fieldsToShow, // Se incluye como parámetro
    this.showEditButton =
        true, // Mostrar botón de editar de forma predeterminada
    this.showDeleteButton =
        true, // Mostrar botón de eliminar de forma predeterminada
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
              allData[index][fieldsToShow[1]], // Primer campo
              style: const TextStyle(fontSize: 20),
            ),
          ),
          subtitle: Text(
            allData[index][fieldsToShow[2]], // Segundo campo
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showEditButton)
                IconBtns(
                  onTap: () {
                    showBottomSheet(
                        allData[index][fieldsToShow[0]]); // Tercer campo
                  },
                  icon: Icons.edit,
                  color: Colors.indigo,
                ),
              if (deleteData != null &&
                  showDeleteButton) // Mostrar el botón solo si deleteData está definido y showDeleteButton es verdadero
                IconBtns(
                  onTap: () {
                    deleteData!(
                        allData[index][fieldsToShow[0]]); // Tercer campo
                  },
                  icon: Icons.delete,
                  color: Colors.redAccent,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
