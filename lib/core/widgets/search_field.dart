import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.onChange,
    this.hintText = 'Sura Name',
  });

  final ValueChanged<String> onChange;
  final String hintText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      controller: textEditingController,
      onChanged: widget.onChange,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(Icons.book),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: textEditingController,
          builder: (context, value, child) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              onPressed: () {
                textEditingController.clear();
                widget.onChange('');
              },
              tooltip: 'Clear',
              icon: Icon(Icons.close, color: colorScheme.primary),
            );
          },
        ),
      ),
    );
  }
}
