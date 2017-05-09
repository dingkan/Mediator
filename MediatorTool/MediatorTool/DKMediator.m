//
//  DKMediator.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
// DingKan://First/First?titleStr=123123123&iconName=icon1

#import "DKMediator.h"

@interface DKMediator()


@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation DKMediator


#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static DKMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[DKMediator alloc] init];
        
    });
    return mediator;
}

-(id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))complection{
    
#if DEBUG
    
    
#else
    if (![url.scheme isEqualToString:@"DingKan"]) {
        // 这里就是针对远程app调用404的简单处理了，根据不同app的产品经理要求不同，你们可以在这里自己做需要的逻辑
        return @(NO);
    }
    
#endif
    
    //解析参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *paramsStr = [url query];
    
    for (NSString *param in [paramsStr componentsSeparatedByString:@"&"]) {
        
        NSArray *elts = [param componentsSeparatedByString:@"="];
        
        if (elts.count < 2) {continue;}
        
        [dict setObject:[elts lastObject] forKey:[elts firstObject]];
        
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    id result = [self performTarget:url.host action:actionName params:dict shouldCacheTarget:NO];
    
    if (complection) {
        if (result) {
            complection(@{@"result":result});
        }else{
            complection(nil);
        }
    }
    
    return  result;
    
}

-(id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    //获取响应的action&Taget
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@",targetName];
    NSString *actionClassString = [NSString stringWithFormat:@"Action_%@:",actionName];
    
    Class targetClass = nil;
    NSObject *target = self.cachedTarget[targetClassString];
    
    //去缓存中查看有没有对应的taget
    if (target == nil) {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc]init];
    }
    
    SEL action = NSSelectorFromString(actionClassString);
    
    if (target == nil) {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        return  nil;
    }
    
    //缓存
    if (shouldCacheTarget) {
        self.cachedTarget[targetClassString] = target;
    }
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }else{
        //可能是swift对象
        actionClassString = [NSString stringWithFormat:@"Action:%@WithParams:",actionName];
        action = NSSelectorFromString(actionClassString);
        
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        } else {
             // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
            SEL action = NSSelectorFromString(@"notFound:");
            if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
            } else {
                // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
                [self.cachedTarget removeObjectForKey:targetClassString];
                return nil;
        }
    }
    }
}

-(void)releaseCacheTargetWithTargetName:(NSString *)targetName{
    NSString *targetClassName = [NSString stringWithFormat:@"Target_%@",targetName];
    
    [self.cachedTarget removeObjectForKey:targetName];
}

-(NSMutableDictionary *)cachedTarget{
    if (!_cachedTarget) {
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    return _cachedTarget;
}

@end
