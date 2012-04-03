//
//  SimpleTableSection.m
//  SimpleTables
//
//  Created by Matt Connolly on 3/04/12.
//  Copyright (c) 2012 Sound Evolution Pty Ltd. All rights reserved.
//

#import "SimpleTableSection.h"

@implementation SimpleTableSection


@synthesize cells = _cells;
@synthesize title = _title;


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
}

@end
