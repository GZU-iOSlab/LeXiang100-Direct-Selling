//
//  AddresseBookTableViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-17.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "AddresseBookTableViewController.h"

@interface AddresseBookTableViewController ()

@end

@implementation AddresseBookTableViewController
extern NSString * phoneNumber;
@synthesize uerInfoArray;
@synthesize number;
@synthesize filteredListContentPhone;
@synthesize filteredListContentDic;
@synthesize phoneNumberArray;
@synthesize nameArray;
@synthesize searchDisplayController;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //self.name = [[NSMutableString alloc]init];
        //self.uerInfoArray = [[NSMutableArray alloc]init];
        self.filteredListContentDic = [[NSMutableArray alloc]init];
        self.title = @"通讯录";
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [self.nameArray release];
    [self.phoneNumberArray release];
    [self.filteredListContentDic release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISearchBar *mySearchBar = [[UISearchBar alloc] init];
	mySearchBar.delegate = self;
	[mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[mySearchBar sizeToFit];
	self.tableView.tableHeaderView = mySearchBar;
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
	[self setSearchDisplayController:searchDisplayController];
	[searchDisplayController setDelegate:self];
	[searchDisplayController setSearchResultsDataSource:self];
    
	[mySearchBar release];
	
	[self.tableView reloadData];
	self.tableView.scrollEnabled = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.filteredListContentDic removeAllObjects];
    [self.uerInfoArray removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContentDic removeAllObjects];// First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
    NSLog(@"nameArray:%d phoneNumberArray:%d",nameArray.count,phoneNumberArray.count);
    
    for (NSDictionary * str in self.uerInfoArray) {
        NSComparisonResult resultName = [[str objectForKey:@"name" ] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (resultName == NSOrderedSame)
        {
            [self.filteredListContentDic addObject:str];
        }
        
        NSComparisonResult resultPhone = [[str objectForKey:@"phoneNumber" ] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (resultPhone == NSOrderedSame)
        {
            [self.filteredListContentDic addObject:str];
        }
    }
    
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
	/*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
	[self.searchDisplayController.searchResultsTableView setDelegate:self];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
	/*
	 Hide the search bar
	 */
	//[self.tableView setContentOffset:CGPointMake(0, 44.f) animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        NSLog(@"filteredListContent:%d",[self.filteredListContentDic count]);
        return [self.filteredListContentDic count];
    }
	else
	{
        NSLog(@"count:%d",self.uerInfoArray.count);
        return self.uerInfoArray.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        [cell autorelease];
    }    // Configure the cell...
    NSMutableString * name = [[NSMutableString alloc]init];
    NSString * phoneNmber;
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        [name appendString: [[self.filteredListContentDic objectAtIndex:indexPath.row] objectForKey:@"name"]];
        phoneNmber = [[self.filteredListContentDic objectAtIndex:indexPath.row] objectForKey:@"phoneNumber"];
    }
	else
	{
        if ([[self.uerInfoArray objectAtIndex:indexPath.row]objectForKey:@"name"]!=nil) {
            [name appendString: [[self.uerInfoArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
        }
        phoneNmber = [[self.uerInfoArray objectAtIndex:indexPath.row]objectForKey:@"phoneNumber"];
    }
    cell.textLabel.text = name;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.detailTextLabel.text = phoneNmber;
    //NSLog(@"name:%@ number:%@",name,[[self.uerInfoArray objectAtIndex:indexPath.row]objectForKey:@"phoneNumber"]);
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [name release];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        phoneNumber = [[self.filteredListContentDic objectAtIndex:indexPath.row]objectForKey:@"phoneNumber"];
    }else
    phoneNumber = [[self.uerInfoArray objectAtIndex:indexPath.row]objectForKey:@"phoneNumber"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"反馈类型";
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
