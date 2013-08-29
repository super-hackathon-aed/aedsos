#import <UIKit/UIKit.h>
#import "AedMKAnnotation.h"
#define POPUP_CANCEL 255
@protocol AedMKPopUpViewDelegate <NSObject>
-(void)pushButton:(UIButton *)button Annotation:(AedMKAnnotation *)annotation;
@end

@interface AedMKPopUpView : UIView
{
	NSInteger *					count;
	UIButton *					btnCancel;
	NSMutableArray *			buttonArray;
	AedMKAnnotation *			mAnnotation;
	id<AedMKPopUpViewDelegate>	delegate;
}
@property (nonatomic ,retain) AedMKAnnotation* Annotation;
@property (nonatomic ,retain) id<AedMKPopUpViewDelegate> Delegate;
-(id) initWithAnnotation:(AedMKAnnotation *)annotation;
-(void)addButton:(UIButton *)button;
@end