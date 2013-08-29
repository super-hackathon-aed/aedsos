#import "AedViewController.h"
#import <QuartzCore/CALayer.h>
#import "commonDefine.h"

@interface AedViewController (Internal)
- (IBAction)pushButton : (id)sender;
- (void)didEyyeMessageReceivedNotify:(NSNotification *)center;
@end

@implementation AedViewController
- (void)didReceiveMemoryWarning
{
	printMethod();
    [super didReceiveMemoryWarning];
}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
	printMethod();
	
	[super viewDidLoad];
	// add Map View Controller << ----------------------------------------------
	mapViewController = [[AedMapViewController alloc] initWithFrame:self.view.frame];
	[[UIApplication sharedApplication] setStatusBarHidden:true];
	self.navigationItem.title = NSLocalizedString(@"Menu", @"");

	// chack device iPad / iPhone
	CGFloat screenScale;
	if ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound)
		screenScale = 1024 / 480;
	else
		screenScale = 1;
	[self.view setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:1.0f alpha:1.0]];
	// make title logo
	UIImage * topMenu = [UIImage imageNamed:@"top_menu.png"];
	UIImageView * logoImage = [[UIImageView alloc] init];
	[logoImage setFrame:CGRectMake( 0 * screenScale, 40 * screenScale , topMenu.size.width , topMenu.size.height)];
	[logoImage setImage:topMenu];
	[logoImage setContentMode:UIViewContentModeScaleAspectFit];
	[self.view addSubview:logoImage];
	// make button
	UIImage * buttonNormal		= [UIImage imageNamed:@"button1normal.png"];
	UIImage * buttonHighlight	= [UIImage imageNamed:@"button1highlighted.png"];	
	// add button
	UIButton * btnEmergency = [[UIButton alloc] init];
	btnEmergency = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnEmergency setBackgroundImage:buttonNormal forState:UIControlStateNormal];
	[btnEmergency setBackgroundImage:buttonHighlight forState:UIControlStateHighlighted];
	[btnEmergency setTitle:NSLocalizedString(@"Emergency", nil) forState:UIControlStateNormal];
	[btnEmergency addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnEmergency setTag:0];
	[btnEmergency setTitleColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0] forState:UIControlStateNormal];
	[btnEmergency setTitleColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0] forState:UIControlStateHighlighted];
	[[btnEmergency layer] setMasksToBounds:YES];
	[btnEmergency setFrame:CGRectMake(		50 * screenScale , 270 * screenScale
								   ,	buttonNormal.size.width , buttonNormal.size.height)];
	[self.view addSubview:btnEmergency];

	// 画面上のViewを全てセンタリングする。
	for (UIView* nextView in [self.view subviews])
	{
		CGRect frame = nextView.frame;
		CGFloat afterW = frame.size.width;
		CGFloat afterH = frame.size.height;
		CGFloat afterX = (self.view.frame.size.width - afterW) / 2;
		CGFloat afterY = frame.origin.y;
		[nextView setFrame:CGRectMake(afterX, afterY, afterW, afterH)];
	}
}
- (void)viewWillAppear:(BOOL)animated
{
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}
- (void)viewDidUnload
{
	printMethod();
    [super viewDidUnload];
}

#pragma mark -
#pragma mark IBAction

// ボタンが押されたときの処理
- (IBAction)pushButton : (id)sender
{
	self.navigationItem.title = NSLocalizedString(@"Menu",nil);
	switch ((int)[sender tag])
	{
		case 0:
			[self.navigationController pushViewController:mapViewController animated:YES];
			break;
		default:
			break;
	}
}
@end
