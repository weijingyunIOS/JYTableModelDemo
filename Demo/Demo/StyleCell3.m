//
//  StyleCell3.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "StyleCell3.h"
#import "StyleCell3Model.h"
#import <Masonry.h>

@interface StyleCell3()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;

@end

@implementation StyleCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(20);
        make.left.right.equalTo(self.label1);
        make.bottom.equalTo(self.contentView);
    }];
    
    self.label1.numberOfLines = 0;
    self.label2.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - JYNodeProtocol
- (void)setCellContent:(StyleCell3Model *)aCellContent{
    self.label1.text = aCellContent.cellTitle;
    self.label2.text = aCellContent.cellSubTitle;
}

#pragma mark - 懒加载
- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        [self.contentView addSubview:_label1];
    }
    return _label1;
}

- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        [self.contentView addSubview:_label2];
    }
    return _label2;
}

@end
