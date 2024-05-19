import 'package:flutter/material.dart';

class ToDoTaskListPage extends StatefulWidget {
  const ToDoTaskListPage({super.key});

  @override
  ToDoTaskListPageState createState() => ToDoTaskListPageState();
}

class ToDoTaskListPageState extends State<ToDoTaskListPage> {
  final Color _tileColor = Colors.blue[50]!;
  final Color _hoverColor = Colors.blue[100]!;
  final Color _clickColor = Colors.blue[200]!;
  bool _isHovering = false;
  bool _isClicked = false;

  void _onEnter(PointerEvent details) {
    setState(() {
      _isHovering = true;
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      _isHovering = false;
      _isClicked = false;
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isClicked = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        backgroundColor: Colors.orange[200],
      ),
      body: MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          child: ListTile(
            title: const Text('Task 1'),
            tileColor: _isClicked
                ? _clickColor
                : (_isHovering ? _hoverColor : _tileColor),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
