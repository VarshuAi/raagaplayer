import 'package:flutter/material.dart';
import '../../design_tokens/radius.dart';
import '../../design_tokens/spacing.dart';
import '../../extensions/context_extensions.dart';
import '../../services/haptic_service.dart';
import '../layout/animation_presets.dart';

class RaagaSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  const RaagaSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: (val) {
        onChanged(val);
        HapticService.selection();
      },
      min: min,
      max: max,
    );
  }
}

class RaagaSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RaagaSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (val) {
        onChanged(val);
        HapticService.light();
      },
    );
  }
}

class RaagaCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RaagaCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (val) {
        onChanged(val);
        HapticService.light();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class RaagaSegmentedControl extends StatelessWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const RaagaSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        children: List.generate(
          segments.length,
          (index) {
            final isSelected = index == selectedIndex;
            return Expanded(
              child: AnimatedTap(
                onTap: () => onSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.button - 2),
                  ),
                  child: Text(
                    segments[index],
                    style: context.textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onSurface.withOpacity(0.7),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
