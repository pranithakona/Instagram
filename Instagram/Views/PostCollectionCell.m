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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self.photoView addGestureRecognizer:tap];
    self.profileView.layer.cornerRadius = self.profileView.bounds.size.width/2;
    self.photoView.layer.cornerRadius = 30;
    
   
}

- (void)setCellWithPost: (Post*) post screenWidth:(CGFloat)width{
    
    
    self.post = post;
    self.photoView.file = post[@"image"];
    [self.photoView loadInBackground];
    self.usernameLabel.text = self.post.author.username;
    self.photoWidthConstraint.constant = width;
    self.profileView.file = self.post.account.image;
    [self.profileView loadInBackground];
    
    
}

- (void)didTap {
    [self.delegate clickPost:self.post];
}


- (IBAction)didLike:(id)sender {
    self.isLiked = !self.isLiked;
    if (self.isLiked){
        self.post.likeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] + 1];
        NSMutableArray *likedBy = [NSMutableArray arrayWithArray: self.post.likedBy];
        [likedBy addObject:[PFUser currentUser].username];
        [self.post setObject:likedBy forKey:@"likedBy"];
    } else {
        self.post.likeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] - 1];
        NSMutableArray *likedBy = [NSMutableArray arrayWithArray: self.post.likedBy];
        [likedBy removeObject:[PFUser currentUser].username];
        [self.post setObject:likedBy forKey:@"likedBy"];
    }
    
    [self.likeButton setImage: (self.isLiked ? [UIImage imageNamed:@"heartfill"] : [UIImage imageNamed:@"heart"]) forState: UIControlStateNormal];
    [self.likeButton setTintColor:(self.isLiked ? [UIColor redColor] :  [UIColor whiteColor])];
    
    [self.post saveInBackground];

    
}

@end
