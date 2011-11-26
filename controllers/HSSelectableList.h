/* 
Copyright 2011 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import <Cocoa/Cocoa.h>
#import "HSGUIController.h"
#import "PySelectableList.h"

@interface HSSelectableList : HSGUIController <NSTableViewDelegate, NSTableViewDataSource>
{
    NSArray *items;
}
- (NSTableView *)view;
- (void)setView:(NSTableView *)aTableView;
- (PySelectableList *)py;

- (void)refresh;
@end