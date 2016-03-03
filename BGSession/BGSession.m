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

//static BOOL 
static BGSession *_instance = nil;

@interface BGSession ()
@property (nonatomic, strong) NSMutableArray *propertyNamesArray;
@property (nonatomic, strong) NSMutableArray *needSynchronizePropertyArray;
@end

@implementation BGSession

+ (instancetype)sharedSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
        [_instance setupSession];
        [_instance registerSynchronizeSessionRunLoop];
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
    self.needSynchronizePropertyArray = [NSMutableArray array];
    
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

- (void)registerSynchronizeSessionRunLoop {
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting | kCFRunLoopExit, YES, INT_MAX-1, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        [self synchronizeSession];
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopCommonModes);
    CFRelease(observerRef);
}

- (void)synchronizeSession {
    if(self.needSynchronizePropertyArray.count == 0) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [self.needSynchronizePropertyArray enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = [self valueForKey:propertyName];
        [userDefaults setValue:value forKey:BGUserDefaultsKey(propertyName)];
    }];
    [self.needSynchronizePropertyArray removeAllObjects];
    //同步
    [userDefaults synchronize];
}

#pragma makr - KVO method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self.needSynchronizePropertyArray addObject:keyPath];
}

@end
