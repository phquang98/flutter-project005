import 'package:flutter/material.dart';

class CustomClearBtn extends StatelessWidget {
  const CustomClearBtn({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => controller.clear(),
      );
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

// TODO: test with VNese, and observe what is the request body
// TODO: compare with Huy for reuse
class _CustomFormState extends State<CustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final noobCtrl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    noobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              // suffixIcon: CustomClearBtn(),
              labelText: 'Filled',
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
                    color: Colors.cyan,
                  ),
                  child: const TextField(),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                  ),
                  child: TextField(
                    controller: noobCtrl,
                    decoration: const InputDecoration(
                      border: null,
                      hintText: 'cacacaca',
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
                  onPressed: () {},
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
