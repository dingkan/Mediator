//
//  DKMediator+DkOne.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/5/13.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "DKMediator+DkOne.h"

/*
 此分类,主要是本地调用入口,在这里也可以发现通过Mediaor调用的弊端
    弊端:我们定义的`DKMediatorOneTarget``DKMediatorOneTarget`字符串,最后通过runtime获取对象和方法,那么就要对字符串进行拼接处理,所以这里定义的2个字符串必须严格的定义
 
*/

static NSString * const DKMediatorOneTarget = @"One";
static NSString * const DKMediatorOneAction = @"One";

@implementation DKMediator (DkOne)
-(UIViewController *)DKMediator_OneViewController:(NSDictionary *)params{
    
    id result = [self performTarget:DKMediatorOneTarget action:DKMediatorOneAction parmars:params shouldCacheTatger:NO];
    
    if (result == nil) {
        return [[UIViewController alloc]init];
    }else{
        return result;
    }
}
@end
