import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/inspection_models.dart';
import '../services/api_service.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key, required this.api});

  final ApiService api;

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateCtrl = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final _shiftCtrl = TextEditingController(text: 'Mañana');
  final _weekCtrl = TextEditingController(text: 'Semana 1');

  final _hourCtrl = TextEditingController(text: '08:00:00');
  final _lotCtrl = TextEditingController();
  final _phCtrl = TextEditingController(text: '7.0');
  final _tempCtrl = TextEditingController(text: '15.0');
  final _turbidityCtrl = TextEditingController(text: '10.0');
  bool _changedWater = false;
  final _waterCtrl = TextEditingController(text: '0');
  final _disinfectantCtrl = TextEditingController(text: '0');
  final _ppmCtrl = TextEditingController(text: '100');
  final _obsCtrl = TextEditingController();
  final _operatorCtrl = TextEditingController();
  final _supervisorCtrl = TextEditingController();

  bool _saving = false;

  @override
  void dispose() {
    for (final ctrl in [
      _dateCtrl,
      _shiftCtrl,
      _weekCtrl,
      _hourCtrl,
      _lotCtrl,
      _phCtrl,
      _tempCtrl,
      _turbidityCtrl,
      _waterCtrl,
      _disinfectantCtrl,
      _ppmCtrl,
      _obsCtrl,
      _operatorCtrl,
      _supervisorCtrl,
    ]) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      final header = InspectionHeader(
        productionDate: _dateCtrl.text.trim(),
        shiftName: _shiftCtrl.text.trim(),
        weekLabel: _weekCtrl.text.trim(),
      );

      final entry = InspectionEntry(
        hourMark: _hourCtrl.text.trim(),
        lotNumber: _lotCtrl.text.trim(),
        phValue: double.parse(_phCtrl.text.trim()),
        waterTempC: double.parse(_tempCtrl.text.trim()),
        turbidityNtu: double.parse(_turbidityCtrl.text.trim()),
        waterChanged: _changedWater,
        waterLiters: double.parse(_waterCtrl.text.trim()),
        disinfectantMl: double.parse(_disinfectantCtrl.text.trim()),
        concentrationPpm: int.parse(_ppmCtrl.text.trim()),
        observations: _obsCtrl.text.trim(),
        operatorInitials: _operatorCtrl.text.trim(),
        supervisorName: _supervisorCtrl.text.trim(),
      );

      await widget.api.createRecord(header: header, entries: [entry]);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro guardado correctamente')),
      );
      _lotCtrl.clear();
      _obsCtrl.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro diario - Planta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _field(_dateCtrl, 'Fecha (yyyy-mm-dd)', width: 220),
                  _field(_shiftCtrl, 'Turno', width: 180),
                  _field(_weekCtrl, 'Semana', width: 180),
                ],
              ),
              const SizedBox(height: 18),
              const Text('Monitoreo de agua', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _field(_hourCtrl, 'Hora', width: 150),
                  _field(_lotCtrl, 'Lote/S', width: 200),
                  _field(_phCtrl, 'pH', width: 120),
                  _field(_tempCtrl, 'Temp (°C)', width: 130),
                  _field(_turbidityCtrl, 'Turbidez (NTU)', width: 160),
                  _field(_waterCtrl, 'Agua (L)', width: 130),
                  _field(_disinfectantCtrl, 'Desinfectante (ml)', width: 180),
                  _field(_ppmCtrl, 'Concentración (ppm)', width: 180),
                  _field(_operatorCtrl, 'Iniciales operario', width: 180),
                  _field(_supervisorCtrl, 'Supervisor', width: 180),
                ],
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                value: _changedWater,
                onChanged: (v) => setState(() => _changedWater = v),
                title: const Text('¿Se cambió el agua?'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _obsCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Observaciones'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: const Icon(Icons.save),
                  label: Text(_saving ? 'Guardando...' : 'Guardar registro'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, {double width = 200}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: (value) => (value == null || value.trim().isEmpty) ? 'Requerido' : null,
      ),
    );
  }
}
