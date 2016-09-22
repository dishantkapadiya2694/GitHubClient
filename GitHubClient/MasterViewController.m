//
//  MasterViewController.m
//  GitHubClient
//
//  Created by Dishant Kapadiya on 9/21/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CFNEtworkController.h"

@interface MasterViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *repo;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSArray *searchResults;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    CFNEtworkController *cfn = [CFNEtworkController new];
    self.repo = [cfn getRepoForRequest:@"swift"];
    self.searchBar.placeholder = self.navigationItem.title;
    self.tableView.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
    self.tableView.reloadData;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *searchString = searchBar.text;
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    CFNEtworkController *cfn = [CFNEtworkController new];
    self.repo = [cfn getRepoForRequest:searchString];
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    if (!self.repo) {
        self.repo = [[NSMutableArray alloc] init];
    }
    [self.repo insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setRepo:self.repo[indexPath.row]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSMutableDictionary *singleRepo = self.repo[indexPath.row];
    cell.textLabel.text = [singleRepo valueForKey:@"full_name"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.repo removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
