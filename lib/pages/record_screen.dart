import 'package:flutter/material.dart';
import 'package:vocatext/widgets/animated_record_button.dart';
import 'dart:async';

import 'package:vocatext/widgets/wave_animation.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  int _recordDurationInSeconds = 0;
  Timer? _timer;
  String _recordedText = '';
  bool _isProcessing = false;
  bool _hasResult = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _stopRecording();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
      _processAudio();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordDurationInSeconds = 0;
      _hasResult = false;
      _recordedText = '';
    });
    _animationController.repeat(reverse: true);
    
    // Start a timer to track recording duration
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordDurationInSeconds++;
      });
    });
    
    // In a real app, you would start recording audio here
    // using a plugin like record, flutter_sound, or audio_recorder
  }

  void _stopRecording() {
    _timer?.cancel();
    _animationController.stop();
    setState(() {
      _isRecording = false;
    });
    
    // In a real app, you would stop recording audio here
  }

  // Simulate processing the audio to text
  Future<void> _processAudio() async {
    setState(() {
      _isProcessing = true;
    });
    
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock result
    setState(() {
      _isProcessing = false;
      _hasResult = true;
      _recordedText = "Voici le texte transcrit de votre enregistrement vocal. "
          "Il s'agit d'un exemple pour illustrer comment le texte sera présenté "
          "une fois que l'audio a été converti. Dans une application réelle, "
          "ce texte proviendrait d'une API de reconnaissance vocale.";
    });
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enregistrement'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_isRecording || _isProcessing) _buildRecordingUI() else _buildResultUI(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingUI() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if (_isProcessing)
            Column(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  'Conversion en cours...',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  _formatDuration(_recordDurationInSeconds),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 40),
                WaveAnimation(
                  animationController: _animationController,
                  isRecording: _isRecording,
                ),
                const SizedBox(height: 40),
                Text(
                  'Parlez maintenant',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: AnimatedRecordButton(
              isRecording: _isRecording,
              onPressed: _toggleRecording,
              isProcessing: _isProcessing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultUI() {
    return Expanded(
      child: Column(
        children: [
          if (_hasResult) ...[
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Durée: ${_formatDuration(_recordDurationInSeconds)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                        _recordedText,
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
                      onPressed: _startRecording,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Nouvel enregistrement'),
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
          ] else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic_none,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Appuyez sur le bouton pour commencer',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 40),
                  AnimatedRecordButton(
                    isRecording: false,
                    onPressed: _toggleRecording,
                    isProcessing: false,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }  }