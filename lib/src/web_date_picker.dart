import 'package:flutter/material.dart';
import 'datetime_extension.dart';
import 'string_extension.dart';

class WebDatePicker extends StatefulWidget {
  const WebDatePicker({
    Key? key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onChange,
    this.style,
    this.width = 200,
    this.height = 36, this.prefix,
  }) : super(key: key);

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?> onChange;
  final TextStyle? style;
  final double width;
  final double height;
  final Widget? prefix;

  @override
  _WebDatePickerState createState() => _WebDatePickerState();
}

class _WebDatePickerState extends State<WebDatePicker> {
  final FocusNode _focusNode = FocusNode();

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  final _controller = TextEditingController();

  final _dateFormat = 'yyyy/MM/dd';

  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  bool _isEnterDateField = false;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.initialDate;
    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2100);

    if (_selectedDate != null) {
      _controller.text = _selectedDate?.parseToString(_dateFormat) ?? '';
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry);
      } else {
        _controller.text = _selectedDate.parseToString(_dateFormat);
        widget.onChange.call(_selectedDate);
        _overlayEntry.remove();
      }
    });
  }

  void onChange(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    _controller.text = _selectedDate.parseToString(_dateFormat);

    _focusNode.unfocus();
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox!.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 5,
            child: SizedBox(
              height: 250,
              child: CalendarDatePicker(
                firstDate: _firstDate,
                lastDate: _lastDate,
                initialDate: _selectedDate ?? DateTime.now(),
                onDateChanged: onChange,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isEnterDateField = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isEnterDateField = false;
          });
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: const OutlineInputBorder(),
              suffixIcon: _buildPrefixIcon(),
              
            ),
            onChanged: (dateString) {
              final date = dateString.parseToDateTime(_dateFormat);
              if (date.isBefore(_firstDate)) {
                _selectedDate = _firstDate;
              } else if (date.isAfter(_lastDate)) {
                _selectedDate = _lastDate;
              } else {
                _selectedDate = date;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    if (_controller.text.isNotEmpty && _isEnterDateField) {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _controller.clear();
          _selectedDate = null;
        },
        splashRadius: 16,
      );
    } else {
      return widget.prefix ?? const Icon(Icons.date_range);
    }
  }
}
