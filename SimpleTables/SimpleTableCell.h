//
//  SimpleTableCell.h
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleTableCell;


typedef UITableViewCell* (^SimpleCellCreateBlock)(SimpleTableCell* simpleCell);
typedef void(^SimpleCellConfigureBlock)(SimpleTableCell* simpleCell, UITableViewCell* tableCell);
typedef void(^SimpleCellSelectedCellBlock)(SimpleTableCell* cell, NSIndexPath* indexPath);

@interface SimpleTableCell : NSObject
{
    NSString* _cellIdentifier; // if nil, the class name will be used. The style will always be appended so
                               // that only cells of the same style will be recycled.
    UITableViewCellStyle _style;
    
    SimpleCellCreateBlock _createBlock;
    SimpleCellConfigureBlock _configureBlock;
    SimpleCellSelectedCellBlock _selectedBlock;
}

// cell style
@property (nonatomic, assign) UITableViewCellStyle style;

// get the cell identifier for this class. Defaults to the class name
@property (nonatomic, readonly) NSString* cellIdentifier;


// block for creating the cell
@property (nonatomic, copy) SimpleCellCreateBlock createBlock;

// block for configuring the cell
@property (nonatomic, copy) SimpleCellConfigureBlock configureBlock;

// block for responding to selections
@property (nonatomic, copy) SimpleCellSelectedCellBlock selectedBlock;


// create a cell - occurs when one cannot be dequed
// base implementation: calls the block if provided, or create a blank cell
- (UITableViewCell*) createCell;

// called after create OR dequeue.
// base implementation: calls the block if provided, or no action
- (void) configureCell:(UITableViewCell*)cell;

// select cell - respond to didSelectRow method
// base implementation: no action
- (void) selectCell:(NSIndexPath*)indexPath;

@end
