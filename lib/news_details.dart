import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final Map<String, dynamic> newsData;

  NewsDetail({required this.newsData});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(widget.newsData['publishedAt']);
    String formattedDate =
        DateFormat('d MMMM yyyy - HH:mm', 'ru_RU').format(parsedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Новость'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.newsData['title'] ?? 'Нет заголовка',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Описание: ${widget.newsData['description'] ?? 'Нет описания'}',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Дата публикации: $formattedDate',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      launchURL(widget.newsData['url']);
                    },
                    child: Text(
                      'Читать полностью',
                      style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    ),
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
