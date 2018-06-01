//
//  ViewController.m
//  DIYRefreshByUIBezierPath
//
//  Created by derek on 2018/6/1.
//  Copyright © 2018年 . All rights reserved.
//

#import "ViewController.h"
#import "DIYRefreshByUIBezierPath-Swift.h"
#import "DIYRefreshByUIBezierPath-Bridging-Header.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) DIYRefreshView * diyRefresh;
@property (nonatomic,strong) NSString * name;
@end

@implementation ViewController

int indexHeader = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.alwaysBounceVertical = YES;
    [self.view addSubview:_tableView];
    
    self.name = @"GYLM";//AKTA
    
    
    //75,58,247   --->  249,67,196
    self.diyRefresh = [DIYRefreshView attachWithScrollView:self.tableView plist:self.name target:self refreshAction:@selector(finishRefreshControl) color:[UIColor colorWithRed:75/255.0 green:58/255.0 blue:247/255.0 alpha:1] lineWidth:3 dropHeight:20 scale:1 showStyle:0 horizontalRandomness:300 isReverseLoadingAnimation:NO finishedCallback:^{
        
        __weak __typeof__(self) weakSelf = self;
        
        [UIView animateWithDuration:1 animations:^{
            weakSelf.diyRefresh.originalContentInsetTop = 0.0;
        }];
    }];
}

-(void)finishRefreshControl{
    
    __weak __typeof__(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        indexHeader -= 1;
        [weakSelf.tableView reloadData];
        [weakSelf.diyRefresh finishingLoading];
        weakSelf.diyRefresh.originalContentInsetTop = 64.0;
    });
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = @"这是一个测试数据";
    cell.detailTextLabel.text = @"这是一个测试数据，swift oc 混编";
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
