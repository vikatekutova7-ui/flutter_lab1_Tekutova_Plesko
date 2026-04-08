// void main() {
//   print('Hello world');
//   String name = 'Artem';
//   String? name2 = null;
//   var count = 0;
//   var title = "Hello";
//   var x = 5;
//   // x = "dsf";
//   final id;
//   id = 5;
//   const app = "Todo";
//   print("$app $id $x $title ${count + 1} $name2 $name");
//   List<String> test = ['язык', 'уроки'];
//   Map<String, dynamic> data = {'key': 1};
//   Set<int> id2 = {1, 2, 3};

// }
import 'dart:ffi';
import 'dart:io';
import 'package:todo_app_2/todo.dart';
import 'package:todo_app_2/todo_repository.dart';
import 'package:ansicolor/ansicolor.dart';

final AnsiPen greenPen = AnsiPen().green();
final AnsiPen redPen = AnsiPen().red();
final AnsiPen bluePen = AnsiPen().blue();
final AnsiPen yellowPen = AnsiPen().yellow();
void main() {
  TodoRepository repo = TodoRepository();
  printMenu();
  while (true) {
    stdout.write("> ");
    String? input = stdin.readLineSync();
    if (input == null) {
      continue;
    }
    input = input.trim();
    if (input.isEmpty) {
      continue;
    }
    bool shouldExit = handleCommand(repo, input);
    if (shouldExit) {
      break;
    }
  }
}

void printMenu() {
  print(yellowPen("Консольное приложение TODO"));
  print("Команды:");
  print("add <текст>          - добавить задачу");
  print("list                 - показать список");
  print("done <id>            - отметить");
  print("delete <id>          - удалить задачу");
  print("exit                 - выход");
  print("");
}

void addCommand(TodoRepository repo, String input) {
  if (input.length <= 4) {
    print("Ошибка: введите текст задачи");
    return;
  }
  String title = input.substring(4).trim();
  repo.add(title);
  print("Задача добавлена");
}

void listCommand(TodoRepository repo) {
  List<Todo> todos = repo.getAll();
  if (todos.isEmpty) {
    print("Список задач пуст");
    return;
  }
  for (var todo in todos) {
    print(todo);
  }
}

void doneCommand(TodoRepository repo, List<String> parts) {
  if (parts.length < 2) {
    print("Ошибка: укажите id");
    return;
  }
  int id = int.parse(parts[1]);
  repo.complete(id);
  print("Задача отмечена выполненной");
}

void deleteCommand(TodoRepository repo, List<String> parts) {
  if (parts.length < 2) {
    print("Ошибка: укажите id");
    return;
  }
  int id = int.parse(parts[1]);
  repo.delete(id);
  print("Задача удалена");
}

bool handleCommand(TodoRepository repo, String input) {
  List<String> parts = input.split(" ");
  String command = parts[0].toLowerCase();
  try {
    switch (command) {
      case "add":
        addCommand(repo, input);
        break;
      case "list":
        listCommand(repo);
        break;
      case "done":
        doneCommand(repo, parts);
        break;
      case "delete":
        deleteCommand(repo, parts);
        break;
      case "exit":
        print("Выход из программы");
        return true;
      default:
        print("Неизвестная команда");
    }
  } catch (e) {
    print(redPen("Ошибка: $e"));
  }
  return false;
}
