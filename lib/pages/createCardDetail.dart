import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pic2thai/main.dart';
import 'package:pic2thai/pages/camera.dart';
import 'package:pic2thai/pages/checkCardPic.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pic2thai/models/card_model.dart';

class CreatecardDetail extends StatefulWidget {
  final String imagePath;
  final Database database;
  const CreatecardDetail({
    super.key,
    required this.database,
    required this.imagePath,
  });

  @override
  State<CreatecardDetail> createState() => CreatecardDetailState();
}

class CreatecardDetailState extends State<CreatecardDetail> {
  int _currentStep = 0;
  bool _isGoingForward = true;

  final thaiWordController = TextEditingController();
  final pronunController = TextEditingController();
  final engWordController = TextEditingController();
  final noteController = TextEditingController();

  Future<bool> insertCard() async {
    final thai = thaiWordController.text.trim();
    final pronun = pronunController.text.trim();
    final english = engWordController.text.trim();
    final note = noteController.text.trim();
    final imagePath = widget.imagePath;

    if (thai.isNotEmpty && pronun.isNotEmpty && english.isNotEmpty) {
      final card = CardModel(
        thaiWord: thai,
        pronunciation: pronun,
        engWord: english,
        note: note,
        iconPath: imagePath,
      );
      await widget.database.insert(
        'cards',
        card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),  
      );
      return false;
    }
  }

  Widget InputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Vocabulary",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: thaiWordController,
            decoration: InputDecoration(
              labelText: 'Thai Word',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: pronunController,
            decoration: InputDecoration(
              labelText: 'Pronunciation',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: engWordController,
            decoration: InputDecoration(
              labelText: 'English Word',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          const Text(
            "Vocabulary",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Note (optional)',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color.fromARGB(245, 235, 231, 243), // สีเทาอ่อน
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // ปรับให้มุมโค้ง
                borderSide: BorderSide.none, // ไม่มีเส้นขอบ
              ),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  List<Step> stepList() => [
    Step(
      title: const Text('Verfiy Photo'),
      isActive: _currentStep >= 0,
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      content: CheckCardPic(imagePath: widget.imagePath),
    ),
    Step(
      title: const Text('Create Detail'),
      isActive: _currentStep >= 1,
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      content: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Create Card Detail",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8806D8),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(widget.imagePath),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              InputSection(),
            ],
          ),
        ),
      ),
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
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: const Color(
                0xFF8806D8,
              ), // วงกลม active/completed สีม่วงเข้ม
              onPrimary: Colors.white, // สีของ icon ด้านใน
              //
            ),
          ),
          child: Stepper(
            key: ValueKey<int>(_currentStep),
            steps: stepList(),
            type: StepperType.horizontal,
            elevation: 0,
            currentStep: _currentStep,
              onStepContinue: () async {
                if (_currentStep < (stepList().length - 1)) {
                  setState(() {
                    _isGoingForward = true;
                    _currentStep += 1;
                  });
                } else {
                  final success = await insertCard();
                  if (success) {
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
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
                    if (_currentStep == 0)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraPage(database: widget.database,),
                            ),
                          );
                        },
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
                          'Retake the photo',
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
      ),
    );
  }
}
