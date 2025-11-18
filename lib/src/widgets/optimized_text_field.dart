// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/common_utils.dart';

enum TextFieldType { material, cupertino, adaptive }

/// A customizable and feature-rich text field with auto-validation support.
///
/// `OptimizedTextField` provides a highly configurable text input widget with
/// features like custom styling, validation, auto-completion, and input control.
/// It supports Material Design aesthetics and offers flexibility to suit various
/// use cases.
///
/// ### Features:
/// - Customizable appearance: colors, borders, padding, and margins.
/// - Auto-validation with debouncing to reduce validation frequency.
/// - Compatibility with Material Design.
/// - Advanced input features: autofill hints, focus control, and input actions.
/// - Support for prefix/suffix icons and widgets.
/// - Obscure text mode for secure inputs like passwords.
/// - Flexible validation feedback and callback when validation state changes.
///
/// ### Example Usage:
/// ```dart
/// OptimizedTextField(
///   hint: "Enter your name",
///   label: "Name",
///   type: TextInputType.text,
///   onChanged: (value) => print("Value changed: $value"),
///   validator: (value) => value?.isEmpty == true ? "Name is required" : null,
///   controller: TextEditingController(),
///   enabled: true,
///   fillColor: Colors.grey[200],
///   borderColor: Colors.blue,
/// )
/// ```
class OptimizedTextField extends StatefulWidget {
  /// Placeholder text displayed inside the text field when it's empty.
  final String? hint;

  /// Text displayed above the text field as a label.
  final String? label;

  /// Specifies the type of keyboard to display for input, such as [TextInputType.text] or [TextInputType.number].
  final TextInputType? type;

  /// Callback triggered whenever the text field's value changes.
  final ValueChanged<String>? onChanged;

  /// Callback triggered when the user submits the text field (e.g., by pressing "Done").
  final ValueChanged<String>? onSubmitted;

  /// A function to validate the input. Should return `null` if valid, or an error message string if invalid.
  final String? Function(String?)? validator;

  /// A `TextEditingController` to control the text field programmatically.
  final TextEditingController? controller;

  /// Callback triggered when the text field is tapped.
  final VoidCallback? onTap;

  /// An optional icon displayed inside the text field.
  final IconData? eIcon;

  /// A widget displayed at the beginning of the text field.
  final Widget? prefix;

  /// A widget displayed at the end of the text field.
  final Widget? suffix;

  /// An icon displayed as part of the text field decoration.
  final Widget? icon;

  /// The `FocusNode` for this text field to manage focus programmatically.
  final FocusNode? focus;

  /// The `FocusNode` of the next field for easy navigation between fields.
  final FocusNode? nextFocus;

  /// Whether the text field is in read-only mode.
  final bool read;

  /// A callback triggered when editing is performed.
  final Function? edit;

  /// Maximum number of lines the text field can display.
  final int maxLines;

  /// Minimum number of lines the text field can display.
  final int minLines;

  /// Whether the text field is enabled for user interaction.
  final bool enabled;

  /// Whether to obscure the text, commonly used for passwords.
  final bool obscureText;

  /// Character used to obscure text (default is '•').
  final String obscuringCharacter;

  /// Background color of the text field.
  final Color? fillColor;

  /// Whether the text field should automatically gain focus when the widget is built.
  final bool autofocus;

  /// A `GlobalKey` used to manage the form containing the text field.
  final GlobalKey<FormState>? formKey;

  /// Whether the field should auto-validate on every change.
  final bool shouldAutoValidate;

  /// Padding inside the text field.
  final EdgeInsetsGeometry? padding;

  /// Margin around the text field.
  final EdgeInsetsGeometry? margin;

  /// Maximum number of lines for error messages.
  final int? errorMaxLines;

  /// Text color for the input.
  final Color? textColor;

  /// Color for the hint text.
  final Color? hintColor;

  /// Color for the label text.
  final Color? labelColor;

  /// Default border color.
  final Color? borderColor;

  /// Border color when the text field is focused.
  final Color? focusedBorderColor;

  /// Border color when the input is invalid.
  final Color? errorBorderColor;

  /// Default border style.
  final InputBorder? border;

  /// Border style when the text field is focused.
  final InputBorder? focusedBorder;

  /// Border style when the input is invalid.
  final InputBorder? errorBorder;

  /// Border style when the field is enabled.
  final InputBorder? enabledBorder;

  /// Text style for the input.
  final TextStyle? style;

  /// Style for the label text.
  final TextStyle? labelStyle;

  /// Style for the hint text.
  final TextStyle? hintStyle;

  /// Padding inside the text field for the text.
  final EdgeInsetsGeometry contentPadding;

  /// Padding added to the text field when it scrolls into view.
  final EdgeInsets? scrollPadding;

  /// Callback triggered when the validation state changes.
  final void Function(bool isValid)? onValidationChanged;

  /// The action button to show on the keyboard (e.g., "Done", "Next").
  final TextInputAction textInputAction;

  /// Autofill hints to assist user input.
  final Iterable<String>? autoFillHints;

  /// Type of the text field. Internal use only.
  final TextFieldType _textFieldType;

  /// Custom box decoration for the text field.
  final BoxDecoration? boxDecoration;

  /// Whether text suggestions are enabled.
  final bool enableSuggestions;

  /// Whether autocorrect is enabled.
  final bool autocorrect;

  /// Specifies when to validate the input, e.g., on user input or form submission.
  final AutovalidateMode? autoValidateMode;

