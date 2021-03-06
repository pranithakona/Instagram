//
//  Post.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic account;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic likedBy;
@dynamic comments;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage:( UIImage * _Nullable )image withCaption:( NSString * _Nullable )caption withUser:(User *)user withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.account = user;
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    newPost.likedBy = [NSMutableArray array];
    newPost.comments = [NSMutableArray array];
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
