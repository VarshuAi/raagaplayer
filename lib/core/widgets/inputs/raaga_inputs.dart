import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';

class RaagaTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final VoidCallback? onEditingComplete;

  const RaagaTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurface.withOpacity(0.38),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: context.colorScheme.onSurface.withOpacity(0.50),
              )
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class RaagaSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const RaagaSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(
          color: context.colorScheme.onSurface.withOpacity(0.06),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: context.colorScheme.onSurface.withOpacity(0.50),
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.38),
                ),
                fillColor: Colors.transparent,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                if (onClear != null) onClear!();
              },
              child: Icon(
                Icons.close_rounded,
                color: context.colorScheme.onSurface.withOpacity(0.50),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
