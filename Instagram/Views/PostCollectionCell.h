//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"

@protocol PostCollectionCellDelegate

- (void)clickPost: (Post*) post;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) Post *post;
@property (nonatomic, weak) id<PostCollectionCellDelegate> delegate;

- (void)setCellWithPost: (Post*) post screenWidth:(CGFloat) width;

@end

NS_ASSUME_NONNULL_END
