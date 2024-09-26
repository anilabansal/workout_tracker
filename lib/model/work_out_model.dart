
class Workout {
  int? id;
  String name;
  int value;
  String date;
  bool isDone;

  Workout({this.id, required this.name, required this.value, required this.date, required this.isDone});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'date': date,
      'isDone': isDone ? 1 : 0,
    };
  }


  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      date: map['date'],
      isDone: map['isDone'] == 1,
    );
  }
}
