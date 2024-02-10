import 'package:flutter/material.dart';

class ReusableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;

  ReusableDropdown({
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  _ReusableDropdownState<T> createState() => _ReusableDropdownState<T>();
}

class _ReusableDropdownState<T> extends State<ReusableDropdown<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: _selectedValue,
      items: widget.items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}
