import 'package:flutter/material.dart';
import 'package:ocean_app_web/views/home/home_view.dart';
import 'package:ocean_app_web/views/tickets/tickets_view.dart';
import 'package:ocean_app_web/views/gallery/gallery_view.dart';


// страница описания программы
class ProgramInformation extends StatelessWidget {
  final ProgInfo prog;
  ProgramInformation(this.prog);

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
                        // Navigator.pushNamed(
                        //     context, '/view/tickets/tickets_view');
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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _programIndormation(context),
          _bottomDescription(context),
        ],
      ),
    );
  }

  Widget _programIndormation(context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 350),
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
                prog.name,
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
                prog.description,
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
                      // Navigator.pushNamed(
                      //     context, '/view/tickets/tickets_view');
                      Route route = MaterialPageRoute(
                            builder: (context) => TicketsView());
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
}
