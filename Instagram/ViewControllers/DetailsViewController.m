//
//  DetailsViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "DetailsViewController.h"
#import "ProfileViewController.h"
#import <Parse/PFImageView.h>
#import "CommentCell.h"
#import "User.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) IBOutlet UIToolbar *keyboardToolbar;
@property (weak, nonatomic) IBOutlet UITextField *hiddenField;
@property (weak, nonatomic) IBOutlet UIImageView *toolbarImageView;
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;


@property (strong, nonatomic) NSMutableArray *arrayOfComments;
@property (nonatomic) BOOL isLiked;
@property (strong, nonatomic) User *user;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchUser];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.hiddenField.delegate = self;
    self.hiddenField.inputAccessoryView = self.keyboardToolbar;
    self.commentField.delegate = self;
    self.commentField.inputAccessoryView = self.keyboardToolbar;
    self.keyboardToolbar.layer.cornerRadius = 15;
    self.toolbarImageView.layer.cornerRadius = self.toolbarImageView.bounds.size.width/2;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width/2;
    self.photoView.layer.cornerRadius = 30;
    
    self.profileImageView.file = self.post.account.image;
    [self.profileImageView loadInBackground];
    self.photoView.file = self.post.image;
    [self.photoView loadInBackground];
    
    
    self.authorLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *date = self.post.createdAt;
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    NSString *dateString = [formatter stringFromDate:date];

    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    NSString *timeString = [formatter stringFromDate:date];
    self.createdAtLabel.text = [NSString stringWithFormat:@"%@ · %@", timeString, dateString];
    
    
    self.isLiked = [self.post.likedBy containsObject:[PFUser currentUser].username];
    [self updateLabels];
    
    self.arrayOfComments = [NSMutableArray arrayWithArray: self.post.comments];
    
    [self.hiddenField becomeFirstResponder];
    [self.commentField becomeFirstResponder];
    [self.hiddenField resignFirstResponder];

}

- (IBAction)didComment:(id)sender {
    if (self.hiddenField.isFirstResponder){
        [self.hiddenField resignFirstResponder];
        self.hiddenField.userInteractionEnabled = true;
        
    } else {
        [self.hiddenField becomeFirstResponder];
        [self.commentField becomeFirstResponder];
        [self.hiddenField resignFirstResponder];
        self.hiddenField.userInteractionEnabled = false;
    }
}

-(void) fetchUser{
    PFQuery *query = [PFQuery queryWithClassName:@"Account"];
    query.limit = 20;
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query includeKey:@"image"];
    [query includeKey:@"user"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.user = posts[0];
            self.commentButton.enabled = true;
            NSLog(@"Successfully loaded user");
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
    
}

- (void)updateLabels {
    [self.likeButton setTitle:[NSString stringWithFormat: @"%@", self.post.likeCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat: @"%@", self.post.commentCount] forState:UIControlStateNormal];
    [self.likeButton setImage: (self.isLiked ? [UIImage imageNamed:@"heartfill"] : [UIImage imageNamed:@"heart"]) forState: UIControlStateNormal];
    [self.likeButton setTintColor:(self.isLiked ? [UIColor redColor] :  [UIColor whiteColor])];
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
    
    [self.post saveInBackground];
    [self updateLabels];
}



- (IBAction)didPostComment:(id)sender {
    NSDictionary *comment = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.user.user.username, self.user.image, self.commentField.text, nil] forKeys:[NSArray arrayWithObjects:@"author", @"image", @"comment", nil]];
    self.post.commentCount = [NSNumber numberWithInt:[self.post.commentCount intValue] + 1];
    [self.arrayOfComments insertObject:comment atIndex:0];
    [self.tableView reloadData];
    
    [self.post setObject:self.arrayOfComments forKey:@"comments"];
    [self.post saveInBackground];
    
    [self.hiddenField endEditing:true];
    [self.commentField endEditing:true];
    [self updateLabels];
}

- (IBAction)didEndEditing:(id)sender {
    [self.commentField endEditing:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    NSDictionary *comment = self.arrayOfComments[indexPath.row];

    //User *commentUser = comment[@"author"];
    cell.authorLabel.text = comment[@"author"];
    cell.profileImageView.file = comment[@"image"];
    [cell.profileImageView loadInBackground];
    cell.commentLabel.text = comment[@"comment"];
    
    return cell;
}

- (IBAction)doDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProfileViewController *profileViewController = [segue destinationViewController];
    profileViewController.user = self.post.account;
}


@end
