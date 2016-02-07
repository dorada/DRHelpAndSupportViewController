//
//  DRGetHelpItem.m
//  Pods
//
//  Created by Daniel Broad on 06/02/2016.
//
//

#import "DRGetHelpItem.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "ZipArchive.h"

#import "UIDevice+Extensions.h"
#import "DRApplicationPaths.h"

@interface DRMailComposeViewController : MFMailComposeViewController
@property (assign,nonatomic) UIStatusBarStyle preferredStatusBarStyle;
@end

@interface DRGetHelpItem ()
@property (strong) NSArray<NSString*> *recipients;
@property (strong) NSArray<NSString*> *attachments;

@end

@interface DRGetHelpItem () <MFMailComposeViewControllerDelegate>
@end

@implementation DRGetHelpItem

-(instancetype) initWithTitle: (NSString*) title
              recipientEmails: (NSArray<NSString*>*) recipients
              attachmentPaths: (NSArray<NSString*>*) attachments {
    self = [super initWithTitle:title actionHandler:^(DRHelpAndSupportItem *item){
        [self doGetHelp];
    }];
    if (self) {
        _recipients = recipients;
        _attachments = attachments;
    }
    return self;
}

-(void) doGetHelp {
    [self exportDatabase];
}

#pragma mark - methods

-(void) addFile: (NSString*) path toArchive: (ZipArchive*) archiver {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [archiver addFileToZip:path newname:[path lastPathComponent]];
    }
}

-(void) exportDatabase {
    DRMailComposeViewController* controller = [[DRMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([self.containingHelpViewController.view.window respondsToSelector:@selector(tintColor)]) {
        controller.view.tintColor = self.containingHelpViewController.navigationController.navigationBar.tintColor;
        controller.navigationBar.barTintColor = self.containingHelpViewController.navigationController.navigationBar.barTintColor;
        controller.navigationBar.titleTextAttributes = self.containingHelpViewController.navigationController.navigationBar.titleTextAttributes;
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(preferredStatusBarStyle)]) {
            controller.preferredStatusBarStyle = [(id) [UIApplication sharedApplication].delegate preferredStatusBarStyle];
        } else if ([rootVC isKindOfClass:UINavigationController.class]) {
            UINavigationController *nav = (UINavigationController*) rootVC;
            if ([[nav.viewControllers objectAtIndex:0] respondsToSelector:@selector(preferredStatusBarStyle)]) {
                controller.preferredStatusBarStyle = [(id) [nav.viewControllers objectAtIndex:0] preferredStatusBarStyle];
            }
        } else {
            controller.preferredStatusBarStyle = rootVC.preferredStatusBarStyle;
        }
        
    }
#endif
    [controller setToRecipients:_recipients];
    
    NSString *subject = [NSString stringWithFormat:@"%@ %@",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    
    NSString *body = [NSString stringWithFormat:@"type your question here please.....\n\n\niOS: %@\n Device: %@\n Bundle:%@\n",[[UIDevice currentDevice] systemVersion],[UIDevice device],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]];
    
    [controller setSubject:subject];
    [controller setMessageBody:body isHTML:NO];
    

    NSArray *helpAttachments = _attachments;
    if ([helpAttachments count]) {
        NSString *archivePath = [DRApplicationPaths.applicationDocumentsDirectory stringByAppendingPathComponent:@"diagnosticinfo.zip"];
        ZipArchive *archiver = [[ZipArchive alloc] init];
        [archiver CreateZipFile2:archivePath];
        for (NSString *fullPath in helpAttachments) {
            [self addFile:fullPath toArchive:archiver];
        }
        [archiver CloseZipFile2];
        
        [controller addAttachmentData:[NSData dataWithContentsOfFile:archivePath] mimeType:@"application/zip" fileName:@"diagnosticinfo.zip"];
        [[NSFileManager defaultManager] removeItemAtPath:archivePath error:nil];
    }
    
    [controller addAttachmentData:[[self sandboxFolder] dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"text/plain" fileName:@"sandbox.txt"];
    
    if (controller == nil) {
    } else {
        [self.containingHelpViewController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        //log4Debug(@"It's away!");
    }
    [self.containingHelpViewController dismissViewControllerAnimated:YES completion:nil];
}

-(NSString*) dumpFolder: (NSURL*) url root: (NSString*) root {
    NSArray *properties = [NSArray arrayWithObjects: NSURLLocalizedNameKey,
                           NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey, nil];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:properties options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    NSMutableString *string = [NSMutableString string];
    for (NSURL *file in files) {
        BOOL directory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:[file path] isDirectory:&directory];
        if (!directory) {
            [string appendFormat:@"%@\t%@\r\n",
             [root stringByAppendingPathComponent:[file lastPathComponent]],
             [[[NSFileManager defaultManager] attributesOfItemAtPath:[file path] error:nil] objectForKey:NSFileSize]];
        } else {
            [string appendString:[self dumpFolder:file root:[root stringByAppendingPathComponent:[file lastPathComponent]]]];
        }
    }
    
    return string;
}

-(NSString*) sandboxFolder {
    NSURL *path = [NSURL fileURLWithPath:[DRApplicationPaths applicationDocumentsDirectory]];
    path = [path URLByDeletingLastPathComponent];
    return [self dumpFolder: path root:@""];
}

@end

@implementation DRMailComposeViewController

-(UIStatusBarStyle) preferredStatusBarStyle {
    return _preferredStatusBarStyle;
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return nil;
}

@end
