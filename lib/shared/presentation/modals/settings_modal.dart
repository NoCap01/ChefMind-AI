import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

/// Settings modal with smooth animations and comprehensive options
class SettingsModal extends ConsumerStatefulWidget {
  const SettingsModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsModal> createState() => _SettingsModalState();
}

class _SettingsModalState extends ConsumerState<SettingsModal>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Settings states
  bool _notificationsEnabled = true;
  bool _recipeReminders = true;
  bool _shoppingReminders = false;
  bool _mealPlanReminders = true;
  bool _darkModeEnabled = false;
  bool _voiceInputEnabled = true;
  bool _offlineModeEnabled = false;
  double _voiceVolume = 0.8;
  String _selectedLanguage = 'English';
  String _selectedUnits = 'Metric';

  final List<String> _languageOptions = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Japanese',
    'Chinese',
  ];

  final List<String> _unitOptions = [
    'Metric',
    'Imperial',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    // TODO: Implement settings save logic
    Navigator.of(context).pop({
      'notificationsEnabled': _notificationsEnabled,
      'recipeReminders': _recipeReminders,
      'shoppingReminders': _shoppingReminders,
      'mealPlanReminders': _mealPlanReminders,
      'darkModeEnabled': _darkModeEnabled,
      'voiceInputEnabled': _voiceInputEnabled,
      'offlineModeEnabled': _offlineModeEnabled,
      'voiceVolume': _voiceVolume,
      'selectedLanguage': _selectedLanguage,
      'selectedUnits': _selectedUnits,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Dialog.fullscreen(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Settings'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: _saveSettings,
                      child: const Text('Save'),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNotificationSettings(),
                      const Divider(height: DesignTokens.spacing32),
                      _buildAppearanceSettings(),
                      const Divider(height: DesignTokens.spacing32),
                      _buildVoiceSettings(),
                      const Divider(height: DesignTokens.spacing32),
                      _buildGeneralSettings(),
                      const Divider(height: DesignTokens.spacing32),
                      _buildDataSettings(),
                      const SizedBox(height: DesignTokens.spacing32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: DesignTokens.spacing16),
        SwitchListTile(
          title: const Text('Enable Notifications'),
          subtitle: const Text('Receive app notifications'),
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        AnimatedOpacity(
          opacity: _notificationsEnabled ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Recipe Reminders'),
                subtitle: const Text('Cooking time and meal prep alerts'),
                value: _recipeReminders && _notificationsEnabled,
                onChanged: _notificationsEnabled
                    ? (value) {
                        setState(() {
                          _recipeReminders = value;
                        });
                      }
                    : null,
                contentPadding: EdgeInsets.zero,
              ),
              SwitchListTile(
                title: const Text('Shopping Reminders'),
                subtitle: const Text('Grocery shopping and ingredient alerts'),
                value: _shoppingReminders && _notificationsEnabled,
                onChanged: _notificationsEnabled
                    ? (value) {
                        setState(() {
                          _shoppingReminders = value;
                        });
                      }
                    : null,
                contentPadding: EdgeInsets.zero,
              ),
              SwitchListTile(
                title: const Text('Meal Plan Reminders'),
                subtitle: const Text('Weekly meal planning notifications'),
                value: _mealPlanReminders && _notificationsEnabled,
                onChanged: _notificationsEnabled
                    ? (value) {
                        setState(() {
                          _mealPlanReminders = value;
                        });
                      }
                    : null,
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppearanceSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: DesignTokens.spacing16),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Use dark theme throughout the app'),
          value: _darkModeEnabled,
          onChanged: (value) {
            setState(() {
              _darkModeEnabled = value;
            });
            // TODO: Update theme mode provider
            ref.read(themeModeProvider.notifier).state =
                value ? ThemeMode.dark : ThemeMode.light;
          },
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('Language'),
          subtitle: Text(_selectedLanguage),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showLanguageSelector(),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildVoiceSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voice & Audio',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: DesignTokens.spacing16),
        SwitchListTile(
          title: const Text('Voice Input'),
          subtitle: const Text('Enable voice commands and dictation'),
          value: _voiceInputEnabled,
          onChanged: (value) {
            setState(() {
              _voiceInputEnabled = value;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        AnimatedOpacity(
          opacity: _voiceInputEnabled ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: DesignTokens.spacing16),
              Text(
                'Voice Volume',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Slider(
                value: _voiceVolume,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(_voiceVolume * 100).round()}%',
                onChanged: _voiceInputEnabled
                    ? (value) {
                        setState(() {
                          _voiceVolume = value;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: DesignTokens.spacing16),
        ListTile(
          title: const Text('Units'),
          subtitle: Text(_selectedUnits),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showUnitsSelector(),
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile(
          title: const Text('Offline Mode'),
          subtitle: const Text('Cache recipes for offline access'),
          value: _offlineModeEnabled,
          onChanged: (value) {
            setState(() {
              _offlineModeEnabled = value;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildDataSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data & Privacy',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: DesignTokens.spacing16),
        ListTile(
          title: const Text('Clear Cache'),
          subtitle: const Text('Free up storage space'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showClearCacheDialog(),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('Export Data'),
          subtitle: const Text('Download your recipes and data'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showExportDataDialog(),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          subtitle: const Text('View our privacy policy'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _openPrivacyPolicy(),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Language',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: DesignTokens.spacing16),
              ..._languageOptions.map((language) {
                return ListTile(
                  title: Text(language),
                  trailing: _selectedLanguage == language
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showUnitsSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Units',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: DesignTokens.spacing16),
              ..._unitOptions.map((unit) {
                return ListTile(
                  title: Text(unit),
                  subtitle: Text(unit == 'Metric' 
                      ? 'Grams, liters, Celsius' 
                      : 'Ounces, cups, Fahrenheit'),
                  trailing: _selectedUnits == unit
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedUnits = unit;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Cache'),
          content: const Text(
            'This will remove all cached recipes and images. '
            'You may need to re-download content when offline.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement cache clearing
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared successfully')),
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _showExportDataDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Export Data'),
          content: const Text(
            'Export your recipes, meal plans, and preferences to a file. '
            'This may take a few moments.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement data export
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export started...')),
                );
              },
              child: const Text('Export'),
            ),
          ],
        );
      },
    );
  }

  void _openPrivacyPolicy() {
    // TODO: Open privacy policy URL
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening privacy policy...')),
    );
  }
}