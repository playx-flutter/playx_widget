import 'package:flutter/material.dart';
import 'package:playx_widget/playx_widget.dart';

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
                OptimizedButton.elevated(
                  child: Text('Confirm'),
                  onPressed: () {},
                ),
                OptimizedCard(
                  child: Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      child: const Text('Ahmed Mohamed')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
