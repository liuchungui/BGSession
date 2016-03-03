//
//  DemoSession.h
//  BGSession
//
//  Created by user on 16/3/3.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGSession.h"
#import <CoreLocation/CoreLocation.h>

@interface DemoSession : BGSession
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;
/**
 *应用是否第一次启动
 */
@property (nonatomic, assign) BOOL firstTimeUse;
/**
 *经度
 */
@property (nonatomic, assign) CLLocationDegrees cityLng;
/**
 *纬度
 */
@property (nonatomic, assign) CLLocationDegrees cityLat;

@property (nonatomic, strong) NSNumber *cityId;
@end
