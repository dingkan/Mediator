//
//  DKOneViewController.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/5/13.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "DKOneViewController.h"

@interface DKOneViewController ()
@property (nonatomic, weak) UILabel *label1;
@end

@implementation DKOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.label1.text = [NSString stringWithFormat:@"%@ -----   %@",self.paramsOne,self.paramsTwo];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.label1.frame = CGRectMake(0, 100, 400, 35);
}

-(UILabel *)label1{
    if (nil == _label1) {
        UILabel *label1 = [[UILabel alloc]init];
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont boldSystemFontOfSize:18];
        [self.view addSubview:label1];
        _label1 = label1;
    }
    return _label1;
}

@end
