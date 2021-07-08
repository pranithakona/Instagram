//
//  DetailsViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "DetailsViewController.h"
#import <Parse/PFImageView.h>
#import "CommentCell.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>
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

@property (strong, nonatomic) NSMutableArray *arrayOfComments;
@property (nonatomic) BOOL isLiked;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.commentField.delegate = self;
    self.commentField.inputAccessoryView = self.keyboardToolbar;
    self.keyboardToolbar.layer.cornerRadius = 15;
    self.toolbarImageView.layer.cornerRadius = self.toolbarImageView.bounds.size.width/2;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.photoView.layer.cornerRadius = 30;
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
    
    [self.commentField becomeFirstResponder];

}

- (void)updateLabels {
    [self.likeButton setTitle:[NSString stringWithFormat: @"%@", self.post.likeCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat: @"%@", self.post.commentCount] forState:UIControlStateNormal];
    [self.likeButton setImage: (self.isLiked ? [UIImage imageNamed:@"heartfill"] : [UIImage imageNamed:@"heart"]) forState: UIControlStateNormal];
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

- (IBAction)didComment:(id)sender {
    if (self.commentField.isFirstResponder){
        NSLog(@"yes");
        //self.keyboardToolbar.hidden = true;
        [self.commentField resignFirstResponder];
        
    } else {
        NSLog(@"no");
        //self.keyboardToolbar.hidden = false;
        [self.commentField becomeFirstResponder];
        
    }
}

- (IBAction)didPostComment:(id)sender {
    NSDictionary *comment = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[PFUser currentUser].username, self.commentField.text, nil] forKeys:[NSArray arrayWithObjects:@"author", @"comment", nil]];
    self.post.commentCount = [NSNumber numberWithInt:[self.post.commentCount intValue] + 1];
    [self.arrayOfComments insertObject:comment atIndex:0];
    [self.tableView reloadData];
    
    [self.post setObject:self.arrayOfComments forKey:@"comments"];
    [self.post saveInBackground];
    
    [self.hiddenField endEditing:true];
    [self.commentField endEditing:true];
    [self updateLabels];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    NSDictionary *comment = self.arrayOfComments[indexPath.row];

    cell.authorLabel.text = comment[@"author"];
    cell.commentLabel.text = comment[@"comment"];
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
