import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:devfest_lushi_2023/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveTest extends StatefulWidget {
  const RiveTest({Key? key}) : super(key: key);

  @override
  State<RiveTest> createState() => _RiveTestState();
}

class _RiveTestState extends State<RiveTest> {

  TextEditingController messageController = TextEditingController();

  Artboard? _riveArtBoard;
  StateMachineController? _stateMachineController;
  SMIInput<bool>? _talkInput;
  bool _isLoading = true, _speaking = false;
  String textSpeak = '';

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    final bytes = await rootBundle.load('assets/talking.riv');
    final file = RiveFile.import(bytes);
    final artBoard = file.mainArtboard;
    _stateMachineController = StateMachineController.fromArtboard(artBoard, 'main');
    if (_stateMachineController != null) {
      artBoard.addController(_stateMachineController!);
      _talkInput = _stateMachineController!.findInput('talk');
    }
    setState(() {
      _riveArtBoard = artBoard;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Test')),
      body: (_isLoading)?
        const Center(child: CircularProgressIndicator(),):
        Padding(
          padding: const EdgeInsets.all(pagePadding),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Entrez votre message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        fillColor: Theme.of(context).colorScheme.inversePrimary,
                        filled: true,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      speak();
                    },
                    icon: Icon(
                      (_speaking)?
                      Icons.mic:
                      Icons.send,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Rive(
                          artboard: _riveArtBoard!,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: textSpeak.isNotEmpty,
                      child: Positioned(
                        top: MediaQuery.of(context).size.height * 0.12,
                        left: 150,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: BubbleSpecialOne(
                            text: textSpeak,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            tail: true,
                            isSender: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }

  speak() async {

    if (_speaking) return;

    textSpeak = '';
    _talkInput?.value = true;
    setState(() {
      _speaking = true;
    });

    String text = messageController.text;
    messageController.clear();
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        textSpeak += text[i];
      });
    }

    setState(() {
      _speaking = false;
    });
    _talkInput?.value = false;
  }

}