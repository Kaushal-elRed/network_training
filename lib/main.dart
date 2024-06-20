import 'package:flutter/material.dart';
import 'package:network_training/web_services/album_web_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Network',
      home: MyHomePage(title: 'Flutter Network'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final channel = AlbumWebServices.webSocket();
  final textcontroller = TextEditingController();
  List<Text> text = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextField(controller: textcontroller),
                const SizedBox(height: 20),
                Text(snapshot.hasData ? snapshot.data : "")
              ],
            );
          }
          return const Text("Stream has error");
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (textcontroller.text.isNotEmpty) {
              channel.sink.add(textcontroller.text);
            }
          },
          child: const Icon(Icons.send)),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    textcontroller.dispose();
    super.dispose();
  }
}
