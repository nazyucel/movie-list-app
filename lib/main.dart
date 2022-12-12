import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:movie_list/model_movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(
        title: '',
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final serviceUrl = Uri.parse("https://mustafayucel.com.tr/naz/movies.php");
  int counter = 0;

  late List<Datum> movieResult;

  Future getMovies() async {
    var response = await http.get(serviceUrl);

    if (response.statusCode == 200) {
      var result = movieListFromJson(response.body);

      setState(() {
        counter = result.data.length;
        movieResult = result.data;
      });
      return result.data;
    } else {
      throw Exception("error");
    }
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("app"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: counter,
          itemBuilder: (context, index) {
            return GFCard(
              elevation: 10,
              color: Colors.white,
              border: Border(),
              boxFit: BoxFit.cover,
              titlePosition: GFPosition.start,
              image: Image.network(
                movieResult[index].thumbnail,
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
              showImage: true,
              title: GFListTile(
                title: Text(
                  "${movieResult[index].title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                // subTitleText: movieResult[index].tags,
              ),
              content: Text(movieResult[index].information),
            );
          },
        ),
      ),
    );
  }
}
