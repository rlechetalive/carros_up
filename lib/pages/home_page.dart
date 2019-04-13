
import 'package:flutter/material.dart';
import 'package:flutter_up/domain/carro.dart';
import 'package:flutter_up/domain/service/carro_service.dart';
import 'package:flutter_up/drawer_list.dart';
import 'package:flutter_up/pages/carro_page.dart';
import 'package:flutter_up/utils/alert.dart';
import 'package:flutter_up/utils/nav.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Positivo"),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            _listBuilder(context),
            Container(color: Colors.yellow),
            Container(color: Colors.green)
          ],
        ),
        drawer: DrawerList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("OK!");
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  _listBuilder(context) {
    Future<List<Carro>> carros = CarroService.getCarros();

    return FutureBuilder<List<Carro>>(
      future: carros,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(context,carros);
      },
    );
  }

  _listView(context, List<Carro> carros) {
    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (context, idx) {
        final c = carros[idx];

        return GestureDetector(
          onTap: () => _onClickCarro(context, c),
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: ListTile(
              leading: Image.network(
                c.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                height: 80,
              ),
              title: Text(
                "> ${c.nome}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _onClickCarro(context, Carro c) {
    print("Carro $c");
    push(context, CarroPage(c));
  }
}
