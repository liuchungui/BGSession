//
//  BGSessionDemoTests.m
//  BGSessionDemoTests
//
//  Created by user on 16/3/3.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DemoSession.h"
#import <CoreLocation/CoreLocation.h>

static NSString *BGUserDefaultsKey(NSString *key) {
    return [NSString stringWithFormat:@"BGSession_%@", key];
}

@interface BGSessionDemoTests : XCTestCase
@end

@implementation BGSessionDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)sessionSaveSuccess {
    XCTestExpectation *expectation = [self expectationWithDescription:@"testThatSessionSaveSuccess"];
    __block BOOL isSaveSuccess = YES;
    DemoSession *session = [DemoSession sharedSession];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger i = arc4random();
    NSLog(@"i = %zd", i);
    session.userName = [NSString stringWithFormat:@"BGSession%zd", i];
    session.userId = [NSString stringWithFormat:@"%zd", i];
    session.firstTimeUse = i%2 ? NO : YES;
    session.cityLng = 137.74848+i/3.0;
    session.cityLat = 63.8484848+i/7.0;
    session.cityId = [NSNumber numberWithInteger:i+10];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //拿取UserDefault中的值
        NSString *userName = [userDefaults valueForKey:BGUserDefaultsKey(@"userName")];
        NSString *userId = [userDefaults valueForKey:BGUserDefaultsKey(@"userId")];
        BOOL firstTimeUse = [[userDefaults valueForKey:BGUserDefaultsKey(@"firstTimeUse")] boolValue];
        CLLocationDegrees cityLat = [[userDefaults valueForKey:BGUserDefaultsKey(@"cityLat")] doubleValue];
        CLLocationDegrees cityLng = [[userDefaults valueForKey:BGUserDefaultsKey(@"cityLng")] doubleValue];
        NSNumber *cityId = [userDefaults valueForKey:BGUserDefaultsKey(@"cityId")];
        
        //比较值
        if(![session.userName isEqualToString:userName]) {
            isSaveSuccess = NO;
        }
        if(![session.userId isEqualToString:userId]) {
            isSaveSuccess = NO;
        }
        if(session.firstTimeUse != firstTimeUse) {
            isSaveSuccess = NO;
        }
        if(session.cityLat != cityLat) {
            isSaveSuccess = NO;
        }
        if(session.cityLng != cityLng) {
            isSaveSuccess = NO;
        }
        if(![session.cityId isEqualToNumber:cityId]) {
            isSaveSuccess = NO;
        }
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:2 handler:NULL];
    
    XCTAssertTrue(isSaveSuccess);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    for (NSInteger i = 0; i < 100; i++) {
        [self sessionSaveSuccess];
    }
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
