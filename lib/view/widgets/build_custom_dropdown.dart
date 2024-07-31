import 'package:customer_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BuildCustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  const BuildCustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.2,
          color: AppColors.textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
