//
//  SimpleTableCell.m
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize style = _style;
@synthesize createBlock = _createBlock;
@synthesize configureBlock = _configureBlock;
@synthesize selectedBlock = _selectedBlock;
@synthesize indexPath = _indexPath;


- (NSString*) cellIdentifier
{
    NSString* identifier = _cellIdentifier;
    if (!identifier) identifier = NSStringFromClass([self class]);
    
    return [NSString stringWithFormat:@"%@-%d", identifier, _style];
}

// create a cell - occurs when one cannot be dequed
// base implementation: calls the block if provided, or create a blank cell
- (UITableViewCell*) createCell
{
    // subclasses should override
    UITableViewCell* result = nil;
    if (_createBlock) {
        result = _createBlock(self);
    } else {
        result = [[UITableViewCell alloc] initWithStyle:self.style
                                        reuseIdentifier:self.cellIdentifier];
    }
    return result;
}


// called after create OR dequeue.
// base implementation: calls the block if provided, or no action
- (void) configureCell:(UITableViewCell*)cell
{
    if (_configureBlock) {
        _configureBlock(self, cell);
    }
}

// select cell - respond to didSelectRow method
// base implementation: no action
- (void) selectCell
{
    if (_selectedBlock) {
        _selectedBlock(self);
    }
}

@end
