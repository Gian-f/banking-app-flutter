import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NormalTextComponent extends StatelessWidget {
  final String value;

  const NormalTextComponent({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class HeadingTextComponent extends StatelessWidget {
  final String value;

  const HeadingTextComponent({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
    );
  }
}

class MyTextFieldComponent extends StatefulWidget {
  final String labelValue;
  final IconData iconData;
  final Function(String) onTextChanged;
  final String? Function(String?) validator;
  final bool? errorStatus;

  const MyTextFieldComponent(
      {super.key,
      required this.labelValue,
      required this.iconData,
      required this.onTextChanged,
      required this.validator,
      this.errorStatus = false});

  @override
  _MyTextFieldComponentState createState() => _MyTextFieldComponentState();
}

class _MyTextFieldComponentState extends State<MyTextFieldComponent> {
  late TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      widget.onTextChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelValue,
        prefixIcon: Icon(widget.iconData),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
      validator: widget.validator,
    );
  }
}

class PasswordTextFieldComponent extends StatefulWidget {
  final String labelValue;
  final IconData iconData;
  final Function(String) onTextSelected;
  final String? Function(String?) validator;
  final bool? errorStatus;

  const PasswordTextFieldComponent(
      {Key? key,
      required this.labelValue,
      required this.iconData,
      required this.onTextSelected,
      required this.validator,
      this.errorStatus = false})
      : super(key: key);

  @override
  _PasswordTextFieldComponentState createState() =>
      _PasswordTextFieldComponentState();
}

class _PasswordTextFieldComponentState
    extends State<PasswordTextFieldComponent> {
  late TextEditingController _controller;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      widget.onTextSelected(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelValue,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        filled: true,
        prefixIcon: Icon(widget.iconData),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(_passwordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined),
        ),
        labelStyle: const TextStyle(color: Colors.white),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
      obscureText: !_passwordVisible,
      validator: widget.validator,
    );
  }
}

class ClickableLoginTextComponent extends StatelessWidget {
  final bool tryingToLogin;
  final Function(String) onTextSelected;

  const ClickableLoginTextComponent({
    super.key,
    required this.tryingToLogin,
    required this.onTextSelected,
  });

  @override
  Widget build(BuildContext context) {
    final initialText =
        tryingToLogin ? "Já possui uma conta? " : "Não tem uma conta? ";
    final loginText = tryingToLogin ? "Entrar" : "Registre-se";

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
              text: "$initialText",
              style: const TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.normal)),
          TextSpan(
            text: loginText,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 21,
                fontWeight: FontWeight.w400),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTextSelected(loginText);
              },
          ),
        ],
      ),
    );
  }
}

class ButtonComponent extends StatelessWidget {
  final String value;
  final Function onButtonClicked;
  final bool isEnabled;
  final bool isLoading;

  const ButtonComponent({
    super.key,
    required this.value,
    required this.onButtonClicked,
    this.isEnabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: isEnabled ? onButtonClicked as void Function()? : null,
      child: Ink(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary
            ],
          ),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

class DividerTextComponent extends StatelessWidget {
  const DividerTextComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'ou',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class ClickableTextComponent extends StatelessWidget {
  final String value;
  final Function(String) onTextSelected;

  ClickableTextComponent({
    super.key,
    required this.value,
    required this.onTextSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          const TextSpan(
            text: 'Ao continuar você aceita nossa ',
          ),
          TextSpan(
            text: 'Política de \n privacidade',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTextSelected('Política de privacidade'),
          ),
          const TextSpan(
            text: ' e ',
          ),
          TextSpan(
            text: 'Termos de uso',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTextSelected('Termos de uso'),
          ),
        ],
      ),
    );
  }
}

class CheckboxComponent extends StatefulWidget {
  final String value;
  final Function(String) onTextSelected;
  final Function(bool) onCheckedChange;

  CheckboxComponent({
    required this.value,
    required this.onTextSelected,
    required this.onCheckedChange,
  });

  @override
  _CheckboxComponentState createState() => _CheckboxComponentState();
}

class _CheckboxComponentState extends State<CheckboxComponent> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _checked,
          onChanged: (bool? value) {
            setState(() {
              _checked = value!;
            });
            widget.onCheckedChange(_checked);
          },
        ),
        ClickableTextComponent(
          value: widget.value,
          onTextSelected: (string) {
            widget.onTextSelected(widget.value);
          },
        ),
      ],
    );
  }
}
