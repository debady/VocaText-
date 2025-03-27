import 'package:flutter/material.dart';
import 'package:vocatext/widgets/animated_gradient_button.dart';
import 'package:vocatext/widgets/recent_conversion_card.dart';
import 'package:vocatext/routes/routes.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                    const SizedBox(height: 30),
                    _buildRecentConversions(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VocaText',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Transformez votre voix en texte',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        AnimatedGradientButton(
          title: 'Enregistrer un message vocal',
          icon: Icons.mic,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.record);
          },
          gradient: const LinearGradient(
            colors: [Color(0xFF6200EE), Color(0xFF9139FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        const SizedBox(height: 16),
        AnimatedGradientButton(
          title: 'Importer un fichier audio',
          icon: Icons.file_upload_outlined,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.import);
          },
          gradient: const LinearGradient(
            colors: [Color(0xFF03DAC6), Color(0xFF56F2E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentConversions(BuildContext context) {
    // For demonstration, we'll use mock data
    final recentConversions = [
      {
        'title': 'Message pour mon ami',
        'text': 'Salut, je voulais savoir si tu es disponible ce week-end...',
        'date': DateTime.now().subtract(const Duration(hours: 2)),
        'duration': const Duration(seconds: 45),
      },
      {
        'title': 'Rappel courses',
        'text': 'Acheter du pain, des légumes et du lait pour demain...',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'duration': const Duration(seconds: 30),
      },
      {
        'title': 'Idées projet',
        'text': 'Développer une application mobile qui permet de...',
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'duration': const Duration(minutes: 1, seconds: 20),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Conversions récentes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {
                // Show all conversions
              },
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (recentConversions.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 70,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucune conversion récente',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recentConversions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final conversion = recentConversions[index];
              return RecentConversionCard(
                title: conversion['title'] as String,
                text: conversion['text'] as String,
                date: conversion['date'] as DateTime,
                duration: conversion['duration'] as Duration,
                onTap: () {
                  // Show conversion details
                },
              );
            },
          ),
      ],
    );
  }
}