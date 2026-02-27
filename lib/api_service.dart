import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

class CleaningApiService {
  CleaningApiService({required this.baseUrl});

  final String baseUrl;

  Future<DashboardKpi> fetchKpis() async {
    final response = await http.get(Uri.parse('$baseUrl/kpis.php'));
    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener KPIs');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return DashboardKpi.fromJson(data);
  }

  Future<List<Movimiento>> fetchMovimientos() async {
    final response = await http.get(Uri.parse('$baseUrl/movimientos.php'));
    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener historial');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Movimiento.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<InventarioItem>> fetchInventario() async {
    final response = await http.get(Uri.parse('$baseUrl/inventario.php'));
    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener inventario');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => InventarioItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
