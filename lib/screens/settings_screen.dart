import 'package:flutter/material.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/app_state.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/eco_card.dart';
import '../widgets/info_banner.dart';
import '../widgets/screen_body.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  bool _offlineCache = true;

  Future<void> _confirmClear(String title, String message) async {
    final confirmed = await showConfirmDialog(
      context,
      title: title,
      message: message,
      confirmLabel: 'Clear',
      cancelLabel: 'Cancel',
    );
    if (confirmed && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title done (placeholder).')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ScreenBody(
        children: [
          const Text('App language', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          _GroupCard(
            children: [
              _LanguageOption(
                label: 'English',
                selected: _language == 'English',
                onTap: () => setState(() => _language = 'English'),
              ),
              _LanguageOption(
                label: 'Türkçe / Turkish',
                selected: _language == 'Türkçe',
                onTap: () => setState(() => _language = 'Türkçe'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Appearance', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm + 4),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: AppState.themeMode,
            builder: (context, mode, _) {
              return Row(
                children: [
                  Expanded(
                    child: _ThemeOption(
                      icon: Icons.light_mode_outlined,
                      label: 'Light',
                      selected: mode == ThemeMode.light,
                      onTap: () => AppState.themeMode.value = ThemeMode.light,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _ThemeOption(
                      icon: Icons.dark_mode_outlined,
                      label: 'Dark',
                      selected: mode == ThemeMode.dark,
                      onTap: () => AppState.themeMode.value = ThemeMode.dark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _ThemeOption(
                      icon: Icons.phone_android_outlined,
                      label: 'System',
                      selected: mode == ThemeMode.system,
                      onTap: () => AppState.themeMode.value = ThemeMode.system,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Data & offline access', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          _GroupCard(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: Icon(Icons.download_outlined, color: scheme.primary),
                title: const Text(
                  'Keep an offline cache',
                  style: AppTextStyles.cardTitle,
                ),
                subtitle: Text(
                  'Open saved results without a connection.',
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                value: _offlineCache,
                onChanged: (value) => setState(() => _offlineCache = value),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.storage_outlined, color: scheme.primary),
                title: const Text('Offline cache', style: AppTextStyles.cardTitle),
                trailing: Text(
                  '2.4 MB',
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'New searches and AI explanations need an internet connection. '
            'Cached results can be viewed offline and may be outdated.',
            style: AppTextStyles.caption.copyWith(
              fontSize: 11,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Privacy & local data', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          const InfoBanner(
            muted: true,
            icon: Icons.shield_outlined,
            text: 'No photos are collected or stored. Favorites, history, '
                'cached results and language/theme settings stay on this device.',
          ),
          const SizedBox(height: AppSpacing.sm + 4),
          _GroupCard(
            children: [
              _ClearRow(
                icon: Icons.history,
                title: 'Clear search history',
                subtitle: 'Remove searches. Keep favorites.',
                onClear: () => _confirmClear(
                  'Clear search history',
                  'Your searches will be removed. Favorites are kept.',
                ),
              ),
              _ClearRow(
                icon: Icons.delete_outline,
                title: 'Clear offline cache',
                subtitle: 'Remove cached results.',
                onClear: () => _confirmClear(
                  'Clear offline cache',
                  'Cached results will be removed from this device.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final List<Widget> children;

  const _GroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return EcoCard(
      outlined: true,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Column(children: children),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? scheme.primary : scheme.onSurfaceVariant,
      ),
      title: Text(label, style: AppTextStyles.body),
      trailing: selected
          ? Text(
              'Active',
              style: AppTextStyles.caption.copyWith(color: scheme.primary),
            )
          : null,
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? scheme.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: scheme.primary),
            const SizedBox(height: AppSpacing.xs),
            Text(
              selected ? '✓ $label' : label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClearRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onClear;

  const _ClearRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: scheme.primary),
      title: Text(title, style: AppTextStyles.cardTitle),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption.copyWith(color: scheme.onSurfaceVariant),
      ),
      trailing: LinkText(label: 'Clear', onPressed: onClear),
    );
  }
}
