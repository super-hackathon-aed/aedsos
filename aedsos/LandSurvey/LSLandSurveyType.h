/**
 * @file		LSLandSurveyStyle.h
 * @brief		測地系定数定義
 * @auther		Sebastian
 */

#ifndef LSGeoRange_LSLandSurveyStyle_h
#define LSGeoRange_LSLandSurveyStyle_h
#import <CoreLocation/CLLocation.h>

#define BesselSemiMajorAxis  6377397.155	// ベッセル測地系における赤道半径
#define GRS80SemiMajorAxis   6378137.000	// 世界測地系における赤道半径
#define WGS84SemiMajorAxis   6378137.000	// GPS測地系における赤道半径
#define BesselSemiMinorAxis  6356079.000000 // ベッセル測地系における極半径
#define GRS80SemiMinorAxis   6356752.314140 // 世界測地系における極半径
#define WGS84SemiMinorAxis   6356752.314245	// GPS測地系における極半径
// (長半径の2乗-短半径の2乗)÷長半径の2乗にて求められる
#define Bessel1stNumericalEccentricitySquare	0.00667436061028297	// ベッセル測地系における第一離心率の二乗
#define GRS801stNumericalEccentricitySquare		0.00669438002301188	// 世界測地系における第一離心率の二乗
#define WGS841stNumericalEccentricitySquare		0.00669437999019758	// GPS測地系における第一離心率の二乗
// 長半径(1-第一離心率の2乗)にて求められる
#define BesselNumeratorOfRateRadiusMeridianCurve	6334832.10663254	// ベッセル測地系時
#define GRS80NumeratorOfRateRadiusMeridianCurve		6335439.32708317	// 世界測地系時
#define WGS84NumeratorOfRateRadiusMeridianCurve		6335439.32729246	// GPS測地系時

/**
 * @brief       距離測定方法
 * @details     距離測定公式の種類の指定用列挙隊です。
 */
enum
{
    DistanceSurveyMethodHubery ,
    DistanceSurveyMethodGeodesicSailing
};
typedef NSInteger LSDistanceSurveyMethd;
/**
 * @brief		測地系の種別
 * @details		計測時の測地系の種類の指定用列挙体です。
 */
enum
{
    /** @brief  ベッセル測地系 */
    LandSurveyStyleBessel ,
    /** @brief  GRS80 世界測地系*/
    LandSurveyStyleGRS80 ,
    /** @brief  GPSでの測地系 */
    LandSurveyStyleWGS84
};
typedef NSInteger LandSurveyStyle;

struct _LSGeoDistancePoint
{
	/**
	 * @brief	始点の経緯度
	 * @note	Geodetic of start point
	 */
    CLLocationCoordinate2D	StartLocation;
	/** 
	 * @brief	終点の経緯度
	 * @note	Geodetic of terminal point
	 */
    CLLocationCoordinate2D	EndLocation;
	/**
	 * @brief	始点と終点の直線距離 
	 * @note	Distance of the starting point and a terminal point 
	 */
    CLLocationDegrees		Distance;
	/**
	 * @brief	始点と終点の緯度軸に置ける距離[m]
	 * @note	Distance of the latitude axis of the starting point and a terminal point
	 */
    CLLocationDegrees		LatitudeDistance;
	/** 
	 * @brief	始点と終点の経度軸に置ける距離[m]
	 * @note	Distance of the longitude axis of the starting point and a terminal point
	 */
    CLLocationDistance		LongitudeDistance;
	/**
	 * @brief	方位角
	 * @note	Angle of direction
	 */
	CLLocationDistance		Direction;
};
/**
 * @struct	IRGeoDistancePoint
 * @brief	2点間の距離／方位情報構造隊
 */
typedef struct _LSGeoDistancePoint LSGeoDistancePoint;


#endif
