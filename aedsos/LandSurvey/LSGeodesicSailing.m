/**
 * @file		IRGeodesicSailing.h
 * @brief		測地線航海算法距離測定公式クラス
 * @auther		Sebastian
 */

#import "LSGeodesicSailing.h"
#import "LSAngleDirection.h"

/**
 * @class	IRGeodesicSailing
 * @brief	測地線航海算法の公式を用いて２点間の距離を算出します。
 */
@implementation LSGeodesicSailing

/**
 * @fn			(IRGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style
 * @brief		地図上の二点間の距離／方位を取得します。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
-(LSGeoDistancePoint)getDistanceWithDirection:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style
{
	LSGeoDistancePoint result;
	result.StartLocation = start;
	result.EndLocation = goal;
	result.Distance = [LSGeodesicSailing getDistance:start Goal:goal Style:style];
	result.LatitudeDistance = [LSGeodesicSailing getLatitudeDistance:start Goal:goal Style:style];
	result.LongitudeDistance = [LSGeodesicSailing getLongitudeDistance:start Goal:goal Style:style];
	result.Direction = [LSAngleDirection getAngleDirection:start Goal:goal Style:style];
	return result;
}

/**
 * @fn			(double)getDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(IRLandSurveyStyle)style
 * @brief		地図上の二点間の直線距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style
{
    double distance = 0;
	double x1 = start.longitude * M_PI / 180;	// 始点の経度[RAD]
	double y1 = start.latitude * M_PI / 180;	// 始点の緯度[RAD]
	double x2 = goal.longitude * M_PI / 180;	// 終点の経度[RAD]
	double y2 = goal.latitude * M_PI / 180;		// 終点の緯度[RAD]
	double a = 0.0f;		// 長半径[m]	Semi-mejor axis of the Earth
	double b = 0.0f;		// 短半径[m]	Semi-minor axis of the Earth
	double f = 0.0f;		// 偏平率 Flattening of the Earth

	switch (style) {
		// ベッセル測地系を使用
		case LandSurveyStyleBessel:
			a = BesselSemiMajorAxis;
			b = BesselSemiMinorAxis;
			break;
		// 世界測地系を使用
		case LandSurveyStyleGRS80:
			a = GRS80SemiMajorAxis;
			b = GRS80SemiMinorAxis;
			break;
		// GPS測地系を使用
		case LandSurveyStyleWGS84:
			a = WGS84SemiMajorAxis;
			b = WGS84SemiMinorAxis;
			break;
		default:
			break;
	}

	f = (a - b) / a;
	
	double P1 = atan((b / a) * tan(y1));
	double P2 = atan((b / a) * tan(y2));
	double x = acos(sin(P1) * sin(P2) + cos(P1) * cos(P2) * cos(x1 - x2));
	if (x == 0)
		return distance;
	double l = (f / 8) * ((sin(x) - x) * pow((sin(P1) + sin(P2)), 2) / pow(cos(x / 2), 2) - (sin(x) - x) * pow(sin(P1) - sin(P2), 2) / pow(sin(x), 2));
	
	distance = a * (x + l);
	// 小数点の桁数を指定(10桁)
	double decimal_no = pow(10, 10);	
	distance = round(decimal_no * distance / 1) / decimal_no;
	return distance;
}

/**
 * @fn			+(double)getLatitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:
 * @brief		地図上の二点間の緯度における距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getLatitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style
{
	return [LSGeodesicSailing getDistance:start 
							Goal:CLLocationCoordinate2DMake(goal.latitude, start.longitude)
						   Style:style];
}

/**
 * @fn			+(double)getLongitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:
 * @brief		地図上の二点間の経度における距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getLongitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style
{
	return [LSGeodesicSailing getDistance:start 
							Goal:CLLocationCoordinate2DMake(start.latitude, goal.longitude)
						   Style:style];
}



@end
