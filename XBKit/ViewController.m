//
//  ViewController.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "ViewController.h"


#import "XBColorSegement.h"
#import "UIImage+Extension.h"
#import "UIButton+Utils.h"
@interface ViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *listTableView;

@property (nonatomic, strong) NSArray *listArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.listTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
