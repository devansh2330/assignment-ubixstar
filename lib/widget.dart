import 'package:assignment_ubixstar/constants.dart';
import 'package:assignment_ubixstar/home.dart';
import 'package:flutter/material.dart';

class ImportWidgetWindow extends StatefulWidget {
  const ImportWidgetWindow({super.key});

  @override
  State<ImportWidgetWindow> createState() => _ImportWidgetWindowState();
}

class _ImportWidgetWindowState extends State<ImportWidgetWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(60),
        color: Colors.green[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selected[0] == true
                            ? Colors.green
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selected[0] = !selected[0];
                      print(selected);
                    });
                  },
                ),
                Container(
                  height: 50,
                  width: 240,
                  decoration: BoxDecoration(color: Colors.grey[400]),
                  child: const Text(
                    'Text Widget',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selected[1] == true
                            ? Colors.green
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selected[1] = !selected[1];
                      print(selected);
                    });
                  },
                ),
                Container(
                  height: 50,
                  width: 240,
                  decoration: BoxDecoration(color: Colors.grey[400]),
                  child: const Text(
                    'Image Widget',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selected[2] == true
                            ? Colors.green
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selected[2] = !selected[2];
                      messageBox = !messageBox;
                      print(selected);
                    });
                  },
                ),
                Container(
                  height: 50,
                  width: 240,
                  decoration: BoxDecoration(color: Colors.grey[400]),
                  child: const Text(
                    'Button Widget',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black,
                    )),
                alignment: Alignment.center,
                child: const Text('Import Widgets'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
