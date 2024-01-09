import 'package:banking_app/navigation.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/form_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isModalSheetVisible = false;
  final String _imageUri = "";
  final bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarSection(
        onBackPressed: () {
          navigate(context, "/home");
        },
        title: 'Perfil',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                setState(() {
                  _isModalSheetVisible = true;
                });
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                backgroundImage:
                    _imageUri != "" ? NetworkImage(_imageUri) : null,
                child: _imageUri == ""
                    ? const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Adicione uma Foto",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            PhoneTextFieldComponent(
              labelValue: 'Nome Completo',
              iconData: Icons.person_outlined,
              onTextChanged: (string) {},
              errorStatus: false,
              validator: (rule) {},
            ),
            const SizedBox(height: 20),
            PhoneTextFieldComponent(
              labelValue: 'Telefone',
              iconData: Icons.phone_android,
              onTextChanged: (string) {},
              errorStatus: false,
              validator: (rule) {},
            ),
            const SizedBox(height: 20),
            PhoneTextFieldComponent(
              labelValue: 'E-mail',
              iconData: Icons.email_outlined,
              onTextChanged: (string) {},
              errorStatus: false,
              validator: (rule) {},
            ),
            const SizedBox(height: 30),
            ButtonComponent(
                value: 'Salvar',
                isLoading: _isSaving,
                onButtonClicked: (string) {},
                isEnabled: false),
          ],
        ),
      ),
    );
  }
}
