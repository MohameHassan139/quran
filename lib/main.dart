import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
  PdfViewerController pdfViewerController = PdfViewerController();
  double zoom = 0.0;
  TextEditingController controller = TextEditingController();
  int pageNo = 0;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController = PdfViewerController();
  late PdfTextSearchResult _searchResult = PdfTextSearchResult();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
          actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              // color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                
              });
              _searchResult = _pdfViewerController.searchText('ا',
                  // searchOption: TextSearchOption.caseSensitive
                  
                  );
              if (kIsWeb) {
                setState(() {});
              } else {
                _searchResult.addListener(() {
                  if (_searchResult.hasResult) {
                    setState(() {});
                  }
                });
              }
            },
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                // color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _searchResult.clear();
                });
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult.nextInstance();
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SfPdfViewer.asset(
          'assets/pdf/quran.pdf',
          controller: pdfViewerController,
          enableDocumentLinkAnnotation: false,
          canShowPageLoadingIndicator: true,
          canShowScrollHead: false,
          pageLayoutMode: PdfPageLayoutMode.single,
          pageSpacing: 0,
          enableDoubleTapZooming: false,

        //  controller: _pdfViewerController,
          currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
          otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
          scrollDirection: PdfScrollDirection.horizontal,
        ),
      ),
    );
  }
}
