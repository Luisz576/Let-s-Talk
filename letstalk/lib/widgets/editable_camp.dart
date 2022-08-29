import 'package:flutter/material.dart';

class EditableCamp extends StatefulWidget {
  late final TextEditingController controller;
  final String? hintText;
  final int? maxLength;
  final void Function(String) onIconSaveIsPressed;
  late final EditableCampStyle style;
  EditableCamp({required this.onIconSaveIsPressed, this.maxLength, TextEditingController? controller, this.hintText, EditableCampStyle? style, Key? key}) : super(key: key){
    this.style = style ?? EditableCampStyle();
    this.controller = controller ?? TextEditingController();
  }

  void changeValue(String? value) => controller.text = value ?? "";

  @override
  State<EditableCamp> createState() => _EditableCampState();
}

class _EditableCampState extends State<EditableCamp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            maxLength: widget.maxLength,
            controller: widget.controller,
            onChanged: (value){
              setState(() {});
            },
            buildCounter: (context, {currentLength = 0, isFocused = false, maxLength}) => null,
            decoration: InputDecoration(
              hintText: widget.hintText,
              //border: null,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: widget.controller.text.trim().length >= 5 ?
            IconButton(
              onPressed: () => widget.onIconSaveIsPressed(widget.controller.text.trim()),
              icon: Icon(Icons.save,
                color: widget.style.iconColor,
              ),
            ) :
            Icon(Icons.edit,
              color: widget.style.iconColor,
            ),
        )
      ],
    );
  }
}

class EditableCampStyle{
  final Color? iconColor;
  EditableCampStyle({this.iconColor});
}