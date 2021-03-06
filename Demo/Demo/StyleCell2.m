//
//  StyleCell2.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "StyleCell2.h"
#import "StyleCell2Model.h"

@implementation StyleCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor blueColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - JYNodeProtocol
+ (CGFloat)heightForContent:(StyleCell2Model *)aContent{
    return 100;
}

- (void)setCellContent:(StyleCell2Model *)aCellContent{
    self.textLabel.text = aCellContent.cellTitle;
    self.detailTextLabel.text = aCellContent.cellSubTitle;
}

@end
