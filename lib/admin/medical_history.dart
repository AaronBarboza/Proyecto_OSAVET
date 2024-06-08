import 'package:flutter/material.dart';

class MedicalHistoryScreen extends StatefulWidget {
  @override
  _MedicalHistoryScreenState createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  List<Map<String, String>> _medicalRecords = [
    {"petName": "Lucas", "details": "Vacunación al día"},
    {"petName": "Docky", "details": "Pendiente de desparasitación"},
    // Agrega más registros médicos si es necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial Médico"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFd0e0eb),
                Color.fromARGB(255, 137, 161, 181),
                Color(0xFFd0e0eb),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFd0e0eb),
              Color.fromARGB(255, 137, 161, 181),
              Color(0xFFd0e0eb),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Historial Médico de Mascotas",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _medicalRecords.length,
                  itemBuilder: (context, index) {
                    final record = _medicalRecords[index];
                    return _buildMedicalRecord(
                      petName: record["petName"]!,
                      details: record["details"]!,
                      onEdit: () {
                        _editMedicalHistory(
                            context, record["petName"]!, record["details"]!);
                      },
                      onDelete: () {
                        _deleteMedicalHistory(context, record["petName"]!);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMedicalHistory(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildMedicalRecord({
    required String petName,
    required String details,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Nombre de la mascota: $petName",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Detalles: $details",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addMedicalHistory(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Agregar Historial Médico"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nombre de la mascota",
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(
                    labelText: "Detalles",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _medicalRecords.add({
                    "petName": nameController.text,
                    "details": detailsController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void _editMedicalHistory(
      BuildContext context, String petName, String currentDetails) {
    TextEditingController detailsController =
        TextEditingController(text: currentDetails);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Historial Médico de $petName"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Detalles actuales: $currentDetails"),
                SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(
                    labelText: "Nuevos detalles",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final index = _medicalRecords
                      .indexWhere((record) => record["petName"] == petName);
                  _medicalRecords[index]["details"] = detailsController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _deleteMedicalHistory(BuildContext context, String petName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar Historial Médico de $petName"),
          content: Text(
              "¿Estás seguro de que quieres eliminar el historial médico de $petName?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _medicalRecords
                      .removeWhere((record) => record["petName"] == petName);
                });
                Navigator.of(context).pop();
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}
