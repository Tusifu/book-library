import 'package:ebook_app/models/Book.dart';
import 'package:ebook_app/screens/addBookPage.dart';
import 'package:ebook_app/screens/detailsPage.dart';
import 'package:ebook_app/services/BookService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Leila";

  List<Book> _books = [];
  List<Book> _filteredBooks = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBooks();
    _searchController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBooks);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBooks() async {
    final books = await BooksDatabase.instance.readAllBooks();
    setState(() {
      _books = books;
      _filteredBooks = books;
    });
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBooks = _books.where((book) {
        return book.title!.toLowerCase().contains(query) ||
            book.book_author!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(),
            ),
          ).then((value) {
            _loadBooks(); // Reload books when returning from the add book page
          });
        },
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black.withOpacity(0.95) : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hello, $name!',
                              style: GoogleFonts.questrial(
                                color: Colors.orange,
                                fontSize: size.height * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.05,
                                  ),
                                  child: FaIcon(
                                    //notifications
                                    FontAwesomeIcons.bell,
                                    size: size.height * 0.03,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.015,
                        ),
                        child: Center(
                          child: Container(
                            width: size.width * 0.95,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              //searchbar
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.indigo,
                                    size: size.height * 0.03,
                                  ),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      hintStyle: GoogleFonts.questrial(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: size.height * 0.02,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Search Ebook',
                                    ),
                                    style: GoogleFonts.questrial(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.01,
                        ),
                        child: Text(
                          'Books List',
                          style: GoogleFonts.questrial(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Display books from the database
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          final book = _filteredBooks[index];
                          return buildVerticalEbook(
                            book.description!,
                            book.book_image!,
                            book.title!,
                            book.book_author!,
                            double.parse(book.rating!),
                            size,
                            isDarkMode,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVerticalEbook(String description, String imageURL, String title,
      String author, double rating, size, isDarkMode) {
    return InkWell(
      onTap: () {
        //navigate to details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              imageURL: imageURL,
              title: title,
              author: author,
              rating: rating,
              description: description,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.005,
        ),
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: size.height * 0.015,
                ),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          title,
                          softWrap: true,
                          style: GoogleFonts.questrial(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        author,
                        style: GoogleFonts.questrial(
                          color: isDarkMode ? Colors.white38 : Colors.black38,
                          fontSize: size.height * 0.02,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.005),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating - $rating',
                              softWrap: true,
                              style: GoogleFonts.questrial(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.yellow,
                                size: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
