import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:yourlist1/db/db.dart';
import 'package:yourlist1/model/todo.dart';
import 'package:yourlist1/util/color.dart';
import 'package:yourlist1/widget/card_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Todo> _todoList = [];
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void playSound() {
    _audioPlayer.play(AssetSource("sounds/sound1.mp3")); // phát âm thanh
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _loadTodo();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _loadTodo() async {
    final todos = await TodoDatabaseHelper.instance.getAllTodos();
    setState(() {
      _todoList = todos;
    });
  }

  Future<void> _removeTodo(int index) async {
    final removedTodo = _todoList[index];

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: CardTodo(
          index: index,
          time: removedTodo.time.toString(),
          titleCard: removedTodo.content,
          onTapRemove: () {},
          onTapDone: () {},
        ),
      ),
      duration: const Duration(milliseconds: 500),
    );

    _todoList.removeAt(index);
    await TodoDatabaseHelper.instance.deleteTodo(removedTodo.id!);
  }

  Future<void> showAddTodoDialog(BuildContext context) async {
    final TextEditingController contentController = TextEditingController();
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: GetColor().backgrouColor,
              title: const Text('Thêm công việc'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      labelText: 'Nội dung công việc',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            selectedTime == null
                                ? 'Chọn thời gian'
                                : selectedTime!.format(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GetColor().buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () async {
                    if (contentController.text.isNotEmpty &&
                        selectedTime != null) {
                      String content = contentController.text;
                      TimeOfDay time = selectedTime!;
                      await TodoDatabaseHelper.instance.insertTodo(
                        Todo(content: content, time: timeToString(time)),
                      );
                      _loadTodo();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vui lòng nhập đầy đủ thông tin'),
                        ),
                      );
                    }
                  },
                  child: const Text('Lưu'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showEditTodoDialog(BuildContext context, Todo todo) async {
    final TextEditingController contentController = TextEditingController();
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: GetColor().backgrouColor,
              title: const Text('Chỉnh sửa công việc'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      labelText: 'Nội dung công việc',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            selectedTime == null
                                ? 'Chọn thời gian'
                                : selectedTime!.format(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GetColor().buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () async {
                    if (contentController.text.isNotEmpty &&
                        selectedTime != null) {
                      todo = Todo(
                        id: todo.id,
                        content: contentController.text,
                        time: timeToString(selectedTime!),
                      );
                      await TodoDatabaseHelper.instance.updateTodo(todo);
                      _loadTodo();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vui lòng nhập đầy đủ thông tin'),
                        ),
                      );
                    }
                  },
                  child: const Text('Lưu'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String timeToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFFBE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        title: const Text(
          'ToDoList',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _loadTodo();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundColor: Color(0xFFB9FBC0),
                child: Icon(Icons.refresh_rounded, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child:
                    _todoList.isEmpty
                        ? const Center(child: Text("No tasks yet"))
                        : AnimatedList(
                          key: _listKey,
                          initialItemCount: _todoList.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index, animation) {
                            final todo = _todoList[index];
                            return SizeTransition(
                              sizeFactor: animation,
                              child: GestureDetector(
                                onTap: () {
                                  showEditTodoDialog(context, todo);
                                },
                                child: CardTodo(
                                  index: index,
                                  time: todo.time.toString(),
                                  titleCard: todo.content,
                                  onTapRemove: () async {
                                    await _removeTodo(index);
                                    await _loadTodo();
                                  },
                                  onTapDone: () async {
                                    playSound();
                                    _confettiController.play();
                                    await Future.delayed(
                                      const Duration(milliseconds: 800),
                                    );
                                    await _removeTodo(index);
                                    await _loadTodo();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTodoDialog(context),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
