import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PDFScreen(),
    );
  }
}

class PDFScreen extends StatefulWidget {
  // final String? path;

  PDFScreen({
    Key? key,
  }) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  // String pdfpath = 'assets/pdf/quran.pdf';
  File pdfFile =
      File('assets/pdf/quran.pdf');
  late Completer<PDFViewController> _controller;

  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  void initState() {
    _controller = Completer<PDFViewController>();
    print(pdfFile.path);
    print(pdfFile.runtimeType);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    // fromAsset('assets/pdf/quran.pdf', 'quran.pdf').then((f) {
    //   setState(() {
    //     pdfpath = f.path;
    //   });
    // });
    super.initState();
  }

  // Future<File> fromAsset(String asset, String filename) async {
  //   // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  //   Completer<File> completer = Completer();

  //   try {
  //     // var dir = await getApplicationDocumentsDirectory();
  //     File file = File("assets/pdf/quran.pdf");
  //     var data = await rootBundle.load(asset);
  //     var bytes = data.buffer.asUint8List();
  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }

  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
     print(pdfFile.path);
    print(pdfFile.runtimeType);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Image.asset("asset/images/Medina.png"),
      //  Stack(
      //   children: <Widget>[
          
      //     PDFView(
      //       filePath: pdfFile.path,
      //       enableSwipe: true,
      //       swipeHorizontal: true,
      //       autoSpacing: false,
      //       pageFling: true,
      //       pageSnap: true,
      //       defaultPage: currentPage!,
      //       fitPolicy: FitPolicy.BOTH,
      //       preventLinkNavigation:
      //           false, // if set to true the link is handled in flutter
      //       onRender: (_pages) {
      //         setState(() {
      //           pages = _pages;
      //           isReady = true;
      //         });
      //       },
      //       onError: (error) {
      //         setState(() {
      //           errorMessage = error.toString();
      //         });
      //         print(error.toString());
      //       },
      //       onPageError: (page, error) {
      //         setState(() {
      //           errorMessage = '$page: ${error.toString()}';
      //         });
      //         print('$page: ${error.toString()}');
      //       },
      //       onViewCreated: (PDFViewController pdfViewController) {
      //         _controller.complete(pdfViewController);
      //       },
      //       onLinkHandler: (String? uri) {
      //         print('goto uri: $uri');
      //       },
      //       onPageChanged: (int? page, int? total) {
      //         print('page change: $page/$total');
      //         setState(() {
      //           currentPage = page;
      //         });
      //       },
      //     ),
      //     errorMessage.isEmpty
      //         ? !isReady
      //             ? Center(
      //                 child: CircularProgressIndicator(),
      //               )
      //             : Container()
      //         : Center(
      //             child: Text(errorMessage),
      //           )
      //   ],
      // ),
     
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
