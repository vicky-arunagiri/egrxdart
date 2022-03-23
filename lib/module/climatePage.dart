import 'package:egrxdart/bloc/climate_bloc.dart';
import 'package:egrxdart/model/climateModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClimatePage extends StatefulWidget {
  const ClimatePage({Key? key}) : super(key: key);

  @override
  _ClimatePageState createState() => _ClimatePageState();
}

class _ClimatePageState extends State<ClimatePage> {
  final climateBloc = ClimateBloc();

  @override
  void initState() {
    setState(() {
      climateBloc.fetchClimateResponse();
    });
    super.initState();
  }

  @override
  void dispose() {
    climateBloc.dispose();
    print('close stream');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ClimateModel>(
        stream: climateBloc.climateStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _buildWeatherScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Container _buildWeatherScreen(ClimateModel data) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTitle(data.name),
          _buildCoord(data.coord),
          _buildMain(data.main),
          _buildWindInfo(data.wind),
          _buildSys(data.sys),
        ],
      ),
    );
  }

  Center _buildTitle(String name) {
    return Center(
      child: Text(
        "Weather in " + name,
        style: const TextStyle(
            color: Color.fromRGBO(0, 123, 174, 100), fontSize: 40.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Column _buildCoord(Coord coord) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            "Coord",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Lat: " + coord.lat.toString()),
            _buildVerticalDivider(),
            Text("Lng: " + coord.lon.toString())
          ],
        ),
      ],
    );
  }

  Column _buildMain(Main main) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            "Main",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Text("Temperature: " + main.temp.toString()),
        Text("Pressure: " + main.pressure.toString()),
        Text("Humidity: " + main.humidity.toString()),
        Text("Highest temperature: " + main.tempMax.toString()),
        Text("Lowest temperature: " + main.tempMin.toString()),
      ],
    );
  }

  Column _buildWindInfo(Wind wind) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            "Wind",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Speed: " + wind.speed.toString()),
            _buildVerticalDivider(),
            Text("Degree: " + wind.deg.toString()),
          ],
        )
      ],
    );
  }

  Container _buildVerticalDivider() {
    return Container(
        height: 20, child: const VerticalDivider(color: Colors.blueGrey));
  }

  Column _buildSys(Sys sys) {
    final dateFormat = new DateFormat('hh:mm:ss');

    var sunriseDate =
        new DateTime.fromMillisecondsSinceEpoch(sys.sunrise * 1000);
    var sunsetDate = new DateTime.fromMillisecondsSinceEpoch(sys.sunset * 1000);
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            "Sys",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Sunrise: " + dateFormat.format(sunriseDate)),
            _buildVerticalDivider(),
            Text("Sunset: " + dateFormat.format(sunsetDate)),
          ],
        ),
      ],
    );
  }
}
