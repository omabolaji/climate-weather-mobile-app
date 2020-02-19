import 'dart:io';

void main() {
  performance();
}

void performance() async {
  task1();
  String taskResult = await task2();
  task3(taskResult);
}

void task1() {
  String result = 'Task 1 data';
  print(result);
}

Future task2() async {
  Duration threeSeconds = Duration(seconds: 3);

  String result2;

  await Future.delayed(threeSeconds, () {
    result2 = 'Task 2 data';
    print(result2);
  });

  return result2;
}

void task3(String task2Data) {
  String result3 = 'Task 3 data';
  print('task two will be ready with $task2Data');
}
