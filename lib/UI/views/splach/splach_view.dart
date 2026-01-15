import 'package:englify_app/UI/views/splach/splach_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplachView extends StatelessWidget {
  const SplachView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplachViewModel(),
      onModelReady: (model) => model.runsetuplogic(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Image.asset("assets/images/applogo.png"),
          ),
        );
      },
    );
  }
}
