import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionCheckProvider extends ChangeNotifier{

  bool _isConnectedToInternet=true;
  bool get isConnectedToInternet=> _isConnectedToInternet;

  StreamSubscription? _streamSubscription;
  StreamSubscription get streamSubscription=> _streamSubscription!;


  InternetConnectionCheckProvider(){
    startListening();
  }

  void startListening(){
    _streamSubscription=InternetConnection().onStatusChange.listen((event){
      _isConnectedToInternet = event == InternetStatus.connected;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription!.cancel();
    super.dispose();
  }


}