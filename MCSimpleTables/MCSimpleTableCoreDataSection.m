//
//  MCSimpleTableCoreDataSection.m
//  MCSimpleTables
//
//  Created by Matt Connolly on 12/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableCoreDataSection.h"
#import "MCSimpleTableCoreDataCell.h"
#import <CoreData/CoreData.h>

// private class for linking MCSimpleTableCell
@interface MCSimpleTablCoreDataSectionCellProxy : NSObject 
@property (nonatomic,weak) MCSimpleTableCoreDataCell* cell;
@property (nonatomic,weak) NSManagedObject* object;
@property (nonatomic,retain) NSIndexPath* indexPath;
- (id)initWithPrototypeCell:(MCSimpleTableCoreDataCell*)cell andManagedObject:(NSManagedObject*)object;
@end

@implementation MCSimpleTableCoreDataSection

- (id)initWithFetchRequest:(NSFetchRequest*)fetchRequest
      managedObjectContext:(NSManagedObjectContext *)context
                 cacheName:(NSString *)name;
{
    self = [super init];
    if (self) {
        _controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:context
                                                            sectionNameKeyPath:nil
                                                                     cacheName:name];
        _controller.delegate = self;
        
        _prototypeCell = [[MCSimpleTableCoreDataCell alloc] initWithSection:self];
        NSError* error = nil;
        [_controller performFetch:&error];
        if (error) {
            NSLog(@"Failed to perform fetch: %@", error.localizedDescription);
            return nil;
        }
    }
    return self;
}

- (NSFetchRequest*)fetchRequest
{
    return _controller.fetchRequest;
}

- (NSUInteger)cellCount
{
    NSUInteger min = self.showsNoObjectsCell ? 1 : 0;
    
    id<NSFetchedResultsSectionInfo> info = [_controller.sections objectAtIndex:0];
    return MAX(min, [info numberOfObjects]);
}

- (MCSimpleTableCell*) cellAtIndex:(NSUInteger)index
{
    NSManagedObject* object = nil;
    id<NSFetchedResultsSectionInfo> info = [_controller.sections objectAtIndex:0];
    
    if (info.numberOfObjects > 0 && index < info.objects.count) {
        object = info.objects[index];
    }
    
    MCSimpleTablCoreDataSectionCellProxy* proxy;
    proxy = [[MCSimpleTablCoreDataSectionCellProxy alloc] initWithPrototypeCell:self.prototypeCell
                                                               andManagedObject:object];
    return (MCSimpleTableCell*)proxy;
}

- (void) addCell:(MCSimpleTableCell*)cell;
{
    @throw [[NSException alloc] initWithName:@"Cannot add cells to MCSimpleTableCoreDataSection"
                                      reason:@"This section has cells provided by core data, not explicitly from code."
                                    userInfo:nil];
}


@end


@implementation MCSimpleTablCoreDataSectionCellProxy

- (id)initWithPrototypeCell:(MCSimpleTableCoreDataCell*)cell andManagedObject:(NSManagedObject*)object;
{
    self = [super init];
    if (self) {
        _object = object;
        _cell = cell;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.cell respondsToSelector:aSelector];
}

- (IMP)methodForSelector:(SEL)aSelector
{
    return [self.cell methodForSelector:aSelector];
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
