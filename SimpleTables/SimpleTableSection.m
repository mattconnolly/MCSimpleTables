//
//  SimpleTableSection.m
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import "SimpleTableSection.h"
#import "SimpleTableViewController.h"
#import "SimpleTableCell.h"

@implementation SimpleTableSection

const static CGFloat VIEW_HEIGHT_PADDING = 8.0f;

@synthesize cells = _cells;
@synthesize title = _title;
@synthesize viewController = _viewController;
@synthesize footerView = _footerView;
@synthesize footerViewBlock = _footerViewBlock;
@synthesize footerHeight = _footerHeight;
@synthesize headerView = _headerView;
@synthesize headerViewBlock = _headerViewBlock;
@synthesize headerHeight = _headerHeight;

- (id)init
{
    self = [super init];
    if (self) {
        _cells = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}


- (NSUInteger) cellCount
{
    return self.cells.count;
}


- (SimpleTableCell*) cellAtIndex:(NSUInteger)index
{
    return [self.cells objectAtIndex:index];
}

// convenience to add a cell to the cells array
- (void) addCell:(SimpleTableCell*)cell
{
    [self.cells addObject:cell];
    cell.viewController = self.viewController;
}


- (void) setViewController:(SimpleTableViewController *)viewController
{
    _viewController = viewController;
    
    for (SimpleTableCell* cell in _cells) {
        cell.viewController = viewController;
    }
}

- (UITableView*) tableView
{
    return self.viewController.tableView;
}

- (UIView*) footerView
{
    if (_footerView == nil && self.footerViewBlock != nil)
    {
        _footerView = self.footerViewBlock(self);
    }
    return _footerView;
}

- (CGFloat) footerHeight
{
    if (_footerHeight) return _footerHeight;
    UIView* view = self.footerView;
    if (view) return view.bounds.size.height + VIEW_HEIGHT_PADDING;
    return 0.0f;
}

- (UIView*) headerView
{
    if (_headerView == nil && self.headerViewBlock != nil)
    {
        _headerView = self.headerViewBlock(self);
    }
    return _headerView;
}

- (CGFloat) headerHeight
{
    if (_headerHeight) return _headerHeight;
    UIView* view = self.headerView;
    if (view) return view.bounds.size.height + VIEW_HEIGHT_PADDING;
    return 0.0f;
}


@end
