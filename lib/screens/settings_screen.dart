import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final StorageService storageService;
  final Function(bool) onThemeModeChanged;

  const SettingsScreen({
    super.key,
    required this.storageService,
    required this.onThemeModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  late bool _isNotificationEnabled;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.storageService.isDarkMode();
    _isNotificationEnabled = widget.storageService.isNotificationEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.settings, color: AppColors.primaryGold),
            SizedBox(width: 8),
            Text('Ayarlar'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section 1: Appearance
          _buildSectionHeader('Görünüm ve Tema'),
          Card(
            child: SwitchListTile(
              title: const Text('Karanlık Mod (Dark Mode)'),
              subtitle: const Text('Gözü yormayan koyu renk teması'),
              secondary: const Icon(Icons.dark_mode, color: AppColors.primaryGold),
              value: _isDarkMode,
              activeTrackColor: AppColors.primaryGold,
              onChanged: (value) async {
                setState(() => _isDarkMode = value);
                await widget.storageService.setDarkMode(value);
                widget.onThemeModeChanged(value);
              },
            ),
          ),
          const SizedBox(height: 20),

          // Section 2: Notifications
          _buildSectionHeader('Bildirimler'),
          Card(
            child: SwitchListTile(
              title: const Text('Son Dakika Bildirimleri'),
              subtitle: const Text('Önemli piyasa gelişmeleri anında cebinizde'),
              secondary: const Icon(Icons.notifications_active, color: AppColors.primaryBlue),
              value: _isNotificationEnabled,
              activeTrackColor: AppColors.primaryBlue,
              onChanged: (value) async {
                setState(() => _isNotificationEnabled = value);
                await widget.storageService.setNotificationEnabled(value);
              },
            ),
          ),
          const SizedBox(height: 20),

          // Section 3: Data & Storage
          _buildSectionHeader('Veri ve Hafıza'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cleaning_services, color: AppColors.bearishRed),
              title: const Text('Önbelleği Temizle'),
              subtitle: const Text('Yerel kaydedilmiş geçici verileri sıfırla'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Uygulama önbelleği temizlendi.')),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Section 4: About & Version
          _buildSectionHeader('Hakkında'),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info_outline, color: AppColors.primaryGold),
                  title: Text('FinansGündem Pro'),
                  subtitle: Text('Sürüm 1.0.0 (BIST, ABD & Kripto)'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.verified, color: AppColors.bullishGreen),
                  title: const Text('Veri Sağlayıcılar'),
                  subtitle: const Text('BIST, Wall Street, CoinDesk & Resmi Kaynaklar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryGold,
        ),
      ),
    );
  }
}
