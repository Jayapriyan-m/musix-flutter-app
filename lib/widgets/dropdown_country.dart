import 'package:flutter/material.dart';

// Custom dropdown code got from official Flutter web
class DropdownCountry<T> extends StatefulWidget {
  final Widget child;
  final void Function(T) onChange;
  T selectedValue;
  final List<DropdownItem<T>> items;
  final DropdownStyle dropdownStyle;
  final DropdownButtonStyle dropdownButtonStyle;
  final Icon? icon;
  final bool hideIcon;
  final bool leadingIcon;
  final bool showSearchBox;

  DropdownCountry({
    Key? key,
    this.hideIcon = false,
    required this.child,
    required this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    required this.onChange,
    required this.selectedValue,
    this.showSearchBox = true,
  }) : super(key: key);

  @override
  State<DropdownCountry<T>> createState() => _DropdownCountryState<T>();
}

class _DropdownCountryState<T> extends State<DropdownCountry<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController = ScrollController();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  late TextEditingController _searchController;
  List<DropdownItem<T>> _filteredItems = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /* void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) =>
              item.child.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  } */

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items.where((item) {
        final text = item.child is Text
            ? (item.child as Text).data
            : item.child.toString();
        return text!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: style.width,
        height: style.height,
        padding: style.padding,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: InkWell(
          onTap: _toggleDropdown,
          child: Row(
            mainAxisAlignment:
            style.mainAxisAlignment ?? MainAxisAlignment.start,
            textDirection:
            widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  width: 96,
                  child: Text(
                    widget.selectedValue.toString(),
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
              Spacer(),
              if (!widget.hideIcon)
                RotationTransition(
                  turns: _rotateAnimation,
                  child: widget.icon ??
                      RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 13,
                          color: Colors.white,
                        ),
                      ),
                ),
              SizedBox(
                width: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle.width ?? size.width,
                child: CompositedTransformFollower(
                  offset:
                  widget.dropdownStyle.offset ?? Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle.elevation ?? 0,
                    color: widget.dropdownStyle.color,
                    shape: widget.dropdownStyle.shape,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle.constraints ??
                            BoxConstraints(
                              maxHeight: (MediaQuery.of(context).size.height -
                                  topOffset -
                                  15)
                                  .clamp(0.0, double.infinity),
                            ),
                        child: Column(
                          children: [
                            if (widget
                                .showSearchBox) // Conditionally show search box
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Container(
                                  height: 40,
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: _filterItems,
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: RawScrollbar(
                                thumbVisibility: true,
                                thumbColor:
                                widget.dropdownStyle.scrollbarColor ??
                                    Colors.grey,
                                controller: _scrollController,
                                child: ListView.builder(
                                  padding: widget.dropdownStyle.padding ??
                                      EdgeInsets.zero,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: _filteredItems.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => _selectItem(
                                          _filteredItems[index].value),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          _filteredItems[index].child,
                                          Divider(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }

  void _selectItem(T value) {
    setState(() {
      widget.selectedValue = value;
    });
    widget.onChange(value);
    _toggleDropdown();
  }
}

class DropdownItem<T> {
  final T value;
  final Widget child;

  DropdownItem({required this.value, required this.child});
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;

  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation = 0,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color? scrollbarColor;
  final ShapeBorder? shape;
  final Offset? offset;
  final double? width;

  const DropdownStyle({
    this.elevation,
    this.color,
    this.padding,
    this.constraints,
    this.scrollbarColor,
    this.shape,
    this.offset,
    this.width,
  });
}
