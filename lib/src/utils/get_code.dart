import 'dart:math';

int getCode() {
  final random = Random();
  int code = 0;
  for (var i = 0; i < 6; i++) {
    code = random.nextInt(100);
  }
  return code;
}
