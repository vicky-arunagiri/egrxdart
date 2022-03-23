import 'package:egrxdart/model/climateModel.dart';
import 'package:egrxdart/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class ClimateBloc {
  Repository _repository = Repository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of ClimateModel object and pass it to the UI screen as a stream.
  final _climateSubject = BehaviorSubject<ClimateModel>();

//This method is used to pass the climate response as stream to UI
  Stream<ClimateModel> get climateStream => _climateSubject.stream;

  fetchClimateResponse() async {
    ClimateModel climatemodel = await _repository.fetchClimatedata();
    _climateSubject.sink.add(climatemodel);
  }

  dispose() {
    //Close the weather fetcher
    _climateSubject.close();
  }
}
