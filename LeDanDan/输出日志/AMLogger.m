/**
 * Copyright 2014 MissionSky, Inc.
 *
 * You are hereby granted a non-exclusive, worldwide, royalty-free license to
 * use, copy, modify, and distribute this software in source code or binary
 * form for use in connection with the web services and APIs provided by
 * MissionSky.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 */

#import "AMLogger.h"

static AMLogLevel logLevel = AMLogVerbose;

@implementation AMLogger

+(void) setLogLevel:(AMLogLevel) level{
	logLevel = level;
}

+(void) logError:(NSString *)format,...
{
    va_list argumentList;
    
    va_start(argumentList, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",str);
}

+(void) logWarn:(NSString *)format,...
{
	if (logLevel < AMLogWarn) {
		return;
	}
	
    va_list argumentList;

    va_start(argumentList, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",str);
}

+(void) logInfo:(NSString *)format,...
{
	if (logLevel < AMLogInfo) {
		return;
	}
	
    va_list argumentList;
    
    va_start(argumentList, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",str);
}

+(void) logVerbose:(NSString *)format,...
{
	if (logLevel < AMLogVerbose) {
		return;
	}
	
    va_list argumentList;
    
    va_start(argumentList, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:argumentList];
    va_end(argumentList);
    NSLog(@"%@",str);
}

+(void) flush
{
}

@end
