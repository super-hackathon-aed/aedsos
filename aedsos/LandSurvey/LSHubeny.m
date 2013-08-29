/**
 * @file		IRHubeny.m
 * @brief		ヒュビネの距離測定公式クラス
 * @auther		Sebastian
 */

#import "LSHubeny.h"
#import "LSAngleDirection.h"
@implementation LSHubeny

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
	result.Distance = [LSHubeny getDistance:start Goal:goal Style:style];
	result.LatitudeDistance = [LSHubeny getLatitudeDistance:start Goal:goal Style:style];
	result.LongitudeDistance = [LSHubeny getLongitudeDistance:start Goal:goal Style:style];
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
	double x1 = start.longitude * M_PI / 180;	// 始点の経度[RAD]
	double y1 = start.latitude * M_PI / 180;	// 始点の緯度[RAD]
	double x2 = goal.longitude * M_PI / 180;	// 終点の経度[RAD]
	double y2 = goal.latitude * M_PI / 180;		// 終点の緯度[RAD]
	double dy = y1 - y2;						// 緯度の差
	double dx = x1 - x2;						// 経度の差
	double m = (y1 + y2) / 2;					// 緯度の平均値
	
    double a = 0.0f;		// 長半径[m]	Semi-mejor axis
    double b = 0.0f;		// 短半径[m]	Semi-minor axis
	double e2 = 0.0f;		// 第一離心率の2乗	
	double n = 0.0f;		// 子午線曲率半径計算用
	double W = 0.0f;		// 曲率半径計算用変数
	double M = 0.0f;		// 子午線曲率半径 Meridian line curvature radius
	double N = 0.0f;		// 卯酉線曲率半径 Prime vertical circle curvature radius

	double d;
	switch (style) {
		// ベッセル測地系を使用
		case LandSurveyStyleBessel:
			a = BesselSemiMajorAxis;
			b = BesselSemiMinorAxis;
			e2 = Bessel1stNumericalEccentricitySquare;
			n = BesselNumeratorOfRateRadiusMeridianCurve;
			break;
		// 世界測地系を使用
		case LandSurveyStyleGRS80:
			a = GRS80SemiMajorAxis;
			b = GRS80SemiMinorAxis;
			e2 = GRS801stNumericalEccentricitySquare;
			n = GRS80NumeratorOfRateRadiusMeridianCurve;
			break;
		// GPS測地系を使用
		case LandSurveyStyleWGS84:
			a = WGS84SemiMajorAxis;
			b = WGS84SemiMinorAxis;
			e2 = WGS841stNumericalEccentricitySquare;
			n = WGS84NumeratorOfRateRadiusMeridianCurve;
			break;
		default:
			break;
	}
	
	W = sqrt(1 - e2 * pow(sin(m), 2));
	// 子午線曲率半径の算出
	M = n / pow(W , 3);
	// 卯酉線曲率半径の算出
	N = a / W;
	// ヒュビネの距離測定公式による距離の算出
	d = sqrt( pow(dy * M , 2) + pow(dx * N * cos(m) , 2));
	return d;
}
/**
 * @fn			+(double)getLatitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:
 * @brief		地図上の二点間の緯度における距離を求めます。
 * @param[in]	start	始点を指定します。
 * @param[in]	goal	終点を指定します。
 * @param[in]	style	測地系の種類を指定します。
 */
+(double)getLatitudeDistance:(CLLocationCoordinate2D)start Goal:(CLLocationCoordinate2D)goal Style:(LandSurveyStyle)style;
{
	return [LSHubeny getDistance:start 
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
	return [LSHubeny getDistance:start 
							Goal:CLLocationCoordinate2DMake(start.latitude, goal.longitude)
						   Style:style];
}

@end
