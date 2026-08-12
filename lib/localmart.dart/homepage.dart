import 'package:flutter/material.dart';
import 'package:localmart/localmart.dart/login.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                aspectRatio: 16 / 9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
              ),
              items:
                  [
                    Image.network(
                      'https://i.wfolio.ru/x/LATXGxMAvg4T0aCx3BMAPcoPN8LBuMrG/WUxqXOvhFPl7GHv-GzWkMqqXeqAxaS7S/lYNN2xlHOX_lMURN2UM2Nho8pSoSar4J/RFFy_MztidZlI_Qh7_IJ5RqZjrwJo0QB.jpg?utm_source=chatgpt.com',
                    ),
                    toString(),
                    Image.network(
                      'https://shopee.co.id/product/1701656273/42028183238?utm_term=SP_Search_Shopping_WomenBags_All_L1WomenBags&utm_campaign=D05_ALL_PIN_Shopping_SP_Search_All_WomenBagsWomenShoes_All&item_id=42028183238&utm_medium=cpc&utm_source=Pinterest&utm_content=4260609520004&pp=0&epik=dj0yJnU9V3VJMk9LZU11ZVNZdjVGWjkxQThqWS1mWm5JdVM1aTAmcD0xJm49anhYWnZKWkEwQ24zZndwQVpqTnpRQSZ0PUFBQUFBR3A4R1VZ',
                    ),
                    3,
                    4,
                    5,
                  ].map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Text(
                            'text $imageUrl',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 30, width: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                // Jarak antar kotak
                padding: const EdgeInsets.symmetric(horizontal: 20),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 kotak dalam 1 baris
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.75,
                ),

                itemCount: 8,

                itemBuilder: (context, index) {
                  final kategori = [
                    {'icon': Icons.phone_android, 'text': 'Elektronik'},
                    {'icon': Icons.checkroom, 'text': 'Pakaian Pria'},
                    {'icon': Icons.watch, 'text': 'Aksesoris'},
                    {'icon': Icons.toys, 'text': 'Mainan Anak'},
                    {'icon': Icons.search, 'text': 'Kecantikan'},
                    {'icon': Icons.add_a_photo, 'text': 'Atasan Wanita'},
                    {'icon': Icons.backpack, 'text': 'Tas Pria'},
                    {'icon': Icons.category, 'text': 'lainnya'},
                  ];

                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HalamanLogin(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(70, 70),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          backgroundColor: const Color.fromARGB(
                            223,
                            202,
                            197,
                            197,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 200, 196, 202),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            kategori[index]['icon'] as IconData,
                            color: const Color.fromARGB(255, 43, 100, 193),
                            size: 30,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        kategori[index]['text'] as String,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
