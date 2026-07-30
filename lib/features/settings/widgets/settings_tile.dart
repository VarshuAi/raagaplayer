import 'package:flutter/material.dart';
import '../../../core/extensions/context_extensions.dart';

class SettingsTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: context.colorScheme.onSurface.withOpacity(0.70),
      ),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.50),
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
