import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Enumerations
// enum PersonProperties { firstName, lastName, age }
// enum AnimalType { cat, dog, bunny }

// void makeSureThisIsACat(AnimalType animalType) {
//   if (animalType != AnimalType.cat)
//     return; // This is to make sure that any code after this line is completely sure that the animalType is a cat.
// }

// Generics: Used to avoid re-writing similar code.
class PairOfStrings {
  final String value1;
  final String value2;
  PairOfStrings(this.value1, this.value2);
}

class PairOfIntegers {
  final int value1;
  final int value2;
  PairOfIntegers(this.value1, this.value2);
}

// So instead of doing this pairOf .....etc, you can do the following:
class Pair<A, B> {
  // Here you define Pair with generic datatype A, and B
  final A value1;
  final B value2;
  Pair(this.value1, this.value2);
}

// Generators: A function (marked with sync* or async*) that returns a list of things but it internally calculates that data in a very simple way
// Iterable<int> getOneTwoThree() sync* {
// Iterables are lazy collections.
//   yield 1;
//   yield 2;
//   yield 3;
// }

// Streams: An asynchronous "pipe" of data (i.e. continuous pipe of information)
// Stream<String> getName() {
//   // return Stream.value('Foo');
//   return Stream.periodic(const Duration(seconds: 1), (value) {
//     return 'Foo';
//   });
// }

// Future: Data to be returned in the future (async programming).
// int multipledByTwo(int a) => a * 2; // This is a sync operation
// Future<int> heavyFutureThatMultipliesByTwo(int a) {
//   return Future.delayed(const Duration(seconds: 3), () {
//     return a * 2;
//   });
// }

// class Cat {
//   final String name;
//   Cat(this.name);

// Custome Operators
// @override
// bool operator ==(covariant Cat other) =>
//     other.name ==
//     name; // covariant tells Dart that forget what the super class (i.e. Object) defines as the parameter type and override it with Cat type

// @override
// int get hashCode => name.hashCode;

// Factory Constructors
// factory Cat.fluffBall() {
//   return Cat('Fluff Ball');
// }
// }

// Extensions: Adding logic to existing classes
// extension Run on Cat {
//   void run() {
//     print('Cat $name is running');
//   }
// }

// class Person {
//   final String firstName;
//   final String lastName;

//   Person(this.firstName, this.lastName);
// }

// extension FullName on Person {
//   String get fullName => '$firstName $lastName';
// }

// Abstract classes: They are like the normal classes, but they cannot be instantiated (i.e. final thing = LivingThin() is not possible)
// abstract class LivingThing {
//   void breath() {
//     print('Living thing is breathing');
//   }

//   void move() {
//     print('I am moving');
//   }
// }

// Now the Cat class wants to use the methods of the LivingThing class, so it must inherit from it
// class Cat extends LivingThing {}

// Classes
// Inheritance/Sub-classing
// class LivingThing {
//   void breath() {
//     print('Living thing is breathing');
//   }

//   void move() {
//     print('I am moving');
//   }
// }

// // Now the Cat class wants to use the methods of the LivingThing class, so it must inherit from it
// class Cat extends LivingThing {}

// class Person {
//   // Constructor is a special logic in a class that constructs or initializes or build that class's instance
//   final String name;

//   Person(
//       this.name); // Here you will need to use a constructor to initialize this name.

//   void printName() {
//     print('I will now print the name of this person');
//     print(name);
//   }
//   // void run() {
//   //   print('Running');
//   // }

//   // void breath() {
//   //   print('Breathing');
//   // }
// }

