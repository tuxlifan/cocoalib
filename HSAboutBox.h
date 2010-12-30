/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import <Cocoa/Cocoa.h>
#import "PyFairware.h"

@interface HSAboutBox : NSWindowController
{
    IBOutlet NSTextField *titleTextField;
    IBOutlet NSTextField *versionTextField;
    IBOutlet NSTextField *copyrightTextField;
    IBOutlet NSTextField *registeredTextField;
    IBOutlet NSButton *registerButton;
    
    PyFairware *app;
}
- (id)initWithApp:(PyFairware *)app;
- (void)updateFields;

- (IBAction)showRegisterDialog:(id)sender;
@end