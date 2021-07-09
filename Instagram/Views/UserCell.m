//
//  UserCell.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.photoView.layer.cornerRadius = 20;
}

@end
