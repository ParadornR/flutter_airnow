import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/create/screen/coord_screed.dart';
import 'package:flutter_airnow/app/ui/create/screen/geo_screen.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Location'),
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: "Geo Location",
                icon: Icon(
                  Icons.edit_location_alt_outlined,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: "GPS Location",
                icon: Icon(Icons.gps_fixed, color: Colors.white),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            GeoScreen(tabController: tabController),
            CoordScreed(tabController: tabController),
          ],
        ),
      ),
    );
  }
}
