import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/create/controller/create_page_controller.dart';
import 'package:flutter_airnow/app/ui/create/screen/gps_screen.dart';
import 'package:flutter_airnow/app/ui/create/screen/geo_screen.dart';
import 'package:get/get.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> with TickerProviderStateMixin {
  final createPageController = Get.put(CreatePageController());

  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );
  final List<Widget> _body = [GeoScreen(), GpsScreen()];

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
                      onTap: (value) {
                        createPageController.claerValue();
                      },
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: const EdgeInsets.all(4),
                      labelStyle: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
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
