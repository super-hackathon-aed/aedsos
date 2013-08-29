#import "commonDefine.h"
#import "AedAppDelegate.h"
#import "AedViewController.h"
@implementation AedAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	[window makeKeyAndVisible];
	viewController = [[AedViewController alloc] init];
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[[navigationController view] setFrame:[UIScreen mainScreen].bounds];
	[window addSubview:navigationController.view];
    return YES;	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
		printMethod();
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
		printMethod();
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	printMethod();
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CommErr", nil) message:@"終了します"
												   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];

}

- (void)dealloc
{
	printMethod();
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CommErr", nil) message:@"終了しました"
												   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];

	//[viewController release];
	//[navigationController release];
	//[window release];
    //[super dealloc];
}

@end
