import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Extract plain string from a widget (e.g. Text widget inside Row, Container, etc.)
String _extractTextFromWidget(Widget w) {
  if (w is Text) return w.data ?? '';
  if (w is Row) return w.children.map(_extractTextFromWidget).join(' ');
  if (w is Column) return w.children.map(_extractTextFromWidget).join(' ');
  if (w is Flexible) return _extractTextFromWidget(w.child);
  if (w is Expanded) return _extractTextFromWidget(w.child);
  if (w is Container && w.child != null) return _extractTextFromWidget(w.child!);
  if (w is Padding && w.child != null) return _extractTextFromWidget(w.child!);
  if (w is Align && w.child != null) return _extractTextFromWidget(w.child!);
  if (w is Center && w.child != null) return _extractTextFromWidget(w.child!);
  if (w is SizedBox && w.child != null) return _extractTextFromWidget(w.child!);
  return '';
}

String? _getCharFromEvent(KeyEvent event) {
  if (event is! KeyDownEvent && event is! KeyRepeatEvent) return null;

  final char = event.character;
  if (char != null && char.isNotEmpty && char.trim().isNotEmpty) {
    return char;
  }

  final label = event.logicalKey.keyLabel;
  if (label.length == 1 && RegExp(r'[a-zA-Z0-9]').hasMatch(label)) {
    return label;
  }
  return null;
}

/// A FormField dropdown wrapper supporting letter-key cycling both when closed and when open.
class KeyCycleDropdownFormField<T> extends StatefulWidget {
  final T? value;
  final T? initialValue;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final InputDecoration? decoration;
  final Widget? hint;
  final Widget? disabledHint;
  final DropdownButtonBuilder? selectedItemBuilder;
  final int elevation;
  final TextStyle? style;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? dropdownColor;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;
  final String Function(DropdownMenuItem<T> item)? getItemLabel;

  const KeyCycleDropdownFormField({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.initialValue,
    this.decoration,
    this.hint,
    this.disabledHint,
    this.selectedItemBuilder,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = true,
    this.isExpanded = true,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.validator,
    this.onSaved,
    this.getItemLabel,
  }) : super(key: key);

  @override
  State<KeyCycleDropdownFormField<T>> createState() => _KeyCycleDropdownFormFieldState<T>();
}

class _KeyCycleDropdownFormFieldState<T> extends State<KeyCycleDropdownFormField<T>> {
  final LayerLink _layerLink = LayerLink();
  FocusNode? _internalFocusNode;
  final FocusNode _overlayFocusNode = FocusNode(debugLabel: 'KeyCycleDropdownFormFieldOverlay');
  OverlayEntry? _overlayEntry;
  final ScrollController _scrollController = ScrollController();

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  T? get _effectiveValue => widget.value ?? widget.initialValue;

  @override
  void dispose() {
    _removeOverlay();
    _scrollController.dispose();
    _internalFocusNode?.dispose();
    _overlayFocusNode.dispose();
    super.dispose();
  }

