import 'package:bloc_patterndemo2/ImageApi.dart';
import 'package:bloc_patterndemo2/ImageModel.dart';
import 'package:rxdart/rxdart.dart';

class ImageBloc {
  final ImageAPI api;

  Stream<List<Images>> _images = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>(maxSize: 2);

  Stream<List<Images>> get images => _images;
  Sink<String> get query => _query;

  ImageBloc(this.api) {
    _images = _query.asyncMap(api.makeRequest).asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}
