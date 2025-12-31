import 'package:flutter/material.dart';
import '../models/delegate_filter.dart';

class DelegateFilterDialog extends StatefulWidget {
  final DelegateFilter currentFilter;
  final Function(DelegateFilter) onApplyFilter;

  const DelegateFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onApplyFilter,
  });

  @override
  State<DelegateFilterDialog> createState() => _DelegateFilterDialogState();
}

class _DelegateFilterDialogState extends State<DelegateFilterDialog> {
  late TextEditingController _searchController;
  late int _orderBy;
  late String _alphaKey;

  final List<String> _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.currentFilter.searchKey,
    );
    _orderBy = widget.currentFilter.orderBy;
    _alphaKey = widget.currentFilter.alphaKey;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8BC34A),
                  Color(0xFF4CAF50),
                  Color(0xFF2E7D32),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Delegates',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name or company...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sort Order
                  const Text(
                    'Sort Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('A to Z'),
                          leading: Radio<int>(
                            value: 1,
                            groupValue: _orderBy,
                            onChanged: (value) {
                              setState(() {
                                _orderBy = value!;
                              });
                            },
                            activeColor: const Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Z to A'),
                          leading: Radio<int>(
                            value: 2,
                            groupValue: _orderBy,
                            onChanged: (value) {
                              setState(() {
                                _orderBy = value!;
                              });
                            },
                            activeColor: const Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Alphabetical Filter
                  const Text(
                    'Filter by Alphabet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _alphabet.map((letter) {
                      final isSelected = _alphaKey == letter;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _alphaKey = isSelected ? '' : letter;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF4CAF50)
                                  : Colors.grey[300]!,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              letter,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Clear Filter Button
                  if (widget.currentFilter.hasFilters ||
                      _searchController.text.isNotEmpty ||
                      _alphaKey.isNotEmpty ||
                      _orderBy != 1)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _orderBy = 1;
                          _alphaKey = '';
                        });
                      },
                      icon: const Icon(Icons.clear_all),
                      label: const Text('Clear All Filters'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF4CAF50),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Apply Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: ElevatedButton(
              onPressed: () {
                final filter = DelegateFilter(
                  searchKey: _searchController.text.trim(),
                  orderBy: _orderBy,
                  alphaKey: _alphaKey,
                );
                widget.onApplyFilter(filter);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
