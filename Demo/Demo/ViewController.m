//
//  ViewController.m
//  Demo
//
//  Created by weijingyun on 16/9/29.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "JYTableModel.h"
#import "StyleCell1.h"
#import "StyleCell2.h"
#import "StyleCell3.h"
#import "StyleCellModel.h"
#import "StyleCell1Model1.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JYTableModel *tableModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
    [self confiTableModel];
    [self addData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)confiTableModel{
    JYCellNode *node1 = [[JYCellNode alloc] init];
    {
        node1.contentClass = [StyleCellModel class];
        node1.groupClass = @[[StyleCell1 class],[StyleCell2 class],[StyleCell3 class]];
    }
    
    JYCellNode *node2 = [[JYCellNode alloc] init];
    {
        node2.contentClass = [StyleCell1Model1 class];
        node2.groupClass = @[[StyleCell1 class]];
    }
    
    [self.tableModel registCellNodes:@[node1,node2] byTableView:self.tableView];
}

- (void)addData{
    StyleCellModel *model1 = [[StyleCellModel alloc] init];
    {
        
    }
    StyleCellModel *model2 = [[StyleCellModel alloc] init];
    {
        
    }
    
    StyleCell1Model1 *model3 = [[StyleCell1Model1 alloc] init];
    {
        
    }
    StyleCell1Model1 *model4 = [[StyleCell1Model1 alloc] init];
    {
        
    }
    [self.tableModel addContents:@[model1,model4,model2,model3]];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableModel heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [self.tableModel cellForRowAtIndexPath:indexPath];
}


#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (JYTableModel *)tableModel{
    if (!_tableModel) {
        _tableModel = [[JYTableModel alloc] init];
    }
    return _tableModel;
}

@end
