import 'package:flutter/material.dart';
import 'package:flutter_up/domain/service/login_service.dart';
import 'package:flutter_up/domain/service/response.dart';
import 'package:flutter_up/pages/home_page.dart';
import 'package:flutter_up/utils/alert.dart';
import 'package:flutter_up/utils/nav.dart';
import 'package:flutter_up/widgets/blue_button.dart';
import 'package:flutter_up/widgets/progress.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var showProgress = false;

  final _tLogin = TextEditingController(text: "ricardo");
  final _tSenha = TextEditingController(text: "abc123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              setState(() {
                showProgress = false;
              });
            },
          )
        ],
      ),
      body: _body(context),
      backgroundColor: Colors.yellow,
    );
  }

  _body(context) {
    return Container(
      margin: EdgeInsets.all(20),
      color: Colors.white,
      child: ListView(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/imgs/positivo1.jpg",
              height: 100,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Login",
            style: TextStyle(fontSize: 44),
          ),
          TextField(
            controller: _tLogin,
            style: TextStyle(fontSize: 44, color: Colors.blue),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Senha",
            style: TextStyle(fontSize: 44),
          ),
          TextField(
            controller: _tSenha,
            style: TextStyle(fontSize: 44, color: Colors.blue),
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: showProgress
                ? Progress()
                : BlueButton(
              "LOGIN",
                  () => _onClickLogin(context),
            ),
          )
        ],
      ),
    );
  }

  _onClickLogin(context) async {
    print("Login!");

    setState(() {
      showProgress = true;
    });

    String login = _tLogin.text;
    String senha = _tSenha.text;

    Response response = await LoginService.login(login,senha);

    if(response.isOk()) {
      push(context, HomePage());
    } else {
      alert(context,msg: response.msg);
    }

    setState(() {
      showProgress = false;
    });
  }
}
