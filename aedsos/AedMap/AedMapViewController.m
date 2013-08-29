#import "AedMapViewController.h"
#import "AedMKAnnotation.h"
#import "commonDefine.h"
#import <MapKit/MapKit.h>
#define M_POLER_RADIUS 6356752
@implementation AedMapViewController

- (id)initWithFrame:(CGRect)frame
{
	self = [super init];
	if (self)
	{
		[[self navigationItem] setTitle:NSLocalizedString(@"AedMap", @"Map")];

		if ( ![[NSUserDefaults standardUserDefaults] stringForKey:@"Radius"])
			[[NSUserDefaults standardUserDefaults] setValue:@"50" forKey:@"Radius"];
		[self.view setFrame:frame];
		// マップビューを設定
		mapview = [[MKMapView alloc] init];
		mapview.showsUserLocation=TRUE;
		mapview.delegate = self;
		[self.view addSubview:mapview];
		[mapview setMapType:MKMapTypeStandard];
		[mapview setDelegate:self];
		[mapview setShowsUserLocation:YES];
		[mapview setScrollEnabled:YES];
		[mapview setZoomEnabled:YES];
        
		annotations = [[NSMutableArray alloc] init];
		landsurvey = [[LSLandSurvey alloc]init];
		[self setView:mapview];
	}
	return self;
}
-(void)viewDidLoad
{
	[super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
	printMethod();
	[super viewWillAppear:animated];
	// ビューコントローラの設定
	[[UIApplication sharedApplication] setStatusBarHidden:true];
	CLLocationCoordinate2D curLocation = [[mapview userLocation] coordinate];

    double latitude = 35.658611;
	double longitude = 139.701111;
	CLLocationCoordinate2D _location;
	_location.latitude = latitude;
	_location.longitude = longitude;
    [self setPinAnnotations:_location title:@"TEST" subtitle:@"TEST"];
    [self setRegion:_location];
    
    
    CLLocationCoordinate2D coords[3];
    coords[0] = CLLocationCoordinate2DMake(35.658611, 139.701111);      //渋谷駅
    coords[1] = CLLocationCoordinate2DMake(35.658944, 139.703417);      //ヒカリエ
    coords[2] = CLLocationCoordinate2DMake(35.670167, 139.702694);      //原宿駅
    MKPolyline *line = [MKPolyline polylineWithCoordinates:coords count:3];
    [mapview addOverlay:line];
    
    CLLocationCoordinate2D coords2[2];
    coords2[0] = CLLocationCoordinate2DMake(35.658611, 139.701111);       //ヒカリエ
    coords2[1] = CLLocationCoordinate2DMake(35.670167, 139.702694);      //原宿駅
    MKPolyline *line2 = [MKPolyline polylineWithCoordinates:coords2 count:2];
    [mapview addOverlay:line2];

    
}
-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}
/**
* @fn			-(void)setRegion:(CLLocationCoordinate2D)location
* @brief		指定した地点を地図の中心に設定します。
* @param[in]	localtion   位置情報を指定
*/
-(void)setRegion:(CLLocationCoordinate2D)location {
    int rad = [[[NSUserDefaults standardUserDefaults] stringForKey:@"Radius"] intValue];
	CLLocationDistance latitudinalMeters = rad;
	CLLocationDistance longitudinalMeters = rad;
	MKCoordinateRegion reg = MKCoordinateRegionMakeWithDistance(location, latitudinalMeters, longitudinalMeters);
	MKCoordinateSpan span = MKCoordinateSpanMake(reg.span.latitudeDelta , reg.span.longitudeDelta);
	region = MKCoordinateRegionMake(location, span);
	[mapview setCenterCoordinate:location];
	[mapview setRegion:region animated:YES];
    
}
-(void)setPinAnnotations:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude title:(NSString *)title subtitle:(NSString *)subtitle{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self setPinAnnotations:coordinate title:title subtitle:subtitle];
}

