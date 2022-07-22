import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({
    Key? key,
    required this.text,
    this.onTap,
    this.onHover,
    this.color,
    this.textColor,
    this.hoverColor,
    this.enabled = true,
    this.showDropdown = true,
    this.width,
    this.items,
    this.itemsHeading,
    this.overlayTap,
  }) : super(key: key);

  final String text;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onHover;
  final bool enabled;
  final bool showDropdown;
  final double? width;
  final void Function(int)? overlayTap;

  /// The `String` items that will be viewed in the dropdown. If enabled is
  /// true, this must not be null.
  final List<AnimatedMenuItem>? items;

  /// The heading that informs what the items are. This is shown in conjunction
  /// with the first element of `items` and therefore will not show if it is
  /// empty. If enabled is true, this must not be null.
  final String? itemsHeading;

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;

  bool _isHovered = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: kGrayColor,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: widget.items!.length < 5 ? null : 200,
              child: ListView.builder(
                shrinkWrap: widget.items!.length < 5,
                itemCount: widget.items!.length,
                itemBuilder: (context, index) => index == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                widget.itemsHeading!,
                                style: kBoldStyle.copyWith(
                                  fontSize: kRegularSize - 4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          OverlayItem(
                            text: widget.items![index].content,
                            isSelected: widget.items![index].isSelected,
                            onTap: () {
                              _focusNode.unfocus();

                              if (widget.overlayTap != null) {
                                widget.overlayTap!(index);
                              }
                            },
                          )
                        ],
                      )
                    : OverlayItem(
                        text: widget.items![index].content,
                        isSelected: widget.items![index].isSelected,
                        onTap: () {
                          _focusNode.unfocus();

                          if (widget.overlayTap != null) {
                            widget.overlayTap!(index);
                          }
                        },
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: (value) {
        if (!widget.enabled) {
          _focusNode.unfocus();
        }
      },
      child: InkWell(
        onTap: widget.enabled
            ? () {
                if (_focusNode.hasFocus) {
                  _focusNode.unfocus();
                } else {
                  _focusNode.requestFocus();
                }

                if (widget.onTap != null) widget.onTap!();
              }
            : null,
        onHover: (isHovered) {
          setState(() {
            _isHovered = isHovered;
          });

          if (widget.onHover != null) {
            widget.onHover!();
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            width: widget.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.hoverColor ?? kGrayColor
                  : widget.color ?? kLightGrayColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: kBoldStyle.copyWith(
                    fontSize: kRegularSize,
                    color: widget.textColor ?? Colors.black,
                  ),
                ),
                widget.showDropdown
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SvgPicture.asset(
                          'assets/dropdown.svg',
                          color: kDarkGrayColor,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Especially made for the custom Dropdown overlay. Makes use of the
/// `AnimatedMenuItem` class for state management of this widget's `isSelected`
/// feature.
class OverlayItem extends StatefulWidget {
  const OverlayItem({
    Key? key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<OverlayItem> createState() => _OverlayItemState();
}

class _OverlayItemState extends State<OverlayItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () {},
      onHover: (isHovered) {
        setState(() {
          _isHovered = isHovered;
        });
      },
      child: Container(
        color: _isHovered || widget.isSelected
            ? kDarkGrayColor.withOpacity(0.2)
            : kGrayColor,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Text(
              widget.text,
              style: kBoldStyle.copyWith(
                fontSize: kRegularSize - 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
