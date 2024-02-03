import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: mainPuage(),
    );
  }
}

class mainPuage extends StatefulWidget {
  const mainPuage({super.key});

  @override
  State<mainPuage> createState() => _mainPuageState();
}

class _mainPuageState extends State<mainPuage> {
  List posts = [];
  final scrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
    scrollController.addListener(_scrollListener);
  }

  Future<void> fetchPosts() async {
    final url =
        'https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=10&page=$page';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(() {
        // posts = posts + json;
        posts.addAll(json);
      });
    } else {
      print('Unexpected response');
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
        debugPrint('first booll : $isLoadingMore');
      });
      page = page + 1;
      print('Now page : $page');
      fetchPosts();
      setState(() {
        isLoadingMore = false;
        debugPrint('secound booll : $isLoadingMore');
      });
    } else {
      print('call none');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
          controller: scrollController,
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = posts[index];
            final title = post['title']['rendered'];
            final description = post['excerpt']['rendered'];
            return Card(
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(
                        'Title : $title',
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        'Description : $description',
                        maxLines: 3,
                      ),
                    ),
                  );
          }),
    );
  }
}
