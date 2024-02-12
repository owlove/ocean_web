import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_app_web/views/gallery/gallery_view.dart';
import 'package:ocean_app_web/views/home/home_view.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class PriceInfo {
  final String money;
  final String description;

  const PriceInfo({
    required this.money,
    required this.description,
  });

  static PriceInfo fromJson(Map<String, dynamic> json) => PriceInfo(
        money: json['money'],
        description: json['description'],
      );
}

Stream<List<PriceInfo>> readPrice() => FirebaseFirestore.instance
    .collection('PriceID')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => PriceInfo.fromJson(doc.data())).toList());

class TicketsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, '/view/gallery/gallery_view');
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
        body: _builBody(context),
      );
}

Widget _builBody(context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        _description(),
        _price(context),
        _bottomDescription(context),
      ],
    ),
  );
}

Widget _description() {
  return Padding(
    padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 150),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Правила посещения",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 92, 157, 1),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Text(
          "* Касса работает с 10:00 до 19:00.\n\n* Войти в экспозиционный корпус по одному билету можно только один раз.\n\n* Запрещено фотографировать и снимать обитателей океанариума с использованием дополнительного освещения, а также кормить животных.\n\n* Администрация не несет ответственности за поддельные билеты, приобретенные в неустановленных местах.",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 92, 157, 1),
              wordSpacing: 10),
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );
}

Widget _price(context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 130),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Цены на билеты",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 92, 157, 1),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        StreamBuilder(
          stream: readPrice(),
          builder: (context, snapshot) {
            buildPrice(PriceInfo price) => Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
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
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            price.description,
                            style: TextStyle(
                              color: Color.fromRGBO(182, 217, 239, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            price.money,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(182, 217, 239, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );

            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final price = snapshot.data!;

              return ListView(
                shrinkWrap: true,
                children: price.map(buildPrice).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget _bottomDescription(context) {
  return Footer(
    child: Container(
      height: 200,
      //color: Colors.blue[800],
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
                      //Navigator.pushNamed(context, '/view/tickets/tickets_view');
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
    ),
    backgroundColor: Colors.blue[800],
  );
}
