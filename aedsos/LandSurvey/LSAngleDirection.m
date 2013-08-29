/**
 * @file		IRAngleDirection.m
 * @brief		方位角測定クラス
 * @auther		Sebastian
 */

#import "LSAngleDirection.h"

@implementation LSAngleDirection
/**
 * @fn			+(CLLocationDirection)getAngleDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style;
 * @brief		地図上の二点間の方位を取得します。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(CLLocationDirection)getAngleDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;
{
    
	double x1 = start.longitude * M_PI / 180;	// 始点の経度[RAD]
	double y1 = start.latitude * M_PI / 180;	// 始点の緯度[RAD]
	double x2 = goal.longitude * M_PI / 180;	// 終点の経度[RAD]
	double y2 = goal.latitude * M_PI / 180;		// 終点の緯度[RAD]
    double yc = (y1 + y2) / 2;					// 緯度の中心値
    double a = 0.0f;                            // 長半径[m]	Semi-mejor axis
    switch (style) {
            // ベッセル測地系を使用
		case LandSurveyStyleBessel:
			a = BesselSemiMajorAxis;
			break;
            // 世界測地系を使用
		case LandSurveyStyleGRS80:
			a = GRS80SemiMajorAxis;
			break;
            // GPS測地系を使用
		case LandSurveyStyleWGS84:
			a = WGS84SemiMajorAxis;
			break;
		default:
			break;
	}
    double dx = a * (x2 - x1) * cos(yc);
	double dy = a * (y2 - y1);
    if (dx == 0 && dy == 0) 
		return 0;
	else
		return atan2(dy, dx);
}
@end