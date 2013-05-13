//
//  SimpleTableViewController.m
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableViewController.h"
#import "MCSimpleTableSection.h"
#import "MCSimpleTableCell.h"


@implementation MCSimpleTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.usesCustomFooterViews = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.usesCustomFooterViews = YES;
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


- (MCSimpleTableCell*)cellAtIndexPath:(NSIndexPath*)indexPath
{
    MCSimpleTableSection* section = (self.sections)[indexPath.section];
    MCSimpleTableCell* simpleCell = [section cellAtIndex:indexPath.row];
    
    // always setup the cell for this indexPath in case it has moved or is used for multiple
    // rows.
    simpleCell.indexPath = [indexPath copy];
    return simpleCell;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (NSInteger) self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    MCSimpleTableSection* section = (self.sections)[sectionIndex];
    return [section cellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    
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
    MCSimpleTableSection* section = (self.sections)[sectionIndex];
    return section.title;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    MCSimpleTableSection* section = (self.sections)[sectionIndex];
    return [section footerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    MCSimpleTableSection* section = (self.sections)[sectionIndex];
    CGFloat height = [section footerHeightInTable:tableView];
    return height;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    MCSimpleTableSection* section = (self.sections)[sectionIndex];
    return [section headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    MCSimpleTableSection* section = (self.sections)[sectionIndex];
    CGFloat height = [section headerHeightInTable:tableView];
    return height;
}

- (BOOL) respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(tableView:heightForHeaderInSection:))
    {
        // if we don't use custom header views, pretend that we don't respond
        // to this method. UIKit will then not call it and provide its own
        // height calculations.
        return self.usesCustomHeaderViews;
    }
    
    if (aSelector == @selector(tableView:heightForFooterInSection:))
    {
        // if we don't use custom footer views, pretend that we don't respond
        // to this method. UIKit will then use its own geometry.
        return self.usesCustomFooterViews;
    }

    return [super respondsToSelector:aSelector];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    return [simpleCell canEditRow];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    return [simpleCell cellHeight];
}

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    return simpleCell.shouldShowMenu;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    return [simpleCell respondsToSelector:action];
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    [simpleCell performSelector:action withObject:sender];
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
    MCSimpleTableCell* simpleCell = [self cellAtIndexPath:indexPath];
    [simpleCell didSelectCell];
}



#pragma mark - Properties

- (NSMutableArray*) sections
{
    if (!_sections) _sections = [NSMutableArray arrayWithCapacity:1];
    return _sections;
}


// convenience to add a section to the array of sections
- (void) addSection:(MCSimpleTableSection*)section
{
    [self.sections addObject:section];
    section.viewController = self;
    section.sectionIndex = [self.sections indexOfObject:section];
}

@end
