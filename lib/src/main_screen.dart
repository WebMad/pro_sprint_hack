import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pro_sprints/src/result_screen.dart';

List<Map<String, dynamic>> users = [
  {
    'id': 1,
    'name': 'Василий',
    'avgSP': 15,
    'tags': ['UI/UX Design']
  },
  {
    'id': 2,
    'name': 'Иван',
    'avgSP': 12,
    'tags': ['Functionality', 'Database']
  },
  {
    'id': 3,
    'name': 'Владимир',
    'avgSP': 10,
    'tags': ['Integration', 'Backend Development']
  },
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> presets = [
    {
      'id': 1,
      'name': 'Оптимизация производительности сервера',
      'description':
          'Необходимо провести оптимизацию сервера для улучшения производительности и скорости отклика.',
      'endDate': '2023-10-08'
    },
    {
      'id': 2,
      'name': 'Разработка нового функционала',
      'description':
          'Добавить новые функции в приложение для улучшения пользовательского опыта.',
      'endDate': '2023-10-10'
    },
    {
      'id': 3,
      'name': 'Оптимизация производительности сервера',
      'description':
          'Необходимо провести оптимизацию сервера для улучшения производительности и скорости отклика.',
      'endDate': '2023-10-18'
    },
    {
      'id': 4,
      'name': 'Исправление ошибок',
      'description':
          'Исправить обнаруженные ошибки в приложении для устранения проблем с его функциональностью.',
      'endDate': '2023-10-05'
    },
  ];

  int counter = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        mini: false,
        onPressed: () {
          sendData();
        },
        child: Text("GO!"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Text(
                  "PRO.СПРИНТ",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Название задачи',
                  ),
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Введите описание задачи',
                  ),
                  maxLines: 5,
                  controller: descriptionController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                    IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        presets.add({
                          'id': counter,
                          'name': nameController.text,
                          'description': descriptionController.text,
                          'endDate': DateFormat("y-MM-dd").format(selectedDate),
                        });

                        nameController.clear();
                        descriptionController.clear();

                        counter++;
                        setState(() {});
                      }
                    },
                    child: const Text("Добавить"),
                  ),
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Список задач",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (final preset in presets.reversed) ...[
                        Padding(
                          key: ValueKey(preset['id']),
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: 300,
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            preset['name'] as String,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              presets.removeWhere(
                                                (element) =>
                                                    element['id'] ==
                                                    preset['id'],
                                              );
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      preset['description'] as String,
                                      maxLines: 4,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Срок: ${preset['endDate']}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Команда",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final user in users)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Material(
                            elevation: 2,
                            child: Container(
                              width: constraints.maxWidth / 3 - 20,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.account_circle_rounded,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(user['name']),
                                  Text(
                                    "AVG SP: ${user['avgSP']}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    (user['tags'] as List<String>).join(', '),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void sendData() {
    post(
      Uri.parse('http://94.131.101.111:8000/tag_tasks/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'users': users,
        'tasks': presets,
      }),
    ).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ResultScreen(results: jsonDecode(value.body));
          },
        ),
      );
    });
  }
}
