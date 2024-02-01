import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteRepository {
  Dio getDioClient() {
    Dio client = Dio();
    return client;
  }
}
