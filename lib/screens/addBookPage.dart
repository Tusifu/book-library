import 'package:ebook_app/Providers/themeProvider.dart';
import 'package:ebook_app/services/BookService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebook_app/models/Book.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newBook = Book(
        title: _titleController.text,
        book_author: _authorController.text,
        rating: _ratingController.text,
        book_image: _imageURLController.text,
        description: _descriptionController.text,
      );

      try {
        await BooksDatabase.instance.create(newBook);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        print("ERROR OCCURED ON ADDING BOOK" + e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add book'),
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
          'Add Book',
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
                                  'Add Book',
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
