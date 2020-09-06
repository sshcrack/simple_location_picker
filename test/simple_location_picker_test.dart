import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:simple_location_picker/utils/slp_constants.dart';

void main() {

  double latitude = SLPConstants.DEFAULT_LATITUDE;
  double longitude = SLPConstants.DEFAULT_LONGITUDE;

  SimpleLocationResult _result;

  startSimpleLocationPicker(WidgetTester tester, SimpleLocationPicker picker) async {
    final key = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: key,
        home: FlatButton(
          onPressed: () async {
            _result = await key.currentState.push(MaterialPageRoute(builder: (context) => picker));
          },
          child: const SizedBox(),
        ),
      ),
    );
  }

  group('Parameter Testing', () {

    testWidgets('Navigation bar color positive test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      AppBar appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      expect(appBar.backgroundColor, isSameColorAs(Colors.green));
    });

    testWidgets('Navigation bar color negative test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      AppBar appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      expect(appBar.backgroundColor, isNot(Colors.redAccent));
    });

    testWidgets('Display Only Mode Positive test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            displayOnly: true,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      AppBar appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      bool isSaveButtonAbsent = appBar.actions[0] is Container;
      expect(isSaveButtonAbsent, true);
    });

    testWidgets('Display Only Mode Negative test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            displayOnly: false,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      AppBar appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      bool isSaveButtonPresent = appBar.actions[0] is IconButton;
      expect(isSaveButtonPresent, true);
    });

    testWidgets('AppBar Title Positive test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitle",
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      expect(find.text('TestTitle'), findsOneWidget);
    });

    testWidgets('AppBar Title Negative test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitleNegative",
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      expect(find.text('TestTitle'), findsNothing);
    });

    testWidgets('AppBar TextColor Positive test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitle",
            appBarTextColor: Colors.redAccent,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      Color titleColor = ((tester.firstWidget(find.text('TestTitle')) as Text).style).color;
      expect(titleColor, isSameColorAs(Colors.redAccent));
    });

    testWidgets('AppBar TextColor Negative test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitle",
            appBarTextColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      Color titleColor = ((tester.firstWidget(find.text('TestTitle')) as Text).style).color;
      expect(titleColor, isNot(Colors.redAccent));
    });

    testWidgets('FlutterMap Marker position test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitle",
            appBarTextColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      double mLatitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1] as MarkerLayerOptions).markers[0]).point.latitude;
      double mLongitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1] as MarkerLayerOptions).markers[0]).point.longitude;

      expect(latitude, mLatitude);
      expect(longitude, mLongitude);
    });

    testWidgets('FlutterMap Marker Color Positive test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            markerColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      Widget children = ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1] as MarkerLayerOptions).markers[0])
          .builder(GlobalKey<NavigatorState>().currentContext);

      Icon markerIcon = children as Icon;
      expect(markerIcon.color, isSameColorAs(Colors.green));
    });

    testWidgets('FlutterMap Marker Color Negative test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            markerColor: Colors.redAccent,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      Widget children = ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1] as MarkerLayerOptions).markers[0])
          .builder(GlobalKey<NavigatorState>().currentContext);

      Icon markerIcon = children as Icon;
      expect(markerIcon.color, isNot(Colors.green));
    });

    testWidgets('FlutterMap ZoomLevel Positive test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitle",
            zoomLevel: 10,
            appBarTextColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      double zoom = ((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).options).zoom;
      expect(zoom, 10);
    });

    testWidgets('FlutterMap ZoomLevel Negative test', (WidgetTester tester) async {
      await startSimpleLocationPicker(
          tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            appBarTitle: "TestTitle",
            zoomLevel: 10,
            appBarTextColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle();

      double zoom = ((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).options).zoom;
      expect(zoom, isNot(SLPConstants.DEFAULT_ZOOM_LEVEL));
    });
  });

  group('Functionality Testing', () {

    // Test that tapping the map moves marker for picker mode
    testWidgets('Move marker Test', (WidgetTester tester) async {

      await startSimpleLocationPicker(tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            displayOnly: false,
            appBarColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      double mLatitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
                                                  as MarkerLayerOptions).markers[0]).point.latitude;
      double mLongitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
                                                  as MarkerLayerOptions).markers[0]).point.longitude;
      expect(mLatitude, latitude);
      expect(mLongitude, longitude);
      expect(find.byType(FlutterMap), findsOneWidget);
      expect(find.byType(MarkerLayer), findsOneWidget);

      await tester.tap(find.byType(MarkerLayer));
      await tester.tapAt(const Offset(100.0, 100.0));
      await tester.pump(new Duration(milliseconds: 50));

      mLatitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
          as MarkerLayerOptions).markers[0]).point.latitude;
      mLongitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
          as MarkerLayerOptions).markers[0]).point.longitude;

      expect(mLatitude, isNot(latitude));
      expect(mLongitude, isNot(longitude));

    });

    // Display only mode should not move marker when map is tapped
    testWidgets('Display Only Mode Fixed Marker Test', (WidgetTester tester) async {

      await startSimpleLocationPicker(tester,
          SimpleLocationPicker(
            initialLatitude: latitude,
            initialLongitude: longitude,
            displayOnly: true,
            appBarColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      double mLatitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
          as MarkerLayerOptions).markers[0]).point.latitude;
      double mLongitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
          as MarkerLayerOptions).markers[0]).point.longitude;
      expect(mLatitude, latitude);
      expect(mLongitude, longitude);
      expect(find.byType(FlutterMap), findsOneWidget);
      expect(find.byType(MarkerLayer), findsOneWidget);

      await tester.tap(find.byType(MarkerLayer));
      await tester.tapAt(const Offset(100.0, 100.0));
      await tester.pump(new Duration(milliseconds: 50));

      mLatitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
          as MarkerLayerOptions).markers[0]).point.latitude;
      mLongitude =
          ((((tester.firstWidget(find.byType(FlutterMap)) as FlutterMap).layers)[1]
          as MarkerLayerOptions).markers[0]).point.longitude;

      expect(mLatitude, latitude);
      expect(mLongitude, longitude);

    });

    // Test if save location button returns the correct coordinates
    testWidgets('Save location response Test', (WidgetTester tester) async {

      _result = null;

      await startSimpleLocationPicker(tester,
          SimpleLocationPicker(
            initialLatitude: 20,
            initialLongitude: 30,
            displayOnly: false,
            appBarColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      AppBar appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      Widget saveButton = appBar.actions[0];

      await tester.tap(find.byWidget(saveButton));
      await tester.pump(new Duration(milliseconds: 1000));

      expect(_result.latitude, 20);
      expect(_result.longitude, 30);

    });


    // Test if location picker can be reopened and saved multiple times without any issue
    testWidgets('Multiple Re-opening Test', (WidgetTester tester) async {

      _result = null;

      await startSimpleLocationPicker(tester,
          SimpleLocationPicker(
            initialLatitude: 20,
            initialLongitude: 30,
            displayOnly: false,
            appBarColor: Colors.green,
          ));

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      AppBar appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      Widget saveButton = appBar.actions[0];

      await tester.tap(find.byWidget(saveButton));
      await tester.pump(new Duration(milliseconds: 1000));

      expect(_result.latitude, 20);
      expect(_result.longitude, 30);

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      saveButton = appBar.actions[0];

      await tester.tap(find.byWidget(saveButton));
      await tester.pump(new Duration(milliseconds: 1000));

      expect(_result.latitude, 20);
      expect(_result.longitude, 30);

      await tester.tap(find.byType(FlatButton));
      await tester.pumpAndSettle(); //

      appBar = find.byType(AppBar).evaluate().single.widget as AppBar;
      saveButton = appBar.actions[0];

      await tester.tap(find.byWidget(saveButton));
      await tester.pump(new Duration(milliseconds: 1000));

      expect(_result.latitude, 20);
      expect(_result.longitude, 30);

    });

  });

}
