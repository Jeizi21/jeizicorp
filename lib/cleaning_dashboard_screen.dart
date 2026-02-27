import 'package:flutter/material.dart';

import 'api_service.dart';
import 'models.dart';

class CleaningDashboardScreen extends StatefulWidget {
  const CleaningDashboardScreen({super.key});

  @override
  State<CleaningDashboardScreen> createState() => _CleaningDashboardScreenState();
}

class _CleaningDashboardScreenState extends State<CleaningDashboardScreen> {
  final CleaningApiService _api =
      CleaningApiService(baseUrl: 'http://localhost:8080/backend');

  late Future<_DashboardData> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  Future<_DashboardData> _loadData() async {
    final kpis = await _api.fetchKpis();
    final movimientos = await _api.fetchMovimientos();
    final inventario = await _api.fetchInventario();
    return _DashboardData(
      kpis: kpis,
      movimientos: movimientos,
      inventario: inventario,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Auxiliar de Limpieza'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureData = _loadData();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<_DashboardData>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar datos: ${snapshot.error}'),
            );
          }

          final data = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Indicadores del turno',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    _KpiGrid(kpis: data.kpis),
                    const SizedBox(height: 20),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _HistorialCard(movimientos: data.movimientos),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _InventarioCard(inventario: data.inventario),
                          ),
                        ],
                      )
                    else ...[
                      _HistorialCard(movimientos: data.movimientos),
                      const SizedBox(height: 16),
                      _InventarioCard(inventario: data.inventario),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_task),
        label: const Text('Nuevo registro'),
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.kpis});

  final DashboardKpi kpis;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _KpiCard(
        title: 'EPP Entregados',
        value: '${kpis.eppEntregados}',
        icon: Icons.health_and_safety,
      ),
      _KpiCard(
        title: 'Químicos Entregados',
        value: '${kpis.quimicosEntregados}',
        icon: Icons.science,
      ),
      _KpiCard(
        title: 'Etiquetas Recibidas',
        value: '${kpis.etiquetasRecibidas}',
        icon: Icons.label,
      ),
      _KpiCard(
        title: 'Limpiezas Completadas',
        value: '${kpis.tareasLimpiezaCompletadas}',
        icon: Icons.cleaning_services,
      ),
      _KpiCard(
        title: 'Alertas de Stock',
        value: '${kpis.alertasStock}',
        icon: Icons.warning_amber,
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: cards
          .map((card) => SizedBox(width: 220, height: 110, child: card))
          .toList(),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _HistorialCard extends StatelessWidget {
  const _HistorialCard({required this.movimientos});

  final List<Movimiento> movimientos;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Historial de entregas/recibos',
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            ...movimientos.take(10).map(
                  (m) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text('${m.tipo}: ${m.item} (${m.cantidad})'),
                    subtitle: Text('${m.area} • ${m.fecha}'),
                    trailing: Icon(
                      m.tipo.toLowerCase().contains('entrega')
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _InventarioCard extends StatelessWidget {
  const _InventarioCard({required this.inventario});

  final List<InventarioItem> inventario;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inventario (EPP, Químicos, Etiquetas)',
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            ...inventario.map(
              (item) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text('${item.nombre} - ${item.categoria}'),
                subtitle: Text('Stock: ${item.stock} | Mínimo: ${item.stockMinimo}'),
                trailing: Icon(
                  item.enAlerta ? Icons.error : Icons.check_circle,
                  color: item.enAlerta ? Colors.red : Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardData {
  final DashboardKpi kpis;
  final List<Movimiento> movimientos;
  final List<InventarioItem> inventario;

  const _DashboardData({
    required this.kpis,
    required this.movimientos,
    required this.inventario,
  });
}
