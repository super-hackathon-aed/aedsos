/**
 * @file		IRHubeny.h
 * @brief		ヒュビネの距離測定公式クラス
 * @auther		Sebastian
 */
#import "LSLandSurveyType.h"


/**
 * @class	IRHubeny
 * @brief	ヒュビネの距離測定公式を用いて２点間の距離を算出します。
 */
@interface LSHubeny : NSObject

/**
 * @fn			(IRGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style
 * @brief		地図上の二点間の距離／方位を取得します。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
-(LSGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;

/**
 * @fn			(double)getDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style
 * @brief		地図上の二点間の直線距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;

/**
 * @fn			+(double)getLatitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:
 * @brief		地図上の二点間の緯度における距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getLatitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;

/**
 * @fn			+(double)getLongitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:
 * @brief		地図上の二点間の経度における距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getLongitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;

@end
