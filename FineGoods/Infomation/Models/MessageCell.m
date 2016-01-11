//
//  MessageCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "MessageCell.h"
#import "Define.h"


@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageICON;
@property (weak, nonatomic) IBOutlet UILabel *textName;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end
@implementation MessageCell {
    UIImageView *_messageImageView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSInteger)index{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //NSLog(<#NSString * _Nonnull format, ...#>)
        self = [[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil][index];
        //[self customViews];
    }
    return self;
}
- (void)setModel:(MessageModel *)model {

    _model = model;
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    
}

- (void)setLabelName:(NSString *)textName {
    _textName.text = textName;
}

- (void)customViews {
    
    
    
    _messageImageView = [UIImageView new];
    [self.contentView addSubview:_messageImageView];
    
    
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //CGFloat leftPadding = 5;
   // CGFloat topPadding = 10;
    //CGFloat padding = 5;
    
   // _messageImageView.frame = CGRectMake(leftPadding, padding, FScreenWidth - 2*leftPadding, 160);
    
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
