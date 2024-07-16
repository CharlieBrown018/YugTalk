import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gtext/gtext.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../../Widgets/Drawer_Widget.dart';
import 'ActivityBoards.dart';
import 'package:intl/intl.dart';

class ActivityBoards_Mod extends StatefulWidget {
  const ActivityBoards_Mod({super.key});

  @override
  _ActivityBoards_ModState createState() => _ActivityBoards_ModState();
}

class _ActivityBoards_ModState extends State<ActivityBoards_Mod>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late List<String> categories;
  late List<String> creators;
  String selectedCategory = 'All';
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  List<ActivityBoards> filteredActivityBoards = activityBoardsData;

  @override
  void initState() {
    super.initState();
    categories = _getCategories();
  }

  List<String> _getCategories() {
    Set<String> categorySet = {'All'};
    for (var board in activityBoardsData) {
      categorySet.add(board.boardCategory);
    }
    return categorySet.toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final color = isDarkMode ? const Color.fromRGBO(19, 18, 19, 1.0) : Colors.grey[200];

    return Scaffold(
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Container(
            color: color,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GText(
                    'Create Activity Board',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.displaySmall?.fontSize ?? 18.0,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Theme.of(context).textTheme.displaySmall?.fontSize ?? 16.0,
                      ),
                    ),
                    child: const GText('5 x 3'),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: _buildDropdownButtons(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildActivityBoardList(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildDropdownButton(
            label: 'Category',
            items: categories,
            value: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
                _filterActivityBoards();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownButton(
      {required String label,
        required List<String> items,
        required String value,
        required ValueChanged<String?> onChanged}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: GText(value),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
    );
  }

  void _filterActivityBoards() {
    setState(() {
      filteredActivityBoards = activityBoardsData.where((board) {
        final matchesCategory = selectedCategory == 'All' ||
            board.boardCategory == selectedCategory;
        return matchesCategory;
      }).toList();
    });
  }

  Widget _buildActivityBoardList(BuildContext context) {
    return SearchableList<ActivityBoards>(
      initialList: filteredActivityBoards,
      seperatorBuilder: (context, index) => const Divider(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.displaySmall?.fontSize ?? 16.0,
      ),
      itemBuilder: (activityBoard) {
        return _activityBoardItem(activityBoard);
      },
      emptyWidget: const _EmptyView(),
      inputDecoration: InputDecoration(
        labelText: "Search Activity Boards",
        hintText: "Search boards...",
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.deepPurple,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      filter: (query) {
        // Filter the list based on the search query
        final lowercaseQuery = query.toLowerCase();
        return filteredActivityBoards.where((board) {
          return board.boardName.toLowerCase().contains(lowercaseQuery) ||
              board.boardDescription.toLowerCase().contains(lowercaseQuery) ||
              DateFormat.yMMMd()
                  .format(board.dateCreated)
                  .toLowerCase()
                  .contains(lowercaseQuery) ||
              DateFormat.yMMMd()
                  .format(board.dateModified)
                  .toLowerCase()
                  .contains(lowercaseQuery);
        }).toList();
      },
    );
  }

  Widget _activityBoardItem(ActivityBoards item) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final color = isDarkMode ? const Color.fromRGBO(19, 18, 19, 1.0) : Colors.grey[200];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: ValueKey(item.boardName),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Edit action
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Delete action
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.deepPurple,
                ),
                title: GText(
                  item.boardName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: item.connectedActivityForms.map((form) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: _buildTag(
                            text: form,
                            color: Colors.deepPurple,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    GText('Category: ${item.boardCategory}'),
                    const SizedBox(height: 4),
                    GText('Description: ${item.boardDescription}'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        GText(
                          'Created: ${DateFormat.yMMMd().format(item.dateCreated)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        GText(
                          'Modified: ${DateFormat.yMMMd().format(item.dateModified)}',
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: item.isFavorite
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                  color: Colors.amber,
                  onPressed: () {
                    setState(() {
                      item.isFavorite = !item.isFavorite;
                      // Move the favorited item to the top
                      filteredActivityBoards.remove(item);
                      filteredActivityBoards.insert(0, item);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GText(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          GText('No data found.'),
        ],
      ),
    );
  }
}