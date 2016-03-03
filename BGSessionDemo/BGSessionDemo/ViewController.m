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
    
    DemoSession *session = [DemoSession sharedSession];
    session.userName = @"Jack";
    session.userId = @"1";
    session.firstTimeUse = YES;
    session.cityLng = 138.88383384;
    session.cityLat = 63.8484848;
    session.cityId = @1838;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
