//
//  FeedViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "FeedViewController.h"
#import "OpeningViewController.h"
#import "DetailsViewController.h"
#import "SceneDelegate.h"
#import "PostCollectionCell.h"
#import <Parse/Parse.h>

@interface FeedViewController () <UICollectionViewDelegate, UICollectionViewDataSource, PostCollectionCellDelegate, UICollectionViewDelegateFlowLayout>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSArray *arrayOfPosts;
@property (strong, nonatomic)  UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *layout = [self.collectionView collectionViewLayout];
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    layout.minimumLineSpacing = -60;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PostCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"PostCollectionCell"];
    self.collectionView.collectionViewLayout = layout;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeed) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
    [self fetchFeed];
    
}

- (void)viewWillAppear:(BOOL)animated {
     self.navigationController.navigationBar.hidden = YES;
}

-(void) fetchFeed{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    [query includeKey:@"image"];
    [query includeKey:@"author"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            [self.collectionView reloadData];
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
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
    
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];

    if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PostCollectionCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.delegate = self;
    [cell setCellWithPost:self.arrayOfPosts[indexPath.item] screenWidth:self.collectionView.frame.size.width];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)clickPost: (Post *) post{
    [self performSegueWithIdentifier:@"DetailsSegue" sender:post];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"DetailsSegue"]){
        DetailsViewController *detailsViewController = [segue destinationViewController];
        Post *post = sender;
        detailsViewController.post = post;
    }
}


@end
