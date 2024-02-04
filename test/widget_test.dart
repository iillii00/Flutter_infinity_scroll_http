import 'dart:io';

void main() {
  showData();
}

void showData() async {
  startTask();
  String data = await accessData();
  fetchData(data);
}

void startTask() {
  String info1 = '요청시작';
  print(info1);
}

Future<String> accessData() async {

  late String account;

  Duration time = Duration(seconds: 3);
  if (time.inSeconds > 2) {
  await  Future.delayed(time, () {
      account = '300조';
      print(account);
    });
  } else {
  await  Future.delayed(time, () {
      account = '안녕';
      print(account);
    });
  }
  return account;
}

void fetchData(String accounts) {
  String info3 = '잔액은 $accounts 입니다.';
  print(info3);
}