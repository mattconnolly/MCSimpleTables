//
//  SimpleTableSection.h
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleTableCell;
@class SimpleTableViewController;
@class SimpleTableSection;

typedef UIView*(^SimpleTableSectionViewBlock)(SimpleTableSection* section);

@interface SimpleTableSection : NSObject
{
    NSMutableArray* _cells;
    NSString* _title;
    __weak SimpleTableViewController* _viewController;
    SimpleTableSectionViewBlock _headerViewBlock;
    SimpleTableSectionViewBlock _footerViewBlock;
    UIView* _headerView;
    UIView* _footerView;
    CGFloat _headerHeight;
    CGFloat _footerHeight;
}

// array of SimpleTableCell objects
@property (nonatomic, readonly) NSMutableArray* cells; 

// title to show in table view
@property (nonatomic, retain) NSString* title;

// block to generate a customer header / footer view for the section, only 
// used if set and the corresponding view is nil
@property (nonatomic, copy) SimpleTableSectionViewBlock headerViewBlock;
@property (nonatomic, copy) SimpleTableSectionViewBlock footerViewBlock;
@property (nonatomic, strong) UIView* headerView;
@property (nonatomic, strong) UIView* footerView;

// height for the header / footer. If not defined, and a view is defined,
// the returned value of the property will be the height of the view plus
// some padding.
- (CGFloat) headerHeightInTable:(UITableView*)tableView;
- (CGFloat) footerHeightInTable:(UITableView*)tableView;

// the SimpleTableViewController where this section is inserted
@property (nonatomic, weak) SimpleTableViewController* viewController;

// accessor for the tableView.
@property (nonatomic, readonly) UITableView* tableView;

// count of cells in the section
@property (nonatomic, readonly) NSUInteger cellCount;

// access a specific cell
- (SimpleTableCell*) cellAtIndex:(NSUInteger)index;

// convenience to add a cell to the cells array
- (void) addCell:(SimpleTableCell*)cell;

@end
