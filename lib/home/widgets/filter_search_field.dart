import 'package:flutter/material.dart';

class FilterSearchField<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemToString;
  final String Function(T) itemToId;
  final String? selectedId;
  final String hintText;
  final Function(T) onSelected;

  const FilterSearchField({
    super.key,
    required this.items,
    required this.itemToString,
    required this.itemToId,
    required this.selectedId,
    required this.hintText,
    required this.onSelected,
  });

  @override
  State<FilterSearchField<T>> createState() => _FilterSearchFieldState<T>();
}

class _FilterSearchFieldState<T> extends State<FilterSearchField<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });

    // If there's a selected item, set the text field to show its name
    if (widget.selectedId != null) {
      for (var item in widget.items) {
        if (widget.itemToId(item) == widget.selectedId) {
          _searchController.text = widget.itemToString(item);
          break;
        }
      }
    }
  }

  @override
  void didUpdateWidget(FilterSearchField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller text if selected item changes from outside
    if (widget.selectedId != oldWidget.selectedId) {
      if (widget.selectedId != null) {
        for (var item in widget.items) {
          if (widget.itemToId(item) == widget.selectedId) {
            _searchController.text = widget.itemToString(item);
            break;
          }
        }
      } else {
        _searchController.clear();
      }
    }
  }

  void _searchItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = [];
      } else {
        _filteredItems = widget.items
            .where((item) => widget
                .itemToString(item)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            onChanged: _searchItems,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search, color: Colors.indigo),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        _searchItems('');
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.indigo, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
          ),
        ),
        if (_filteredItems.isNotEmpty)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _filteredItems.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  final itemName = widget.itemToString(item);

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.withOpacity(0.1),
                      child: Text(
                        itemName[0],
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      itemName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      _searchController.text = itemName;
                      widget.onSelected(item);
                      setState(() {
                        _filteredItems = [];
                        _focusNode.unfocus();
                      });
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
