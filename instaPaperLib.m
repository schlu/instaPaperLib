//
//  instaPaperLib.m
//  PlainNote
//
//  Created by Vincent Koser on 2/20/10.
//  Copyright 2010 kosertech. All rights reserved.
//

#import "InstaPaperLib.h"


@implementation InstaPaperLib


// returns YES if everythign went ok returns NO if a bad status or connection error
-(BOOL) postToInstapaperWithUserName:(NSString*)username 
                            password:(NSString*)password 
                                body:(NSString*)postText 
                                 url:(NSString*)url 
                               title:(NSString*)title {
	
	NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&url=%@",
					  username, password, url];
  
	if (postText != nil) {
    post = [post stringByAppendingFormat:@"&selection=%@", postText];
  }
  
	if (title != nil) {
    post = [post stringByAppendingFormat:@"&title=%@", title];
  }
  
	return [self postToInstapaper:@"add" postBody:post];
}

-(BOOL) authenticateWithUserName:(NSString*)username password:(NSString*)password {
	NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",
					  username, password];
	
	return [self postToInstapaper:@"authenticate" postBody:post];
}

-(BOOL) postToInstapaper:(NSString *)apiMethod postBody:(NSString *)postBody {
	NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.instapaper.com/api/%@", apiMethod]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

	//post it
	[request setHTTPBody:postData];
	
	//get response
	NSHTTPURLResponse* urlResponse = nil;
	NSError *error = [[NSError alloc] init];
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
	NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"Response Code: %d", [urlResponse statusCode]);
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
		NSLog(@"Response: %@", result);
		//here you get the response
		return YES;
	}
	return NO;
}

@end
