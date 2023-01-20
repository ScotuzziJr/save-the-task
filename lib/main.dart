import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 25, 25, 25);

void main() => runApp(const STT());

class STT extends StatelessWidget {
  const STT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save The Task',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: primaryColor),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save The Task'),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          suffixIcon:
                              Icon(Icons.assignment, color: primaryColor),
                          hintText: 'New task...',
                          hintStyle: TextStyle(fontSize: 24)),
                      style:
                          const TextStyle(fontSize: 24, color: Colors.black87),
                      keyboardType: TextInputType.text,
                      controller: taskController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Task field it\'s required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(90, 50),
                              backgroundColor: primaryColor),
                          child: const Text('Add task'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _tasks.add(taskController.text);
                              });
                              taskController.clear();
                            }
                          }))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text(_tasks[index]),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _tasks.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ));
                    },
                    itemCount: _tasks.length)),
          ],
        ),
      ),
    );
  }
}
