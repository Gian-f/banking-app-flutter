import 'package:banking_app/utils/util.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/form_widgets.dart';
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

  IconData selectedIcon = Icons.star;
  GoalStatus selectedStatus = GoalStatus.ATIVO;

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
                // Lógica para validação, se necessário
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
                isLoading: false,
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
    // Goal newGoal = Goal(
    //   name: nameController.text,
    //   icon: selectedIcon,
    //   currentProgress: currentProgressController.text,
    //   goalNumber: goalNumberController.text,
    //   status: selectedStatus,
    //   expectedDate: DateTime.parse(expectedDateController.text),
    // );
    // print('Novo Objetivo: $newGoal');
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
}
