import 'package:flutter/material.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/design_tokens/radius.dart';
import '../../../core/design_tokens/colors.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/buttons/raaga_buttons.dart';
import '../../../core/widgets/cards/raaga_cards.dart';
import '../../../core/widgets/inputs/raaga_inputs.dart';
import '../../../core/widgets/feedback/raaga_feedback.dart';
import '../../../core/widgets/controls/raaga_controls.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../core/widgets/layout/glass_container.dart';
import '../../../core/widgets/layout/dividers.dart';
import '../../../core/widgets/layout/status_views.dart';
import '../../../core/widgets/layout/animation_presets.dart';
import '../../../core/theme/app_theme.dart';

class DesignSystemScreen extends StatefulWidget {
  const DesignSystemScreen({super.key});

  @override
  State<DesignSystemScreen> createState() => _DesignSystemScreenState();
}

class _DesignSystemScreenState extends State<DesignSystemScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  double _sliderValue = 0.5;
  bool _switchValue = true;
  bool _checkboxValue = false;
  int _selectedSegment = 0;
  
  // Theme state
  ThemeData _currentTheme = AppTheme.dark;
  String _themeName = "Dark Theme";

  @override
  void dispose() {
    _textController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _updateTheme(ThemeData theme, String name) {
    setState(() {
      _currentTheme = theme;
      _themeName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Wrap with Theme widget to show instant switching updates
    return Theme(
      data: _currentTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.colorScheme.surface,
            appBar: AppBar(
              backgroundColor: context.colorScheme.surfaceContainerLow,
              title: Text(
                'Raaga UI Showcase - $_themeName',
                style: context.textTheme.titleMedium,
              ),
              centerTitle: true,
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.palette_rounded),
                  onSelected: (value) {
                    if (value == 'dark') {
                      _updateTheme(AppTheme.dark, "Dark Theme");
                    } else if (value == 'amoled') {
                      _updateTheme(AppTheme.amoled, "AMOLED Mode");
                    } else if (value == 'contrast') {
                      _updateTheme(AppTheme.highContrast, "High Contrast");
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'dark', child: Text('Dark Theme')),
                    const PopupMenuItem(value: 'amoled', child: Text('AMOLED Theme')),
                    const PopupMenuItem(value: 'contrast', child: Text('High Contrast Theme')),
                  ],
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: Typography
                  _buildSectionHeader(context, 'Typography'),
                  _buildTypeRow(context, 'Display Large', context.textTheme.displayLarge),
                  _buildTypeRow(context, 'Headline Large', context.textTheme.headlineLarge),
                  _buildTypeRow(context, 'Title Large', context.textTheme.titleLarge),
                  _buildTypeRow(context, 'Title Medium', context.textTheme.titleMedium),
                  _buildTypeRow(context, 'Body Large', context.textTheme.bodyLarge),
                  _buildTypeRow(context, 'Label Large', context.textTheme.labelLarge),
                  const RaagaDivider(height: 32),

                  // Section: Glassmorphism & Cards
                  _buildSectionHeader(context, 'Surfaces & Cards'),
                  Row(
                    children: [
                      Expanded(
                        child: RaagaCard(
                          surfaceLevel: 2,
                          child: Column(
                            children: [
                              Text('Surface 2', style: context.textTheme.titleSmall),
                              const SizedBox(height: 8),
                              const Text('Default card level', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: RaagaCard(
                          surfaceLevel: 3,
                          child: Column(
                            children: [
                              Text('Surface 3', style: context.textTheme.titleSmall),
                              const SizedBox(height: 8),
                              const Text('Elevated card depth', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  RaagaGlassContainer(
                    height: 100,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Center(
                      child: Text(
                        'RaagaGlassContainer (Frosted glass)',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const RaagaDivider(height: 32),

                  // Section: Interactive Buttons
                  _buildSectionHeader(context, 'Buttons'),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      RaagaButton(
                        text: 'Primary Button',
                        onTap: () {
                          RaagaSnackBar.show(context: context, message: 'Primary Tapped');
                        },
                      ),
                      RaagaButton(
                        text: 'Secondary Button',
                        isSecondary: true,
                        onTap: () {
                          RaagaSnackBar.show(context: context, message: 'Secondary Tapped');
                        },
                      ),
                      RaagaTextButton(
                        text: 'Text Button',
                        onTap: () {
                          RaagaSnackBar.show(context: context, message: 'Text Button Tapped');
                        },
                      ),
                      Row(
                        children: [
                          RaagaIconButton(
                            icon: Icons.play_arrow_rounded,
                            onTap: () => RaagaSnackBar.show(context: context, message: 'Play Tapped'),
                          ),
                          RaagaIconButton(
                            icon: Icons.favorite_rounded,
                            color: context.colorScheme.primary,
                            onTap: () => RaagaSnackBar.show(context: context, message: 'Heart Tapped'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const RaagaDivider(height: 32),

                  // Section: Input Fields
                  _buildSectionHeader(context, 'Inputs'),
                  RaagaSearchBar(
                    controller: _searchController,
                    hintText: 'Search matching songs...',
                    onChanged: (val) => setState(() {}),
                    onClear: () => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  RaagaTextField(
                    controller: _textController,
                    hintText: 'Enter dynamic username...',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  const RaagaDivider(height: 32),

                  // Section: Controls & Selectors
                  _buildSectionHeader(context, 'Controls & Selectors'),
                  Row(
                    children: [
                      Text('Switch Toggle:', style: context.textTheme.bodyLarge),
                      const Spacer(),
                      RaagaSwitch(
                        value: _switchValue,
                        onChanged: (val) => setState(() => _switchValue = val),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Checkbox Toggle:', style: context.textTheme.bodyLarge),
                      const Spacer(),
                      RaagaCheckbox(
                        value: _checkboxValue,
                        onChanged: (val) => setState(() => _checkboxValue = val ?? false),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  RaagaSegmentedControl(
                    segments: const ['Compact', 'Medium', 'Expanded'],
                    selectedIndex: _selectedSegment,
                    onSelected: (idx) => setState(() => _selectedSegment = idx),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Volume seeking slider:', style: context.textTheme.bodyLarge),
                  RaagaSlider(
                    value: _sliderValue,
                    onChanged: (val) => setState(() => _sliderValue = val),
                  ),
                  const RaagaDivider(height: 32),

                  // Section: Feedback Dialogs
                  _buildSectionHeader(context, 'Feedback overlays'),
                  Row(
                    children: [
                      Expanded(
                        child: RaagaButton(
                          text: 'Show Dialog',
                          isSecondary: true,
                          onTap: () {
                            RaagaDialog.show(
                              context: context,
                              title: 'Delete Playlist?',
                              content: 'Are you sure you want to permanently delete this playlist?',
                              actions: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RaagaTextButton(
                                    text: 'Cancel',
                                    onTap: () => Navigator.of(context).pop(),
                                  ),
                                  RaagaButton(
                                    text: 'Delete',
                                    onTap: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: RaagaButton(
                          text: 'Show BottomSheet',
                          isSecondary: true,
                          onTap: () {
                            RaagaBottomSheet.show(
                              context: context,
                              title: 'Song Details',
                              child: Container(
                                height: 180,
                                alignment: Alignment.center,
                                child: Text(
                                  'Details list metadata rendering...',
                                  style: context.textTheme.bodyLarge,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const RaagaDivider(height: 32),

                  // Section: Loading Indicators & skeletons
                  _buildSectionHeader(context, 'Loading States'),
                  const RaagaLoadingSkeleton(),
                  const SizedBox(height: AppSpacing.md),
                  const RaagaProgressIndicator(value: 0.7),
                  const RaagaDivider(height: 32),

                  // Section: Empty / Error State
                  _buildSectionHeader(context, 'Status Screen Layouts'),
                  RaagaCard(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      height: 240,
                      child: RaagaEmptyState(
                        title: 'No Offline Songs Found',
                        description: 'Download tracks or connect to local storage.',
                        icon: Icons.cloud_off_rounded,
                        actionText: 'Refresh Library',
                        onActionTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTypeRow(BuildContext context, String name, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              name,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Music First design',
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
