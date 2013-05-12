//
//  MCSimpleTableCoreDataCell.m
//  MCSimpleTables
//
//  Created by Matt Connolly on 12/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableCoreDataCell.h"
#import "MCSimpleTableCoreDataSection.h"

@implementation MCSimpleTableCoreDataCell

- (id)initWithSection:(MCSimpleTableCoreDataSection*)section
{
    self = [super init];
    if (self) {
        _section = section;
    }
    return self;
}

@end
