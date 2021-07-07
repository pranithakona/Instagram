//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "PostCollectionCell.h"

@implementation PostCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.photoView addGestureRecognizer:tap];
    self.profileView.layer.cornerRadius = self.profileView.bounds.size.width/2;
    self.photoView.layer.cornerRadius = 20;
}

- (void)setCellWithPost: (Post*) post screenWidth:(CGFloat)width{
    self.post = post;
    self.photoView.file = post[@"image"];
    [self.photoView loadInBackground];
    self.captionLabel.text = post.caption;
    self.usernameLabel.text = post.author.username;
    self.photoWidthConstraint.constant = width;
    
}

- (IBAction)didTap:(id)sender {
    [self.delegate clickPost:self.post];
}

@end
