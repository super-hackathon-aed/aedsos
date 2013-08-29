#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AedMKAnnotation.h"
#import "LSLandSurvey.h"

@interface AedMapViewController : UIViewController <MKMapViewDelegate>
{
	LSLandSurvey *			landsurvey;
	MKMapView *				mapview;
	MKOverlayView *			routeOrverlay;
	NSMutableArray *		annotations;
	MKCoordinateRegion		region;
}
- (id)initWithFrame:(CGRect)frame;
-(void)setPinAnnotations:(CLLocationCoordinate2D)location title:(NSString *)title subtitle:(NSString *)subtitle;
-(void)setPinAnnotations:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude title:(NSString *)title subtitle:(NSString *)subtitle;
-(double)convertMeterFromLatitude:(CLLocationDegrees)latitude;
-(double)convertMeterFromLongitude:(CLLocationDegrees)longitude;
-(void)setRegion:(CLLocationCoordinate2D)location;
-(void)touchAnnotationLeftButton :(AedMKAnnotation *) annotation;
-(void)touchAnnotationRightButton :(AedMKAnnotation *) annotation;
@end
