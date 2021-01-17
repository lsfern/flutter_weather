part of 'network_bloc.dart';

@immutable
abstract class NetworkEvent {
  final ConnectivityResult connectivityResult;

  NetworkEvent(this.connectivityResult);
}

class NetWorkChanged extends NetworkEvent {
  NetWorkChanged(ConnectivityResult connectivityResult)
      : super(connectivityResult);
}
