//
//  CommentCell.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
