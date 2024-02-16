import 'package:flutter/material.dart';

class CustomClearBtn extends StatelessWidget {
  const CustomClearBtn({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => controller.clear(),
      );
}

// NOTE: Problem: get data when user clicks Btn, send data back to parent, then Nav.pop
// Solution 1: pass data inside Nav.pop(ctx, dataHere)
// Not possible, runs ok but slow by 1 rendered frame, probably caused by Nav.pop() is async
// Solution 2: give setState to child, when onPress -> setState -> Nav.pop()
class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
    required this.updateFormData,
    required this.closeFormHdlr,
  });

  final Function(String, int, String, String) updateFormData;
  final Function closeFormHdlr;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

// TODO: test with VNese, and observe what is the request body
// TODO: compare with Huy for reuse
class _CustomFormState extends State<CustomForm> {
  // retrieve curr value of corresponding TextField
  final ctrlOne = TextEditingController();
  final ctrlTwo = TextEditingController();
  final ctrlThree = TextEditingController();

  String? curRadioValue = 'male';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    ctrlOne.dispose();
    ctrlTwo.dispose();
    ctrlThree.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: ctrlOne,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              // suffixIcon: CustomClearBtn(),
              labelText: 'Username',
              hintText: 'hint text',
              helperText: 'supporting text',
              filled: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                      // color: Colors.cyan,
                      ),
                  child: TextField(
                    controller: ctrlTwo,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                      // color: Colors.cyan,
                      ),
                  child: TextField(
                    controller: ctrlThree,
                    decoration: const InputDecoration(
                      border: null,
                      labelText: 'Country',
                      hintText: 'hint text',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Flexible(
                child: RadioListTile(
                  title: const Text('Male'),
                  value: 'male',
                  groupValue: curRadioValue,
                  onChanged: (value) {
                    setState(() {
                      curRadioValue = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: RadioListTile(
                  title: const Text('Female'),
                  value: "female",
                  groupValue: curRadioValue,
                  onChanged: (value) {
                    setState(() {
                      curRadioValue = value;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () {
                    String foo = ctrlOne.text;
                    int bar = int.tryParse(ctrlTwo.text) ?? -1;
                    String baz = ctrlThree.text;

                    // First return data to parent
                    widget.updateFormData(foo, bar, baz,
                        curRadioValue!.toString()); // TODO: no null assertions

                    // Then disclose the widget
                    widget.closeFormHdlr();
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
