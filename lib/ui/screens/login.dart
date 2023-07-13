import 'package:bikersflutterapp/bloc/login/login_event.dart';
import 'package:bikersflutterapp/bloc/login/login_state.dart';
import 'package:bikersflutterapp/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToHome(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(title: "Bikers APP")));
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _navigateToHome();
          } else if (state is LoginFailure) {
            // Show an error message or perform other actions upon login failure
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                  Container(
                    margin: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const Text(
                          'This is the loggin screen',
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Mail",
                            hintText: "Email",
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                          controller: _usernameController,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "Pass",
                              prefixIcon: Icon(Icons.remove_red_eye),
                              contentPadding: EdgeInsets.only(bottom: 12.0)
                          ),
                          obscureText: true,//is a kind of InputText.password
                          controller: _passwordController,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal:80.0, vertical: 20.0)
                          ),
                          onPressed:() => loginBloc.add(
                              LoginButtonPressed(
                                  username: _usernameController.text,
                                  password: _passwordController.text)
                          ),
                          child: const Text("Sign In"))
                    ],
                  ),
                  if (state is LoginLoading) // Show progress indicator when LoginLoading state is emitted
                    SizedBox(height: 16.0),
                    CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
