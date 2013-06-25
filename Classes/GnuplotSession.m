//
//  GnuplotSession.m
//  GnuplotObjc
//
//  Created by HEINRICH Yannick on 04/12/11.
//  Copyright (c) 2011 UNICAEN. All rights reserved.
//

#define PATH_MAXNAMESZ       4096

#import "GnuplotSession.h"


@implementation GnuplotSession
static NSString *gnuplot_path=nil;


+(BOOL)setupGnuplot{
    NSString *found_path = nil;
    
    NSString *path_env = @(getenv("PATH"));
    NSArray * search_paths = [path_env componentsSeparatedByString:@":"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    for(NSString *look_path in search_paths)
    {
        NSString * path = [look_path stringByAppendingPathComponent:@"gnuplot"];
        if([manager isExecutableFileAtPath:path])
        {
            found_path = [path copy];
            break;
        }
    }
    if(found_path!=nil){
#ifdef DEBUG
        NSLog(@"Gnuplot loaded from:%@",found_path);
#endif
        [self set_gnuplot_path:found_path];
        return YES;
    }
    else {
        NSLog(@"The gnuplot binary file was not found in $PATH. Check your environment variable");
        return NO;
    }
}
+(void) initialize{
    [super initialize];
#ifdef DEBUG
    NSLog(@"Initialize gnuplot for all classes");
#endif
    if(gnuplot_path == nil){
        [GnuplotSession setupGnuplot];
    }
}
-(id) init{
    if([GnuplotSession gnuplot_path] == nil){
#ifdef DEBUG
        NSLog(@"The Gnuplot binary was not found");
        return nil;
#endif
    }
    self = [super init];
    if(self){
#ifdef  DEBUG
        NSLog(@"Init Gnuplot session:%@",self);
#endif
        //Init the pipe to gnuplot
        nbplots = 0;
        
        NSPipe *inPipe = [NSPipe pipe];
        inhandle = [inPipe fileHandleForWriting];
        
        NSTask *task = [[[NSTask alloc]init] autorelease];
        [task setStandardInput:inPipe];
        [task setLaunchPath:[GnuplotSession gnuplot_path]];
        
        NSArray *args = [NSArray arrayWithObjects:@"-persist", nil];
        [task setArguments:args];
        
        [task launch];
    }
    
    return self;
}
-(void) exec:(NSString *)cmd,...{
    //Get the format
    va_list arguments;
    va_start(arguments,cmd);
    NSString *arg_cmd = [[NSString alloc] initWithFormat:cmd arguments:arguments];
    va_end(arguments);
#ifdef DEBUG
    NSLog(@"Execute Commande : %@",arg_cmd);
#endif
    NSString *cmdline = [NSString stringWithFormat:@"%@;\n",arg_cmd] ;
    [inhandle writeData:[cmdline dataUsingEncoding:NSUTF8StringEncoding]];
    [arg_cmd release];
}
-(void)dealloc{
#ifdef DEBUG
    NSLog(@"Deallocing %@",self);
#endif
    [inhandle closeFile];
    [inhandle dealloc];
    [super dealloc];
}
@end

@implementation GnuplotSession (private)

+(NSString*)gnuplot_path{
    return gnuplot_path;
}
+(void)set_gnuplot_path:(NSString *)path{
    gnuplot_path = path;
}

@end