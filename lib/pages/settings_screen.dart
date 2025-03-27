import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'Français';
  bool _saveHistory = true;
  bool _darkMode = false;
  bool _highQualityAudio = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader('Général'),
          _buildLanguageSelector(),
          _buildSettingSwitch(
            'Enregistrer l\'historique',
            'Garder une trace de vos conversions précédentes',
            _saveHistory,
            (value) {
              setState(() {
                _saveHistory = value;
              });
            },
          ),
          _buildThemeSelector(),
          const Divider(),
          _buildSectionHeader('Enregistrement audio'),
          _buildSettingSwitch(
            'Haute qualité audio',
            'Utiliser une meilleure qualité d\'audio (plus de données)',
            _highQualityAudio,
            (value) {
              setState(() {
                _highQualityAudio = value;
              });
            },
          ),
          _buildAudioFormatSelector(),
          const Divider(),
          _buildSectionHeader('À propos'),
          _buildAboutTile('Version', '1.0.0'),
          _buildAboutButton('Politique de confidentialité'),
          _buildAboutButton('Conditions d\'utilisation'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      title: const Text('Langue'),
      subtitle: const Text('Langue de reconnaissance vocale'),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
          }
        },
        items: <String>['Français', 'English', 'Español', 'Deutsch']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        underline: Container(),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return SwitchListTile(
      title: const Text('Mode sombre'),
      subtitle: const Text('Changer l\'apparence de l\'application'),
      value: _darkMode,
      onChanged: (bool value) {
        setState(() {
          _darkMode = value;
        });
      },
    );
  }

  Widget _buildAudioFormatSelector() {
    return ListTile(
      title: const Text('Format d\'enregistrement'),
      subtitle: const Text('Format par défaut pour les nouveaux enregistrements'),
      trailing: DropdownButton<String>(
        value: 'MP3',
        onChanged: (String? newValue) {},
        items: <String>['MP3', 'WAV', 'M4A']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        underline: Container(),
      ),
    );
  }

  Widget _buildSettingSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildAboutTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildAboutButton(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}