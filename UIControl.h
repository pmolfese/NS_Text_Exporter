/* UIControl */

#import <Cocoa/Cocoa.h>
#import "EGIFile.h"

@interface UIControl : NSObject
{
    IBOutlet id fileController;
	IBOutlet id convertButton;
	IBOutlet id progressBar;
	IBOutlet id tableView;
	IBOutlet id normalize;
	NSMutableArray *files;
}
- (IBAction)addFile:(id)sender;
- (IBAction)convert:(id)sender;
-(NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info 
				proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op;
- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info 
			  row:(int)row dropOperation:(NSTableViewDropOperation)operation;

@end
