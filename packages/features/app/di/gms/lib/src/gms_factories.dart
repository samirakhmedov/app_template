import 'package:analytics_gms/analytics.dart';
import 'package:analytics_interface/analytics_plugin.dart';
import 'package:location_gms/location.dart';
import 'package:location_interface/location.dart';
import 'package:push_gms/push.dart';
import 'package:push_interface/push.dart';

/// Creates the GMS analytics service.
AnalyticServiceInterface createGmsAnalyticsService() => Analytics();

/// Creates the GMS push notification service.
PushServiceInterface createGmsPushService() => Push();

/// Creates the GMS location service.
LocationServiceInterface createGmsLocationService() => Location();
