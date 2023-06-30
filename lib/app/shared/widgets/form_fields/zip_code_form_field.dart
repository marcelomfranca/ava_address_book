import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../modules/core/domain/exceptions/validate_exception.dart';
import '../../../modules/core/infra/themes/styles.dart';
import 'error_text.dart';
import 'form_title.dart';

class ZipCodeFormField extends StatefulWidget {
  const ZipCodeFormField({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    this.onChanged,
    this.onFocusChangeValidate,
  });

  final String title;
  final TextEditingController controller;
  final void Function(String)? validator;
  final Function(String)? onChanged;
  final Future<void> Function(String)? onFocusChangeValidate;

  @override
  State<ZipCodeFormField> createState() => ZipCodeFormFieldState();
}

class ZipCodeFormFieldState extends State<ZipCodeFormField> {
  String errorText = '';
  Color indicatorColor = Colors.transparent;

  bool validate() {
    if (widget.validator != null) {
      final validated = _validator(widget.controller.text);

      validateAction(validated);
    }

    return errorText.isEmpty;
  }

  void validateAction(validated) {
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

  String? _validator(value) {
    try {
      widget.validator?.call(value ?? '');
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
          child: Focus(
            onFocusChange: (value) async {
              if (value == false) {
                debugPrint('cepFormField: loseFocus');

                final cep = widget.controller.text;

                FocusScope.of(context).requestFocus(FocusNode());

                if (cep.isNotEmpty) {
                  if (validate()) {
                    if (widget.onFocusChangeValidate != null) {
                      widget.onFocusChangeValidate!(widget.controller.text).then((_) => validateAction(null));
                    }
                  }
                }
              }
            },
            child: TextFormField(
              textCapitalization: TextCapitalization.none,
              controller: widget.controller,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              scrollPadding: EdgeInsets.zero,
              style: StylesAVA.textFormField.copyWith(color: (errorText.isNotEmpty) ? indicatorColor : null),
              autovalidateMode: AutovalidateMode.disabled,
              cursorColor: indicatorColor,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              decoration: InputDecoration(
                hintText: 'Digite o CEP',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: (errorText.isNotEmpty) ? BorderSide(color: indicatorColor) : BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: (errorText.isNotEmpty) ? BorderSide(color: indicatorColor) : BorderSide.none),
                disabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: indicatorColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: indicatorColor)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: indicatorColor)),
              ),
              onChanged: (value) {
                widget.controller.value =
                    TextEditingValue(text: value.toLowerCase(), selection: widget.controller.selection);

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
        ),
        ErrorText(text: errorText),
      ],
    );
  }
}
