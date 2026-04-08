import 'dart:io';

Future<String> readUserInput() async {
    print('Enter something:');
    return stdin.readLineSync() ?? '';
}

Future<List<String>> fetchTodos() async {
  await Future.delayed(Duration(seconds: 1)); 
  return ['Remote todo 1', 'Remote todo 2'];
}

void main() async {
  final input = await readUserInput();
  print('You entered: $input');
  print('Loading todos...');
  final todos = await fetchTodos();
  todos.forEach(print);
}