import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class TanyaScreen extends StatefulWidget {
  const TanyaScreen({Key? key}) : super(key: key);

  static const String routeName = '/tanya';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => TanyaScreen(),
    );
  }

  @override
  _TanyaScreenState createState() => _TanyaScreenState();
}

class _TanyaScreenState extends State<TanyaScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modul Pertanyaan'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              icon: Text('TANYA IMAM'),
            ),
            Tab(
              icon: Text('MOHON NIKAH'),
            ),
            Tab(
              icon: Text('TEMPAH QURBAN'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text("It's cloudy here"),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
