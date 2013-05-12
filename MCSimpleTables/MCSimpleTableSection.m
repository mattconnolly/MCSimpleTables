//
//  SimpleTableSection.m
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableSection.h"
#import "MCSimpleTableViewController.h"
#import "MCSimpleTableCell.h"

@implementation MCSimpleTableSection

const static CGFloat VIEW_HEIGHT_PADDING = 8.0f;

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


- (MCSimpleTableCell*) cellAtIndex:(NSUInteger)index
{
    return (self.cells)[index];
}

// convenience to add a cell to the cells array
- (void) addCell:(MCSimpleTableCell*)cell
{
    [self.cells addObject:cell];
    cell.viewController = self.viewController;
}


- (void) setViewController:(MCSimpleTableViewController *)viewController
{
    _viewController = viewController;
    
    for (MCSimpleTableCell* cell in _cells) {
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

- (CGFloat) footerHeightInTable:(UITableView*)tableView;
{
    if (_footerHeight) return _footerHeight;
    UIView* view = self.footerView;
    if (view)
    {
        CGSize size = CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX);
        CGSize fits = [view sizeThatFits:size];
        if (fits.height != CGFLOAT_MAX) _footerHeight = fits.height;
        _footerHeight += VIEW_HEIGHT_PADDING;
    }
    return _footerHeight;
}

- (UIView*) headerView
{
    if (_headerView == nil && self.headerViewBlock != nil)
    {
        _headerView = self.headerViewBlock(self);
    }
    return _headerView;
}

- (CGFloat) headerHeightInTable:(UITableView*)tableView
{
    if (_headerHeight) return _headerHeight;
    UIView* view = self.headerView;
    if (view)
    {
        CGSize size = CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX);
        CGSize fits = [view sizeThatFits:size];
        if (fits.height != CGFLOAT_MAX) _headerHeight = fits.height;
        _headerHeight += VIEW_HEIGHT_PADDING;
    }
    return _headerHeight;
}


@end
