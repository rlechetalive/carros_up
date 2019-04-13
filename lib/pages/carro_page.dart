import 'package:flutter/material.dart';
import 'package:flutter_up/domain/carro.dart';

class CarroPage extends StatelessWidget {
  final Carro carro;

  const CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Image.network(
            carro.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
            height: 80,
          ),
          Center(
            child: Text(
              carro.nome,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
