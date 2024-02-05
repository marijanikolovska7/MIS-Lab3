import 'package:flutter/material.dart';
import 'exam.dart';
import 'colors.dart';
import 'examItem.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final examsList = Exam.examList();
  List<Exam> _foundExam = [];
  final _examController = TextEditingController();
  final _dateController = TextEditingController();
  bool isLoggedIn = false;
  bool toggleForm = true;

  final _inputKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  String? name = "";
  String? username = "";

  late TextEditingController txt;
  late TextEditingController user;


  @override
  void initState() {
    super.initState();
    txt = TextEditingController()
      ..addListener(() {
        // print(txt.text);
      });

    user = TextEditingController()
      ..addListener(() {
        // print(txt.text);
      });
    toggleForm = true;
  }

  Future<List<Exam>> _get(String username) async {
    List<Exam> examsList = [];
    return examsList;
  }


    @override
    Widget build(BuildContext context) {
      if (!isLoggedIn) {
        return Scaffold(
          backgroundColor: BGColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Welcome to EXAM BOOKING!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Form(
                  key: _inputKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: user,
                          decoration: InputDecoration(
                            hintText: 'Enter your index...',
                          ),
                          validator: (inputString) {
                            username = inputString;
                            if (inputString!.length < 1) {
                              return 'Please write your index!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_inputKey.currentState!.validate()) {
                              username = user.text;
                              user.text = "";
                              _get(username!)
                                  .then((List<Exam> examsList) =>
                              {
                                setState(() {
                                  _foundExam = examsList;
                                  isLoggedIn = true;
                                })
                              });
                              _messangerKey.currentState?.showSnackBar(
                                  SnackBar(
                                      content:
                                      Text('Successful!')));
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: BGColor,
          appBar: _buildAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      'EXAM BOOKING',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Note: You need to put in the correct date format: "YYYY-MM-DD HH:MM:SS"',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Text(
                        'Exams',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    for (Exam exam in _foundExam.reversed) ExamItem(exam: exam),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _examController,
                  decoration: InputDecoration(
                    hintText: 'Name of the exam...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    hintText: 'Date and time of the exam...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    'Add exam',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (_examController.text.isNotEmpty &&
                        _dateController.text.isNotEmpty) {
                      _addExamItem(
                        _examController.text,
                        _dateController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Blue,
                    minimumSize: Size(double.infinity, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

      void _addExamItem(String exam, String date) {
        setState(() {
          examsList.add(Exam(
              id: DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              examText: exam,
              date: date));
          _foundExam = examsList;
        });

        _examController.clear();
        _dateController.clear();
      }

      AppBar _buildAppBar() {
        return AppBar(
          backgroundColor: BGColor,
          elevation: 0,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 40,
              width: 40,
            ),
          ]),
        );
      }
    }


