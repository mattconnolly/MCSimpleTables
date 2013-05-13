//
//  MCSimpleTableCoreDataSectionCellProxy.m
//  MCSimpleTables
//
//  Created by Matt Connolly on 13/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableCoreDataSectionCellProxy.h"
#import "MCSimpleTableCoreDataCell.h"
#import "MCSimpleTableCoreDataSection.h"

@implementation MCSimpleTableCoreDataSectionCellProxy


- (id)initWithPrototypeCell:(MCSimpleTableCoreDataCell*)cell andManagedObject:(NSManagedObject*)object;
{
    self = [super init];
    if (self) {
        _object = object;
        _cell = cell;
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.cell;
}

// called after create OR dequeue.
// base implementation: calls the block if provided, or no action
- (void) configureCell:(UITableViewCell*)tableCell
{
    [_cell configureCell:tableCell];
    
    if (_cell.section.configureBlock) {
        _cell.section.configureBlock(_cell.section, tableCell, self.object);
    }
}

// select cell - respond to didSelectRow method
// base implementation: no action
- (void) didSelectCell
{
    [_cell didSelectCell];
    
    if (_cell.section.selectedBlock) {
        _cell.section.selectedBlock((MCSimpleTableCoreDataCell*)self, self.object);
    }
}

@end
