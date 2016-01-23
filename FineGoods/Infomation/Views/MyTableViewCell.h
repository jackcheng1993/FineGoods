//
//  MyTableViewCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabelViewModel.h"
@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarName;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *datestrTime;
@property (weak, nonatomic) IBOutlet UIImageView *recommendImage;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIView *tagsView;
//
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carveImageone;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buyImage;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;


- (void)setCellWithModel:(List_Model *)model;
@end
