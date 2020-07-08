class Quote {

  String text;

  String author;

  Quote({this.text , this.author});

  get getText =>  text;

  set setText(text) {this.text = text;}

  get getAuthor =>  author;

  set setAuthor(author) {this.author = author;}
}