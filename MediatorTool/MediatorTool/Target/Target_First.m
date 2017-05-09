//
//  Target_First.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "Target_First.h"
#import "DKFirstViewController.h"

@implementation Target_First
-(UIViewController *)Action_First:(NSDictionary *)params{
    
    DKFirstViewController *vc = [[DKFirstViewController alloc]init];
    if ([params valueForKey:@"titleStr"]) {
        vc.titleStr = params[@"titleStr"];
    }
    
    if ([params valueForKey:@"iconName"]) {
        vc.iconName = params[@"iconName"];
    }
    
    return vc;
}
@end
