//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"
#import "User.h"


NS_ASSUME_NONNULL_BEGIN

@protocol PostCollectionCellDelegate;

@interface PostCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoWidthConstraint;
@property (weak, nonatomic) IBOutlet PFImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) id<PostCollectionCellDelegate> delegate;
@property (nonatomic) BOOL isLiked;

- (void)setCellWithPost: (Post*) post screenWidth:(CGFloat) width;

@end

@protocol PostCollectionCellDelegate

- (void) clickPost: (Post *) post;

@end

NS_ASSUME_NONNULL_END
