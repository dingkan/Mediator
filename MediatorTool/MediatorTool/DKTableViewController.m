//
//  DKTableViewController.m
//  MediatorTool
//
//  Created by 丁侃 on 2017/4/28.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "DKTableViewController.h"
#import "DKMediator.h"
#import "DKMediator+First.h"

@interface DKTableViewController ()

@end

@implementation DKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HHHHH"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHHHH"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = [NSString stringWithFormat:@"%ld",indexPath.row];
    NSString *icon = (indexPath.row % 2) ? @"icon1" :@"icon2";
    
    UIViewController *v = [[DKMediator sharedInstance] DKMediator_FirstViewController:@{
                                                                       @"titleStr":title,
                                                                       @"iconName":icon
                                                                       }];
    
    [self presentViewController:v animated:YES completion:nil];
}

@end
