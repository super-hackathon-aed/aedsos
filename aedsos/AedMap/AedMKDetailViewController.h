#import <UIKit/UIKit.h>
#import "AedMKAnnotation.h"
@interface AedMKDetailViewController : UIViewController
{
	AedMKAnnotation * mAnnotation;
}
@property (nonatomic , retain) AedMKAnnotation * Annotation;
@end
