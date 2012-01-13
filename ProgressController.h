/* 
Copyright 2011 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "BSD" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/bsd_license
*/

#import <Cocoa/Cocoa.h>
#import "Worker.h"

extern NSString *JobCompletedNotification;
extern NSString *JobCancelledNotification;

@interface ProgressController : NSWindowController
{
    IBOutlet NSButton *cancelButton;
    IBOutlet NSProgressIndicator *progressBar;
    IBOutlet NSTextField *statusText;
    IBOutlet NSTextField *descText;
    
    id _jobId;
    BOOL _running;
    NSObject<Worker> *_worker;
}
+ (ProgressController *)mainProgressController;

- (id)init;

- (IBAction)cancel:(id)sender;

- (void)hide;
- (void)show;
- (void)showWithCancelButton:(BOOL)cancelEnabled;
- (void)showSheetForParent:(NSWindow *) parentWindow;
- (void)showSheetForParent:(NSWindow *) parentWindow withCancelButton:(BOOL)cancelEnabled;

/* Properties */
- (BOOL)isShown;
- (id)jobId;
- (void)setJobId:(id)jobId;
- (void)setJobDesc:(NSString *)desc;
- (void)setWorker:(NSObject<Worker> *)worker;
@end
