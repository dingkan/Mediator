//
//  DKMediator.h
//  MediatorTool
//
//  Created by 丁侃 on 2017/5/13.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKMediator : NSObject

/*
 Mediator组件化方案
    1.底层是通过runtime来获取响应的action对象调用target方法来实现
    2.组件调用
        1.远程调用(主要需要和服务端定义接口,通过字符串来获取响应的对象和方法)
        2.本地调用(需要我们来定义字符串)
 

 1.定义单列对象
 2.定义远程调用入口
 */

+(instancetype)sharedInstance;

//远程入口
-(id)performActionWithUrl:(NSURL *)url complection:(void(^)(NSDictionary *))completion;

//本地入口
-(id)performTarget:(NSString *)targetName action:(NSString *)actionName parmars:(NSDictionary *)parmars shouldCacheTatger:(BOOL)cacheTarget;

-(void)releasedCachedTargetWithTargetName:(NSString *)tagerName;

@end
