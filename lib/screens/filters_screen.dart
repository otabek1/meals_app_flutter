import 'package:flutter/material.dart';
import '/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final void Function(Map<String, bool>) saveFilters;
  Map<String?, bool?>? currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

Widget _buildSwtichTile(String title, String description, bool currentValue,
    void Function(bool)? update) {
  return SwitchListTile(
    value: currentValue,
    onChanged: update,
    title: Text(title),
    subtitle: Text(description),
  );
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters!["gluten"] as bool;
    _lactoseFree = widget.currentFilters!["lactose"] as bool;
    _vegan = widget.currentFilters!["vegan"] as bool;
    _vegetarian = widget.currentFilters!["vegetarian"] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  "gluten": _glutenFree,
                  "lactose": _lactoseFree,
                  "vegan": _vegan,
                  "vegetarian": _vegetarian
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwtichTile(
                    "Gluteen-Free", "Shows only glutin-free meals", _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwtichTile("Lactose-Free",
                    "Shows only lactose-free meals", _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwtichTile(
                    "Vegetarian", "Shows only vegetarian meals", _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwtichTile("Vegan", "Shows only vegan meals", _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                    print(newValue);
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
