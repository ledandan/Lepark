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

#import <Foundation/Foundation.h>


typedef enum
{
    AMLogError = 0,
    AMLogWarn = 1,
    AMLogInfo = 2,
    AMLogVerbose = 3
}AMLogLevel;

@interface AMLogger : NSObject {
    
}

/**
 * Sets the log level.
 *
 * @param level The level to set.
 *
 *
 */

+ (void)setLogLevel: (AMLogLevel)level;

/**
 * Logs an error message to the Apple System Log facility.
 *
 * @param format The string to write to the Apple System Log facility.
 *
 *
 */
+ (void)logError: (NSString *)format,...;

/**
 * Logs an warning message to the Apple System Log facility.
 *
 * @param format The string to write to the Apple System Log facility.
 *
 *
 */
+ (void)logWarn: (NSString *)format,...;

/**
 * Logs an information message to the Apple System Log facility.
 *
 * @param format The string to write to the Apple System Log facility.
 *
 *
 */
+ (void)logInfo: (NSString *)format,...;

/**
 * Logs a verbose message to the Apple System Log facility.
 *
 * @param format The string to write to the Apple System Log facility.
 *
 *
 */
+ (void)logVerbose: (NSString *)format,...;

/**
 * Clears buffers and causes any buffered data to be written to the Apple System Log facility.
 *
 *
 */
+ (void)flush;

@end


#define AMLogError(frmt, ...) [AMLogger logError:frmt, ##__VA_ARGS__] 
#define AMLogWarn(frmt, ...) [AMLogger logWarn:frmt, ##__VA_ARGS__]
#define AMLogInfo(frmt, ...) [AMLogger logInfo:frmt, ##__VA_ARGS__]
#define AMLogVerbose(frmt, ...) [AMLogger logVerbose:frmt, ##__VA_ARGS__]

