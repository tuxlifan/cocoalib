/* 
Copyright 2011 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import <Cocoa/Cocoa.h>
#import "PyGUI.h"
#import "PyColumns.h"

@interface PyTable : PyGUI {}
- (PyColumns *)columns;
- (void)add;
- (void)cancelEdits;
- (BOOL)canEditColumn:(NSString *)column atRow:(NSInteger)row;
- (void)deleteSelectedRows;
- (NSInteger)numberOfRows;
- (void)saveEdits;
- (void)selectRows:(NSArray *)rows;
- (NSArray *)selectedRows;
- (NSString *)selectionAsCSV;
- (void)setValue:(id)value forColumn:(NSString *)column row:(NSInteger)row;
- (void)sortByColumn:(NSString *)column desc:(BOOL)desc;
- (id)valueForColumn:(NSString *)column row:(NSInteger)row;
@end
