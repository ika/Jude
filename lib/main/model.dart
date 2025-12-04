// Main Database Model

class Main {
  int id;
  String t;

  Main({required this.id, required this.t});

  factory Main.fromJson(Map<String, dynamic> json) =>
      Main(id: json['id'], t: json['t']);

  @override
  String toString() {
    return 'Main(id: $id, t: $t)';
  }
}
