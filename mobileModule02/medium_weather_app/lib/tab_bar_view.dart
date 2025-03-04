import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
import 'weather_tab.dart';
import 'provider.dart';
import 'package:provider/provider.dart';

class Coordinates {
	final double lat;
	final double lon;

	Coordinates({required this.lat, required this.lon});

	@override
	String toString() => "Coordinates(lat: $lat, lon: $lon)";
}

class WeatherData {
	final String city;
	final String temp;
	final String windSpeed;

	WeatherData({required this.city, required this.temp, required this.windSpeed});

	// Metodo di fallback in caso di errore
	factory WeatherData.error(String city) {
		return WeatherData(city: city, temp: '', windSpeed: "Errore nel recupero dei dati");
	}

	@override
	String toString() => "WeatherData(city: $city, temp: $temp°C, desc: $windSpeed)";
}


class MyTabBarView extends StatefulWidget {
	final List<Tab> myTabs;
	final String location;

	const MyTabBarView(
	{
		super.key,
		required this.myTabs,
		required this.location,
	});

	@override
	_MyTabBarViewState createState() => _MyTabBarViewState();
}


class _MyTabBarViewState extends State<MyTabBarView> with SingleTickerProviderStateMixin {
	late TabController _tabController;
	final List<List<WeatherData>> _weatherDataList = [];
	// late String currentLocation;
	String currentTab = '';

	Future<Coordinates> fetchCoordinates() async {

		final searchProvider = Provider.of<SearchProvider>(context, listen: false);
		if (searchProvider.location.isEmpty)
		{
			return Coordinates(lat: 0, lon: 0);
		}
		final locationFull = searchProvider.location;

    debugPrint('bbbbbbbbbb');

		List<String> data = locationFull.split(',').map((s) => s.trim()).toList();
    debugPrint('bbbbbbbbbccccccccccb');
    if (data.length < 3) {
      debugPrint('Error: locationFull does not contain enough elements');
      return Coordinates(lat: 0, lon: 0);
  }

		String location = data[0];
    debugPrint('bbbbbbbbbc222cccccccccb');
		String country = data[1];
    debugPrint('bbbbbbbbbc2222233333cccccccccb');
		String countryCode = data[2];
    debugPrint('bbbbbbbbbc22222333335555cccccccccb');

		String baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

		String url = '$baseUrl?name=$location';

		final response = await http.get(Uri.parse(url));
		if (response.statusCode == 200) {
			var data = jsonDecode(response.body);
			var res = data['results'];

			if (res != null)
			{
				for (var x in res) {
					if (x['country'] == country && x['country_code'] == countryCode)
					{
						Coordinates coords = Coordinates(lat: x['latitude'].toDouble(), lon: x['longitude'].toDouble());
						return coords;
					}
				}
				return Coordinates(lat: 0, lon: 0);
			}
		} 
		else {
			print("Failed to fetch data: ${response.statusCode}");
		}
		return Coordinates(lat: 0, lon: 0);
	}

	Future<List<List<WeatherData>>> fetchWeaterOnCoordinates(Coordinates coords, String? currentTab) async
	{
		String location = widget.location.split(',')[0];
		String baseUrl = 'https://api.open-meteo.com/v1/forecast';
		String tabQuery = '';
		String format = '';
		List<List<WeatherData>> result = [[], [], []];
		debugPrint('result0: asfasfasf');
		debugPrint('result0: asfasfasf');
		debugPrint('result0: ${result[0]}');
		debugPrint('result1: ${result[1]}');
		debugPrint('result2: ${result[2]}');

		List<String> tabsNames = ['Currently', 'Today', 'Weekly'];
		List<String> formatNames = ['current', 'hourly', 'daily'];
		List<List<String>> paramNames = [['weather_code', 'temperature_2m', 'wind_speed_10m'], ['weather_code', 'temperature_2m', 'wind_speed_10m'], ['weather_code', 'temperature_2m_max', 'temperature_2m_min']];
		List<String> tabQueryNames = ['&${formatNames[0]}=${paramNames[0][0]},${paramNames[0][1]},${paramNames[0][2]}', '&${formatNames[1]}=${paramNames[1][0]},${paramNames[1][1]},${paramNames[1][2]}', '&${formatNames[2]}=${paramNames[2][0]},${paramNames[2][1]},${paramNames[2][2]}'];


		for (int i = 0; i < 3; i++)
		{
			currentTab = tabsNames[i];
			format = formatNames[i];
			tabQuery = tabQueryNames[i];
			String url = '$baseUrl?latitude=${coords.lat}&longitude=${coords.lon}$tabQuery';

			final response = await http.get(Uri.parse(url));
			if (response.statusCode == 200) {
				var data = jsonDecode(response.body);
				var res = data[format];
				debugPrint('res: $res');

				if (res != null)
				{
					if (location.isNotEmpty)
					{
						if (i == 0)
						{
							result[i].add(
								WeatherData(city: location, temp: res[paramNames[i][1]].toString(), windSpeed: res[paramNames[i][2]].toString()));
						}
						else
						{
							for (int j = 0; j < res['time'].length; ++j)
							{
								result[i].add(
									WeatherData(city: location, temp: res[paramNames[i][1]][j].toString(), windSpeed: res[paramNames[i][2]][j].toString()));
							}
						}
					}
				}
			}
		} 
		return result;
	}

	void fetchWeatherDataTab(String? currentTab) async {
		List<List<WeatherData>> weatherList = [];
		Coordinates coordinates = await fetchCoordinates();

		weatherList = await fetchWeaterOnCoordinates(coordinates, currentTab);
	
		if (!mounted) return;
		Provider.of<SearchProvider>(context, listen: false).updateWeatherData(weatherList);
	}



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.myTabs.length, vsync: this);
	// currentLocation = widget.location;
  }

	@override
		void didUpdateWidget(covariant MyTabBarView oldWidget) {
		super.didUpdateWidget(oldWidget);

		// Se la location è cambiata, fai un nuovo fetch
		if (widget.location != oldWidget.location) {
			fetchWeatherDataTab(widget.myTabs[_tabController.index].text);
		}
	}

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
	return Column(
		children: [
		Expanded(
			child: TabBarView(
			controller: _tabController,
			children: widget.myTabs.map((Tab tab) {
			return Center(
				child: Consumer<SearchProvider>(
				builder: (context, searchProvider, child) {
					final weatherDataList = searchProvider.weatherDataList;

					// Mostra i dati se disponibili, altrimenti un messaggio
					if (weatherDataList.isNotEmpty) {
					List<WeatherData> dataToShow;
					if (tab.text == 'Currently') {
						dataToShow = weatherDataList[0];
					} else if (tab.text == 'Today') {
						dataToShow = weatherDataList[1];
					} else if (tab.text == 'Weekly') {
						dataToShow = weatherDataList[2];
					} else {
						dataToShow = [];
					}

					return ListView.builder(
						itemCount: dataToShow.length,
						itemBuilder: (context, index) {
						final weatherData = dataToShow[index];
						return ListTile(
							title: Text(weatherData.city),
							subtitle: Text('Temp: ${weatherData.temp}°C, Wind: ${weatherData.windSpeed}'),
						);
						},
					);
					} else {
					return Text('${widget.location} + tutte le cazzo di tab ${tab.text}');
					}
				},
				),
			);
			}).toList(),
			),
		),
		TabBar(
			controller: _tabController,
			labelColor: Colors.blue,
			tabs: widget.myTabs,
		),
		],
	);
	}
}
