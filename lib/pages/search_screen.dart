import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, this.updateUi});

  VoidCallback? updateUi;

  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search a City',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;

              Navigator.pop(context);
            },
            decoration: InputDecoration(
              iconColor: Colors.orange,
              contentPadding: const EdgeInsets.all(30.0),
              border: const OutlineInputBorder(),
              hintText: 'Search a City',
              label: const Text(
                'Search',
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () async {
                  cityName = cityName;
                  BlocProvider.of<WeatherCubit>(context)
                      .getWeather(cityName: cityName!);
                  BlocProvider.of<WeatherCubit>(context).cityName = cityName;

                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
