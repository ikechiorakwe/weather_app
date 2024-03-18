import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constant.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherLoading());
      try {
        WeatherFactory wf = WeatherFactory(apiKey);       
        Weather weather = await wf.currentWeatherByLocation(event.position.latitude, event.position.longitude);
        debugPrint("get the $weather");
        emit( WeatherSucces(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
  }
}
