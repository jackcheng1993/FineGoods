//
//  ButtonTableViewCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DisDetailViewController.h"

#import "DiscoverModel.h"


typedef void(^BtnClickedBlock)(NSString *btnid, NSString *btnType, NSString *tagid);

@interface ButtonTableViewCell : UITableViewCell

@property (nonatomic, copy) BtnClickedBlock BtnClickedBlock;

-(void)updateWithModel:(NSArray *)buttonSource;

@end
