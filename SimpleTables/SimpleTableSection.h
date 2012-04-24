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

@interface SimpleTableSection : NSObject
{
    NSMutableArray* _cells;
    NSString* _title;
    __weak SimpleTableViewController* _viewController;
}

// array of SimpleTableCell objects
@property (nonatomic, readonly) NSMutableArray* cells; 

// title to show in table view
@property (nonatomic, retain) NSString* title;

// the SimpleTableViewController where this section is inserted
@property (nonatomic, weak) SimpleTableViewController* viewController;

// accessor for the tableView.
@property (nonatomic, readonly) UITableView* tableView;

- (NSUInteger) cellCount;
- (SimpleTableCell*) cellAtIndex:(NSUInteger)index;

// convenience to add a cell to the cells array
- (void) addCell:(SimpleTableCell*)cell;

@end
