//
//  Target_One.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/5/13.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "Target_One.h"
#import "DKOneViewController.h"

@implementation Target_One
-(UIViewController *)Action_One:(NSDictionary *)parmas{
    
    DKOneViewController *vc = [[DKOneViewController alloc]init];
    
    vc.paramsOne = parmas[@"one"];
    vc.paramsTwo = parmas[@"two"];
    
    return vc;
    
}
@end
