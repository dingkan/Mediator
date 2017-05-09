//
//  DKFirstViewController.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "DKFirstViewController.h"

@interface DKFirstViewController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *iconView;
@end

@implementation DKFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.view addSubview:iconView];
        _iconView = iconView;
    }
    return _iconView;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 100, self.view.frame.size.width, 16);
    
    self.iconView.frame = CGRectMake((self.view.frame.size.width - 200) * 0.5, 150, 200, 200);
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    self.titleLabel.text = titleStr;
}

-(void)setIconName:(NSString *)iconName{
    _iconName = iconName;
    self.iconView.image = [UIImage imageNamed:iconName];
}

@end
