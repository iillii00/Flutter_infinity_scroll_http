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
  bool isLoading = false;

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
        posts.addAll(json);
      });
    } else {
      print('Unexpected response');
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if(!isLoading){
        isLoading = true;
        print('p1 : $isLoading');
      }
      page = page + 1;
      print('Now page : $page');
      fetchPosts().then((_){
        setState(() {
          isLoading = false;
          print('p2 : $isLoading');
        });
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
          itemCount: posts.length + (isLoading ? 0 : 1),
          itemBuilder: (BuildContext context, int index) {
            if (index < posts.length) {
              print('index : $index');
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
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}