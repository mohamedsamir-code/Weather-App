import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_screen.dart';


class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherSuccess) {
          weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
          return successBody(context);
        } else if (state is WeatherFailure) {
          return Center(
            child: Text('There is no weather, Please search again!'),
          );
        } else {
          return defaultBody();
        }
      }),
      // body: true
      //     ?
      //     :
    );
  }

  Center defaultBody() {
    return Center(
          child: ColoredBox(
            color: Color(0xffffffff),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/weather_.png',
                  ),
                  height: 500,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        );
  }

  Container successBody(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                weatherData!.getThemeColor(),
                weatherData!.getThemeColor()[300]!,
                weatherData!.getThemeColor()[100]!
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(
                flex: 5,
              ),
              Text(
                BlocProvider.of<WeatherCubit>(context).cityName!,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Updated: ${weatherData!.date}',
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage(
                      weatherData!.getImage(),
                    ),
                  ),
                  Text(
                    weatherData!.temp.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'maxTemp :${weatherData!.maxTemp.toInt()}',
                      ),
                      Text(
                        'minTemp :${weatherData!.minTemp.toInt()}',
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                weatherData!.weatherStateName,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        );
  }
}