void test() {
  // Generics
  final names = Pair('foo',
      20); // Here, dart is smart enough to understand that names is a pair of String and an int.

  // Generators
  // print(getOneTwoThree());
  // OR you can use the lazy cabapility of an iterable by a for loop
  // for (final value in getOneTwoThree()) {
  //   print(value);
  // }
  // Also, you can break from the loop at a certain condition as follows:
  // for (final value in getOneTwoThree()) {
  //   print(value);
  //   if (value == 2) {
  //     break;
  //   }
  // }

  // Streams
// void test() async {
  // final value = getName();
  // print(value); // Here you will get Instance of '_ControllerStream<String>'
  // You get the value by prefixing the function with the keyword "await for"
  // await for (final value in getName()) {
  //   print(value);
  // }
  // print('Stream finished working');

  // Future
// void test() async {
  // async is a keyword that marks a function as a synchronous which means it will executes some commands that will not return immedietly
  // final result = heavyFutureThatMultipliesByTwo(10);
  // print(
  //     result); // Here you will get Instance of 'Future<int>' and not the actual value  20
  // You get the value back by prefixing the function with the keyword "await" which will wait for the result of this function to be calculated and then move to the next line
  // final result2 = await heavyFutureThatMultipliesByTwo(10);
  // print(result2);

  // Extensions
  // final meow = Cat('Fluffers');
  // meow.run();
  // final foo = Person('Foo', 'Bar');
  // print(foo.fullName);
  // Custome Operators: allow you to override the ability of your class to be used as an operand for normal operations
  // final cat1 = Cat('Foo');
  // final cat2 = Cat('Foo');
  // if (cat1 == cat2) {
  //   print('They are equal');
  // } else {
  //   print('They are not equal');
  // }
  // Factory Constructors is a way to construct instances of your classes using convenience functions
  // final fluffBall = Cat('Fluff ball');
  // print(fluffBall.name);
  // // Instead, you can use the factory constructor as follows:
  // final flufBallCpy = Cat.fluffBall();
  // print(fluffBall.name);

  // Abstract classes
  // final thing = LivingThing(); ==> Here you will get an error because LivingThing cannot be instantiated.
  // final fluffers = Cat();

  // Classes are grouping o f various functionalities into one packagable piece of data.
  // Inheritance/Sub-classing
  // final fluffers = Cat();
  // fluffers.move();
  // fluffers.breath();

  // Instances are objects and objects are created from classes.
  // Now you will say a person variable is an instance of that Person class.
  // final foo = Person('Foo Bar');
  // print(foo.name);
  // foo.printName();

  // final person = Person();
  // person.run();
  // person.breath();

  // Enumerations are named list of related items
  // print(animalType);
  // if (animalType == AnimalType.cat) {
  //   print("Oh I love cats");
  // } else if (animalType == AnimalType.dog) {
  //   print("Dogy are so fluffy");
  // } else if (animalType == AnimalType.bunny) {
  //   print("I wish I had a bunny");
  // }
  // // It is recommended to use switch statement here
  // switch (animalType) {
  //   case AnimalType.bunny:
  //     print("Bunny");
  //     break;
  //   case AnimalType.cat:
  //     print("Cat");
  //     break;
  //   case AnimalType.dog:
  //     print("Dog");
  //     break;
  // }
  // print("FUNCTION IS FINISHED");

  // final length = names?.length ??
  //     0; // If the names (i.e. List<String>? names) list is not null, then grap its length. Else set length to 0
  // names?.add('Baz');

  // String? name = firstName;
  // name ??= middleName; // If firstName is Null then assign the middleName
  // name ??= lastName;
  // print(name);

  // const String? firstName = null;
  // const String? middleName = 'Bar';
  // const String? lastName = 'Baz';
  // // TO pick the first non-null value, we can do the following:
  // if (firstName != null) {
  //   print('first name is the first non-null value');
  // } else if (middleName != null) {
  //   print('middle name is the first non-null value');
  // } else if (lastName != null) {
  //   print("last name is the first non-null value");
  // }
  // // OR
  // const firstNonNullValue = firstName ??
  //     middleName ??
  //     lastName; // firstName, are you null? YES, then I will pick the middleName, and so on.

  // List<String>? names = ['Foo', 'Bar', null];  // Here the error is because the question mark is like a promise that the names might be absent and as soon as it is filled with some strings (i.e. Foo, and Bar), it cannot contain null
  // To fix the previous error by:
  // List<String?>? names = [
  //   'Foo',
  //   'Bar',
  //   null
  // ]; // We have a list of strings and it is called names. names can sometimes be null (i.e. it can be absent). If it is not absent, it can contain objects of type string that themselves sometimes be absent.
  // names = null;

  // String? name = null; // The question mark tells dart that name is a string and sometime it can be null
  // print(name);
  // name = 'Foo';
  // print(name);

  // Maps are used to hold key-value pairs of information
  // var person = {
  //   'age': 20,
  //   'name': 'Foo',
  // };
  // print(person);
  // person['name'] = 'FOOOOOOO';
  // print(person);

  // SETS is a list of unique things
  // var names = {'foo', 'bar', 'baz'}; // Set of strings
  // names.add('foo');
  // names.add('bar');
  // names.add('baz');
  // print(names);
  // const things = {'foo', 1}; // Set of objects

  // LISTS is a list of homogenous things
  // final names = ['Foo', 'Bar', 'Baz'];
  // final foo = names[2];
  // print(foo);
  // print(names.length);
  // names.add('My name');
  // print(names.length);

  // final name = 'Foo Bar Baz';
  // final nameTimes100 = name * 100;
  // print(nameTimes100);

  // var age = 20;
  // final halfOfAge = age / 2;
  // print(halfOfAge);
  // final ageMinusOne = --age;
  // print(age);
  // print(ageMinusOne);

  // const name = 'Foo';
  // if (name == 'Foo') {
  //   print('Yes this is foo');
  // } else if (name != 'Bar') {
  //   print('This value is not Bar');
  // } else {
  //   print("I don't know what this is");
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    test();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
