

class Cache {
  int? id;
  String text;
  int code; // 1 = bookmark 2 = highlight

  Cache({this.id, required this.text, required this.code});

  // used when inserting data to the database
  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'code': code};
  }

  @override
  String toString() {
    return 'Cache(id: $id, text: $text, code: $code)';
  }
}
