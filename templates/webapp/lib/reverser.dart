library reverser;

import 'dart:html';

// Example of hooking into the DOM and responding to changes from input fields
initReverser() {
  var output = querySelector('#out');
  var input = querySelector('#name');
  input.onKeyUp.listen((_) {
    output.text = input.value.split('').reversed.join();
  });
}