import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';

class IntrayTodo extends StatelessWidget {
  final String title;
  final String keyValue;
  IntrayTodo({this.keyValue, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          color: addButtonColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
                color: Colors.black.withOpacity(0.5), blurRadius: 10.0)
          ]),
      child: Row(
        children: [
          Radio(

          ),
          Column(
            children: [
              Text(
                title,
                style: darkTodoTitle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
