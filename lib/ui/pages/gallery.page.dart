import 'package:flutter/material.dart';
import 'database_service.dart';

class GalleryPage extends StatefulWidget {
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<Map<String, dynamic>> birthdays = [];
  final DatabaseService dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadBirthdays();
  }

  Future<void> _loadBirthdays() async {
    final data = await dbService.getAllBirthdays();
    setState(() {
      birthdays.clear();
      birthdays.addAll(
        data.where((birthday) => birthday['groupName'] == 'Famille'),
      );
    });
  }

  void _showAddBirthdayForm() {
    final _formKey = GlobalKey<FormState>();
    String? name;
    String? group;
    String? day;
    String? month;
    String? year;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Center(
            child: Text(
              "Ajouter un Anniversaire",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Champ pour le nom
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer un nom";
                      }
                      return null;
                    },
                    onSaved: (value) => name = value,
                  ),
                  SizedBox(height: 16),

                  // Champ pour la date
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Jour",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => day = value,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Mois",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => month = value,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Année",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => year = value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Groupe
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Groupe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ["Famille", "Amis", "Travail", "Autre"]
                        .map((group) => DropdownMenuItem(
                      value: group,
                      child: Text(group),
                    ))
                        .toList(),
                    onChanged: (value) => group = value,
                    validator: (value) => value == null ? "Veuillez choisir un groupe" : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final birthday = {
                      'name': name!,
                      'date': '$day/$month/$year',
                      'groupName': group!,
                    };

                    await dbService.addBirthday(birthday);
                    Navigator.of(context).pop();
                    _loadBirthdays();
                  }
                },
                icon: Icon(Icons.cake),
                label: Text("Enregistrer"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // primary: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateBirthdayForm(Map<String, dynamic> birthday) {
    final _formKey = GlobalKey<FormState>();
    String? name = birthday['name'];
    String? group = birthday['groupName'];
    String? day = birthday['date'].split('/')[0];
    String? month = birthday['date'].split('/')[1];
    String? year = birthday['date'].split('/')[2];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Center(
            child: Text(
              "Mettre à jour l'anniversaire",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Champ pour le nom
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer un nom";
                      }
                      return null;
                    },
                    onSaved: (value) => name = value,
                  ),
                  SizedBox(height: 16),

                  // Champ pour la date
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: day,
                          decoration: InputDecoration(
                            hintText: "Jour",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => day = value,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: month,
                          decoration: InputDecoration(
                            hintText: "Mois",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => month = value,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: year,
                          decoration: InputDecoration(
                            hintText: "Année",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => year = value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Groupe
                  DropdownButtonFormField<String>(
                    value: group,
                    decoration: InputDecoration(
                      labelText: "Groupe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ["Famille", "Amis", "Travail", "Autre"]
                        .map((group) => DropdownMenuItem(
                      value: group,
                      child: Text(group),
                    ))
                        .toList(),
                    onChanged: (value) => group = value,
                    validator: (value) => value == null ? "Veuillez choisir un groupe" : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedBirthday = {
                    'id': birthday['id'],
                    'name': name!,
                    'date': '$day/$month/$year',
                    'groupName': group!,
                  };

                  await dbService.updateBirthday(updatedBirthday);
                  Navigator.of(context).pop();
                  _loadBirthdays();
                }
              },
              child: Text("Mettre à jour"),
            ),
          ],
        );
      },
    );
  }

  void _deleteBirthday(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Voulez-vous vraiment supprimer cet anniversaire ?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await dbService.deleteBirthday(id);
                _loadBirthdays();
                Navigator.of(context).pop();
              },
              child: Text("Oui"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Non"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anniversaires-Famille'),
      ),
      body: ListView.builder(
        itemCount: birthdays.length,
        itemBuilder: (context, index) {
          final birthday = birthdays[index];
          return ListTile(
            title: Text('${birthday['name']}'),
            subtitle: Text('${birthday['date']} - Groupe : ${birthday['groupName']}'),
            trailing: Wrap(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateBirthdayForm(birthday),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteBirthday(birthday['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBirthdayForm,
        tooltip: 'Ajouter un Anniversaire',
        child: Icon(Icons.add),
      ),
    );
  }
}
