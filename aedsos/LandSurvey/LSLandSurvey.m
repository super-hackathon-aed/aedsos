//
//  IRLandSurvey.m
//  IRGeoRange
//
//

#import "LSLandSurvey.h"


@implementation LSLandSurvey

-(LSGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Method:(LSDistanceSurveyMethd)method Style:(LandSurveyStyle)style
{
    LSGeoDistancePoint result;
    switch (method) {
        case DistanceSurveyMethodHubery:
			result = [[[LSHubeny alloc] init] getDistanceWithDirection:start Goal:goal Style:style];
            break;
        case DistanceSurveyMethodGeodesicSailing:
			result = [[[LSGeodesicSailing alloc]init] getDistanceWithDirection:start Goal:goal Style:style];
            break;
		default:
            break;
    }
    return result;
}
@end
