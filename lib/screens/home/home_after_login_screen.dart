import 'package:cata_treco/screens/tabbars/tab_bar_page_screen.dart';
import 'package:cata_treco/screens/utils/first_page_AL_screen.dart';
import 'package:flutter/material.dart';

class HomeAfterLoginScreen extends StatefulWidget {
  const HomeAfterLoginScreen({Key? key}) : super(key: key);

  @override
  State<HomeAfterLoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeAfterLoginScreen> {
  int _selectedPage = 0;
  List<Widget> listPage = [];

  @override
  void initState() {
    listPage.add(const FirstPageALScreen());
    listPage.add(const UserTabPageScreen());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPage,
        children: listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Coleta',
          ),
        ],
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
