//
//  IRMapViewAnnotation.m
//  arch
//
//  Created by Sebastian on 11/12/22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AedMKAnnotation.h"
@implementation AedMKAnnotation
@synthesize coordinate;
@synthesize annotationTitle;
@synthesize annotationSubtitle;

//初期化処理
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord title:(NSString *)annTitle subtitle:(NSString *)annSubtitle {
	if (self=[super init]) {
		coordinate.latitude = coord.latitude;
		coordinate.longitude = coord.longitude;
		annotationTitle = annTitle;
		annotationSubtitle = annSubtitle;
	}
	return self;
}
//タイトル
- (NSString *)title
{
	return annotationTitle;
}
//サブタイトル
- (NSString *)subtitle
{
	return annotationSubtitle;
}
@end