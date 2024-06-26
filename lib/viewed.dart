import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'objects.dart';
import 'news_details.dart';

class ViewedTab extends StatefulWidget {
  final List<ViewedNews> viewedNews;

  ViewedTab({required this.viewedNews});

  @override
  _ViewedTabState createState() => _ViewedTabState();
}

class _ViewedTabState extends State<ViewedTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новостной клиент'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: widget.viewedNews.length,
              itemBuilder: (context, index) {
                final news = widget.viewedNews[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(220, 255, 255, 255),
                    border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    minVerticalPadding: 20,
                    title: Text(news.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    subtitle: Text(
                        DateFormat('d MMMM yyyy - HH:mm', 'ru_RU')
                            .format(DateTime.parse(news.publishedAt)),
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            newsData: news.toMap(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )),
      ),
    );
  }
}
