//
//  SimpleTableCell.h
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleTableCell;
@class SimpleTableViewController;


typedef UITableViewCell* (^SimpleCellCreateBlock)(SimpleTableCell* simpleCell);
typedef void(^SimpleCellConfigureBlock)(SimpleTableCell* simpleCell, UITableViewCell* tableCell);
typedef void(^SimpleCellSelectedCellBlock)(SimpleTableCell* simpleCell);

@interface SimpleTableCell : NSObject
{
    Class _cellClass; // if nil, defaults to UITableViewCell
    NSString* _cellIdentifier; // if nil, the class name will be used. The style will always be appended so
                               // that only cells of the same style will be recycled.
                               
    // will always be set before calling the class or its blocks
    NSIndexPath* _indexPath;
    BOOL _canEditRow;
    CGFloat _cellHeight;
    
    // configuration
    UITableViewCellStyle _style;
    
    // blocks for configuration and responding to actions
    SimpleCellCreateBlock _createBlock;
    SimpleCellConfigureBlock _configureBlock;
    SimpleCellSelectedCellBlock _selectedBlock;
    
    // weak reference to the view controller containing this cell
    __weak SimpleTableViewController* _viewController;
}

//
//=== Properties ===
//

// cell style
@property (nonatomic, assign) UITableViewCellStyle style;

// the cell identifier for this class. Defaults to the class name if nil
@property (nonatomic, strong) NSString* cellIdentifier;

// the class to be used for the cell, if nil, defaults to UITableViewCell
@property (nonatomic, assign) Class cellClass;

// set by the SimpleTable controller before calling any of the blocks or methods below
@property (nonatomic, strong) NSIndexPath* indexPath;

// block for creating the cell
@property (nonatomic, copy) SimpleCellCreateBlock createBlock;

// block for configuring the cell
@property (nonatomic, copy) SimpleCellConfigureBlock configureBlock;

// block for responding to selections
@property (nonatomic, copy) SimpleCellSelectedCellBlock selectedBlock;

// true if the row can be edited
@property (nonatomic, assign) BOOL canEditRow;

// override the cell height if required.
@property (nonatomic, assign) CGFloat cellHeight;

// the SimpleTableViewController where this section is inserted
@property (nonatomic, weak) SimpleTableViewController* viewController;

// get the actual cell. This may return nil if the cell is not visible
// If this SimpleTableCell instance controls multiple cells, then its value will only
// be reliable after the indexPath property has been set
@property (nonatomic, readonly) UITableViewCell* tableCell;

// should the cell show any edit menu (cut,copy,paste,etc)
// functions need to be implemented as methods on the subclass of
// the SimpleCell instance for that cell.
@property (nonatomic, assign) BOOL shouldShowMenu;

//
//=== Methods ===
//

// callback: create a cell - occurs when one cannot be dequed
// base implementation: calls the block if provided, or create a blank cell
- (UITableViewCell*) createCell;

// callback: called after create OR dequeue.
// base implementation: calls the block if provided, or no action
- (void) configureCell:(UITableViewCell*)cell;

// callback: select cell - respond to didSelectRow method
// base implementation: calls the selected block if provided, or no action
- (void) didSelectCell;


@end
