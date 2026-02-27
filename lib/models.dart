class DashboardKpi {
  final int eppEntregados;
  final int quimicosEntregados;
  final int etiquetasRecibidas;
  final int tareasLimpiezaCompletadas;
  final int alertasStock;

  const DashboardKpi({
    required this.eppEntregados,
    required this.quimicosEntregados,
    required this.etiquetasRecibidas,
    required this.tareasLimpiezaCompletadas,
    required this.alertasStock,
  });

  factory DashboardKpi.fromJson(Map<String, dynamic> json) {
    return DashboardKpi(
      eppEntregados: json['epp_entregados'] ?? 0,
      quimicosEntregados: json['quimicos_entregados'] ?? 0,
      etiquetasRecibidas: json['etiquetas_recibidas'] ?? 0,
      tareasLimpiezaCompletadas: json['tareas_limpieza_completadas'] ?? 0,
      alertasStock: json['alertas_stock'] ?? 0,
    );
  }
}

class Movimiento {
  final int id;
  final String tipo;
  final String item;
  final int cantidad;
  final String area;
  final String fecha;

  const Movimiento({
    required this.id,
    required this.tipo,
    required this.item,
    required this.cantidad,
    required this.area,
    required this.fecha,
  });

  factory Movimiento.fromJson(Map<String, dynamic> json) {
    return Movimiento(
      id: json['id'] ?? 0,
      tipo: json['tipo'] ?? '',
      item: json['item'] ?? '',
      cantidad: json['cantidad'] ?? 0,
      area: json['area'] ?? '',
      fecha: json['fecha'] ?? '',
    );
  }
}

class InventarioItem {
  final int id;
  final String categoria;
  final String nombre;
  final int stock;
  final int stockMinimo;

  const InventarioItem({
    required this.id,
    required this.categoria,
    required this.nombre,
    required this.stock,
    required this.stockMinimo,
  });

  bool get enAlerta => stock <= stockMinimo;

  factory InventarioItem.fromJson(Map<String, dynamic> json) {
    return InventarioItem(
      id: json['id'] ?? 0,
      categoria: json['categoria'] ?? '',
      nombre: json['nombre'] ?? '',
      stock: json['stock'] ?? 0,
      stockMinimo: json['stock_minimo'] ?? 0,
    );
  }
}
