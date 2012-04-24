//
//  SimpleTableViewController.m
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import "SimpleTableViewController.h"
#import "SimpleTableSection.h"
#import "SimpleTableCell.h"


@interface SimpleTableViewController ()
- (SimpleTableCell*)cellAtIndexPath:(NSIndexPath*)indexPath;
@end

@implementation SimpleTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (SimpleTableCell*)cellAtIndexPath:(NSIndexPath*)indexPath
{
    SimpleTableSection* section = [self.sections objectAtIndex:indexPath.section];
    SimpleTableCell* simpleCell = [section cellAtIndex:indexPath.row];
    
    // always setup the cell for this indexPath in case it has moved or is used for multiple
    // rows.
    simpleCell.indexPath = indexPath;
    return simpleCell;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (NSInteger) self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    SimpleTableSection* section = [self.sections objectAtIndex:sectionIndex];
    return [section cellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    
    NSString *cellIdentifier = simpleCell.cellIdentifier;
    
    // find a reusable cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // or create a new one
    if (cell == nil) {
        cell = [simpleCell createCell];
    }
    
    // Configure the cell...
    [simpleCell configureCell:cell];
    
    return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex
{
    SimpleTableSection* section = [self.sections objectAtIndex:sectionIndex];
    return section.title;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    return [simpleCell canEditRow];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    return [simpleCell cellHeight];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    [simpleCell selectCell];
}



#pragma mark - Properties

- (NSMutableArray*) sections
{
    if (!_sections) _sections = [NSMutableArray arrayWithCapacity:1];
    return _sections;
}


// convenience to add a section to the array of sections
- (void) addSection:(SimpleTableSection*)section
{
    [self.sections addObject:section];
    section.viewController = self;
}

@end
