import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'tab_bar_view.dart';
import 'provider.dart';
import 'package:provider/provider.dart';
import 'geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void searchCity(searchController, context) {
		debugPrint('Searching for: ${searchController.text}');
		Provider.of<SearchProvider>(context, listen: false).updateLocation(searchController.text);
    debugPrint('location updated');
}

Future<void> useGeolocalization(context) async {
	try {
		String location = await getCoordinates();
		debugPrint('Location for: ${location}');
		Provider.of<SearchProvider>(context, listen: false).updateLocation(location);
	} catch (e) {
		print("Error: $e");
	}
}


IconButton wAppBarIconButton(searchController, context) {
	return IconButton(
		icon: const Icon(
			Icons.search,
			color: Colors.white,
			),
		tooltip: 'Search city',
		onPressed: () => searchCity(searchController, context),
	);
}

List<Widget> wAppBarActions(context) {
	return <Widget>[
		IconButton(
			icon: const Icon(
				Icons.beach_access,
				color: Colors.white,
			),
			tooltip: 'Get current location',
			onPressed: () => useGeolocalization(context),
		),
	];
}


AppBar weatherAppBar(searchController, context) {
	return AppBar(
		backgroundColor: Colors.deepPurple,
		leading: wAppBarIconButton(searchController, context),
		title: Row(
			children: [
				Expanded(
					child: MySearchBar(controller: searchController),
				),
			],
		),
		actions: wAppBarActions(context),
	);
}


Future<List<String>> onTest(text) async {
	String baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

	try {
		final response = await http.get(Uri.parse('$baseUrl?name=$text&count=2'));

		if (response.statusCode == 200) {
			var data = jsonDecode(response.body);
		
			if (data['results'] != null)
			{
				List<String> res = List<String>.from(data['results'].map(
          (item) => '${item['name']}, ${item['country']}, ${item['country_code']}'
        ));
				return res;
			}
		} else {
			print("Failed to fetch data: ${response.statusCode}");
		}
	} catch (e) {
		print("Error fetching location data: $e");
	}
	return [];
}

  // Expanded(
  // 	child: WeatherClass(),
  // ),
  // Expanded(
  // 	child: 
  // 		ElevatedButton(
  // 			onPressed: () => onTest(searchController.text),
  // 			child: Text("Skapa")),
  // 		),
Widget weatherBody(List<Tab> myTabs, TextEditingController searchController) {
  return Column(
    children: [
      Expanded(
        child: Consumer<SearchProvider>(
          builder: (context, searchProvider, child) {
            return MyTabBarView(
              myTabs: myTabs,
              location: searchProvider.location,
            );
          },
        ),
      ),
    ],
  );
}


BottomAppBar weatherBottomAppBar(myTabs) {
	return BottomAppBar(
		child: TabBar(
			labelColor: Colors.blue,
			tabs: myTabs,
		),
	);
}