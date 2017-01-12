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
#import "StyleCell1Model.h"
#import "StyleCell2Model.h"
#import "StyleCell3Model.h"
#import "JYGroupNode.h"

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reload 1-1" style:0 target:self action:@selector(reloadIndexPath)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:0 target:self action:@selector(reload)];
}

- (void)confiTableModel{
    JYGroupNode *node = [JYGroupNode nodeContentClass:[StyleCellModel class] config:^(JYGroupNode *node) {
        
        node.groupHeaderCellNode = [JYCellNode cellClass:[StyleCell1 class] config:^(JYCellNode *cellNode) {
            
        }];
        
        node.groupCellNode = [JYCellNode cellClass:[StyleCell2 class] config:^(JYCellNode *cellNode) {
            
        }];
        
        node.groupFooterCellNode = [JYCellNode cellClass:[StyleCell3 class] config:^(JYCellNode *cellNode) {
            
        }];
        
    }];
    
    [self.tableModel registCellNodes:@[node] byTableView:self.tableView cellDelegate:self];
    [self.tableModel configCellEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 20) marginColor:[UIColor whiteColor]];
}

- (void)addData{
    StyleCellModel *model1 = [[StyleCellModel alloc] init];
    {
        StyleCell1Model *cell1 = [[StyleCell1Model alloc] init];
        cell1.cellTitle = @"model1_组头_cellTitle";
        cell1.cellSubTitle = @"model1_组头_cellSubTitle";
        
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 2; i ++) {
            StyleCell2Model *cell2 = [[StyleCell2Model alloc] init];
            cell2.cellTitle = [NSString stringWithFormat:@"model1_中间拼接_cellTitle_%tu",i];
            cell2.cellSubTitle = [NSString stringWithFormat:@"model1_中间拼接_cellSubTitle_%tu",i];
            [arrayM addObject:cell2];
        }
        
        StyleCell3Model *cell3 = [[StyleCell3Model alloc] init];
        cell3.cellTitle = @"model1_组尾cellTitle";
        cell3.cellSubTitle = @"model1_组尾cellSubTitle";
        
        model1.cell1Model = cell1;
        model1.cell2ModelArray = [arrayM copy];
        model1.cell3Model = cell3;
     
    }
    StyleCellModel *model2 = [[StyleCellModel alloc] init];
    {
        
        StyleCell1Model *cell1 = [[StyleCell1Model alloc] init];
        cell1.cellTitle = @"model2_组头cellTitle";
        cell1.cellSubTitle = @"model2_组头cellSubTitle";
        
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 3; i ++) {
            StyleCell2Model *cell2 = [[StyleCell2Model alloc] init];
            cell2.cellTitle = [NSString stringWithFormat:@"model2_中间拼接_cellTitle_%tu",i];
            cell2.cellSubTitle = [NSString stringWithFormat:@"model2_中间拼接_cellSubTitle_%tu",i];
            [arrayM addObject:cell2];
        }
        
        StyleCell3Model *cell3 = [[StyleCell3Model alloc] init];
        cell3.cellTitle = @"model2_组尾cellTitle";
        cell3.cellSubTitle = @"model2_组尾cellSubTitle";
        
        model2.cell1Model = cell1;
        model2.cell2ModelArray = [arrayM copy];
        model2.cell3Model = cell3;
        
    }
    
    [self.tableModel addContents:@[model1,model2,model1,model2,model1,model2]];
}

#pragma mark - 测试cell间距调整展示问题
- (void)reloadIndexPath{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
}

- (void)reload{
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
