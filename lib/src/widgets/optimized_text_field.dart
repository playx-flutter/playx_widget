// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/common_utils.dart';

enum TextFieldType {
  material,
  cupertino,
  adaptive,
}

/// OptimizedTextField is a customized text field with features like auto validation with the ability to be customized.
class OptimizedTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final TextInputType? type;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final IconData? eIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? icon;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final bool read;
  final Function? edit;
  final int maxLines;
  final int minLines;
  final bool enabled;
  final bool obscureText;
  final Color? fillColor;
  final bool autofocus;
  final GlobalKey<FormState>? formKey;
  final bool shouldAutoValidate;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final int? errorMaxLines;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;

  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsets? scrollPadding;

  final void Function(bool isValid)? onValidationChanged;
  final TextInputAction textInputAction;
  final Iterable<String>? autoFillHints;
  final TextFieldType _textFieldType;
  final BoxDecoration? boxDecoration;

  const OptimizedTextField({
    super.key,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.onTap,
    this.icon,
    this.type,
    this.validator,
    this.controller,
    this.focus,
    this.nextFocus,
    this.prefix,
    this.suffix,
    this.label,
    this.read = false,
    this.obscureText = false,
    this.enabled = true,
    this.eIcon,
    this.edit,
    this.fillColor,
    this.autofocus = false,
    this.shouldAutoValidate = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.margin,
    this.errorMaxLines = 2,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.formKey,
    this.onValidationChanged,
    this.textInputAction = TextInputAction.done,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    this.scrollPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.enabledBorder,
    this.style,
    this.labelStyle,
    this.autoFillHints,
    this.hintStyle,
    this.onSubmitted,
  })  : _textFieldType = TextFieldType.material,
        boxDecoration = null;

  const OptimizedTextField.adaptive({
    super.key,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.onTap,
    this.icon,
    this.type,
    this.validator,
    this.controller,
    this.focus,
    this.nextFocus,
    this.prefix,
    this.suffix,
    this.label,
    this.read = false,
    this.obscureText = false,
    this.enabled = true,
    this.eIcon,
    this.edit,
    this.fillColor,
    this.autofocus = false,
    this.shouldAutoValidate = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.margin,
    this.errorMaxLines = 2,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.formKey,
    this.onValidationChanged,
    this.textInputAction = TextInputAction.done,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    this.scrollPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.enabledBorder,
    this.style,
    this.labelStyle,
    this.autoFillHints,
    this.boxDecoration,
    this.hintStyle,
    this.onSubmitted,
  }) : _textFieldType = TextFieldType.adaptive;

  const OptimizedTextField.cupertino({
    super.key,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.onTap,
    this.icon,
    this.type,
    this.validator,
    this.controller,
    this.focus,
    this.nextFocus,
    this.prefix,
    this.suffix,
    this.label,
    this.read = false,
    this.obscureText = false,
    this.enabled = true,
    this.eIcon,
    this.edit,
    this.fillColor,
    this.autofocus = false,
    this.shouldAutoValidate = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.margin,
    this.errorMaxLines = 2,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.formKey,
    this.onValidationChanged,
    this.textInputAction = TextInputAction.done,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    this.scrollPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.enabledBorder,
    this.style,
    this.labelStyle,
    this.autoFillHints,
    this.boxDecoration,
    this.hintStyle,
    this.onSubmitted,
  }) : _textFieldType = TextFieldType.cupertino;

  @override
  State<StatefulWidget> createState() {
    return _CustomFieldState();
  }
}

class _CustomFieldState extends State<OptimizedTextField> {
  GlobalKey<FormState>? formKey;
  bool? _isFieldValid;

  @override
  void initState() {
    formKey = widget.formKey ??
        (widget.shouldAutoValidate ? GlobalKey<FormState>() : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (widget._textFieldType) {
      case TextFieldType.material:
        child = _buildMaterialTextField();
        break;
      case TextFieldType.cupertino:
        child = _buildCupertinoTextField();
        break;
      case TextFieldType.adaptive:
        child = isCupertino
            ? _buildCupertinoTextField()
            : _buildMaterialTextField();
        break;
    }

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: child,
    );
  }

