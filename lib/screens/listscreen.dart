import 'package:flutter/material.dart';
import 'package:evide_assignment/model/model.dart';
   import 'dart:convert';
   import 'package:evide_assignment/screens/detailscreen.dart';

class StopListScreen extends StatefulWidget {
  const StopListScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _StopListScreenState();
  }
}
Future<List<BusStop>> loadStops(BuildContext context) async {
  final data = await DefaultAssetBundle.of(context)
      .loadString('assets/mock/stops.json');
  final decoded = json.decode(data) as Map<String, dynamic>;

  final stopsList = decoded["tirTOkuttp"] as List<dynamic>;

  return stopsList.map((e) => BusStop.fromJson(e)).toList();
}


class _StopListScreenState extends State<StopListScreen> {
  List<BusStop> stops = [];
  List<BusStop> filtered = [];
  TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadStops(context).then((data) {
      setState(() {
        stops = data;
        filtered = data;
      });
    });
  }

  void filterSearch(String query) {
    setState(() {
      filtered = stops
          .where((s) => s.stopname.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bus Stops")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchCtrl,
              onChanged: filterSearch,
              decoration: InputDecoration(
                hintText: "Search stops...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (ctx, i) {
                final stop = filtered[i];
                return ListTile(
                  title: Text(stop.stopname),
                  subtitle: Text("ETA ~ ${stop.timedifference} mins"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StopDetailScreen(stop: stop),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
