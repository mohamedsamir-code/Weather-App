import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState>{
  WeatherCubit(this.weatherServices):super(WeatherInitial());
  String? cityName;
  WeatherModel? weatherModel;
  WeatherServices weatherServices;
  void getWeather({required String cityName}) async{
    emit(WeatherLoading());
    try {
      weatherModel = await weatherServices.getWeather(cityName: cityName);
      emit(WeatherSuccess());
    } catch(e){
      emit(WeatherFailure());
    }
  }


}