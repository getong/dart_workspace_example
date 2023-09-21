Stream<int> boatStream() async* {
  for(int i = 1; i<=10;i++){
    print("SENT boat no. " + i.toString());
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  Stream<int> stream = boatStream();

  stream.listen((receivedData){
      print("RECEIVED boat no." + receivedData.toString());
  });
}
