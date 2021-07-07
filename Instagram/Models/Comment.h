//
//  Comment.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment : NSObject

@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *comment;

@end

NS_ASSUME_NONNULL_END
