class BookModel {
  String? title;
  List<String>? authorName;
  int? firstPublishYear;
  int? coverId;
  String? key;
  List<String>? subjects;

  BookModel({
    this.title,
    this.authorName,
    this.firstPublishYear,
    this.coverId,
    this.key,
    this.subjects,
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
    };
  }
}
