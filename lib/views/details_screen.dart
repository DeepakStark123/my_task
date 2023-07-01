// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.datetime,
    required this.discription,
    required this.title,
  }) : super(key: key);
  final DateTime datetime;
  final String discription;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Details Screen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Create at:- ${datetime.toLocal()}".text.size(16).bold.make(),
              10.heightBox,
              "Title:- $title".text.size(16).bold.make(),
              10.heightBox,
              "Discription:-".text.size(16).bold.make(),
              Text(
                discription,
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
