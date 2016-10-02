//
//  StyleCell1.m
//  Demo
//
//  Created by weijingyun on 16/10/1.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "StyleCell1.h"
#import "StyleCell1Model.h"

@implementation StyleCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor redColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - JYNodeProtocol
+ (CGFloat)heightForContent:(StyleCell1Model *)aContent{
    return 50;
}

- (void)setCellContent:(StyleCell1Model *)aCellContent{
    self.textLabel.text = aCellContent.cellTitle;
    self.detailTextLabel.text = aCellContent.cellSubTitle;
}


@end
