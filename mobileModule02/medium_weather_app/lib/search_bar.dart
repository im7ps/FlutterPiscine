import 'utils.dart' show onTest;
import 'package:flutter/material.dart';
import 'provider.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatefulWidget {
    final TextEditingController controller;

    const MySearchBar(
        {
            super.key,
            required this.controller
        });

    @override
    _MySearchBarState createState() => _MySearchBarState();
}


class _MySearchBarState extends State<MySearchBar> {
	OverlayEntry? _overlayEntry;
	final LayerLink _layerLink = LayerLink();
	List<String> _suggestions = [];


	void showOverlay() {
		// debugPrint('SKibig: $_overlayEntry');
		if (_overlayEntry != null)
		{
			return;
		}
		_overlayEntry = _createOverlayEntry();
		Overlay.of(context).insert(_overlayEntry!);
	}

	void _hideOverlay() {
		_overlayEntry?.remove();
		_overlayEntry = null;
	}



	OverlayEntry _createOverlayEntry() {
		return OverlayEntry(
			builder: (context) {
				return Positioned(
					child: CompositedTransformFollower(
						link: _layerLink,
						offset: Offset(0, 40),
						child: Material(
							elevation: 4,
							child: Column(
								mainAxisSize: MainAxisSize.min,
								children: _suggestions.map((item) => ListTile(
									title: Text(item),
									onTap: () {
										widget.controller.text = item;
                    debugPrint('uu4444444uuuuuuuu');
                    Provider.of<SearchProvider>(context, listen: false).updateLocation(item);
                    debugPrint('uuuuuuuuuu');
										_hideOverlay();
									},
								)).toList(),
							),
						),
					),
				);
			}
		);
	}


	void _updateOverlay() {
    	_overlayEntry?.markNeedsBuild();
	}


	void _handleTextChange() async {
    debugPrint('asdasd');
		if (widget.controller.text.length >= 2) {
			List<String> result = await onTest(widget.controller.text);
			setState(() {
				_suggestions = result;
			});
      debugPrint('Suggestions: $_suggestions');
			_updateOverlay();
		}
	}

	InputDecoration wSearchBarDecoration() {
		return InputDecoration(
			hintText: 'Search city',
		);
	}


	TextField wSearchBar(controller) {
		return TextField(
			controller: controller,
			decoration: wSearchBarDecoration(),
			onTap: () => showOverlay(),
		);
	}

    @override
    void initState() {
      super.initState();
		  widget.controller.addListener(_handleTextChange);
    }

    @override
    void dispose() {
		debugPrint('disposing');
		_hideOverlay();
        widget.controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      // debugPrint('MySearchBar build method called');
        return CompositedTransformTarget(
			link: _layerLink,
			child: GestureDetector(
			    child: wSearchBar(widget.controller),
			),
		);
    }
}

