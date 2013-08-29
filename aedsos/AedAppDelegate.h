#import <UIKit/UIKit.h>
@class AedViewController;

@interface AedAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *					window;
	UINavigationController *	navigationController;
    AedViewController *			viewController;
}
@end
