import 'package:flutter/material.dart';
import 'package:pic2thai/main.dart';
import 'package:pic2thai/pages/checkCardPic.dart';
import 'package:pic2thai/pages/createCardDetail.dart';
import 'package:sqflite/sqflite.dart';


class Createcard extends StatefulWidget {
  final Database database;
  const Createcard({super.key, required this.database});

  @override
  State<Createcard> createState() => _CreatecardState();
}

class _CreatecardState extends State<Createcard> {
  int _currentStep = 0;
  bool _isGoingForward = true;

  List<Step> stepList() => [
    Step(
      title: const Text('Verfiy Photo'),
      isActive: _currentStep >= 0,
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      content: CheckCardPic(),
    ),
    Step(
      title: const Text('Create Detail'),
      isActive: _currentStep >= 1,
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      content: CreatecardDetail(database: widget.database),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(title: const Text('Create card')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final beginOffset =
              _isGoingForward
                  ? const Offset(1, 0) // ไปข้างหน้า = slide จากขวา
                  : const Offset(-1, 0); // ย้อนกลับ = slide จากซ้าย
          return SlideTransition(
            position: Tween<Offset>(
              begin: beginOffset,
              end: Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        },
        child: Stepper(
          key: ValueKey<int>(_currentStep),
          steps: stepList(),
          type: StepperType.horizontal,
          elevation: 0,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < (stepList().length - 1)) {
              setState(() {
                _isGoingForward = true;
                _currentStep += 1;
              });
            } else {
              // ขั้นสุดท้าย: กด "Create"
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Card created!"),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 2),
                ),
              );

              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (route) => false,
                );
              });
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min, // <-- ป้องกันการขยายไม่จำกัด
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: const Color(0xFF8806D8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      _currentStep == 0 ? 'Yes' : 'Create',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  if (_currentStep > 0) const SizedBox(height: 16),
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFF8806D8),
                          fontSize: 20,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
