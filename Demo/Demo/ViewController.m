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
    JYNode *node1 = [JYNode nodeContentClass:[StyleCellModel class] config:^(JYNode *node) {
        
//        [node addCellNode:[JYCellNode cellClass:[StyleCell1 class] config:^(JYCellNode *cellNode) {
//            cellNode.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
//            cellNode.marginColor = self.tableView.backgroundColor;
//        }]];
//        
//        [node addCellNode:[JYCellNode cellClass:[StyleCell2 class] config:^(JYCellNode *cellNode) {
//            cellNode.edgeInsets = UIEdgeInsetsMake(10, 10, 0, 10);
//            cellNode.marginColor = self.tableView.backgroundColor;
////            cellNode.topColor = [UIColor purpleColor];
//        }]];
//        
//        [node addCellNode:[JYCellNode cellClass:[StyleCell3 class] config:^(JYCellNode *cellNode) {
//            cellNode.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
////            cellNode.marginColor = self.tableView.backgroundColor;
//            cellNode.topColor = [UIColor purpleColor];
//            cellNode.bottomColor = [UIColor blueColor];
//            cellNode.leftColor = [UIColor redColor];
//            cellNode.rightColor = [UIColor redColor];
//        }]];
        node.jy_CellType = 1;
        [node addCellNodes:@[[StyleCell1 class],[StyleCell2 class],[StyleCell3 class]]];
    }];
    
    JYNode *node1_1 = [JYNode nodeContentClass:[StyleCellModel class] config:^(JYNode *node) {
        node.jy_CellType = 0;
        [node addCellNodes:@[[StyleCell1 class],[StyleCell2 class]]];
    }];
    
    JYNode *node2 = [JYNode nodeContentClass:[StyleCell1Model class] config:^(JYNode *node) {
        [node addCellNodes:@[[StyleCell1 class]]];
    }];
    
    [self.tableModel registCellNodes:@[node1,node1_1,node2] byTableView:self.tableView];
    [self.tableModel configCellEdgeInsets:UIEdgeInsetsMake(0, 10, 10, 10) marginColor:self.tableView.backgroundColor];
    [self.tableModel configSeparatorColor:[UIColor blackColor] hiddenLast:YES];
}

- (void)addData{
    StyleCellModel *model1 = [[StyleCellModel alloc] init];
    {
        model1.cell1Title = @"model1 - 头";
        model1.cell1SubTitle = @"cell1SubTitle";
        model1.cell2Title = @"model1 - 中";
        model1.cell2SubTitle = @"cell2SubTitle";
        model1.cell3Title = @"model1 - 尾部宣传部长新技能就可能参考咨询啊圣诞节卡升级到那时空间三大咖是加拿大桑吉内蒂卡上三等奖阿森纳的空间啊说";
        model1.cell3SubTitle = @"cell3SubTitle - 阿斯顿撒开你的卡萨按实际的时刻记得你卡上阿萨德卡蛇年大吉阿森纳将卡上的科技三等奖";
    }
    StyleCellModel *model2 = [[StyleCellModel alloc] init];
    {
        model2.cell1Title = @"model2 - 头";
        model2.cell1SubTitle = @"cell1SubTitle";
        model2.cell2Title = @"model2 - 中";
        model2.cell2SubTitle = @"cell2SubTitle";
    }
    
    StyleCell1Model *model3 = [[StyleCell1Model alloc] init];
    {
        model3.cellTitle = @"model3.cellTitle";
        model3.cellSubTitle = @"model3.cellSubTitle";
    }
    StyleCell1Model *model4 = [[StyleCell1Model alloc] init];
    {
        model4.cellTitle = @"model4.cellTitle";
        model4.cellSubTitle = @"model4.cellSubTitle";
    }
    [self.tableModel addContents:@[model1,model4,model2,model3,model1,model4,model2,model3,model1,model4,model2,model3,model1,model4,model2,model3,model1,model4,model2,model3,model1,model4,model2,model3,model1,model4,model2,model3,model1,model4,model2,model3]];
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
