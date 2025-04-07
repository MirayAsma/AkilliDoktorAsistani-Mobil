import 'package:flutter/material.dart';
import 'test_results_screen.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final List<Map<String, dynamic>> _confirmedPatients = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadConfirmedPatients();
  }

  void _loadConfirmedPatients() {
    // Simüle edilmiş veri yükleme
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _confirmedPatients.addAll([
            {
              'id': 1,
              'name': 'Ahmet Yılmaz',
              'age': '45',
              'gender': 'Erkek',
              'appointmentDate': '12.04.2025',
              'appointmentTime': '09:30',
              'status': 'Onaylandı',
              'doctor': 'Dr. Mehmet Öz',
              'department': 'Kardiyoloji'
            },
            {
              'id': 2,
              'name': 'Ayşe Kaya',
              'age': '35',
              'gender': 'Kadın',
              'appointmentDate': '15.04.2025',
              'appointmentTime': '14:15',
              'status': 'Onaylandı',
              'doctor': 'Dr. Zeynep Kaya',
              'department': 'Dahiliye'
            },
            {
              'id': 3,
              'name': 'Mustafa Demir',
              'age': '62',
              'gender': 'Erkek',
              'appointmentDate': '18.04.2025',
              'appointmentTime': '11:00',
              'status': 'Onaylandı',
              'doctor': 'Dr. Ahmet Yılmaz',
              'department': 'Nöroloji'
            },
            {
              'id': 4,
              'name': 'Fatma Şahin',
              'age': '29',
              'gender': 'Kadın',
              'appointmentDate': '20.04.2025',
              'appointmentTime': '10:45',
              'status': 'Onaylandı',
              'doctor': 'Dr. Ali Kaya',
              'department': 'Göz Hastalıkları'
            },
          ]);
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onaylanmış Hastalar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                _confirmedPatients.clear();
              });
              _loadConfirmedPatients();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _confirmedPatients.isEmpty
              ? const Center(
                  child: Text(
                    'Onaylanmış randevusu olan hasta bulunamadı',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _confirmedPatients.length,
                  itemBuilder: (context, index) {
                    final patient = _confirmedPatients[index];
                    return _buildPatientCard(patient);
                  },
                ),
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestResultsScreen(
                patientId: patient['id'] as int,
                patientName: patient['name'] as String,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child: Text(
                      (patient['name'] as String).substring(0, 1),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient['name'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${patient['age']} yaş, ${patient['gender']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Onaylandı',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Randevu Tarihi',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${patient['appointmentDate']} - ${patient['appointmentTime']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Doktor',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          patient['doctor'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestResultsScreen(
                            patientId: patient['id'] as int,
                            patientName: patient['name'] as String,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.analytics),
                    label: const Text('Tahlil Sonuçları'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
