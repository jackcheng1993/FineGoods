//
//  ButtonClickCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonModel.h"

typedef void(^BuyClickedBlock)(NSString *url);

@interface ButtonClickCell : UITableViewCell

@property (nonatomic, copy) BuyClickedBlock BuyClickedBlock;

@property (nonatomic, strong) ButtonListModel *modelbtn;





@end
