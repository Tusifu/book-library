// ignore_for_file: file_names

import 'package:ebook_app/Providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String imageURL;
  final String title;
  final String author;
  final double rating;
  final String description;

  const DetailsPage({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.author,
    required this.rating,
    required this.description,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
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
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.02)
                                  : Colors.black.withOpacity(0.02),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.height * 0.05,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: size.height * 0.4,
                                  width: size.width * 0.8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      //ebook image
                                      widget.imageURL,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.025,
                            ),
                            child: Container(
                              height: size.height * 0.04,
                              width: size.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  //go back to home page
                                  onTap: () => Navigator.pop(
                                    context,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: size.height * 0.025,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Text(
                          //ebook title
                          widget.title,
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: size.height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Text(
                          //ebook author
                          widget.author,
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.005,
                          horizontal: size.width * 0.05,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //rating
                            Text(
                              'Rating - ${widget.rating}',
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.055),
                        child: Align(
                          child: Text(
                            //TODO: add ebook description
                            //ebook description
                            widget.description,
                            style: GoogleFonts.poppins(
                              color:
                                  isDarkMode ? Colors.white54 : Colors.black54,
                              fontSize: size.height * 0.018,
                            ),
                          ),
                        ),
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
}
