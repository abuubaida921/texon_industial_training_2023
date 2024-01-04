import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());

  /*
  var list = [1,2,3,4,5];
  print(list[2]);


  const a = 12;
  const pi = 3.14;

  // a=13;
  print(pi);

  print(a);
  print(pi);*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<dynamic> s_response = [];

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        setState(() {
          s_response = jsonData['data'];
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUsers();
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
      print(_counter);
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(
            child: Text('THis is a title'),
          )),
      
      // body: Center(child: Text(s_response.toString()),),

      body: ListView.builder(
        itemCount: s_response.length,
        itemBuilder: (context, index) {
          final user = s_response[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(user['avatar']),),
            title: Text('${user['first_name']} ${user['last_name']}'),
            subtitle: Text(user['email']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { fetchUsers(); },child: Icon(Icons.download),),
      // body: Center(
      //     child: GestureDetector(
      //       onTap: (){
      //         fetchUsers();
      //       },
      //       child: Column(children: [
      //         Text(
      //           'FetchData from server',
      //           style: TextStyle(fontSize: 20),
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         s_response.isEmpty
      //             ? Center(child: CircularProgressIndicator())
      //             : ListView.builder(
      //           itemCount: s_response.length,
      //           itemBuilder: (context, index) {
      //             final user = s_response[index];
      //             return ListTile(
      //               leading: CircleAvatar(
      //                 backgroundImage: NetworkImage(user['avatar']),
      //               ),
      //               title: Text('${user['first_name']} ${user['last_name']}'),
      //               subtitle: Text(user['email']),
      //             );
      //           },
      //         ),
      //       ],),
      //     )),


      // body: Column(
      //   children: [
      //     Row(
      //       children: [
      //         Container(
      //           height: 100,
      //           width: 100,
      //           child: Image.network(
      //               'https://avatars.githubusercontent.com/u/145796865?v=4'),
      //         ),
      //         Expanded(
      //           child: Text(
      //             'Nur Nobi',
      //             style: TextStyle(fontSize: 30),
      //           ).animate().fadeIn().scale().move(delay: 1000.ms,duration: 60.ms).blurXY(),
      //         ),
      //       ],
      //     ),
      //     Container(
      //       color: Colors.red,
      //       height: 300,
      //       child: ListView.builder(
      //           itemCount: 5,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               onTap:() {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondScreen()));
      //                 // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clicked on position no ${index + 1}')));
      //                 // Fluttertoast.showToast(msg: 'Clicked on position no');
      //               },
      //               title: Text('${index + 1}. Texon Limited',style: TextStyle(color: Colors.white),),
      //             );
      //           }),
      //     )
      //   ],
      // ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     //
      //     // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      //     // action in the IDE, or press "p" in the console), to see the
      //     // wireframe for each widget.
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment Hocche',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
