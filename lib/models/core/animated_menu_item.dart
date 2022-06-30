class AnimatedMenuItem {
  AnimatedMenuItem({required this.content, this.isSelected = false});

  String content;
  bool isSelected;

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
