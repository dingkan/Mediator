//
//  Target_First.h
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_First : NSObject

-(UIViewController *)Action_First:(NSDictionary *)params;

-(UIViewController *)Action_NotFound:(NSDictionary *)params;

@end
