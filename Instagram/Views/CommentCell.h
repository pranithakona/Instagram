//
//  CommentCell.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

NS_ASSUME_NONNULL_END
