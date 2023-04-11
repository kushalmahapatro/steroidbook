import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    this.incrementBy = 1,
    this.countLabel,
    this.iconData,
    this.showToolTip = true,
    this.onItemHovered,
  }) : super(key: key);

  final String title;
  final int incrementBy;
  final String? countLabel;
  final IconData? iconData;
  final bool showToolTip;
  final ValueChanged<String>? onItemHovered;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += widget.incrementBy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: hover(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            hover(
                child: Text(
              widget.countLabel ??
                  'You have pushed the button this many times:',
            )),
            hover(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: hover(
        child: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: widget.showToolTip ? 'Increment' : null,
          child: hover(child: Icon(widget.iconData ?? Icons.add)),
        ),
      ),
    );
  }

  Widget hover({required Widget child}) {
    return MouseRegion(
      onEnter: (_) => widget.onItemHovered?.call(child.toString()),
      onExit: (_) => widget.onItemHovered?.call(''),
      child: child,
    );
  }
}
