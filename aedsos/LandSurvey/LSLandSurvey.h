//
//  IRLandSurvey.h
//  IRGeoRange
//
//
#import "LSLandSurveyType.h"
#import "LSGeodesicSailing.h"
#import "LSHubeny.h"

@interface LSLandSurvey : NSObject
/**
 * @fn			(IRGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style
 * @brief		地図上の二点間の距離／方位を取得します。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]   method  距離測定公式を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
-(LSGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Method:(LSDistanceSurveyMethd)method Style:(LandSurveyStyle)style;

@end
