import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onInput;

  const NumericKeypad({Key? key, required this.onInput}) : super(key: key);

  void _onKeyPressed(String value) {
    onInput(value);
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', 'DEL'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              return _KeypadButton(
                label: key,
                onPressed: () => _onKeyPressed(key),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _KeypadButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDelete = label == 'DEL';

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isDelete ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: isDelete
              ? Icon(Icons.backspace_outlined, color: Colors.white)
              : Text(
                  label,
                  style: AppTextStyles.heading4.copyWith(
                    color: isDelete ? Colors.white : AppColors.textPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}
