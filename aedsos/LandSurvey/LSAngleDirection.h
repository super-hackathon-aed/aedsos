/**
 * @file		IRAngleDirection.h
 * @brief		方位角測定クラス
 * @auther		Sebastian
 */
#import "LSLandSurveyType.h"
/**
 * @class	IRAngleDirection
 * @brief	2点の経緯度から方位角を算出するクラス
 */
@interface LSAngleDirection : NSObject

/**
 * @fn			+(CLLocationDirection)getAngleDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style;
 * @brief		地図上の二点間の方位を取得します。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(CLLocationDirection)getAngleDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;
@end
