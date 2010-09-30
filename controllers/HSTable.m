/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import "HSTable.h"
#import "Utils.h"

@implementation HSTable
- (id)initWithPyClassName:(NSString *)aClassName pyParent:(id)aPyParent view:(NSTableView *)aTableView
{
    self = [super initWithPyClassName:aClassName pyParent:aPyParent];
    tableView = aTableView;
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    return self;
}

/* Private */
- (void)setPySelection
{
    NSArray *selection = [Utils indexSet2Array:[tableView selectedRowIndexes]];
    NSArray *pyselection = [[self py] selectedRows];
    if (![selection isEqualTo:pyselection])
        [[self py] selectRows:selection];
}

- (void)setViewSelection
{
    NSIndexSet *selection = [Utils array2IndexSet:[[self py] selectedRows]];
	[tableView selectRowIndexes:selection byExtendingSelection:NO];
}

/* HSGUIController */
- (PyTable *)py
{
    return (PyTable *)py;
}

- (NSView *)view
{
    return tableView;
}

/* Data source */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[self py] numberOfRows];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
    // Cocoa's typeselect mechanism can call us with an out-of-range row
    if (row >= [[self py] numberOfRows]) {
        return @"";
    }
    return [[self py] valueForColumn:[column identifier] row:row];
}

/* NSTableView Delegate */
- (void)tableView:(NSTableView *)aTableView didClickTableColumn:(NSTableColumn *)column
{
    if ([[aTableView sortDescriptors] count] == 0) {
        return;
    }
    NSSortDescriptor *sd = [[aTableView sortDescriptors] objectAtIndex:0];
    [[self py] sortByColumn:[sd key] desc:![sd ascending]];
}

// See HSOutline.outlineViewSelectionIsChanging: to know why we update selection in both notifs
- (void)tableViewSelectionIsChanging:(NSNotification *)notification
{
    [self setPySelection];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self setPySelection];
}

/* Public */

- (void)refresh
{
    // If we just deleted the last item, we want to update the selection before we reload
    [self setViewSelection];
    [tableView reloadData];
    [self setViewSelection];
}

- (void)showSelectedRow
{
    [tableView scrollRowToVisible:[tableView selectedRow]];
}

- (void)updateSelection
{
    [self setViewSelection];
}
@end
