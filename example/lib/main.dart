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

final focusNode = FocusNode();
final focusNode2 = FocusNode();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            SizedBox(
              height: 100,
              child: OptimizedTextField(
                hint: 'Search',
                focus: focusNode,
                nextFocus: focusNode2,
              ),
            ),
            SizedBox(
              height: 100,
              child: OptimizedTextField.cupertino(
                hint: 'Search',
                focus: focusNode2,
              ),
            ),
            const FavoriteButton(),
            const OptimizedCard(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(12),
              child: Center(child: Text('Ahmed Mohamed')),
            ),
            Row(
              children: [
                Expanded(
                  child: OptimizedListTile(
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
                ),
                const VerticalDashedLine(
                  height: 100,
                ),
                Expanded(
                  child: OptimizedListTile(
                    leading: const Icon(Icons.timer),
                    title: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Time',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14.sp),
                        )),
                    subtitle: SizedBox(
                        width: double.infinity,
                        child: Text(
                          '22:00 PM',
                          style: TextStyle(fontSize: 12.sp),
                          textAlign: TextAlign.start,
                        )),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    horizontalSpace: 8.w,
                  ),
                ),
              ],
            ),
            const ImageViewer.cachedNetwork(
              'https://avatars.githubusercontent.com/u/35397170?s=200&v=4',
              height: 100,
            ),
            const DashedLine(),
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
