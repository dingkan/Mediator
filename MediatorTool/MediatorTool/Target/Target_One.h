//
//  Target_One.h
//  MediatorTool
//
//  Created by 丁侃 on 2017/5/13.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>
//此对象,就是runtime通过String来获取的响应对象,这里我们需要定义对象的方法,方法名称需要服务端进行统一,所需参数同样需要统一
#import <UIKit/UIKit.h>

@interface Target_One : NSObject

-(UIViewController *)Action_One:(NSDictionary *)parmas;

@end
