import 'dart:async';

import 'package:counter_plus_plus/controller/isar_service.dart';
import 'package:flutter/material.dart';

import '../model/counter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final IsarService isarService = IsarService();
  final TextEditingController controller = TextEditingController();
  List<Counter> counters = [];
  late StreamSubscription<Counter> counterSubscription;

  @override
  void initState() {
    super.initState();
    getCountersFromDB();
  }

  getCountersFromDB() async {
    counters = await isarService.getCounters();
    setState(() {});
  }

  void onAddPressed() async {
    String label = controller.text;
    if (label.isEmpty) {
      Navigator.pop(context);
      return;
    }
    Counter counter = Counter(name: label);
    await isarService.saveCounter(counter);
    Navigator.pop(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter++"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.fingerprint),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddCounter(
                controller: controller,
                onAddPressed: onAddPressed,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: StreamBuilder<List<Counter>>(
            stream: isarService.counterStream(),
            builder: (context, snapshot) {
              Widget buildWidget = const Text("No Data");
              if (snapshot.hasData) {
                buildWidget = Column(
                  children: snapshot.data!.map((counter) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                color: Colors.deepPurple.shade200,
                                onPressed: () {},
                                icon: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade200,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.remove,
                                    size: 42,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      counter.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      counter.count.toString(),
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text("2 min ago"),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade200,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.add,
                                    size: 42,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                buildWidget = const Text("Error Fetching DB");
              }

              return buildWidget;
            },
          ),
        ),
      ),
    );
  }
}

class AddCounter extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onAddPressed;
  const AddCounter({
    super.key,
    required this.controller,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  const Expanded(
                    child: Text(
                      "Add Counter",
                      style: TextStyle(
                        // fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onAddPressed,
                    child: const Text("Add"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Label",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
