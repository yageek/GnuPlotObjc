//
//  main.m
//  GnuplotObjc
//
//  Created by HEINRICH Yannick on 04/12/11.
//  Copyright (c) 2011 UNICAEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GnuplotSession.h"
int main (int argc, const char * argv[])
{
    
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    // insert code here...
    GnuplotSession *session = [[[GnuplotSession alloc]init] autorelease];
    if(session == nil){
        NSLog(@"Unable to load the library");
        return 0;
    } 
    [session exec:@"set xlabel \"Hello\""];
    [session exec:@"plot x"];
    [session exec:@"replot x**%i",2];
    
    GnuplotSession *session2 = [[[GnuplotSession alloc]init] autorelease];
    if(session2 == nil){
        NSLog(@"Unable to load the library");
        return 0;
    } 
    [session2 exec:@"set xlabel \"Hello\""];
    [session2 exec:@"plot x"];
    [session2 exec:@"replot x**%i",2];
    
    
    [pool release];
    return 0;
}

