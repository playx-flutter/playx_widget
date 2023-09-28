import 'package:flutter/material.dart';
import 'package:playx_widget/playx_widget.dart';

void main() async {
  runApp(ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(title: 'Flutter Demo', home: MyApp());
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(
              height: 100,
              child: OptimizedTextField.cupertino(
                hint: 'Search',
              ),
            ),
            const OptimizedCard(
              margin: EdgeInsets.all(16),
              innerCardShadowMargin: EdgeInsets.all(4),
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(12),
              child: Center(child: Text('Ahmed Mohamed')),
            ),
            OptimizedListTile(
              leading: const Icon(Icons.speed),
              title: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Speed',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14.sp),
                  )),
              subtitle: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '30 km/h',
                    style: TextStyle(fontSize: 12.sp),
                    textAlign: TextAlign.start,
                  )),
              trailing: const Icon(Icons.car_repair),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              horizontalSpace: 8.w,
            ),
            const ImageViewer.cachedNetwork(
              'https://avatars.githubusercontent.com/u/35397170?s=200&v=4',
              height: 100,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AutoAnimatedList(
                items: const ['Ahmed', 'Mohamed', 'Mohsen'],
                itemBuilder: (BuildContext context, String item, int index) {
                  return Text(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
