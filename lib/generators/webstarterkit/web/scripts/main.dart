import 'dart:html';

main() {
  var navdrawerContainer = querySelector('.navdrawer-container');
  var appbarElement = querySelector('.app-bar');
  var menuBtn = querySelector('.menu');
  var main = querySelector('main');

  closeMenu() {
    document.body.classes.remove('open');
    appbarElement.classes.remove('open');
    navdrawerContainer.classes.remove('open');
  }

  toggleMenu() {
    document.body.classes.toggle('open');
    appbarElement.classes.toggle('open');
    navdrawerContainer.classes.toggle('open');
    navdrawerContainer.classes.add('opened');
  }

  main.onClick.listen((_) => closeMenu());
  menuBtn.onClick.listen((_) => toggleMenu());
  navdrawerContainer.onClick.listen((event) {
    if (event.target.nodeName == 'A' || event.target.nodeName == 'LI') {
      closeMenu();
    }
  });
}