  Widget _buildMaterialTextField() {
    return Material(
      type: MaterialType.transparency,
      child: Form(
        key: formKey,
        child: TextFormField(
          enabled: widget.enabled,
          onTap: widget.onTap,
          validator: widget.validator,
          controller: widget.controller,
          focusNode: widget.focus,
          readOnly: widget.read,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          obscureText: widget.obscureText,
          keyboardType: widget.type,
          autofillHints: widget.autoFillHints,
          scrollPadding:
              widget.scrollPadding ?? EdgeInsets.symmetric(vertical: 20.h),
          onChanged: (String input) {
            // ignore: prefer_null_aware_method_calls
            widget.onChanged?.call(input);
            if (widget.shouldAutoValidate) {
              if (formKey != null) {
                final formState = formKey!.currentState;
                final isValid = formState != null && formState.validate();
                if (widget.onValidationChanged != null) {
                  if (_isFieldValid != isValid) {
                    widget.onValidationChanged!(isValid);
                    _isFieldValid = isValid;
                  }
                }
              }
            }
          },
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: (v) {
            widget.nextFocus?.requestFocus();
            widget.onSubmitted?.call(v);
          },
          style: widget.style ??
              TextStyle(
                fontSize: 16,
                color: widget.textColor,
              ),
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            labelStyle: widget.labelStyle ??
                TextStyle(
                  color: widget.labelColor,
                  fontSize: 14,
                ),
            hintText: widget.hint,
            prefixIcon: widget.prefix,
            labelText: widget.label,
            contentPadding: widget.contentPadding,
            icon: widget.icon,
            suffixIcon: widget.suffix,
            hintStyle: widget.hintStyle ?? TextStyle(color: widget.hintColor),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: widget.borderColor ??
                        Theme.of(context).colorScheme.onSurface,
                    width: 2,
                  ),
                ),
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor ??
                        Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
            errorBorder: widget.errorBorder ??
                OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.errorBorderColor ?? Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
            focusedErrorBorder: widget.errorBorder ??
                OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.errorBorderColor ?? Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
            errorStyle: TextStyle(color: widget.errorBorderColor ?? Colors.red),
            errorMaxLines: widget.errorMaxLines,
            border: widget.border ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ??
                          Theme.of(context).colorScheme.onSurface),
                  borderRadius: BorderRadius.circular(8),
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildCupertinoTextField() {
    return Form(
      key: formKey,
      child: CupertinoTextFormFieldRow(
          enabled: widget.enabled,
          onTap: widget.onTap,
          validator: widget.validator,
          controller: widget.controller,
          focusNode: widget.focus,
          readOnly: widget.read,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          obscureText: widget.obscureText,
          keyboardType: widget.type,
          autofillHints: widget.autoFillHints,
          scrollPadding:
              widget.scrollPadding ?? EdgeInsets.symmetric(vertical: 20.h),
          onChanged: (String input) {
            // ignore: prefer_null_aware_method_calls
            widget.onChanged?.call(input);
            if (widget.shouldAutoValidate) {
              if (formKey != null) {
                final formState = formKey!.currentState;
                final isValid = formState != null && formState.validate();
                if (widget.onValidationChanged != null) {
                  if (_isFieldValid != isValid) {
                    widget.onValidationChanged!(isValid);
                    _isFieldValid = isValid;
                  }
                }
              }
            }
          },
          placeholder: widget.hint,
          placeholderStyle: widget.hintStyle ??
              TextStyle(
                  fontWeight: FontWeight.w400,
                  color: widget.hintColor ?? CupertinoColors.placeholderText),
          prefix: widget.prefix,
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: (v) {
            widget.nextFocus?.requestFocus();
            widget.onSubmitted?.call(v);
          },
          style: widget.style ??
              TextStyle(
                fontSize: 16,
                color: widget.textColor,
              ),
          padding: widget.contentPadding,
          decoration: widget.boxDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.borderColor ??
                      Theme.of(context).colorScheme.onSurface,
                  width: 2,
                ),
              )),
    );
  }
}
