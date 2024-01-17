import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_app_web/views/gallery/fish_info.dart';
import 'package:ocean_app_web/views/tickets/tickets_view.dart';
import 'package:ocean_app_web/views/home/home_view.dart';

// Класс для создания объектов (рыб) для листвью и страницы с описанием
class Fish {
  final String name;
  final String description;
  final String imageUrl;
  final String fullDescription;

  const Fish({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.fullDescription,
  });

  static Fish fromJson(Map<String, dynamic> json) => Fish(
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        fullDescription: json['fullDescription'],
      );
}

// чтение из firebase
Stream<List<Fish>> readFish() => FirebaseFirestore.instance
    .collection('FishID')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Fish.fromJson(doc.data())).toList());

// страница со списком рыб и ссылкой на новую страницу описания рыб
class GalleryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(0, 92, 157, 1),
        appBar: AppBar(
          toolbarHeight: 80,
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Режим работы:",
                      style: TextStyle(
                          color: Color.fromRGBO(182, 217, 239, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Пн-Пт: 10:00 - 20:00",
                      style: TextStyle(
                          color: Color.fromRGBO(182, 217, 239, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Сб-Вс: 10:00 - 22:00",
                      style: TextStyle(
                          color: Color.fromRGBO(182, 217, 239, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "Галерея рыб",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromRGBO(182, 217, 239, 1),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/view/tickets/tickets_view');
                          Route route = MaterialPageRoute(
                              builder: (context) => TicketsView());
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        },
                        child: Text(
                          'Билеты',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 92, 157, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(182, 217, 239, 1),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/view/home/HomeView');
                          Route route = MaterialPageRoute(
                              builder: (context) => HomeView());
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        },
                        child: Text(
                          'Главная страница',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 92, 157, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(182, 217, 239, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 92, 157, 1),
        ),
        body: StreamBuilder(
          stream: readFish(),
          builder: (context, snapshot) {
            buildFish(Fish fish) => Container(
                  height: 150,
                  padding: EdgeInsets.only(left: 50, right: 50, bottom: 15),
                  child: Card(
                    color: Color.fromRGBO(105, 181, 231, 1),
                    child: ListTile(
                      title: Text(
                        fish.name,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 92, 157, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      subtitle: Text(
                        fish.description,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 92, 157, 1),
                          fontSize: 20,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FishDetails(fish),
                          ),
                        );
                      },
                    ),
                  ),
                );
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final fish = snapshot.data!;

              return ListView(
                children: fish.map(buildFish).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}
