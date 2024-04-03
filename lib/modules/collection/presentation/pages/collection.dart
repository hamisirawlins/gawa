import 'package:flutter/material.dart';
import 'package:gawa/constants.dart';
import 'package:gawa/modules/collection/presentation/pages/add_collection.dart';

class CollectionsPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CollectionsPage());
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionsPage> {
  //Views
  final List<Widget> _pageList = <Widget>[
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Discover Product Partnerships"),
    ),
    const Center(
      child: Text("Stats"),
    ),
    const Center(
      child: Text("Profile"),
    ),
  ];

  //Variables
  bool showAddButton = true;
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;

      //Show Add Button Conditionally
      if (index != 0) {
        showAddButton = false;
      } else {
        showAddButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: showAddButton,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[300],
          onPressed: () {
            Navigator.push(context, AddCollectionScreen.route());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(child: _pageList.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: kPrimaryColor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bubble_chart,
                color: kPrimaryColor,
              ),
              label: "Stats"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              label: "Profile")
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
