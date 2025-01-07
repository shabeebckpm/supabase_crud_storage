// ignore_for_file: public_member_api_docs, sort_constructors_first


class Note {
  int? id;
  String content;
  Note({
    this.id,
    required this.content,  
  });

factory Note.fromMap(Map<String, dynamic> map){
  return Note(
    id: map['id'] as int,
    content: map['content'] as String,
  );
}

Map<String, dynamic> toMap(){
  return {
    
    'content': content,
  };
}
}