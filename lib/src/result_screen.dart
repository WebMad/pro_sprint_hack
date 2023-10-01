import 'dart:convert';

import 'package:flutter/material.dart';

import 'main_screen.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> results;

  const ResultScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Распланированный спринт"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "PRO.СПРИНТ",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 15),
              for (final user in results['users']) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${users.firstWhere((element) => element['id'] == user['id'])['name']} - ${user['total_points']}SP",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (final task in user['assigned_tasks'])
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 2,
                            child: Container(
                              width: 200,
                              height: 120,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    const Utf8Decoder()
                                        .convert(task['name'].codeUnits),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'SP: ${task['complexity']}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  if (task['tags'] != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tags: ${(task['tags'] as List<dynamic>).join(', ')}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
