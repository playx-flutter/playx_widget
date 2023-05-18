import 'package:flutter/material.dart';
import 'package:playx_widget/widgets/app_version.dart';
import 'package:playx_widget/widgets/auto_animated_list.dart';
import 'package:playx_widget/widgets/center_loading.dart';
import 'package:playx_widget/widgets/image_viewer.dart';
import 'package:playx_widget/widgets/keep_alive_wrapper.dart';
import 'package:playx_widget/widgets/optimized_card.dart';
import 'package:playx_widget/widgets/optimized_scroll_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: KeepAliveWrapper(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Playx Example'),
          ),
          body: OptimizedScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  height: 100,
                  child: AppVersion(
                    prefix: 'Version ',
                  ),
                ),
                const SizedBox(
                  height: 100,
                  child: CenterLoading(
                    color: Colors.blue,
                  ),
                ),
                ImageViewer.cachedNetwork(
                  'https://avatars.githubusercontent.com/u/35397170?s=200&v=4',
                  height: 100,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: AutoAnimatedList(
                    items: const ['Ahmed', 'Mohamed', 'Mohsen'],
                    itemBuilder:
                        (BuildContext context, String item, int index) {
                      return Text(item);
                    },
                  ),
                ),
                OptimizedCard(
                  child: Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      child: Text('Ahmed Mohamed')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
