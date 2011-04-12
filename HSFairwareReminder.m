/* 
Copyright 2011 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import "HSFairwareReminder.h"
#import "Dialogs.h"
#import "Utils.h"

@implementation HSFairwareReminder
+ (BOOL)showNagWithApp:(PyFairware *)app
{
    BOOL r = YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *code = [ud stringForKey:@"RegisteredCode"];
    if (code == nil) {
        code = @"";
    }
    NSString *email = [ud stringForKey:@"RegisteredEmail"];
    if (email == nil)
        email = @"";
    [app setRegisteredCode:code andEmail:email];
    if ((![app isRegistered]) && (n2f([app unpaidHours]) >= 1)) {
        HSFairwareReminder *fr = [[HSFairwareReminder alloc] initWithApp:app];
        r = [fr showNag];
        [fr release];
    }
    return r;
}

- (id)initWithApp:(PyFairware *)aApp
{
    self = [super init];
    _nib = [[NSNib alloc] initWithNibNamed:@"FairwareReminder" bundle:[NSBundle bundleForClass:[self class]]];
    app = aApp;
    [_nib instantiateNibWithOwner:self topLevelObjects:nil];
    [nagPanel update];
    [codePanel update];
    [nagPanel setTitle:fmt([nagPanel title],[app appName])];
    [nagPromptTextField setStringValue:fmt([nagPromptTextField stringValue],[app appName])];
    [nagUnpaidHoursTextField setStringValue:fmt([nagUnpaidHoursTextField stringValue],n2f([app unpaidHours]))];
    [codePromptTextField setStringValue:fmt([codePromptTextField stringValue],[app appName])];
    return self;
}

- (void)dealloc
{
    [_nib release];
    [super dealloc];
}

- (IBAction)contribute:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://open.hardcoded.net/contribute/"]];
}

- (IBAction)moreInfo:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://open.hardcoded.net/about/"]];
}

- (IBAction)cancelCode:(id)sender
{
    [codePanel close];
    [NSApp stopModalWithCode:NSCancelButton];
}

- (IBAction)enterCode:(id)sender
{
    [nagPanel close];
    [NSApp stopModalWithCode:NSOKButton];
}

- (IBAction)submitCode:(id)sender
{
    NSString *code = [codeTextField stringValue];
    NSString *email = [emailTextField stringValue];
    NSString *errorMsg = [app isCodeValid:code withEmail:email];
    if (errorMsg == nil) {
        [codePanel close];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setValue:code forKey:@"RegisteredCode"];
        [ud setValue:email forKey:@"RegisteredEmail"];
        [app setRegisteredCode:code andEmail:email];
        [Dialogs showMessage:@"Your code is valid. Thanks!"];
        [NSApp stopModalWithCode:NSOKButton];
    }
    else {
        [Dialogs showMessage:errorMsg];
    }
}

- (IBAction)closeDialog:(id)sender
{
    [nagPanel close];
    [NSApp stopModalWithCode:NSCancelButton];
}

- (BOOL)showNag
{
    NSInteger r;
    while (YES) {
        r = [NSApp runModalForWindow:nagPanel];
        if (r == NSOKButton) {
            r = [self enterCode];
            if (r == NSOKButton) {
                return YES;
            }
        }
        else {
            return NO;
        }
    }
}

- (NSInteger)enterCode
{
    return [NSApp runModalForWindow:codePanel];
}

@end
