class BookModel {
  final String? title;
  final List<String>? authorName;
  final int? firstPublishYear;
  final int? coverId;
  final String? key;
  final List<String>? subjects;
  final bool isFavorite;

  BookModel({
    this.title,
    this.authorName,
    this.firstPublishYear,
    this.coverId,
    this.key,
    this.subjects,
    this.isFavorite = false,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] as String?,
      authorName: json['author_name'] != null
          ? List<String>.from(json['author_name'])
          : null,
      firstPublishYear: json['first_publish_year'] as int?,
      coverId: json['cover_i'] as int?,
      key: json['key'] as String?,
      subjects: json['subject'] != null
          ? List<String>.from(json['subject'])
          : null,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author_name': authorName,
      'first_publish_year': firstPublishYear,
      'cover_i': coverId,
      'key': key,
      'subject': subjects,
      'isFavorite': isFavorite,
    };
  }

  BookModel copyWith({
    String? title,
    List<String>? authorName,
    int? firstPublishYear,
    int? coverId,
    String? key,
    List<String>? subjects,
    bool? isFavorite,
  }) {
    return BookModel(
      title: title ?? this.title,
      authorName: authorName ?? this.authorName,
      firstPublishYear: firstPublishYear ?? this.firstPublishYear,
      coverId: coverId ?? this.coverId,
      key: key ?? this.key,
      subjects: subjects ?? this.subjects,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
