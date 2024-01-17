import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_app_web/views/home/program_info.dart';
import 'package:ocean_app_web/views/tickets/tickets_view.dart';
import 'package:ocean_app_web/views/gallery/gallery_view.dart';

class ProgInfo {
  final String name;
  final String description;
  final String fullDescription;

  const ProgInfo({
    required this.name,
    required this.description,
    required this.fullDescription,
  });

  static ProgInfo fromJson(Map<String, dynamic> json) => ProgInfo(
        name: json['name'],
        description: json['description'],
        fullDescription: json['fullDescription'],
      );
}

Stream<List<ProgInfo>> readProg() => FirebaseFirestore.instance
    .collection('ProgID')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => ProgInfo.fromJson(doc.data())).toList());

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(182, 217, 239, 1),
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
                        //Navigator.pushNamed(context, '/view/gallery/gallery_view');
                        Route route = MaterialPageRoute(
                            builder: (context) => GalleryView());
                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => false);
                      },
                      child: Text(
                        'Галерея',
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
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _welcomeDescription(),
        _programs(),
        _helpInformation(),
        _bottomDescription(context),
      ],
    ),
  );
}

Widget _welcomeDescription() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Text(
        "Добро пожаловать в океанариум!",
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 92, 157, 1),
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _programs() {
  return Container(
    padding: EdgeInsets.only(
      left: 50,
      right: 50,
      top: 50,
    ),
    child: Column(
      children: [
        Container(
          child: Text(
            "Программы на месяц:",
            style: TextStyle(
              fontSize: 25,
              color: Color.fromRGBO(0, 92, 157, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 250,
          child: StreamBuilder(
            stream: readProg(),
            builder: (context, snapshot) {
              buildProg(ProgInfo prog) => Card(
                    color: Color.fromRGBO(0, 92, 157, 0.9),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(prog.name,
                            style: TextStyle(
                              color: Color.fromRGBO(182, 217, 239, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                            textAlign: TextAlign.center),
                        subtitle: Text(
                          prog.description,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(182, 217, 239, 1),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProgramInformation(prog),
                            ),
                          );
                        },
                      ),
                    ),
                  );

              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final prog = snapshot.data!;

                return Scrollbar(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 350,
                    children: prog.map(buildProg).toList(),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}

Widget _helpInformation() {
  return Padding(
    padding: EdgeInsets.only(top: 150, bottom: 150, left: 50, right: 50),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(0, 92, 157, 0.9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            5,
          ),
          color: Color.fromRGBO(0, 92, 157, 0.9),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Помоги океану вместе с The Ocean Foundation",
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(182, 217, 239, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Океан выходит за все географические границы, отвечает за каждый второй вдох, который мы делаем, и покрывает 71% земной поверхности. На протяжении более 20 лет наше сообщество стремится заполнить пробел в благотворительности, который исторически давал океану только 7% экологических грантов и, в конечном счете, менее 1% всей благотворительности, чтобы поддержать сообщества, которые нуждаются в этом финансоировании для морских наук и сохранения океана. Сообщетво было основано, чтобы помочь изменить это менее чем благоприятное соотношение.",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(182, 217, 239, 1),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Больше информаци по ссылке: https://oceanfdn.org.ru',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(182, 217, 239, 1),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _bottomDescription(context) {
  return Container(
    height: 200,
    color: Colors.blue[800],
    child: Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Column(children: [
              Text(
                "Контакты:",
                style: TextStyle(
                    color: Color.fromRGBO(182, 217, 239, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Телефон: +7 908 00 00 404",
                  style: TextStyle(
                      color: Color.fromRGBO(182, 217, 239, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Text(
                "Адрес: ул. Окулова, д. 3",
                style: TextStyle(
                    color: Color.fromRGBO(182, 217, 239, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ]),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/view/tickets/tickets_view');
                    Route route =
                        MaterialPageRoute(builder: (context) => TicketsView());
                    Navigator.pushAndRemoveUntil(
                        context, route, (route) => false);
                  },
                  child: Text(
                    'Билеты',
                    style: TextStyle(
                      color: Color.fromRGBO(182, 217, 239, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/view/gallery/gallery_view');
                      Route route = MaterialPageRoute(
                          builder: (context) => GalleryView());
                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => false);
                    },
                    child: Text(
                      'Галерея',
                      style: TextStyle(
                        color: Color.fromRGBO(182, 217, 239, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
