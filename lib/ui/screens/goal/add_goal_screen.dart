import 'package:banking_app/data/remote/dto/request/register_goal.dart';
import 'package:banking_app/domain/controller/goal_controller.dart';
import 'package:banking_app/navigation.dart';
import 'package:banking_app/utils/util.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import '../../../data/di/module.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/widgets.dart';
import 'list_goal_screen.dart';

class AddGoalScreen extends StatefulWidget {
  @override
  _AddGoalScreenState createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final nameController = TextEditingController();
  final currentProgressController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final goalNumberController = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final expectedDateController = TextEditingController();
  DateTime? selectedDate;
  String? selectedDateText;
  final controller = getIt<GoalController>();
  IconData selectedIcon = Icons.star;
  GoalStatus selectedStatus = GoalStatus.ATIVO;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Objetivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextFieldComponent(
              controller: nameController,
              labelValue: 'Nome do Objetivo',
              iconData: Icons.title,
              onTextChanged: (text) {
                // Lógica para tratar a mudança no texto
              },
              validator: (value) {
                // Lógica para validação
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            NumberFieldComponent(
              controller: currentProgressController,
              labelValue: 'Progresso Atual',
              iconData: Icons.show_chart,
              onTextChanged: (text) {
                print(text);
              },
              validator: (value) {
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            NumberFieldComponent(
              controller: goalNumberController,
              labelValue: 'Valor da Meta',
              iconData: Icons.flag,
              onTextChanged: (text) {
                print(text);
              },
              validator: (value) {
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            MyTextFieldComponent(
              labelValue: 'Data Esperada',
              enabled: true,
              controller: expectedDateController,
              iconData: Icons.calendar_today,
              onTextChanged: (text) {},
              onTap: () {
                _selectDate(context);
              },
              validator: (value) {
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<GoalStatus>(
              popupProps: PopupProps.menu(fit: FlexFit.loose),
              items: GoalStatus.values.toList(),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.flag),
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
              ),
              itemAsString: (GoalStatus? status) {
                switch (status) {
                  case GoalStatus.ATIVO:
                    return 'ATIVO';
                  case GoalStatus.INATIVO:
                    return 'INATIVO';
                  case GoalStatus.CONCLUIDO:
                    return 'PENDENTE';
                  default:
                    return '';
                }
              },
              onChanged: (GoalStatus? value) {
                setState(() {
                  selectedStatus = value ?? GoalStatus.ATIVO;
                });
              },
              selectedItem: selectedStatus,
            ),
            SizedBox(height: 30),
            ButtonComponent(
                value: 'Salvar Objetivo',
                isLoading: _isSaving,
                onButtonClicked: () {
                  onSaveButtonClicked();
                },
                isEnabled: true),
          ],
        ),
      ),
    );
  }

  void onSaveButtonClicked() {
    if (nameController.text.isEmpty) {
      showErrorDialog(context, 'O nome do objetivo não pode estar vazio');
      return;
    }

    double? currentProgress = double.tryParse(currentProgressController.text
        .replaceAll("R\$", "")
        .replaceAll(".", "")
        .replaceAll(",", ""));
    if (currentProgress == null) {
      showErrorDialog(context, 'O progresso atual deve ser um número');
      return;
    }

    double? goalNumber = double.tryParse(goalNumberController.text
        .replaceAll("R\$", "")
        .replaceAll(".", "")
        .replaceAll(",", ""));
    if (goalNumber == null) {
      showErrorDialog(context, 'O número do objetivo deve ser um número');
      return;
    }

    DateTime? expectedDate = dateFormatStringUtc(expectedDateController.text);
    if (expectedDate == null) {
      showErrorDialog(context, 'A data esperada deve ser uma data válida');
      return;
    }

    RegisterGoalRequest newGoal = RegisterGoalRequest(
        name: nameController.text,
        currentProgress: currentProgress,
        goalNumber: goalNumber,
        expectedDate: expectedDate,
        iconName: "Icons.home",
        status: selectedStatus.name);
    onRegisterClicked(newGoal);
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateText = selectedDate!.toLocal().toString().split(' ')[0];
      });
      expectedDateController.text = formatDateString(selectedDateText!);
    }
  }

  void onRegisterClicked(RegisterGoalRequest newGoal) async {
    setState(() => _isSaving = true);
    try {
      await controller.registerGoal(newGoal);
      if (nameController.text.isEmpty ||
          currentProgressController.text.isEmpty ||
          goalNumberController.text.isEmpty ||
          expectedDateController.text.isEmpty) {
        showSnackbar(
            context,
            const Text(
                "Ocorreu um erro. Por favor tente novamente mais tarde!"));
      }
      if (mounted) {
        showSnackbar(context, const Text("Operação realizada com sucesso!"));
        navigateFinish(context, "/goals");
      } else {
        showSnackbar(context, const Text("Erro: Falha ao adicionar objetivo!"));
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
}
