import 'dart:html';

void main() {
  var element = new DivElement()
    ..text = "Hello, World!";
  document.body.children.add(element);
}
