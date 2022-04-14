import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BookStepsService with ChangeNotifier {
  int currentStep = 1;
  int totalStep = 5;

  increaseCurrentStep() {
    currentStep = currentStep + 1;
    notifyListeners();
  }

  // setCurrentStepOne() {
  //   currentStep = 1;
  //   Future.delayed(
  //       const Duration(
  //         milliseconds: 400,
  //       ), () {
  //     notifyListeners();
  //   });
  // }

  decreaseCurrentStep() {
    currentStep = currentStep - 1;
    notifyListeners();
  }

  List<StepsAndNext> stepsNameList = [
    StepsAndNext("Choose Location", 'Service Personalization'),
    StepsAndNext("Service Personalization", 'Available Schedules'),
    StepsAndNext("Available Schedules", 'Booking Informations'),
    StepsAndNext("Informations", 'Booking Confirmations'),
    StepsAndNext("Booking Confirmations", ''),
  ];

  decreaseStep(BuildContext context) {
    //increase page steps by one
    Provider.of<BookStepsService>(context, listen: false).decreaseCurrentStep();
  }

  onNext(BuildContext context) {
    //increase page steps by one
    Provider.of<BookStepsService>(context, listen: false).increaseCurrentStep();
  }
}

class StepsAndNext {
  String title;
  String subtitle;
  StepsAndNext(this.title, this.subtitle);
}
