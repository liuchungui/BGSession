//
//  BGSession.m
//  BGSession
//
//  Created by user on 16/3/3.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGSession.h"
#import <objc/runtime.h>

static NSString *BGUserDefaultsKey(NSString *key) {
    return [NSString stringWithFormat:@"BGSession_%@", key];
}

static BGSession *_instance = nil;

@interface BGSession ()
@property (nonatomic, strong) NSMutableArray *propertyNamesArray;
@end

@implementation BGSession

+ (instancetype)sharedSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
        [_instance setupSession];
    });
    return _instance;
}

- (void)dealloc {
    [self.propertyNamesArray enumerateObjectsUsingBlock:^(NSString * key, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObserver:self forKeyPath:key];
    }];
}

- (void)setupSession {
    self.propertyNamesArray = [NSMutableArray array];
    
    //获取所有属性
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
        
        //获取缓存的值进行初始化
        id value = [[NSUserDefaults standardUserDefaults] valueForKey:BGUserDefaultsKey(propertyName)];
        if(value) {
            [self setValue:value forKey:propertyName];
        }
        
        //add KVO
        [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:nil];
        
        //添加到数组当中
        [self.propertyNamesArray addObject:propertyName];
    }
    free(properties);
}

#pragma makr - KVO method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id value = [self valueForKey:keyPath];
    [userDefaults setValue:value forKey:BGUserDefaultsKey(keyPath)];
    [userDefaults synchronize];
}

@end
