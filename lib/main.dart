import 'package:bloc_patterndemo2/Bloc/ImageBloc.dart';
import 'package:bloc_patterndemo2/ImageApi.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final imageBloc = ImageBloc(ImageAPI());

  Widget buildImage(dynamic snapshot) {
    return Column(
      children: <Widget>[
        Padding(
          child: Image.network(
            snapshot.urls.small,
            fit: BoxFit.fitWidth,
          ),
          padding: EdgeInsets.all(
            8.0,
          ),
        ),
        Text(snapshot.description == null ? 'Null' : snapshot.description),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: imageBloc.query.add,
            ),
            Expanded(
              child: StreamBuilder(
                stream: imageBloc.images,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return buildImage(snapshot.data[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
