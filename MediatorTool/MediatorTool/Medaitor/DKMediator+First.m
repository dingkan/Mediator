//
//  DKMediator+FirstViewController.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "DKMediator+First.h"

NSString * const kCTMediatorTarget = @"First";
NSString * const kCTMediatorAction = @"First";


@implementation DKMediator (First)
-(UIViewController *)DKMediator_FirstViewController:(NSDictionary *)parmas{
    return [self performTarget:kCTMediatorTarget action:kCTMediatorAction params:parmas shouldCacheTarget:NO];
}

@end