  String _getItemString(DropdownMenuItem<T> item) {
    if (widget.getItemLabel != null) {
      return widget.getItemLabel!(item);
    }
    final extracted = _extractTextFromWidget(item.child).trim();
    if (extracted.isNotEmpty) return extracted;
    return item.value?.toString() ?? '';
  }

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      const itemEstimateHeight = 42.0;
      final targetScroll = (index * itemEstimateHeight).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    }
  }

  void _cycleKey(String char) {
    if (widget.onChanged == null || widget.items.isEmpty) return;
    final charLower = char.toLowerCase();

    final matchingIndices = <int>[];
    for (int i = 0; i < widget.items.length; i++) {
      final label = _getItemString(widget.items[i]).trim();
      if (label.isNotEmpty && label.toLowerCase().startsWith(charLower)) {
        matchingIndices.add(i);
      }
    }

    if (matchingIndices.isEmpty) return;

    final currentValue = _effectiveValue;
    final currentIndexInMatching = matchingIndices.indexWhere(
      (idx) => widget.items[idx].value == currentValue,
    );

    int targetItemIndex;
    if (currentIndexInMatching != -1) {
      final nextMatching = (currentIndexInMatching + 1) % matchingIndices.length;
      targetItemIndex = matchingIndices[nextMatching];
    } else {
      targetItemIndex = matchingIndices[0];
    }

    final selectedItem = widget.items[targetItemIndex];
    widget.onChanged?.call(selectedItem.value);

    if (mounted) {
      setState(() {});
    }
    _overlayEntry?.markNeedsBuild();
    _scrollToIndex(targetItemIndex);
  }

  KeyEventResult _handleClosedKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space || key == LogicalKeyboardKey.arrowDown) {
      _toggleOverlay();
      return KeyEventResult.handled;
    }

    final char = _getCharFromEvent(event);
    if (char != null) {
      _cycleKey(char);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  KeyEventResult _handleOverlayKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape) {
      _removeOverlay();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
      _removeOverlay();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      _navigateIndex(1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      _navigateIndex(-1);
      return KeyEventResult.handled;
    }

    final char = _getCharFromEvent(event);
    if (char != null) {
      _cycleKey(char);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _navigateIndex(int delta) {
    if (widget.items.isEmpty || widget.onChanged == null) return;
    final currentIndex = widget.items.indexWhere((item) => item.value == _effectiveValue);
    int nextIndex;
    if (currentIndex == -1) {
      nextIndex = 0;
    } else {
      nextIndex = (currentIndex + delta).clamp(0, widget.items.length - 1);
    }
    final selectedItem = widget.items[nextIndex];
    widget.onChanged?.call(selectedItem.value);
    if (mounted) {
      setState(() {});
    }
    _overlayEntry?.markNeedsBuild();
    _scrollToIndex(nextIndex);
  }

  void _toggleOverlay() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;
    final selectedIndex = widget.items.indexWhere((item) => item.value == _effectiveValue);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _removeOverlay,
                child: const SizedBox.expand(),
              ),
            ),
            Positioned(
              width: size.width < 200 ? 200 : size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Focus(
                  focusNode: _overlayFocusNode,
                  autofocus: true,
                  onKeyEvent: (node, event) => _handleOverlayKeyEvent(event),
                  child: Material(
                    elevation: widget.elevation.toDouble(),
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                    color: widget.dropdownColor ?? Colors.white,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.menuMaxHeight ?? 260,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        color: widget.dropdownColor ?? Colors.white,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final isSelected = item.value == _effectiveValue;
                          return InkWell(
                            onTap: () {
                              widget.onChanged?.call(item.value);
                              _removeOverlay();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              color: isSelected ? Colors.blue.shade50 : null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? Colors.blue.shade900 : Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      child: item.child,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _overlayEntry != null) {
        _overlayFocusNode.requestFocus();
        if (selectedIndex != -1) {
          _scrollToIndex(selectedIndex);
        }
      }
    });
  }

  void _removeOverlay() {
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSelectedItemWidget() {
    if (widget.items.isEmpty) {
      return widget.hint ?? const SizedBox();
    }
    final selectedItemIndex = widget.items.indexWhere((item) => item.value == _effectiveValue);
    if (selectedItemIndex != -1) {
      return widget.items[selectedItemIndex].child;
    }
    return widget.hint ?? const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = (widget.decoration ?? const InputDecoration(border: OutlineInputBorder())).copyWith(
      suffixIcon: widget.icon ?? const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
      isDense: widget.isDense,
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        focusNode: _effectiveFocusNode,
        autofocus: widget.autofocus,
        onKeyEvent: (node, event) => _handleClosedKeyEvent(event),
        child: InkWell(
          onTap: widget.onChanged != null ? _toggleOverlay : null,
          child: InputDecorator(
            decoration: effectiveDecoration,
            child: DefaultTextStyle(
              style: widget.style ?? const TextStyle(fontSize: 14, color: Colors.black87),
              child: _buildSelectedItemWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

/// A DropdownButton wrapper supporting letter-key cycling both when closed and when open.
class KeyCycleDropdownButton<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;
  final Widget? disabledHint;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Widget? underline;
  final int elevation;
  final TextStyle? style;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? dropdownColor;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final String Function(DropdownMenuItem<T> item)? getItemLabel;

  const KeyCycleDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.disabledHint,
    this.selectedItemBuilder,
    this.underline,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.getItemLabel,
  }) : super(key: key);

  @override
  State<KeyCycleDropdownButton<T>> createState() => _KeyCycleDropdownButtonState<T>();
}

class _KeyCycleDropdownButtonState<T> extends State<KeyCycleDropdownButton<T>> {
  final LayerLink _layerLink = LayerLink();
  FocusNode? _internalFocusNode;
  final FocusNode _overlayFocusNode = FocusNode(debugLabel: 'KeyCycleDropdownButtonOverlay');
  OverlayEntry? _overlayEntry;
  final ScrollController _scrollController = ScrollController();

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  @override
  void dispose() {
    _removeOverlay();
    _scrollController.dispose();
    _internalFocusNode?.dispose();
    _overlayFocusNode.dispose();
    super.dispose();
  }

  String _getItemString(DropdownMenuItem<T> item) {
    if (widget.getItemLabel != null) {
      return widget.getItemLabel!(item);
    }
    final extracted = _extractTextFromWidget(item.child).trim();
    if (extracted.isNotEmpty) return extracted;
    return item.value?.toString() ?? '';
  }

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      const itemEstimateHeight = 42.0;
      final targetScroll = (index * itemEstimateHeight).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    }
  }

  void _cycleKey(String char) {
    if (widget.onChanged == null || widget.items.isEmpty) return;
    final charLower = char.toLowerCase();

    final matchingIndices = <int>[];
    for (int i = 0; i < widget.items.length; i++) {
      final label = _getItemString(widget.items[i]).trim();
      if (label.isNotEmpty && label.toLowerCase().startsWith(charLower)) {
        matchingIndices.add(i);
      }
    }

    if (matchingIndices.isEmpty) return;

    final currentValue = widget.value;
    final currentIndexInMatching = matchingIndices.indexWhere(
      (idx) => widget.items[idx].value == currentValue,
    );

    int targetItemIndex;
    if (currentIndexInMatching != -1) {
      final nextMatching = (currentIndexInMatching + 1) % matchingIndices.length;
      targetItemIndex = matchingIndices[nextMatching];
    } else {
      targetItemIndex = matchingIndices[0];
    }

    final selectedItem = widget.items[targetItemIndex];
    widget.onChanged?.call(selectedItem.value);

    if (mounted) {
      setState(() {});
    }
    _overlayEntry?.markNeedsBuild();
    _scrollToIndex(targetItemIndex);
  }

  KeyEventResult _handleClosedKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space || key == LogicalKeyboardKey.arrowDown) {
      _toggleOverlay();
      return KeyEventResult.handled;
    }

    final char = _getCharFromEvent(event);
    if (char != null) {
      _cycleKey(char);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  KeyEventResult _handleOverlayKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape) {
      _removeOverlay();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
      _removeOverlay();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      _navigateIndex(1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      _navigateIndex(-1);
      return KeyEventResult.handled;
    }

    final char = _getCharFromEvent(event);
    if (char != null) {
      _cycleKey(char);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _navigateIndex(int delta) {
    if (widget.items.isEmpty || widget.onChanged == null) return;
    final currentIndex = widget.items.indexWhere((item) => item.value == widget.value);
    int nextIndex;
    if (currentIndex == -1) {
      nextIndex = 0;
    } else {
      nextIndex = (currentIndex + delta).clamp(0, widget.items.length - 1);
    }
    final selectedItem = widget.items[nextIndex];
    widget.onChanged?.call(selectedItem.value);
    if (mounted) {
      setState(() {});
    }
    _overlayEntry?.markNeedsBuild();
    _scrollToIndex(nextIndex);
  }

  void _toggleOverlay() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;
    final selectedIndex = widget.items.indexWhere((item) => item.value == widget.value);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _removeOverlay,
                child: const SizedBox.expand(),
              ),
            ),
            Positioned(
              width: size.width < 200 ? 200 : size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Focus(
                  focusNode: _overlayFocusNode,
                  autofocus: true,
                  onKeyEvent: (node, event) => _handleOverlayKeyEvent(event),
                  child: Material(
                    elevation: widget.elevation.toDouble(),
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                    color: widget.dropdownColor ?? Colors.white,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.menuMaxHeight ?? 260,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        color: widget.dropdownColor ?? Colors.white,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final isSelected = item.value == widget.value;
                          return InkWell(
                            onTap: () {
                              widget.onChanged?.call(item.value);
                              _removeOverlay();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              color: isSelected ? Colors.blue.shade50 : null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: isSelected ? Colors.blue.shade900 : Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      child: item.child,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _overlayEntry != null) {
        _overlayFocusNode.requestFocus();
        if (selectedIndex != -1) {
          _scrollToIndex(selectedIndex);
        }
      }
    });
  }

  void _removeOverlay() {
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSelectedItemWidget() {
    if (widget.items.isEmpty) {
      return widget.hint ?? const SizedBox();
    }
    final selectedItemIndex = widget.items.indexWhere((item) => item.value == widget.value);
    if (selectedItemIndex != -1) {
      return widget.items[selectedItemIndex].child;
    }
    return widget.hint ?? const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        focusNode: _effectiveFocusNode,
        autofocus: widget.autofocus,
        onKeyEvent: (node, event) => _handleClosedKeyEvent(event),
        child: InkWell(
          onTap: widget.onChanged != null ? _toggleOverlay : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle(
                style: widget.style ?? const TextStyle(fontSize: 13, color: Colors.black87),
                child: _buildSelectedItemWidget(),
              ),
              const SizedBox(width: 4),
              widget.icon ?? const Icon(Icons.arrow_drop_down, color: Colors.blueAccent, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
