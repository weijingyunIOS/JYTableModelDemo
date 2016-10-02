//
//  StyleCell3.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "StyleCell3.h"
#import "StyleCell3Model.h"

@implementation StyleCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - JYNodeProtocol
+ (CGFloat)heightForContent:(StyleCell3Model *)aContent{
    return 100;
}

- (void)setCellContent:(StyleCell3Model *)aCellContent{
    self.textLabel.text = aCellContent.cellTitle;
    self.detailTextLabel.text = aCellContent.cellSubTitle;
}

@end
