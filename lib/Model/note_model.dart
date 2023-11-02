class Note {
  String? _id;
  String? title;
  String? content;
  DateTime? _date;

  Note({
    String? id,
    this.title = '',
    this.content = '',
    DateTime? date,
  }) {
    _id = id;
    _date = date;
  }

//json to opj
  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
    );
  }
//set and get
//ID
  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

//DATE
  DateTime? get date => _date;
  set date(DateTime? value) {
    _date = value;
  }

//Title
  String? get noteTitle => title;
  set noteTitle(String? value) {
    title = value;
  }

//String
  String? get noteContent => content;
  set noteContent(String? value) {
    content = value;
  }

//opj to json
  Map<String, dynamic> get json =>
      {'id': id, 'title': title, 'content': content, 'date': date.toString()};
}
