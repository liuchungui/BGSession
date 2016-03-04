//
//  ViewController.m
//  BGSessionDemo
//
//  Created by user on 16/3/3.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "ViewController.h"
#import "DemoSession.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        DemoSession *session = [DemoSession sharedSession];
        session.userName = @"Jack";
        session.userId = @"1";
        session.firstTimeUse = YES;
        session.cityLng = 138.88383384;
        session.cityLat = 63.8484848;
        session.cityId = @1838;
    });
    
//    //写入
//    [[NSUserDefaults standardUserDefaults] setValue:@"Jack" forKey:@"UserDefaults_userName"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    //读取
//    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserDefaults_userName"];
//    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"UserDefaults_userName"]);
    
    
//    //使用归档写入
//    NSString *userName = @"Jack";
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserNameFile"];
//    [NSKeyedArchiver archiveRootObject:userName toFile:filePath];
//    
//    //使用解归档读取
//    userName = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
