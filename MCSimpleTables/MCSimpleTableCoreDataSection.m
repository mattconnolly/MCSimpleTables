//
//  MCSimpleTableCoreDataSection.m
//  MCSimpleTables
//
//  Created by Matt Connolly on 12/05/13.
//  Copyright (c) 2013 Matthew Connolly. All rights reserved.
//

#import "MCSimpleTableCoreDataSection.h"
#import "MCSimpleTableCoreDataCell.h"
#import "MCSimpleTableViewController.h"
#import <CoreData/CoreData.h>

// private class for linking MCSimpleTableCell
@interface MCSimpleTablCoreDataSectionCellProxy : NSObject 
@property (nonatomic,weak) MCSimpleTableCoreDataCell* cell;
@property (nonatomic,weak) NSManagedObject* object;
@property (nonatomic,retain) NSIndexPath* indexPath;
- (id)initWithPrototypeCell:(MCSimpleTableCoreDataCell*)cell andManagedObject:(NSManagedObject*)object;
@end

@implementation MCSimpleTableCoreDataSection

@synthesize fetchedResultsController = _controller;

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



#pragma mark NSFetchedResultsControllerDelegate protocol methods


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.viewController.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [_viewController.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                     withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_viewController.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                     withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [_viewController.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [_viewController.tableView deleteRowsAtIndexPaths:@[indexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [_viewController.tableView reloadRowsAtIndexPaths:@[indexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [_viewController.tableView deleteRowsAtIndexPaths:@[indexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
            [_viewController.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [_viewController.tableView endUpdates];
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