-(void)setPinAnnotations:(CLLocationCoordinate2D)location title:(NSString *)title subtitle:(NSString *)subtitle
{
	AedMKAnnotation * annotaion = [[AedMKAnnotation alloc] initWithLocationCoordinate:location title:title subtitle:subtitle];
	[annotations addObject:annotaion];
	[mapview addAnnotations:annotations];
}
-(double)convertMeterFromLatitude:(CLLocationDegrees)latitude
{
	return latitude * ((2 * M_PI * M_POLER_RADIUS) / 360);
}

-(double)convertMeterFromLongitude:(CLLocationDegrees)longitude
{
	return longitude * (2 * M_PI * (M_POLER_RADIUS * cos([mapview userLocation].coordinate.latitude))) / 360;
}
/**
 * @fn			- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
 * @brief       MapViewの中心点変更前イベント
 * @param[in]	animated    中心点移動時のマップアニメーションの有無
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{

}
/**
 * @fn			- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
 * @brief       MapViewの中心点変更後イベント
 * @param[in]	animated    中心点移動時のマップアニメーションの有無
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated

{
	printMethod();
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKPolylineView *view = [[MKPolylineView alloc] initWithOverlay:overlay];
    view.strokeColor = [UIColor blueColor];
    view.lineWidth = 1.0;
    return view;
}

/**
 * @fn			-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
 * @brief       MapViewのアノテーション追加イベント
 * @param[in]	annotation  追加されるアノテーション
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	printMethod();
	if (annotation == mapView.userLocation) {
		return nil;
	}
	MKPinAnnotationView *annotationView;
	NSString* identifier = annotation.title;
	
	annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	if(nil == annotationView)
	{  
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
	}
	if([annotation isKindOfClass:[AedMKAnnotation class]]) {
        UIImage *pinImage = [UIImage imageNamed:@"pin_aed.png"];
		annotationView.image = pinImage;
        annotationView.canShowCallout = YES;
		UIButton * rightAccessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[rightAccessoryButton setFrame:CGRectMake(0, 0, 23, 23)];
		[rightAccessoryButton setTag:0];
		[rightAccessoryButton setBackgroundImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
		[annotationView setRightCalloutAccessoryView:rightAccessoryButton];
		UIButton * leftAccessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[leftAccessoryButton setFrame:CGRectMake(0, 0, 23, 23)];
		[leftAccessoryButton setTag:1];
		[leftAccessoryButton setBackgroundImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
		[annotationView setLeftCalloutAccessoryView:leftAccessoryButton];
        
		return annotationView;
	}
    return nil;
}
/**
 * @fn			- (void)mapView:(MKMapView*)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
 * @brief       アノテーションのバルーンに設置したボタンの押下イベント
 * @param[in]	annotation  タッチしたアノテーション
 * @param[in]	control     タッチしたアノテーション上のコントロール
 */
- (void)mapView:(MKMapView*)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	printMethod();
    NSInteger tag = control.tag;
    AedMKAnnotation * annotation = (AedMKAnnotation *)[view annotation];
    if (tag == 0) {
        [self touchAnnotationRightButton:annotation];
    } else if (tag == 1) {
        [self touchAnnotationLeftButton:annotation];
    }
}
/**
 * @fn			-(void)touchAnnotationRightButton :(AedMKAnnotation *) annotation
 * @brief       アノテーションのバルーンに設置した右ボタンの押下イベント
 * @param[in]	annotation  タッチしたボタンのあるアノテーション
 */
-(void)touchAnnotationRightButton :(AedMKAnnotation *) annotation{
	printMethod();
}
/**
 * @fn			-(void)touchAnnotationLeftButton :(AedMKAnnotation *) annotation
 * @brief       アノテーションのバルーンに設置した左ボタンの押下イベント
 * @param[in]	annotation  タッチしたボタンのあるアノテーション
 */
-(void)touchAnnotationLeftButton :(AedMKAnnotation *) annotation{
	printMethod();   
}

@end
