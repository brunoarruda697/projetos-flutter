import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/ui/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: "Lojinha do Saitama",
              theme: ThemeData(
                primarySwatch: Colors.yellow,
                primaryColor: Color.fromARGB(255, 255, 255, 0),
                inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.red,
                  )),
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
