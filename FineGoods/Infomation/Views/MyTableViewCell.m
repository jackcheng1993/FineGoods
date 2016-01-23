//
//  MyTableViewCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "MyTableViewCell.h"

#import "Define.h"
@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setCellWithModel:(List_Model *)model {
    [_avatarName sd_setImageWithURL:[NSURL URLWithString:model.author.avatar]];
    _nickname.text = model.author.nickname;
    _datestrTime.text  = model.datestr;
    if ([model.is_recommend isEqualToString:@"1"]) {
        
        _recommendImage.image = [UIImage imageNamed:@"alert_success_icon"];
    }
    //关注
    [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
    //[_attentionButton setTitle:@"已关注" forState:UIControlStateSelected];
    Pics_Model *picModel = model.pics[0];
    [_picImage sd_setImageWithURL:[NSURL URLWithString:picModel.url]];
    _contentLabel.text = model.content;
    _iconImage.image = [UIImage imageNamed:@"alert_error_icon"];
    NSArray *array = model.tags;
    CGFloat w = 0;//纪录上一个button的宽度
    CGFloat h = 10;//
    for (NSInteger i = 0; i< array.count; i++) {
        
        Tags_Model *model = array[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [model.name boundingRectWithSize:CGSizeMake(FScreenWidth - 50, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        button.frame = CGRectMake(10+w, 0, length + 15, h);
        if (_tagsView.frame.size.width < 10 + w +length + 15 ) {
            button.frame = CGRectMake(10 + w, h, 0, 0);
            i = array.count - 1;
            
        }
        
        [_tagsView addSubview:button];
        
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
