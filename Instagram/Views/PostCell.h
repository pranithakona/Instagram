//
//  PostCell.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostCellDelegate

- (void)clickPost: (Post*) post;

@end

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (strong, nonatomic) Post *post;
@property (nonatomic, weak) id<PostCellDelegate> delegate;

- (void)setCellWithPost: (Post*) post;

@end



NS_ASSUME_NONNULL_END
