// WMO Weather interpretation codes (WW)
// Code	Description
// 0	Clear sky
// 1, 2, 3	Mainly clear, partly cloudy, and overcast
// 45, 48	Fog and depositing rime fog
// 51, 53, 55	Drizzle: Light, moderate, and dense intensity
// 56, 57	Freezing Drizzle: Light and dense intensity
// 61, 63, 65	Rain: Slight, moderate and heavy intensity
// 66, 67	Freezing Rain: Light and heavy intensity
// 71, 73, 75	Snow fall: Slight, moderate, and heavy intensity
// 77	Snow grains
// 80, 81, 82	Rain showers: Slight, moderate, and violent
// 85, 86	Snow showers slight and heavy
// 95 *	Thunderstorm: Slight or moderate
// 96, 99 *	Thunderstorm with slight and heavy hail


	// Text currentlyTabInfo(label) {


	// 	return Text('d');
	// }

	// Text todayTabInfo(label) {
	// 	return Text('');
	// }

	// Text weeklyTabInfo(label) {
	// 	return Text('asdasd');
	// }

	// Future<Map> fetchWeaterOnCoordinates(coords) async
	// 	{
	// 		String baseUrl = 'https://api.open-meteo.com/v1/forecast';

	// 		String tabQuery = '';
	// 		if (widget.label == 'currently')
	// 		{
	// 			tabQuery = '&current=temperature_2m,weather_code,wind_speed_10m';
	// 		}	
	// 		else if (widget.label == 'today')
	// 		{
	// 			tabQuery = '&hourly=temperature_2m,weather_code,wind_speed_10m';
	// 		}	
	// 		else if (widget.label == 'weekly')
	// 		{
	// 			tabQuery = '&daily=weather_code,temperature_2m_max,temperature_2m_min';
	// 		}	

	// 		String url = '$baseUrl?latitude=${coords[0]}&longitude=${coords[1]}${tabQuery}';

	// 		final response = await http.get(Uri.parse(url));
	// 		if (response.statusCode == 200) {
	// 			var data = jsonDecode(response.body);
	// 			var res = data['current'];

	// 			if (res != null)
	// 			{
	// 				return res;
	// 			}
	// 		} 
	// 		else {
	// 			print("Failed to fetch data: ${response.statusCode}");
	// 		}
	// 		return {};
	// 	}

	// Future<List<double>> fetchCoordinates() async {

	// 	final searchProvider = Provider.of<SearchProvider>(context, listen: false);
	// 	if (searchProvider.location.isEmpty)
	// 	{
	// 		return [];
	// 	}
	// 	final location_full = searchProvider.location;

	// 	List<String> data = location_full.split(',').map((s) => s.trim()).toList();

	// 	String location = data[0];
	// 	String country = data[1];
	// 	String countryCode = data[2];

	// 	String baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

	// 	String url = '$baseUrl?name=$location';

	// 	final response = await http.get(Uri.parse(url));
	// 	if (response.statusCode == 200) {
	// 		var data = jsonDecode(response.body);
	// 		var res = data['results'];

	// 		if (res != null)
	// 		{
	// 			for (var x in res) {
	// 				if (x['country'] == country && x['country_code'] == countryCode)
	// 				{
	// 					List<double> coords = [x['latitude'].toDouble(), x['longitude'].toDouble()];
	// 					return coords;
	// 				}
	// 			}
	// 			return [];
	// 		}
	// 	} 
	// 	else {
	// 		print("Failed to fetch data: ${response.statusCode}");
	// 	}
	// 	return [];
	// }
