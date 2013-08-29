#import "AedMKPopUpView.h"
@interface AedMKPopUpView(internal)
-(IBAction)buttonTouchUpInside:(id)sender;
-(IBAction)buttonTouchUpOutside:(id)sender;
@end
@implementation AedMKPopUpView(internal)
-(IBAction)buttonTouchUpInside:(id)sender
{
	NSInteger tag = [sender tag];
	if (tag == POPUP_CANCEL)
		[self removeFromSuperview];
	else
	{
		[delegate pushButton:sender Annotation:mAnnotation];
	}
}
-(IBAction)buttonTouchUpOutside:(id)sender
{
	[self removeFromSuperview];
}
@end
@implementation AedMKPopUpView
@synthesize Delegate = delegate;
@synthesize Annotation = mAnnotation;
-(id) initWithAnnotation:(AedMKAnnotation *)annotation
{
	self = [super initWithFrame:CGRectMake(0, 0, 200, 50)];
	mAnnotation = annotation;
	btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
	UIImage * buttonNormal		= [UIImage imageNamed:@"button1normal.png"];
	UIImage * buttonHighlight	= [UIImage imageNamed:@"button1highlighted.png"];	
	[btnCancel setBackgroundImage:buttonNormal forState:UIControlStateNormal];
	[btnCancel setBackgroundImage:buttonHighlight forState:UIControlStateHighlighted];
	[btnCancel setTitle:@"キャンセル" forState:UIControlStateNormal];
	[btnCancel setTag:POPUP_CANCEL];
	[btnCancel addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
	[btnCancel addTarget:self action:@selector(buttontouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
	[self addSubview:btnCancel];
	count = 0;
	buttonArray = [[NSMutableArray alloc] init];
	return self;
}
-(void)addButton:(UIButton *)button
{
	CGFloat btnHeight = 0;
	[button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
	[button addTarget:self action:@selector(buttontouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
	[buttonArray addObject:button];
	[self addSubview:button];
	for (int i = 0 ; i < [buttonArray count]; i++)
	{
		UIButton * btn = [buttonArray objectAtIndex:i];
		CGSize btnSize = btn.frame.size;
		[btn setFrame:CGRectMake(0, btnHeight, btnSize.width, btnSize.height)];
		btnHeight += btnSize.height;
	}
	[btnCancel setFrame:CGRectMake(0, btnHeight, 200 , 50)];
	btnHeight += 50;
	[self setFrame:CGRectMake(0, 0, 200, btnHeight)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
