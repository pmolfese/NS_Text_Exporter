//
//  EGIFile.m
//  NS_Text_Export
//
//  Created by Peter Molfese on 4/11/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "EGIFile.h"


@implementation EGIFile

@synthesize name;
@synthesize path;

-init
{
	self = [super init];
	if( self == nil )
		return nil;
	
	return self;
}


-(void)setName
{
	self.name = [[self path] lastPathComponent];
}


-(void)main
{
	NSBundle *main = [NSBundle mainBundle];
	NSString *pathToNSExport = [main resourcePath];
	pathToNSExport = [pathToNSExport stringByAppendingString:@"/NSExport"];
	NSLog(@"Path to Resource: %@", pathToNSExport);
	NSTask *myTask = [NSTask launchedTaskWithLaunchPath:pathToNSExport arguments:[NSArray arrayWithObject:self.path]];
	[myTask waitUntilExit];
	
}


@end
