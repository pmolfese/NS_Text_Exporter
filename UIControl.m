#import "UIControl.h"

@implementation UIControl


-(void)awakeFromNib
{
	//files = [[NSMutableArray alloc] initWithCapacity:0];
	[tableView registerForDraggedTypes: [NSArray arrayWithObject:NSFilenamesPboardType] ];
}

- (IBAction)addFile:(id)sender
{
	NSAutoreleasePool *addPool = [[NSAutoreleasePool alloc] init];
	NSOpenPanel *myOpenPanel = [NSOpenPanel openPanel];
	[myOpenPanel setAllowsMultipleSelection:YES];
	NSArray *fileTypes = [NSArray arrayWithObject:@"RAW"];
	if( [myOpenPanel runModalForTypes:fileTypes] == NSOKButton )
	{
		int i, ct;
		ct = [[myOpenPanel filenames] count];
		for( i=0; i<ct; ++i )
		{
			EGIFile *myFile = [[EGIFile alloc] init];
			[myFile setPath:[[myOpenPanel filenames] objectAtIndex:i]];
			[myFile setName:[[myFile path] lastPathComponent]];
			//[files addObject:myFile];
			[fileController addObject:myFile];
			[myFile release];
		}
		//[fileController addObjects:files];
		//[files removeAllObjects];
	}
	[addPool release];
}

- (IBAction)convert:(id)sender
{
	//NSBundle *main = [NSBundle mainBundle];
//	NSString *pathToNSExport = [main resourcePath];
//	pathToNSExport = [pathToNSExport stringByAppendingString:@"/NSExport"];
//	NSLog(@"Path to Resource: %@", pathToNSExport);
	
	NSArray *allFiles = [fileController arrangedObjects];
	//[progressBar setMaxValue:[allFiles count]];
	//[progressBar setMinValue:0];
	[progressBar setIndeterminate:YES];
	[progressBar setDisplayedWhenStopped:NO];
	[progressBar setUsesThreadedAnimation:YES];
	[progressBar startAnimation:self];
	NSOperationQueue *myQ = [[NSOperationQueue alloc] init];
	[myQ setMaxConcurrentOperationCount:3];
	for( EGIFile *myFile in allFiles )
	{
		[myQ addOperation:myFile];
	}
	[myQ waitUntilAllOperationsAreFinished];
	[progressBar stopAnimation:self];
	[fileController removeObjects:allFiles];
	[progressBar setDisplayedWhenStopped:NO];
}


//drag and drop stuff

-(NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info 
				 proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op 
{
    // Add code here to validate the drop
    //NSLog(@"validate Drop");
	[tv setDropRow: -1 dropOperation: NSTableViewDropOn];
    return NSDragOperationCopy;    
}

- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info 
			  row:(int)row dropOperation:(NSTableViewDropOperation)operation
{
	int i;
	int compareStr;

	
    NSPasteboard* pboard = [info draggingPasteboard];
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) 
	{
        NSArray *theFiles = [[pboard propertyListForType:NSFilenamesPboardType] retain];
        // Perform operation using the list of files
		
		for( i=0; i<[theFiles count]; ++i )
		{
			NSString *myStr = [NSString stringWithString: [theFiles objectAtIndex:i]];
			compareStr = [[myStr pathExtension] caseInsensitiveCompare:@"RAW"];
			if( compareStr == 0 )
			{
				NSLog(@"Adding to table");
				EGIFile *newFile = [[EGIFile alloc] init];
				[newFile setName:[myStr lastPathComponent]];
				[newFile setPath:myStr];
				[fileController addObject:newFile];
			}
			else
			{
				NSLog(@"Wrong File Type");
			}
		}
		
    }
	
	return YES;
}

@end
