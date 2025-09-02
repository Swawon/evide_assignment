
import 'package:flutter/material.dart';
import 'package:evide_assignment/model/model.dart';
   import 'package:shared_preferences/shared_preferences.dart';
class StopDetailScreen extends StatefulWidget {
  final BusStop stop;
  const StopDetailScreen({required this.stop,super.key});

 @override
  State<StatefulWidget> createState() {
    return _StopDetailScreenState();
  }
}

class _StopDetailScreenState extends State<StopDetailScreen> {
  bool isFav = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadFav();
  }

  _loadFav() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isFav = prefs.getBool(widget.stop.stopname) ?? false;
    });
  }

  _toggleFav() {
    setState(() {
      isFav = !isFav;
    });
    prefs.setBool(widget.stop.stopname, isFav);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stop.stopname)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Latitude: ${widget.stop.latitude}"),
            Text("Longitude: ${widget.stop.longitude}"),
            Text("ETA: ${widget.stop.timedifference} minutes"),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _toggleFav,
              icon: Icon(isFav ? Icons.star : Icons.star_border),
              label: Text(isFav ? "Unfavorite" : "Add to Favorites"),
            )
          ],
        ),
      ),
    );
  }
}
