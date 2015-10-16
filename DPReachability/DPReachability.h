#import <Foundation/Foundation.h>


@interface DPReachability : NSObject

+ (void)beginNetworkConnection;
+ (void)endNetworkConnection;

+ (BOOL)isInternetConnectionAvailable;
+ (BOOL)isInternetConnectionViaWifi;

@end
