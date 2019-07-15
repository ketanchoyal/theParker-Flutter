#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyBSBaDYgtD2GGqEbkv_0PVY6vCC82_KAQw"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end

@interface AppDelegate : FlutterAppDelegate

@end
