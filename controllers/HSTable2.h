/* 
Copyright 2011 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import <Cocoa/Cocoa.h>
#import "HSGUIController2.h"
#import "HSColumns2.h"
#import "PyTable2.h"

@interface HSTable2 : HSGUIController2 <NSTableViewDelegate, NSTableViewDataSource>
{
    HSColumns2 *columns;
}
- (id)initWithModel:(PyTable2 *)aPy tableView:(NSTableView *)aTableView;
- (id)initWithPyRef:(PyObject *)aPyRef tableView:(NSTableView *)aTableView;

/* Virtual */
- (PyTable2 *)model;
- (NSTableView *)view;
- (void)setView:(NSTableView *)aTableView;

/* Public */
- (HSColumns2 *)columns;
- (void)refresh;
- (void)showSelectedRow;
- (void)updateSelection;
@end