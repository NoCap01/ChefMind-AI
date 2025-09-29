import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'about_screen.dart';
import '../../../core/theme/theme_provider.dart';

class SimpleSettingsScreen extends ConsumerWidget {
  const SimpleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.grey.shade800,
      ),
      body: ThemedBackground(
        isDark: isDark,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // App Settings Section
            _buildSectionHeader(context, 'App Settings'),
            const SizedBox(height: 8),
            _buildSettingsCard(
              context,
              [
                _buildSettingsTile(
                  context,
                  Icons.palette_outlined,
                  'Theme',
                  themeNotifier.currentThemeName,
                  () => _showThemeDialog(context, ref),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // About Section
            _buildSectionHeader(context, 'About'),
            const SizedBox(height: 8),
            _buildSettingsCard(
              context,
              [
                _buildSettingsTile(
                  context,
                  Icons.info_outline,
                  'About ChefMind AI',
                  'Version 1.0.0',
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // App Logo and Version
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6366F1), // Indigo 500
                          Color(0xFF8B5CF6), // Violet 500
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/icons/homo_icon.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.restaurant_menu,
                          color: Colors.white,
                          size: 32,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'ChefMind AI',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your AI Cooking Companion',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white70 : Colors.grey.shade500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6366F1), // Indigo 500
            ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6366F1),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.grey.shade800,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? Colors.white54 : Colors.grey.shade400,
      ),
      onTap: onTap,
    );
  }

  // Dialog methods
  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.read(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context,
              'Light',
              Icons.light_mode,
              ThemeMode.light,
              currentTheme,
              (value) {
                themeNotifier.setThemeMode(value);
                Navigator.pop(context);
              },
            ),
            _buildThemeOption(
              context,
              'Dark',
              Icons.dark_mode,
              ThemeMode.dark,
              currentTheme,
              (value) {
                themeNotifier.setThemeMode(value);
                Navigator.pop(context);
              },
            ),
            _buildThemeOption(
              context,
              'System',
              Icons.auto_mode,
              ThemeMode.system,
              currentTheme,
              (value) {
                themeNotifier.setThemeMode(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    IconData icon,
    ThemeMode value,
    ThemeMode currentValue,
    Function(ThemeMode) onChanged,
  ) {
    final isSelected = value == currentValue;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing:
          isSelected ? const Icon(Icons.check, color: Color(0xFF6366F1)) : null,
      onTap: () => onChanged(value),
    );
  }
}
