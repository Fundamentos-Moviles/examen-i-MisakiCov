import 'package:flutter/material.dart';
import 'package:examen1_cqi/utils/constantes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = List.from(Lista);
  final Set<int> nonDeletableIds = {1, 10, 15, 20, 23};
  final Set<int> specialIds = {1, 5, 10, 15};
  void deleteItem(int index) {
    final data = items[index].split('#');
    final int id = int.parse(data[0]);
    if (nonDeletableIds.contains(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se puede eliminar el elemento con ID: $id')),
      );
    } else {
      setState(() {
        items.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Elemento con ID: $id eliminado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Text('Calendario de Cumpleaños',
            style: TextStyle(color: Colors.black)),
          ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: Lista.length,
        itemBuilder: (context, index) {
          final data = items[index].split('#');
          return NotificationCard(
            id: int.parse(data[0]),
            date: '${data[2]} de ${data[3]}',
            title: '${data[4]} ${data[5]}',
            description: data[6],
            starCount: int.parse(data[7]),
            onDelete: () => deleteItem(index),
            specialIds: specialIds  ,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Covarrubias Quintero Isaac',
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final int id;
  final String date;
  final String title;
  final String description;
  final int starCount;
  final VoidCallback onDelete;
  final Set<int> specialIds;

  NotificationCard({
    this.id = 0,
    required this.date,
    required this.title,
    required this.description,
    this.starCount = 0,
    required this.onDelete,
    required this.specialIds,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
    bool showDeleteButton = false;
    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          setState(() {
            showDeleteButton = !showDeleteButton;
          });
          final snackBar = SnackBar(
            content: Text(
              'ID: ${widget.id}\n'
              'Fecha de nacimiento: ${widget.date}\n'
              'Nombre completo: ${widget.title}\n'
              'Descripción: ${widget.description}\n'
              'No. de Estrellas: ${widget.starCount}',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Stack(
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Row(
                      children: List.generate(5, (index) => Icon(
                        Icons.star,
                        color: index < widget.starCount ? Colors.yellow : Colors.grey,
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (showDeleteButton)
                          TextButton(
                            onPressed: widget.onDelete,
                            child: Text('Borrar', style: TextStyle(color: Colors.red)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 8.0,
                child: Icon(
                  widget.specialIds.contains(widget.id) ? Icons.phonelink_erase : Icons.edit_calendar_outlined,
                  color: widget.specialIds.contains(widget.id) ? Colors.yellow : Colors.grey,
                ),
              )
            ],
          ),
        );
      }
    }