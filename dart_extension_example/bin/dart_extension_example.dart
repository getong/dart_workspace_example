extension StringExtensions on String {
  int countWords() {
    return this.split(' ').length;
  }
}

void main() {
  String text = "Hello, world!";
  int wordCount = text.countWords();
  print("Word count: $wordCount"); // Output: Word count: 2
}
