import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/model/weather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  final bloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body:
            BlocProvider(create: (context) => bloc, child: WeatherPageChild()));
  }
}

class WeatherPageChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc , WeatherState>(
      listener: (context, WeatherState state) {
        print("State keeps changing");
      },
      child: BlocBuilder<WeatherBloc , WeatherState>(
        builder: (context, WeatherState state) {
          
          if (state is WeatherInitial) {
            return this.buildCityInputField();
          } else if (state is WeatherLoading) {
            return this.buildLoading();
          } else if (state is WeatherLoaded) {
            return this.buildWeatherData(state.weather);
          }
        },
      ),
    );
  }

  Widget buildLoading() {
    return SpinKitChasingDots(color: Colors.blue);
  }

  Widget buildCityInputField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Enter A City Name",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 20,
        ),
        CityInputField(),
      ],
    );
  }

  Widget buildWeatherData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${weather.temperature.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  const CityInputField({
    Key key,
  }) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(String cityName) {
    WeatherBloc bloc = BlocProvider.of<WeatherBloc>(context);
    bloc.add(GetWeatherEvent(cityName));
  }
}
