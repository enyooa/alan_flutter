import 'package:bloc/bloc.dart';
import 'package:alan/bloc/blocs/common_blocs/events/unit_event.dart';
import 'package:alan/bloc/blocs/common_blocs/states/unit_state.dart';
import 'package:alan/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial()) {
    on<CreateUnitEvent>(_createUnit);
    on<FetchUnitsEvent>(_fetchUnits);
  }

  Future<void> _fetchUnits(FetchUnitsEvent event, Emitter<UnitState> emit) async {
    emit(UnitLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(UnitError("Authentication token not found."));
        return;
      }

      final response = await http.get(
        Uri.parse(baseUrl + 'unit-measurements'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final units = jsonDecode(response.body) as List;

        final unitData = units
            .map((u) => {
                  'name': u['name'],
                  'tare': u['tare'],
                })
            .toList();

        emit(UnitFetchedSuccess(unitData));
      } else {
        emit(UnitError("Failed to fetch unit measurements."));
      }
    } catch (e) {
      emit(UnitError("Error: $e"));
    }
  }

  Future<void> _createUnit(CreateUnitEvent event, Emitter<UnitState> emit) async {
    emit(UnitLoading());

    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(UnitError("Authentication token not found."));
        return;
      }

      // API request
      final response = await http.post(
        Uri.parse(baseUrl + 'unit-measurements'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': event.name,
          'tare': event.tare, // Add tare to the request body
        }),
      );

      if (response.statusCode == 201) {
        emit(UnitCreatedSuccess("Единица успешно сохранена"));
      } else {
        final errorData = jsonDecode(response.body);
        emit(UnitError(errorData['message'] ?? "Не удалось сохранить единицу"));
      }
    } catch (e) {
      emit(UnitError("Ошибка: $e"));
    }
  }
}
