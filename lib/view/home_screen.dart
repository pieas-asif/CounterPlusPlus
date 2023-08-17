import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter++"),
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
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: SafeArea(
        child: Center(
          child: Text("Hello Iser"),
        ),
      ),
    );
  }
}
