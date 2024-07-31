import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gophermart/api/http_client.dart';
import 'package:gophermart/const/app_colors.dart';
import 'package:gophermart/const/const.dart';
import 'package:gophermart/models/auth_request.dart';
import 'package:gophermart/src/homePage/home.dart';
import 'package:gophermart/src/widgets/first_loading_progress_view.dart';
import 'package:gophermart/utils/preferences.dart';

import '../../const/app_ui.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/auth';
  @override
  State<StatefulWidget> createState() => AuthPageState();
}

class AuthPageState extends State {
  final _formKey = GlobalKey<FormState>();
  bool? _agreement = false;
  bool _loading = false;
  String user = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const FirstLoadingProgressView(
            description: 'Выполняется запрос',
          )
        : Scaffold(
            appBar: AppBar(
                title: const Text('GOPHERMART ʕ◔ϖ◔ʔ'), centerTitle: true),
            body: Container(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              4, // fromHeight use double.inf,
                          child: AppUi.imageSickGopher,
                        ),
                        TextFormField(
                          onChanged: (String? value) {
                            setState(() {
                              user = value!;
                            });
                          },
                          // ignore: body_might_complete_normally_nullable
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Введите логин!';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Логин',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Пароль',
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password = value!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Введите пароль';
                            }
                            String p = "[a-zA-Z0-9+._\%-+]{1,256}";
                            RegExp regExp = RegExp(p);

                            if (regExp.hasMatch(value)) return null;

                            return 'Неверная парольная строка';
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 20.0),
                        CheckboxListTile(
                            activeColor: AppColors.appColor,
                            value: _agreement,
                            title: const Text(
                                'Я ознакомился с правилами и согласен отдать все'),
                            onChanged: (bool? newValue) {
                              setState(() => _agreement = newValue);
                            }),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            foregroundColor: AppColors.textColorDisabled,
                            minimumSize: const Size.fromHeight(50),
                            // fromHeight use double.infinity as width and 40 is the height
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String text;
                              if (_agreement == false) {
                                text = 'Необходимо принять условия соглашения';
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(text),
                                      backgroundColor:
                                          AppColors.textColorGray));

                                return;
                              } else {
                                text = 'Форма успешно заполнена';
                              }

                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text(text),
                                    backgroundColor: AppColors.textColorGray));
                            }
                            setState(() {
                              _loading = true;
                            });
                            var jsonAuthRequest =
                                AuthRequest(user, password).toJson();

                            try {
                              var result = await httpAuthBase(
                                  ApiConstants.transportApiEndpoint,
                                  "/api/user/login",
                                  jsonEncode(jsonAuthRequest));
                              if (result.statusCode == 200) {
                                await Preferences.set(Preference.token,
                                    result.headers["authorization"]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage("home")));
                                setState(() {
                                  _loading = false;
                                });
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                      content:
                                          Text('Неправильный логин/пароль'),
                                      backgroundColor:
                                          AppColors.textColorGray));
                              }
                            } catch (e) {
                              setState(() {
                                _loading = false;
                              });
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text("Что-то не так"),
                                    backgroundColor: AppColors.textColorGray));
                            }
                          },
                          child: const Text(
                            style: TextStyle(fontSize: 15),
                            'ВХОД',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            foregroundColor: AppColors.textColorDisabled,
                            minimumSize: const Size.fromHeight(50),
                            // fromHeight use double.infinity as width and 40 is the height
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String text;
                              if (_agreement == false) {
                                text = 'Необходимо принять условия соглашения';
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(text),
                                      backgroundColor:
                                          AppColors.textColorGray));

                                return;
                              } else {
                                text = 'Форма успешно заполнена';
                              }

                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text(text),
                                    backgroundColor: AppColors.textColorGray));
                            }
                            setState(() {
                              _loading = true;
                            });
                            var jsonAuthRequest =
                                AuthRequest(user, password).toJson();

                            try {
                              var result = await httpAuthBase(
                                  ApiConstants.transportApiEndpoint,
                                  "/api/user/register",
                                  jsonEncode(jsonAuthRequest));
                              if (result.statusCode == 200) {
                                await Preferences.set(Preference.token,
                                    result.headers["authorization"]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage("home")));
                                setState(() {
                                  _loading = false;
                                });
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                      content:
                                          Text('Неправильный логин/пароль'),
                                      backgroundColor:
                                          AppColors.textColorGray));
                              }
                            } catch (e) {
                              setState(() {
                                _loading = false;
                              });
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text("Что-то не так"),
                                    backgroundColor: AppColors.textColorGray));
                            }
                          },
                          child: const Text(
                            style: TextStyle(fontSize: 15),
                            'РЕГИСТРАЦИЯ',
                          ),
                        ),
                      ],
                    ))));
  }
}
