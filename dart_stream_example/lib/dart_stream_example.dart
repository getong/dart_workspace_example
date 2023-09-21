Stream<int> boatStream() async* {
  for(init i = 1; i<=10;i++){
    print("SENT boat no. " + i.toString());
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}


int calculate() async {
  Stream<int> stream = boatStream();
  return 6 * 7;
}
