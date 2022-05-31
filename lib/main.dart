import 'package:flutter/material.dart';
import 'package:webscraping/web_scrapping.dart';

import './computer.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MainState();
}

class _MainState extends State<MyApp> {
  final WebScraper webScraper = WebScraper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: FutureBuilder(
            future: webScraper.extractData(),
            builder: (_, snapShot) {
              if (snapShot.hasData) {
                List<Computer> computers = snapShot.data as List<Computer>;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ListTile(
                          leading: Image.network(
                            computers[index].image,
                            fit: BoxFit.cover,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              computers[index].price,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          subtitle: Text(
                            computers[index].info,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                    itemCount: computers.length,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
