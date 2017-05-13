//
//  ViewController.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//


#import "ViewController.h"
#import "DKMediator+DkOne.h"

@interface ViewController ()
@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, weak) UITextField *textF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self btn];
    
    [self textF];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIButton *)btn{
    if (!_btn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"本地入口" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _btn = btn;
    }
    return _btn;
}

-(UITextField *)textF{
    if (!_textF) {
        UITextField *textF = [[UITextField alloc]init];
        textF.text = @"dingkan://One/One?one=FirstParams&two:SecondParams";
        [self.view addSubview:textF];
        _textF = textF;
    }
    return _textF;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _btn.frame = CGRectMake(30, 100, 100, 35);
    _textF.frame = CGRectMake(30, 150, 400, 35);
}


-(void)Click{
    UIViewController *vc = [[DKMediator sharedInstance] DKMediator_OneViewController:@{@"one":@"本地调用参数一",@"two":@"本地调用参数二"}];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
