class Note {
  final int? id;
  final String description;

  Note({this.id, required this.description});

  Note copy({
    int? id,
    String? description,
  }) =>
      Note(
        id: id ?? this.id,
        description: description ?? this.description,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json['id'] as int?,
        description: json['description'] as String,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'description': description,
      };
}
