//
//  PostCell.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithPost: (Post*) post{
    self.post = post;
    self.photoView.file = post[@"image"];
    [self.photoView loadInBackground];
    self.captionLabel.text = post.caption;
    
}

- (IBAction)didTap:(id)sender {
    [self.delegate clickPost:self.post];
}

@end
