//
//  ProfileCell.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.photoView.layer.cornerRadius = 20;
}

@end
