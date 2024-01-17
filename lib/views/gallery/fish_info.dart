import 'package:flutter/material.dart';
import 'package:ocean_app_web/views/gallery/gallery_view.dart';
import 'package:ocean_app_web/views/tickets/tickets_view.dart';
import 'package:ocean_app_web/views/home/home_view.dart';

// страница описания конкретной выбранной рыбы
class FishDetails extends StatelessWidget {
  final Fish fish;
  FishDetails(this.fish);

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
              child: Container(
                child: Text(
                  fish.name,
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
                        Route route =
                            MaterialPageRoute(builder: (context) => HomeView());
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
      body: SingleChildScrollView(
        child: Column(children: [
          Image(
            image: AssetImage(fish.imageUrl),
            fit: BoxFit.cover,
          ),
          Container(
            padding:
                EdgeInsets.only(left: 100, right: 100, top: 50, bottom: 100),
            child: Text(
              fish.fullDescription,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color.fromRGBO(0, 92, 157, 1),
                fontSize: 20.0,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
