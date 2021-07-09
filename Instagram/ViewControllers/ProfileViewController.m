//
//  ProfileViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "ProfileViewController.h"
#import "OpeningViewController.h"
#import "SceneDelegate.h"
#import "ProfileHeaderView.h"
#import "ProfileCell.h"
#import "Post.h"
#import "User.h"
#import <Parse/Parse.h>

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSArray *arrayOfPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    UICollectionViewFlowLayout *layout = [self.collectionView collectionViewLayout];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    CGFloat itemWidth = (self.collectionView.frame.size.width - 30 - layout.minimumInteritemSpacing * 3)/3;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProfileHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProfileHeaderView"];
    
    [self.activityIndicator startAnimating];
    [self fetchFeed];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

-(void) fetchFeed{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query includeKey:@"image"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            [self.collectionView reloadData];
            NSLog(@"Successfully loaded timeline");
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayOfPosts.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    Post *post = self.arrayOfPosts[indexPath.row];

    cell.photoView.file = post[@"image"];
    [cell.photoView loadInBackground];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ProfileHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"ProfileHeaderView" forIndexPath:indexPath];

    headerView.optionsButton.hidden = true;
    [headerView.backButton addTarget:self action:@selector(didTapProfile) forControlEvents:UIControlEventTouchUpInside];
    
    headerView.nameLabel.text = self.user.name;
    headerView.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.user.username];
    headerView.bioLabel.text = self.user.bio;
    if (self.user.image){
        headerView.profileImageView.file = self.user.image;
        [headerView.profileImageView loadInBackground];
    }
    else {
        headerView.profileImageView.image = [UIImage systemImageNamed:@"person.circle"];
    }
    headerView.postsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.arrayOfPosts.count];
    headerView.followersLabel.text = [NSString stringWithFormat:@"%u", arc4random_uniform(1000)];
    headerView.followingLabel.text = [NSString stringWithFormat:@"%u", arc4random_uniform(1000)];
    return headerView;

}

- (void)didTapProfile{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)onLogout {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects[0].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OpeningViewController *openingViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpeningViewController"];
        sceneDelegate.window.rootViewController = openingViewController;
    }];
    
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}


@end
