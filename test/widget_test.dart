import 'dart:io';

void main() {
  showData();
}

void showData() async {
  startTask();
  accessData();
  fetchData();
}

void startTask() {
  String info1 = '요청시작';
  print(info1);
}

// Future<void> accessData() async {
//   String info2 = '데이터 처리 완료';
//   print(info2);
// }

Future<void> accessData() async {
  Duration time = Duration(seconds: 3);
  if (time.inSeconds > 2) {
   await Future.delayed(time, () {
      String info2 = '데이터 처리 완료';
      print(info2);
    });
  } else {
    String info2 = '데이터 가지고 왔음';
    print(info2);
  }
}

void fetchData() {
  String info3 = '잔액은 5천원 입니다.';
  print(info3);
}
