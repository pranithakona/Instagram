//
//  ProfileHeaderView.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import "ProfileHeaderView.h"

@implementation ProfileHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cardView.layer.cornerRadius = 40;
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width /2;
}

@end
