class Exam {
  String? id;
  String? examText;
  String? date;

  Exam({required this.id, required this.examText, required this.date});

  static List<Exam> examList() {
    return [
      Exam(
          id: '01',
          examText: 'MIS',
          date: "2024-02-05 16:00:00Z"),
    ];
  }
}


