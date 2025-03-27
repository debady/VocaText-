import 'package:flutter/material.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  bool _isImporting = false;
  bool _hasImported = false;
  String _importedText = '';

  Future<void> _pickAndImportAudio() async {
    setState(() {
      _isImporting = true;
    });
    
    // In a real app, you would use a plugin like file_picker or image_picker
    // to allow the user to select an audio file
    
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock result
    setState(() {
      _isImporting = false;
      _hasImported = true;
      _importedText = "Voici le texte transcrit du fichier audio importé. "
          "Cet exemple illustre comment le résultat serait présenté après "
          "l'importation et le traitement d'un fichier audio. Dans une "
          "application réelle, ce texte proviendrait de l'analyse du fichier "
          "audio via une API de reconnaissance vocale.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importer un audio'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _hasImported ? _buildResultView() : _buildImportView(),
      ),
    );
  }

  Widget _buildImportView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upload_file,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Importer un fichier audio',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Formats supportés: MP3, WAV, M4A',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _isImporting
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _pickAndImportAudio,
                    icon: const Icon(Icons.file_upload_outlined),
                    label: const Text('Choisir un fichier'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.mic),
              label: const Text('Enregistrer plutôt'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.music_note,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'audio_file.mp3',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '2.4 MB · 1:45',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                Text(
                  'Texte transcrit',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: Text(
                    _importedText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pickAndImportAudio,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Importer un autre fichier'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Implement copy to clipboard functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Texte copié dans le presse-papier'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copier'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Implement share functionality
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Partager'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}