//
//  DKMediator.h
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKMediator : NSObject
+ (instancetype)sharedInstance;
//远程调用入口
-(id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))complection;

//本地调用入口
-(id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

-(void)releaseCacheTargetWithTargetName:(NSString *)targetName;

@end
