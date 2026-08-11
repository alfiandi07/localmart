import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LocalMart",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 3, 100, 179),
          ),
        ),
        leading: Icon(
          Icons.home,
          color: const Color.fromARGB(255, 3, 100, 179),
        ),
        actions: [
          Icon(
            Icons.notifications,
            color: const Color.fromARGB(255, 3, 100, 179),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 253, 253),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.only()),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Cari di LocalMart',
                prefixIcon: Icon(Icons.search),
                fillColor: const Color.fromARGB(207, 108, 102, 102),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(32, 52, 48, 48),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(32, 52, 48, 48),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(32, 52, 48, 48),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30, width: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(72, 57, 56, 56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(72, 57, 56, 56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.access_alarm_outlined),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(72, 57, 56, 56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.shop_2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(72, 57, 56, 56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
