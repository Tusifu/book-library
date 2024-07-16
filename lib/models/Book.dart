// MODEL FOR FAVORITES, IT WILL BE USED TO STORE DATA IN LOCAL STORAGE WHICH IS
// SQLFLITE.

// ignore_for_file: non_constant_identifier_names, constant_identifier_names, prefer_const_declarations

final String tableBooks = 'books';

class BookFields {
  static final List<String> values = [
    /// Add all fields
    id, title, book_author, rating, description,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String book_author = 'book_author';
  static const String rating = 'rating';
  static const String book_image = 'book_image';
  static const String description = 'description';
}

class Book {
  int? id;
  String? title;
  String? book_author;
  String? book_image;
  String? rating;
  String? description;

  Book({
    this.id,
    this.title,
    this.book_author,
    this.book_image,
    this.rating,
    this.description,
  });

  Book copy({
    required int id,
    required String title,
    required String book_author,
    required String book_image,
    required String rating,
    required String description,
  }) =>
      Book(
        id: id,
        title: title,
        book_author: book_author,
        rating: rating,
        book_image: book_image,
        description: description,
      );

  static Book fromJson(Map<String, Object?> json) => Book(
        id: json[BookFields.id] as int,
        title: json[BookFields.title] as String,
        book_author: json[BookFields.book_author] as String,
        rating: json[BookFields.rating] as String,
        book_image: json[BookFields.book_image] as String,
        description: json[BookFields.description] as String,
      );

  Map<String, Object?> toJson() => {
        BookFields.id: id,
        BookFields.title: title,
        BookFields.book_author: book_author,
        BookFields.rating: rating,
        BookFields.book_image: book_image,
        BookFields.description: description,
      };
}
