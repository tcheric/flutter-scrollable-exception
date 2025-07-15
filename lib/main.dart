import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

// Home page with PageView
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: [
          ScrollingPage(),
          Center(child: Text('Page 2'),),
          Center(child: Text('Page 3')),
        ],
      ),
    );
  }
}

// First page of the PageView, which implements vertical scrolling
class ScrollingPage extends StatefulWidget {
  const ScrollingPage({super.key});

  @override
  State<ScrollingPage> createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> {
  late final ScrollController _scrollController;
  double targetScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.position.isScrollingNotifier.addListener(() {
        if(_scrollController.position.isScrollingNotifier.value == false) {
          double blockHeight = MediaQuery.sizeOf(context).height * 0.8;

          // Calculates where to scroll to
          setState(() {
            if (_scrollController.offset < blockHeight) {
              targetScrollOffset = 0;
            } else if (_scrollController.offset < blockHeight * 2) {
              targetScrollOffset = blockHeight;
            } else if (_scrollController.offset < blockHeight * 3) {
              targetScrollOffset = blockHeight * 2;
            } else if (_scrollController.offset < blockHeight * 4) {
              targetScrollOffset = blockHeight * 3;
            }
          });

          // both jumpTo() and animateTo() cause the same exception
          _scrollController.animateTo(
            targetScrollOffset,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
          );

          // _scrollController.jumpTo(targetScrollOffset);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double blockHeight = MediaQuery.sizeOf(context).height * 0.8;
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Container(color: Colors.red.shade100, height: blockHeight),
          Container(color: Colors.red.shade200, height: blockHeight),
          Container(color: Colors.red.shade400, height: blockHeight),
          Container(color: Colors.red.shade600, height: blockHeight),
          Container(color: Colors.red.shade800, height: blockHeight),
        ],
      ),
    );
  }
}
