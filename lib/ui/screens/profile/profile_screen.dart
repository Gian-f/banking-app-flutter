import 'dart:convert';

import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/screens/home/home_screen.dart';
import 'package:banking_app/ui/screens/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:universal_io/io.dart';

import '../../../data/di/module.dart';
import '../../../domain/controller/profile_controller.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = getIt<ProfileController>();
  File? _imageFile;
  Uint8List? _tempImage;
  bool _isSaving = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    profileController.fetchUserData().then((value) {
      setState(() {
        isLoading =
            value || profileController.user.value!.isEmpty ? false : true;
      });
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    final profileController = getIt<ProfileController>();
    final user = profileController.user.value;
    final userPhoto = user!.profile_image;
    Uint8List bytes = base64Decode(userPhoto.toString());

    Widget imageSection = userPhoto == null
        ? const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
          )
        : ClipOval(
            child: Image.memory(
              bytes,
              fit: BoxFit.cover,
              width: 0.3 * MediaQuery.of(context).size.width,
              height: 0.3 * MediaQuery.of(context).size.width,
            ),
          );

    return Scaffold(
      appBar: TopBarSection(
        onBackPressed: () {
          navigateFinish(context, "/home");
        },
        title: 'Perfil',
      ),
      body: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(70),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 50, bottom: 10),
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  leading: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child:
                                          Icon(Icons.photo_library_outlined)),
                                  title: const Text('Galeria',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400)),
                                  onTap: () async {
                                    await pickFromGallery(context);
                                  },
                                ),
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  leading: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.photo_camera_outlined)),
                                  title: const Text('Câmera',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400)),
                                  onTap: () async {
                                    await pickImageFromCamera(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    child: SizedBox(
                      width: 0.3 * MediaQuery.of(context).size.width,
                      height: 0.3 * MediaQuery.of(context).size.width,
                      child: Center(
                        child: imageSection,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Adicione uma Foto",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                MyTextFieldComponent(
                  labelValue: 'Nome Completo',
                  iconData: Icons.person_outlined,
                  initialValue: user.name,
                  enabled: false,
                  onTextChanged: (name) {
                    profileController.onEvent(FullNameChanged(name));
                  },
                  errorStatus: false,
                  validator: (rule) {
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                MyTextFieldComponent(
                  labelValue: 'E-mail',
                  enabled: false,
                  iconData: Icons.email_outlined,
                  initialValue: user.email,
                  onTextChanged: (string) {},
                  errorStatus: false,
                  validator: (rule) {
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                PhoneTextFieldComponent(
                  labelValue: 'Telefone',
                  iconData: Icons.phone_android,
                  initialValue: user.contact_number,
                  onTextChanged: (phone) {
                    profileController.onEvent(PhoneChanged(phone));
                  },
                  errorStatus: false,
                  validator: (rule) {
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ButtonComponent(
                  value: 'Salvar',
                  isLoading: _isSaving,
                  onButtonClicked: () {
                    onUpdateUserClicked();
                  },
                  isEnabled: true,
                ),
                const SizedBox(height: 20),
                DeleteAccountButtonComponent(
                  isEnabled: true,
                  isLoading: false,
                  value: 'Desativar conta',
                  onButtonClicked: () {
                    onDeleteAccountClicked(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onUpdateUserClicked() async {
    setState(() => _isSaving = true);
    try {
      await profileController.onEvent(UpdateUserButtonClicked());
      if (_tempImage != null) {
        _imageFile = File.fromRawPath(_tempImage!);
      }
      if (mounted) {
        showSnackbar(context, const Text("Operação realizada com sucesso!"));
      } else {
        showSnackbar(context, const Text("Erro: Falha no login"));
      }
    } catch (error) {
      if (mounted) {
        showSnackbar(context,
            const Text("Ocorreu um erro. Tente novamente mais tarde!"));
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100);
    if (pickedFile != null) {
      Navigator.pop(context);
      setState(() {
        _imageFile = File(pickedFile.path);
        _updateImageBase64(_imageFile!);
      });
    }
  }

  Future<void> pickFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
    if (pickedFile != null) {
      Navigator.pop(context);
      setState(() {
        _imageFile = File(pickedFile.path);
        _updateImageBase64(_imageFile!);
      });
    }
  }

  Future<String> _updateImageBase64(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    _tempImage = imageBytes;
    profileController.onEvent(PhotoChanged(base64Image));
    return base64Image;
  }

  Future<void> onDeleteAccountClicked(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Atenção!'),
        content:
            const Text('Você tem certeza que deseja desativar a sua conta?'),
        actions: [
          TextButton(
            onPressed: () => logout(
              context,
            ),
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Não'),
          ),
        ],
      ),
    );

    if (shouldPop ?? false) {
      SystemNavigator.pop();
    }
  }
}
