part of 'network_bloc.dart';

@immutable
abstract class NetworkState {
  final ConnectivityResult connectivityResult;

  NetworkState({this.connectivityResult});
}
class NetWorkInitial extends NetworkState {

  NetWorkInitial()
      : super(connectivityResult: ConnectivityResult.none);
}

class NetWorkChange extends NetworkState {
  final ConnectivityResult connectivityResult;

  NetWorkChange(this.connectivityResult)
      : super(connectivityResult: connectivityResult);
}
