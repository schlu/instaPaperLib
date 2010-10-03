//
//  instaPaperLib.h
//  PlainNote
//
//  Created by Vincent Koser on 2/20/10.
//  Copyright 2010 kosertech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InstaPaperLib : NSObject {

}

-(BOOL) postToInstapaperWithUserName:(NSString*)username 
                            password:(NSString*)password 
                                body:(NSString*)PostText 
                                 url:(NSString*)url 
                               title:(NSString*)title;

-(BOOL) authenticateWithUserName:(NSString*)username password:(NSString*)password;

-(BOOL) postToInstapaper:(NSString *)apiMethod postBody:(NSString *)postBody;

@end
