import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/create/screen/gps_screen.dart';
import 'package:flutter_airnow/app/ui/create/screen/geo_screen.dart';


class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget> _body = [GeoScreen(), GpsScreen()];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Create"), centerTitle: true),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: kToolbarHeight,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xFFD7FBF4),
                      ),
                      padding: const EdgeInsets.all(4),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.bodyMedium!,
                      tabs: const [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_location_alt_outlined),
                              SizedBox(width: 8),
                              Text("Geo Location"),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.gps_fixed),
                              SizedBox(width: 8),
                              Text("GPS Location"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: TabBarView(
                  physics: ClampingScrollPhysics(),
                  controller: _tabController,
                  children: _body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
