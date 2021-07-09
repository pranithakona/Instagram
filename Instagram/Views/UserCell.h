//
//  UserCell.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *photoView;

@end

NS_ASSUME_NONNULL_END
