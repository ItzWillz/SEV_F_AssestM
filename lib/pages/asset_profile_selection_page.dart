import 'package:flutter/material.dart';

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class AssetProfileSelectionPage extends StatefulWidget {
  const AssetProfileSelectionPage({super.key, required this.callBack});
  final void Function(String?) callBack;

  @override
  State<AssetProfileSelectionPage> createState() =>
      _AssetProfileSelectionPageState();
}

class _AssetProfileSelectionPageState extends State<AssetProfileSelectionPage> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  //ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: DropdownMenu<IconLabel>(
            controller: iconController,
            enableFilter: true,
            requestFocusOnTap: true,
            width: 350,
            leadingIcon: const Icon(Icons.search),
            label: const Text('Select Profile...'),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
            ),
            onSelected: (IconLabel? icon) {
              setState(() {
                selectedIcon = icon;
              });
            },
            dropdownMenuEntries:
                IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
              (IconLabel icon) {
                return DropdownMenuEntry<IconLabel>(
                  value: icon,
                  label: icon.label,
                  leadingIcon: Icon(icon.icon),
                );
              },
            ).toList(),
          ),
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  widget.callBack(null);
                },
                child: Text('Continue without profile')),
            ElevatedButton(
                onPressed: () {
                  widget.callBack(selectedIcon?.label);
                },
                child: Text('Continue'))
          ],
        )
      ],
    );
  }
}
