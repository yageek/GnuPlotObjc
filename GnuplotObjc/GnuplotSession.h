//
//  GnuplotSession.h
//  GnuplotObjc
//
//  Created by HEINRICH Yannick on 04/12/11.
//  Copyright (c) 2011 UNICAEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <unistd.h>
/**
  * Interface to represent a GnuplotSession
 */
@interface GnuplotSession : NSObject{
    NSFileHandle* inhandle;
    
    int nbplots;
  
}
/**
 * Initiliaze the library to find the gnuplot path
 * @return return true if managed to find gnuplot programm and false else
 */
+(BOOL)setupGnuplot;
/**
 * Initialize all class runtime
 */
+(void) initialize;
/**
 * Init the class
 */
-(id)init;
/**
 * Exec the command in the current session
 * @param The command to execute
 */
-(void)exec:(NSString*)cmd,... NS_FORMAT_FUNCTION(1, 2);

/**
 * Release all
 */
-(void) dealloc;
@end

/**
 * Interface to represent a private access to GnuplotSession
 */
@interface GnuplotSession (private)
/**
 * Get the value of the gnuplot path currently stored
 * @return a NSString object with tht value of path
 */
+(NSString*)gnuplot_path;
/**
 * Set the current value of the Gnuplot path
 * @param The value to assign
 */
+(void)set_gnuplot_path:(NSString*)path;

@end
