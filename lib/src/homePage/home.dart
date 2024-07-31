import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gophermart/api/http_client.dart';
import 'package:gophermart/const/app_colors.dart';
import 'package:gophermart/const/app_ui.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:gophermart/models/accrualsList.dart';
import 'package:gophermart/models/balance.dart';
import 'package:gophermart/models/withdraw.dart';
import 'package:gophermart/models/withdrawalList.dart';
import 'package:gophermart/src/authPage/auth_page.dart';
import 'package:gophermart/src/widgets/first_loading_progress_view.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage(String s, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BalanseResponse balance = BalanseResponse(0, 0);
  String resultWithDraw = "";
  List<AccrualResponce> accruals = List.empty();
  List<WithdrawalResponse> withdrawals = List.empty();
  bool loading = false;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
    });
    _getBalance();
    _getAccruals();
    _getWithdrawals();
    setState(() {
      loading = false;
    });
  }

  _getBalance() async {
    try {
      var jsonResult = await apiHttpGet('/api/user/balance');
      var json = jsonDecode(jsonResult.body);

      BalanseResponse result = BalanseResponse.fromJson(json);
      setState(() {
        balance = result;
      });
    } catch (e) {
      setState(() {
        balance = BalanseResponse(0, 0);
      });
    }
  }

  Future<List<AccrualResponce>> _getAccruals() async {
    var result = await apiHttpGet('/api/user/orders');
    Iterable l = json.decode(result.body);
    List<AccrualResponce> resultAccruals =
        List<AccrualResponce>.from(l.map((e) => AccrualResponce.fromJson(e)));
    setState(() {
      accruals = resultAccruals;
    });
    return resultAccruals;
  }

  Future<List<WithdrawalResponse>> _getWithdrawals() async {
    var result = await apiHttpGet('/api/user/withdrawals');
    Iterable w = json.decode(result.body);
    List<WithdrawalResponse> resultWithdrawals = List<WithdrawalResponse>.from(
        w.map((e) => WithdrawalResponse.fromJson(e)));
    setState(() {
      withdrawals = resultWithdrawals;
    });
    return resultWithdrawals;
  }

  _listAccruals() {
    return RefreshIndicator(
      onRefresh: _getAccruals,
      child: ListView.builder(
          itemCount: accruals.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: Icon(
                  Icons.circle_rounded,
                  color: switch (accruals[index].status) {
                    "INVALID" => AppColors.textColorRed,
                    "PROCESSING" => Colors.yellow,
                    "NEW" => AppColors.textColorDisabled,
                    "PROCESSED" => AppColors.textColorGreen,
                    String() => Colors.transparent,
                  },
                ),
                trailing: switch (accruals[index].status) {
                  "INVALID" => Icon(Icons.error),
                  "PROCESSING" => Icon(Icons.work_history),
                  "NEW" => Icon(Icons.new_label),
                  "PROCESSED" => Icon(Icons.done),
                  String() => Icon(Icons.abc),
                },
                title: Text(
                    "${accruals[index].number} (${accruals[index].accrual ?? 0.0})"));
          }),
    );
  }

  _listWithdrawals() {
    return RefreshIndicator(
      onRefresh: _getWithdrawals,
      child: ListView.builder(
          itemCount: withdrawals.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("QR ${withdrawals[index].order}"),
                          content: SizedBox(
                            height: 300,
                            child: SfBarcodeGenerator(
                              value: 'POINTS_${withdrawals[index].sum}',
                              symbology: QRCode(),
                            ),
                          ),
                        );
                      });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${withdrawals[index].order} "),
                    Text("${withdrawals[index].sum}"),
                  ],
                ));
          }),
    );
  }

  Widget _tabView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.47,
      child: ContainedTabBarView(
        tabs: const [
          Text(
            'Пополнения',
            style: TextStyle(color: AppColors.textColorDarkGray),
          ),
          Text('Списания',
              style: TextStyle(color: AppColors.textColorDarkGray)),
        ],
        views: [
          Container(child: _listAccruals()),
          Container(child: _listWithdrawals()),
        ],
        onChange: (index) => print(index),
      ),
    );
  }

  final TextEditingController _orderController = TextEditingController();
  final TextEditingController _deductPoints = TextEditingController();
  final TextEditingController _numberOrder = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    _orderController.clear();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('ЗАКАЗ'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {});
              },
              controller: _orderController,
              decoration: const InputDecoration(hintText: "введите номер"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: AppColors.textColorRed,
                textColor: AppColors.mainPageBannerBackgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: const Text('Отменить'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: AppColors.appColor,
                textColor: AppColors.mainPageBannerBackgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: const Text('OK'),
                onPressed: () async {
                  await _registerOrder(_orderController.text)
                      .then((value) => switch (value) {
                            202 => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Успешно зарегистрировано'),
                                    backgroundColor: AppColors.textColorGreen)),
                            200 => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Уже было загружено.xD Айайай!'),
                                    backgroundColor: AppColors.textColorGreen)),
                            int() => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Что-то не так  =('),
                                    backgroundColor: AppColors.textColorGray)),
                          });
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String? get _errorText {
    final text = _deductPoints.value.text;

    if (text.isEmpty) {
      return null;
    }
    if (double.parse(text) > balance.current) {
      return 'Остановитесь!';
    }

    return null;
  }

  void _showModalBottomSheet(BuildContext context, double balance) {
    _deductPoints.clear();
    _numberOrder.clear();
    setState(() {
      resultWithDraw = 'no';
    });
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    controller: _deductPoints,
                    decoration: InputDecoration(
                        errorText: _errorText ?? null,
                        labelText:
                            'Сумма списания не более ${balance.toString()}'),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    controller: _numberOrder,
                    decoration:
                        const InputDecoration(labelText: 'Номер заказа'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  switch (resultWithDraw) {
                    "ok" => SizedBox(
                        height: 300,
                        child: SfBarcodeGenerator(
                          value: 'POINTS_${_deductPoints.text}',
                          symbology: QRCode(),
                        ),
                      ),
                    "no" || "" => Center(
                        child: Container(
                          height: 300,
                        ),
                      ),
                    String() => Center(
                        child: Column(
                          children: [
                            Text("ОШИБКА"),
                            SizedBox(height: 5),
                            Container(
                              height: 300,
                              child: AppUi.errorGopher,
                            ),
                          ],
                        ),
                      ),
                  },
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          color: AppColors.appColor,
                          textColor: AppColors.mainPageBannerBackgroundColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          onPressed: () async {
                            if (_numberOrder.text == "" ||
                                _deductPoints.text == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text("Заполните все поля"),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 150,
                                  left: 10,
                                  right: 10,
                                ),
                              ));
                              return;
                            } else {
                              var withdraw = WithdrawRequest(_numberOrder.text,
                                      double.parse(_deductPoints.text))
                                  .toJson();
                              var jsonWithdraw = jsonEncode(withdraw);
                              await _registerWithdraw(jsonWithdraw).then(
                                (value) {
                                  setState(() {
                                    resultWithDraw = switch (value) {
                                      200 => 'ok',
                                      402 => 'money',
                                      422 => 'bad',
                                      500 => 'bad',
                                      int() => 'bad',
                                    };
                                  });
                                  setState(() {});
                                },
                              );
                            }
                          },
                          child: const Text('Списать')),
                    ],
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainPageBannerBackgroundColor,
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () {
          _showModalBottomSheet(context, balance.current);
        },
        backgroundColor: AppColors.appColor.withOpacity(0.7),
        child: const Icon(
          Icons.add,
          color: AppColors.mainPageBannerBackgroundColor,
          size: 32,
        ),
      ),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        leading: const Row(children: [
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/leadingLogo.png'),
          ),
        ]),
        backgroundColor: AppColors.mainPageBannerBackgroundColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _exit(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: AppColors.textColorGray,
              ))
        ],
        title: const Text(
          "Ваш баланс",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: loading
          ? const FirstLoadingProgressView(description: 'инициализация...')
          : Column(children: [
              Row(
                children: [
                  SizedBox(
                    height: 230,
                    child: GestureDetector(
                      onTap: () {
                        _getBalance();
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        margin: AppUi.cardMargin,
                        elevation: 10,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              const Image(
                                  image: AssetImage(
                                      'assets/images/bonuscard.png')),
                              Padding(
                                  padding: AppUi.cardPadding,
                                  child: Text(
                                    "${balance.current}\n${balance.withdrawn}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 56,
                                      color: AppColors.appColor,
                                    ),
                                  )),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: MaterialButton(
                  minWidth: 340,
                  padding: AppUi.cardPadding,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: AppColors.appColor,
                  textColor: AppColors.mainPageBannerBackgroundColor,
                  // textTheme: ButtonTextTheme.primary,
                  onPressed: () {
                    _displayTextInputDialog(context);
                  },
                  child: const Text(
                    "Зарегистрировать заказ",
                    style: TextStyle(
                        color: AppColors.mainPageBannerBackgroundColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _tabView(context)
            ]),
    );
  }
}

_exit(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => AuthPage()));
}

Future<int> _registerOrder(String data) async {
  var result = await apiHttpPostOrdernumber('/api/user/orders', data);
  return result.statusCode;
}

Future<int> _registerWithdraw(String data) async {
  var result = await apiHttpPostOrdernumber('/api/user/balance/withdraw', data);
  return result.statusCode;
}

_smth() {
  print('smth');
}
