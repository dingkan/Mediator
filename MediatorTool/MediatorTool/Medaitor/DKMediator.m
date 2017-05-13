//
//  DKMediator.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/5/13.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "DKMediator.h"

@interface DKMediator()
@property (nonatomic, strong) NSMutableDictionary *cachedTarget;
@end

@implementation DKMediator

+(instancetype)sharedInstance{
    
    static DKMediator *mediator;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[DKMediator alloc]init];
    });
    return mediator;
}

-(id)performActionWithUrl:(NSURL *)url complection:(void(^)(NSDictionary *))completion{
    
    //1.解析url,从而获取对象的action,target;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //获取URL中定义的接口
    NSString *urlStr = [url path];
        //解析参数
    for (NSString *subStr in [urlStr componentsSeparatedByString:@"&"]) {
       //muxinglive://MXStarRecruitHome/taskDetail
        
        //?task_id=123&live_id=123
        
        NSArray *parmasArray = [subStr componentsSeparatedByString:@"="];
        
        if (parmasArray.count < 2) {continue;}
        
        [dict setValue:parmasArray.lastObject forKey:parmasArray.firstObject];
    }
    
    //3.获取响应对象
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    if ([actionName containsString:@"native"]) {
        return @(NO);
    }
    
    
    //2.通过runtim获取响应对象
    id result = [self performTarget:url.host action:actionName parmars:dict shouldCacheTatger:NO];
    
    
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        }else{
            completion(nil);
        }
    }
    
    return  result;
}

-(id)performTarget:(NSString *)targetName action:(NSString *)actionName parmars:(NSDictionary *)parmars shouldCacheTatger:(BOOL)cacheTarget{
    //通过runtime来获取响应对象
    //通过mediator中间类获取响应对象,本质上是利用runtime特性通过string来获取响应对象,所以此组件化方案存在一大弊端:1.外部通过url跳转必须和服务端定义接口,2.通过本地调用,也是极大的抵赖字符串

    //1.获取对象和方法,这里需要将字符串转化为我们定义的对象,所以需要对string进行初步处理
//    id target = NSClassFromString(targetName);
//    SEL action = NSSelectorFromString(actionName);
    
    NSString *targetClassStr = [NSString stringWithFormat:@"Target_%@",targetName];
    NSString *actionClassStr = [NSString stringWithFormat:@"Action_%@:",actionName];
    
    Class targetClass = nil;
    
    //2.查看缓存
    NSObject *target = [self.cachedTarget valueForKey:targetClassStr];
    if (target == nil) {
        targetClass = NSClassFromString(targetClassStr);
        target = [[targetClass alloc]init];
    }
    
    SEL action = NSSelectorFromString(actionClassStr);
    
    //3.判空
    if (target == nil) {
        
        //无法获取对象,在这里进行相应处理,这里只是简单的返Nil
        
        return nil;
    }
    
    //4.判断是否需要缓存
    if (cacheTarget) {
        [self.cachedTarget setValue:target forKey:targetClassStr];
    }
    
    
    //5.利用runtime来让我们定义的对象相应对应的方法,来获取组件
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [target performSelector:action withObject:parmars];
#pragma clang diagnostic pop
    }else{
        
        //如果对无法获取相应方法进行统一处理
        SEL notFound = NSSelectorFromString([NSString stringWithFormat:@"notFound:"]);
        
        
        if ([target respondsToSelector:notFound]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            return [target performSelector:notFound];
#pragma clang diagnostic pop
        }else{
            
            //这里对无法响应notFound方法进行处理
            [self.cachedTarget removeObjectForKey:targetClassStr];
            
            //这里只是简单的返回Nil
            return nil;
        }
    }
    return nil;
}


//暴露移除缓存
-(void)releasedCachedTargetWithTargetName:(NSString *)tagerName{
    NSString *targetClassName = [NSString stringWithFormat:@"Target_%@",tagerName];
    [self.cachedTarget removeObjectForKey:targetClassName];
}

-(NSMutableDictionary *)cachedTarget{
    if (!_cachedTarget) {
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    return _cachedTarget;
}


@end
