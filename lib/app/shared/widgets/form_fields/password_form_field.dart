import 'package:flutter/material.dart';

import '../../../modules/core/domain/exceptions/validate_exception.dart';
import '../../../modules/core/infra/themes/styles.dart';
import 'error_text.dart';
import 'form_title.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.title,
    this.controller,
    this.confirmController,
    this.hintText = 'Digite sua senha',
    this.validator,
    this.onChanged,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final TextEditingController? confirmController;
  final void Function(String, String?)? validator;
  final Function(String)? onChanged;

  @override
  State<PasswordFormField> createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  late final controller = widget.controller ?? TextEditingController();
  bool obscureText = true;
  Color indicatorColor = Colors.transparent;
  String errorText = '';

  @override
  void initState() {
    super.initState();

    widget.confirmController?.addListener(() {
      validate();
    });
  }

  bool validate() {
    if (widget.validator != null) {
      final confirm = widget.confirmController?.text;

      final validated = _validator(controller.text, confirm);

      if (mounted) {
        if (validated == null) {
          setState(() {
            errorText = '';
            indicatorColor = const Color(0xFF21CBA6);
          });
        } else {
          setState(() {
            errorText = validated;
            indicatorColor = Colors.red;
          });
        }
      }
    }

    return errorText.isEmpty;
  }

  String? _validator(String value, [String? confirm]) {
    try {
      widget.validator?.call(value, confirm);
      return null;
    } on ValidateException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(text: widget.title),
        SizedBox(
          height: 35,
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            controller: widget.controller,
            obscureText: obscureText,
            scrollPadding: EdgeInsets.zero,
            style: StylesAVA.textFormField.copyWith(color: (errorText.isNotEmpty) ? indicatorColor : null),
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: indicatorColor,
            obscuringCharacter: '●',
            decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    child: obscureText
                        ? Icon(Icons.lock_outline, size: 15, color: (errorText.isNotEmpty) ? indicatorColor : null)
                        : Icon(Icons.lock_open_outlined,
                            size: 14, color: (errorText.isNotEmpty) ? indicatorColor : null),
                    onTap: () => setState(() => obscureText = !obscureText),
                  ),
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: indicatorColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: indicatorColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: indicatorColor)),
            ),
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }

              validate();
            },
            validator: (value) {
              final validated = validate();

              return validated ? null : '';
            },
          ),
        ),
        ErrorText(text: errorText),
      ],
    );
  }
}
