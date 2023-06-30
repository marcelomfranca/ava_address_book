import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../modules/core/domain/exceptions/validate_exception.dart';
import '../../../modules/core/infra/themes/styles.dart';
import 'error_text.dart';
import 'form_title.dart';

class CustomFormTextField extends StatefulWidget {
  const CustomFormTextField({
    super.key,
    this.title = '',
    this.controller,
    this.readOnly = false,
    this.hintText = 'Digite os dados',
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.inputFormatters = const [],
    this.suffixIcon,
    this.showErrorText = true,
  });

  final String title;
  final TextEditingController? controller;
  final bool readOnly;
  final String hintText;
  final void Function(String)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final Widget? suffixIcon;
  final bool showErrorText;

  @override
  State<CustomFormTextField> createState() => CustomFormTextFieldState();
}

class CustomFormTextFieldState extends State<CustomFormTextField> {
  late final controller = widget.controller ?? TextEditingController();
  Color indicatorColor = Colors.transparent;
  String errorText = '';

  bool validate() {
    if (widget.validator != null) {
      final validated = _validator(controller.text);

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
        Visibility(visible: widget.title.isNotEmpty, child: FormTitle(text: widget.title)),
        SizedBox(
          height: 35,
          child: TextFormField(
            keyboardType: widget.keyboardType,
            // errorTextPresent: false,
            textAlign: widget.textAlign,
            maxLength: widget.maxLength,
            textCapitalization: TextCapitalization.sentences,
            controller: widget.controller,
            readOnly: widget.readOnly,
            style: StylesAVA.textFormField.copyWith(color: (errorText.isNotEmpty) ? indicatorColor : null),
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: indicatorColor,
            decoration: InputDecoration(
              hintText: widget.hintText,
              counterText: '',
              suffixIcon: widget.suffixIcon,
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
            inputFormatters: [...widget.inputFormatters],
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
        Visibility(visible: widget.showErrorText, child: ErrorText(text: errorText)),
      ],
    );
  }
}
