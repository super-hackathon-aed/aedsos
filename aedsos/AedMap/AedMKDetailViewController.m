#import "AedMKDetailViewController.h"

@implementation AedMKDetailViewController
@synthesize Annotation = mAnnotation;
-(id)init
{
	self = [super init];
	return self;
}

-(void)setAnnotation:(AedMKAnnotation *)Annotation
{
	mAnnotation = Annotation;
}
@end
