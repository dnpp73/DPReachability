#import "DPReachability.h"
#import "Reachability.h"
#import "dp_exec_block_on_main_thread.h"


@implementation DPReachability

#pragma mark - for iOS

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
static int networkCount = 0;
#elif TARGET_OS_MAC
#endif

+ (void)beginNetworkConnection
{
    #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    dp_exec_block_on_main_thread(^{
        networkCount++;
        if (networkCount > 0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    });
    #elif TARGET_OS_MAC
    #endif
}

+ (void)endNetworkConnection
{
    #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    dp_exec_block_on_main_thread(^{
        if (networkCount > 0) {
            networkCount--;
            if (networkCount == 0) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
        }
    });
    #elif TARGET_OS_MAC
    #endif
}

#pragma mark - Reachability

+ (Reachability*)curReach
{
    static Reachability* curReach = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        curReach = [Reachability reachabilityForInternetConnection];
    });
    return curReach;
}

+ (BOOL)isInternetConnectionAvailable
{
    return [self curReach].isReachable;
}

+ (BOOL)isInternetConnectionViaWifi
{
    return [self curReach].isReachableViaWiFi;
}

@end
