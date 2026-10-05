class BookDetailsModel {
  final String? title;
  final String? description;
  final int? numberOfPages;
  final List<String>? subjects;

  const BookDetailsModel({
    this.title,
    this.description,
    this.numberOfPages,
    this.subjects,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      title: json['title'] as String?,
      description: json['description'] is String
          ? json['description']
          : json['description']?['value'] as String?,
      numberOfPages: json['number_of_pages'] as int?,
      subjects: (json['subjects'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}
