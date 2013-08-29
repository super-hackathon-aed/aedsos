#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface AedMKAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *annotationTitle;
	NSString *annotationSubtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *annotationTitle;
@property (nonatomic, retain) NSString *annotationSubtitle;
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
						   title:(NSString *)annTitle subtitle:(NSString *)annSubtitle;
- (NSString *)title;
- (NSString *)subtitle;
@end
