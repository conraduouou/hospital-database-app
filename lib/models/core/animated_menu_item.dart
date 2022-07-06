class AnimatedMenuItem {
  AnimatedMenuItem(
      {required this.content, this.isSelected = false, this.isHovered = false});

  String content;
  bool isSelected;
  bool isHovered;

  void toggleSelected() {
    isSelected = !isSelected;
  }

  void toggleHovered() {
    isHovered = !isHovered;
  }
}
