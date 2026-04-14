// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import '../utility/constants.dart';
//
// class MultiSelectDropDown<T> extends StatelessWidget {
//   final List<T> items;
//   final Function(List<T>) onSelectionChanged;
//   final String Function(T) displayItem;
//   final List<T> selectedItems;
//
//   const MultiSelectDropDown({
//     Key? key,
//     required this.items,
//     required this.onSelectionChanged,
//     required this.displayItem,
//     required this.selectedItems,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2<T>(
//             isExpanded: true,
//             hint: Text(
//               'Select Items',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Theme.of(context).hintColor,
//               ),
//             ),
//             items: items.map((item) {
//               return DropdownMenuItem<T>(
//                 value: item,
//                 // Disable default onTap to avoid closing menu when selecting an item
//                 enabled: false,
//                 child: StatefulBuilder(
//                   builder: (context, menuSetState) {
//                     final isSelected = selectedItems.contains(item);
//                     return InkWell(
//                       onTap: () {
//                         isSelected ? selectedItems.remove(item) : selectedItems.add(item);
//                         onSelectionChanged(selectedItems);
//                         menuSetState(() {});
//                       },
//                       child: Container(
//                         height: double.infinity,
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Row(
//                           children: [
//                             if (isSelected)
//                               const Icon(Icons.check_box_outlined)
//                             else
//                               const Icon(Icons.check_box_outline_blank),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Text(
//                                 displayItem(item),
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }).toList(),
//             // Use last selected item as the current value so if we've limited menu height, it scrolls to the last item.
//             value: selectedItems.isEmpty ? null : selectedItems.last,
//             onChanged: (value) {},
//             selectedItemBuilder: (context) {
//               return items.map(
//                 (item) {
//                   return Container(
//                     alignment: AlignmentDirectional.center,
//                     child: Text(
//                       selectedItems.map(displayItem).join(', '),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       maxLines: 1,
//                     ),
//                   );
//                 },
//               ).toList();
//             },
//             buttonStyleData: ButtonStyleData(
//               padding: EdgeInsets.only(left: 16, right: 8),
//               height: 50,
//               decoration: BoxDecoration(
//                 color: secondaryColor,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 40,
//               padding: EdgeInsets.zero,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../utility/constants.dart';

class MultiSelectDropDown<T> extends StatefulWidget {
  final List<T> items;
  final Function(List<T>) onSelectionChanged;
  final String Function(T) displayItem;
  final List<T> selectedItems;

  const MultiSelectDropDown({
    Key? key,
    required this.items,
    required this.onSelectionChanged,
    required this.displayItem,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<MultiSelectDropDown<T>> createState() => _MultiSelectDropDownState<T>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  // Use a Notifier that matches the expected Iterable type
  late ValueNotifier<List<T>> _selectedItemsNotifier;

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier =
        ValueNotifier<List<T>>(List.from(widget.selectedItems));
  }

  @override
  void didUpdateWidget(MultiSelectDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedItemsNotifier.value = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        // This makes the button "active"
        onChanged: (value) {
          // Leave empty, logic is in InkWell
        },

        // Connect the list of selected values
        multiValueListenable: _selectedItemsNotifier,

        hint: Text(
          'Select Items',
          style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
        ),

        items: widget.items.map((item) {
          return DropdownItem<T>(
            value: item,
            // Keep this true so the row is interactive
            enabled: true,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = _selectedItemsNotifier.value.contains(item);
                return InkWell(
                  onTap: () {
                    final currentList =
                        List<T>.from(_selectedItemsNotifier.value);
                    if (isSelected) {
                      currentList.remove(item);
                    } else {
                      currentList.add(item);
                    }

                    // Update notifier to refresh the field text
                    _selectedItemsNotifier.value = currentList;

                    // Send data back to Provider
                    widget.onSelectionChanged(currentList);

                    // Refresh the checkbox inside the menu
                    menuSetState(() {});
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          color: isSelected ? Colors.blue : Colors.white70,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            widget.displayItem(item),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),

        selectedItemBuilder: (context) {
          // This creates the text that appears on the closed field
          return widget.items.map((item) {
            return Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                _selectedItemsNotifier.value.isEmpty
                    ? 'Select Items'
                    : _selectedItemsNotifier.value
                        .map(widget.displayItem)
                        .join(', '),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            );
          }).toList();
        },

        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 16, right: 8),
          height: 50,
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondaryColor,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.zero,
          // height: 48,
        ),
      ),
    );
  }
}
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import '../utility/constants.dart';
//
// class MultiSelectDropDown<T> extends StatelessWidget {
//   final List<T> items;
//   final Function(List<T>) onSelectionChanged;
//   final String Function(T) displayItem;
//   final List<T> selectedItems;
//
//   const MultiSelectDropDown({
//     Key? key,
//     required this.items,
//     required this.onSelectionChanged,
//     required this.displayItem,
//     required this.selectedItems,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2<T>(
//             isExpanded: true,
//
//             /// Hint
//             hint: Text(
//               'Select Items',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Theme.of(context).hintColor,
//               ),
//             ),
//
//             /// Items
//             items: items.map((item) {
//               return DropdownItem<T>(
//                 value: item,
//                 enabled: false,
//                 child: StatefulBuilder(
//                   builder: (context, menuSetState) {
//                     final isSelected = selectedItems.contains(item);
//
//                     return InkWell(
//                       onTap: () {
//                         if (isSelected) {
//                           selectedItems.remove(item);
//                         } else {
//                           selectedItems.add(item);
//                         }
//
//                         onSelectionChanged(selectedItems);
//                         menuSetState(() {});
//                       },
//                       child: Container(
//                         height: 40,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           children: [
//                             Icon(
//                               isSelected
//                                   ? Icons.check_box_outlined
//                                   : Icons.check_box_outline_blank,
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Text(
//                                 displayItem(item),
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }).toList(),
//
//             /// Required but unused
//             onChanged: (value) {},
//
//             /// Selected text display
//             selectedItemBuilder: (context) {
//               return items.map((item) {
//                 return Container(
//                   alignment: AlignmentDirectional.center,
//                   child: Text(
//                     selectedItems.isEmpty
//                         ? 'Select Items'
//                         : selectedItems.map(displayItem).join(', '),
//                     style: const TextStyle(
//                       fontSize: 14,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     maxLines: 1,
//                   ),
//                 );
//               }).toList();
//             },
//
//             /// Button styling
//             buttonStyleData: ButtonStyleData(
//               padding: const EdgeInsets.only(left: 16, right: 8),
//               height: 50,
//               decoration: BoxDecoration(
//                 color: secondaryColor,
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//
//             /// Dropdown styling
//             dropdownStyleData: DropdownStyleData(
//               maxHeight: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: secondaryColor,
//               ),
//             ),
//
//             /// Menu item styling (fixed)
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.zero,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
