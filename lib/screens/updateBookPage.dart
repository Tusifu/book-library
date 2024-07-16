import 'package:ebook_app/Providers/themeProvider.dart';
import 'package:ebook_app/screens/homePage.dart';
import 'package:ebook_app/services/BookService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebook_app/models/Book.dart';
import 'package:provider/provider.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  const EditBookPage({Key? key, required this.book}) : super(key: key);

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _ratingController;
  late TextEditingController _imageURLController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.book_author);
    _ratingController = TextEditingController(text: widget.book.rating);
    _imageURLController = TextEditingController(text: widget.book.book_image);
    _descriptionController =
        TextEditingController(text: widget.book.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _ratingController.dispose();
    _imageURLController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedBook = Book(
        id: widget.book.id,
        title: _titleController.text,
        book_author: _authorController.text,
        rating: _ratingController.text,
        book_image: _imageURLController.text,
        description: _descriptionController.text,
      );

      try {
        await BooksDatabase.instance.update(updatedBook);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update book'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    InputDecoration _inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: isDarkMode ? Colors.white54 : Colors.black54,
        ),
        filled: true,
        fillColor: isDarkMode
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Book',
          style: GoogleFonts.poppins(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black.withOpacity(0.95) : Colors.white,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: _inputDecoration('Title'),
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _authorController,
                        decoration: _inputDecoration('Author'),
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the author';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _ratingController,
                        decoration: _inputDecoration('Rating'),
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a rating';
                          }
                          final rating = double.tryParse(value);
                          if (rating == null || rating < 0 || rating > 5) {
                            return 'Please enter a valid rating between 0 and 5';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _imageURLController,
                        decoration: _inputDecoration('Book Image URL'),
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: _inputDecoration('Description'),
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.04),
                      Center(
                        child: SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.8,
                          child: InkWell(
                            onTap: _submitForm,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                gradient: LinearGradient(
                                  stops: const [0.4, 2],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: isDarkMode
                                      ? [
                                          Colors.orange,
                                          Colors.orange,
                                        ]
                                      : [
                                          Colors.orange,
                                          Colors.orange,
                                        ],
                                ),
                              ),
                              child: Align(
                                child: Text(
                                  'Update Book',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