  /// Delay duration for text field debouncing.
  /// If provided [onChanged] will be fired after the debounce duration only.
  /// If [debounceValidation] is true, It will debounce the validation also.
  /// If not it will be fired normally.
  final Duration? debounceDuration;

  /// Whether to debounce validation for performance improvement.
  final bool debounceValidation;

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
    this.obscuringCharacter = '•',
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
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 10.0,
    ),
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
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.autoValidateMode,
    this.debounceDuration,
    this.debounceValidation = false,
  }) : _textFieldType = TextFieldType.material,
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
    this.obscuringCharacter = '•',
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
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 10.0,
    ),
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
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.autoValidateMode,
    this.debounceDuration,
    this.debounceValidation = false,
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
    this.obscuringCharacter = '•',
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
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 10.0,
    ),
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
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.autoValidateMode,
    this.debounceDuration,
    this.debounceValidation = false,
  }) : _textFieldType = TextFieldType.cupertino;

  @override
  State<StatefulWidget> createState() {
    return _CustomFieldState();
  }
}

class _CustomFieldState extends State<OptimizedTextField> {
  GlobalKey<FormState>? formKey;
  bool? _isFieldValid;
  Timer? _debounceTimer;

  @override
  void initState() {
    formKey =
        widget.formKey ??
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
        child = CommonImageUtils.isCupertino
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
          obscuringCharacter: widget.obscuringCharacter,
          enableSuggestions: widget.enableSuggestions,
          autocorrect: widget.autocorrect,
          autovalidateMode: widget.autoValidateMode,
          scrollPadding:
              widget.scrollPadding ?? EdgeInsets.symmetric(vertical: 20.h),
          onChanged: (String input) {
            // ignore: prefer_null_aware_method_calls
            if (widget.debounceDuration != null) {
              if (_debounceTimer?.isActive ?? false) {
                _debounceTimer?.cancel();
              }
              _debounceTimer = Timer(widget.debounceDuration!, () {
                widget.onChanged?.call(input);
              });
            } else {
              widget.onChanged?.call(input);
            }

            if (widget.shouldAutoValidate) {
              if (widget.debounceValidation &&
                  widget.debounceDuration != null) {
                if (_debounceTimer?.isActive ?? false) {
                  _debounceTimer?.cancel();
                }
                _debounceTimer = Timer(widget.debounceDuration!, () {
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
                });
              } else {
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
            }
          },
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: (v) {
            widget.nextFocus?.requestFocus();
            widget.onSubmitted?.call(v);
          },
          style:
              widget.style ?? TextStyle(fontSize: 16, color: widget.textColor),
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            labelStyle:
                widget.labelStyle ??
                TextStyle(color: widget.labelColor, fontSize: 14),
            hintText: widget.hint,
            prefixIcon: widget.prefix,
            labelText: widget.label,
            contentPadding: widget.contentPadding,
            icon: widget.icon,
            suffixIcon: widget.suffix,
            hintStyle: widget.hintStyle ?? TextStyle(color: widget.hintColor),
            enabledBorder:
                widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color:
                        widget.borderColor ??
                        Theme.of(context).colorScheme.onSurface,
                    width: 2,
                  ),
                ),
            focusedBorder:
                widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        widget.focusedBorderColor ??
                        Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
            errorBorder:
                widget.errorBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.errorBorderColor ?? Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
            focusedErrorBorder:
                widget.errorBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.errorBorderColor ?? Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
            errorStyle: TextStyle(color: widget.errorBorderColor ?? Colors.red),
            errorMaxLines: widget.errorMaxLines,
            border:
                widget.border ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        widget.borderColor ??
                        Theme.of(context).colorScheme.onSurface,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
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
        obscuringCharacter: widget.obscuringCharacter,
        enableSuggestions: widget.enableSuggestions,
        autocorrect: widget.autocorrect,
        autovalidateMode: widget.autoValidateMode ?? AutovalidateMode.disabled,
        scrollPadding:
            widget.scrollPadding ?? EdgeInsets.symmetric(vertical: 20.h),
        onChanged: (String input) {
          // ignore: prefer_null_aware_method_calls
          if (widget.debounceDuration != null) {
            if (_debounceTimer?.isActive ?? false) {
              _debounceTimer?.cancel();
            }
            _debounceTimer = Timer(widget.debounceDuration!, () {
              widget.onChanged?.call(input);
            });
          } else {
            widget.onChanged?.call(input);
          }

          if (widget.shouldAutoValidate) {
            if (widget.debounceValidation && widget.debounceDuration != null) {
              if (_debounceTimer?.isActive ?? false) {
                _debounceTimer?.cancel();
              }
              _debounceTimer = Timer(widget.debounceDuration!, () {
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
              });
            } else {
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
          }
        },
        placeholder: widget.hint,
        placeholderStyle:
            widget.hintStyle ??
            TextStyle(
              fontWeight: FontWeight.w400,
              color: widget.hintColor ?? CupertinoColors.placeholderText,
            ),
        prefix: widget.prefix,
        autofocus: widget.autofocus,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: (v) {
          widget.nextFocus?.requestFocus();
          widget.onSubmitted?.call(v);
        },
        style: widget.style ?? TextStyle(fontSize: 16, color: widget.textColor),
        padding: widget.contentPadding,
        decoration:
            widget.boxDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    widget.borderColor ??
                    Theme.of(context).colorScheme.onSurface,
                width: 2,
              ),
            ),
      ),
    );
  }
}
