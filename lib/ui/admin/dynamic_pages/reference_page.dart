import 'package:cash_control/bloc/models/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_control/bloc/blocs/admin_page_blocs/blocs/operations_bloc.dart';
import 'package:cash_control/bloc/blocs/admin_page_blocs/events/operations_event.dart';
import 'package:cash_control/bloc/blocs/admin_page_blocs/states/operations_state.dart';
import 'package:cash_control/constant.dart';

class OperationHistoryPage extends StatefulWidget {
  @override
  _OperationHistoryPageState createState() => _OperationHistoryPageState();
}

class _OperationHistoryPageState extends State<OperationHistoryPage> {
  final TextEditingController searchController = TextEditingController();
  List<Operation> allOperations = [];
  List<Operation> filteredOperations = [];

  @override
  void initState() {
    super.initState();
    context.read<OperationsBloc>().add(FetchOperationsHistoryEvent());
  }

  void _filterOperations(String query) {
  setState(() {
    filteredOperations = allOperations.where((operation) {
      final operationLower = operation.operation.toLowerCase();
      final typeLower = operation.type.toLowerCase();
      return operationLower.contains(query.toLowerCase()) || typeLower.contains(query.toLowerCase());
    }).toList();
  });
}


  void _editOperation(BuildContext context, Map<String, dynamic> operation) {
    final type = operation['type'];
    switch (type) {
      case 'Продажа':
        _showEditDialog(context, operation, ['количество', 'цена'], (fields) {
          context.read<OperationsBloc>().add(
                EditOperationEvent(
                  id: int.tryParse(operation['id'].toString()) ?? 0,
                  type: 'Продажа',
                  updatedFields: {
                    'amount': int.tryParse(fields['amount'] ?? '0') ?? 0,
                    'price': double.tryParse(fields['price'] ?? '0.0') ?? 0.0,
                  },
                ),
              );
        });
        break;
      case 'Карточка товара':
        _showEditDialog(context, operation, ['Наименование продукта', 'описание'], (fields) {
          context.read<OperationsBloc>().add(
                EditOperationEvent(
                  id: int.tryParse(operation['id'].toString()) ?? 0,
                  type: 'Карточка товара',
                  updatedFields: {
                    'name_of_products': fields['name_of_products'] ?? '',
                    'description': fields['description'] ?? '',
                  },
                ),
              );
        });
        break;
      case 'Подкарточка товара':
        _showEditDialog(context, operation, ['название подкарточки', 'брутто', 'нетто'], (fields) {
          context.read<OperationsBloc>().add(
                EditOperationEvent(
                  id: int.tryParse(operation['id'].toString()) ?? 0,
                  type: 'Подкарточка товара',
                  updatedFields: {
                    'name': fields['name'] ?? '',
                    'brutto': double.tryParse(fields['brutto'] ?? '0.0') ?? 0.0,
                    'netto': double.tryParse(fields['netto'] ?? '0.0') ?? 0.0,
                  },
                ),
              );
        });
        break;
      case 'Ценовое предложение':
        _showEditDialog(context, operation, ['количество', 'цена'], (fields) {
          context.read<OperationsBloc>().add(
                EditOperationEvent(
                  id: int.tryParse(operation['id'].toString()) ?? 0,
                  type: 'Ценовое предложение',
                  updatedFields: {
                    'amount': int.tryParse(fields['amount'] ?? '0') ?? 0,
                    'price': double.tryParse(fields['price'] ?? '0.0') ?? 0.0,
                  },
                ),
              );
        });
        break;
    }
  }

  void _deleteOperation(BuildContext context, Map<String, dynamic> operation) {
    final type = operation['type'];
    context.read<OperationsBloc>().add(
          DeleteOperationEvent(
            id: int.tryParse(operation['id'].toString()) ?? 0,
            type: type,
          ),
        );
  }

  void _showEditDialog(
    BuildContext context,
    Map<String, dynamic> operation,
    List<String> fields,
    Function(Map<String, String>) onSave,
  ) {
    final Map<String, TextEditingController> controllers = {
      for (var field in fields)
        field: TextEditingController(text: operation[field]?.toString() ?? ''),
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Редактировать ${operation['type']}', style: titleStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: fields.map((field) {
              return TextField(
                controller: controllers[field],
                decoration: InputDecoration(
                  labelText: field,
                  labelStyle: formLabelStyle,
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена', style: buttonTextStyle.copyWith(color: errorColor)),
            ),
            TextButton(
              onPressed: () {
                final updatedFields = {
                  for (var field in fields) field: controllers[field]?.text ?? '',
                };
                onSave(updatedFields);
                Navigator.pop(context);
              },
              child: Text('Сохранить', style: buttonTextStyle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('История операций', style: headingStyle),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: verticalPadding),
              child: TextField(
                controller: searchController,
                style: bodyTextStyle,
                decoration: InputDecoration(
                  hintText: 'Поиск...',
                  hintStyle: captionStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  prefixIcon: const Icon(Icons.search, color: textColor),
                ),
                onChanged: _filterOperations,
              ),
            ),
            Expanded(
              child: BlocConsumer<OperationsBloc, OperationsState>(
                listener: (context, state) {
                  if (state is OperationsSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message, style: bodyTextStyle), backgroundColor: primaryColor),
                    );
                  } else if (state is OperationsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message, style: bodyTextStyle), backgroundColor: errorColor),
                    );
                  }
                },
                builder: (context, state) {
                if (state is OperationsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OperationsLoaded) {
                  if (allOperations.isEmpty) {
                    allOperations = state.operations;
                    filteredOperations = state.operations;
                  }

                  if (filteredOperations.isEmpty) {
                    return Center(
                      child: Text('Нет данных для отображения.', style: bodyTextStyle),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredOperations.length,
                    itemBuilder: (context, index) {
                      final operation = filteredOperations[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(operation.operation, style: titleStyle),
                          subtitle: Text(operation.type, style: captionStyle),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: primaryColor),
                                onPressed: () => _editOperation(context, operation.toJson()),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: errorColor),
                                onPressed: () => _deleteOperation(context, operation.toJson()),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is OperationsError) {
                  return Center(
                    child: Text(state.message, style: bodyTextStyle),
                  );
                }
                return Center(
                  child: Text('Нет данных.', style: bodyTextStyle),
                );
              },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
