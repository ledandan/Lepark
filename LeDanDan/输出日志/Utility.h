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
#import <UIKit/UIKit.h>

@interface Utility : NSObject
{
}

/*
 Get the application documents directory path

 */
+(NSString*)applicationDocumentsDirectory;

/*
 Get the application cache directory path

 */
+(NSString*)applicationCacheDirectory;

/*
 Get the application temp directory path

 */
+(NSString*)applicationTempDirectory;

/*
 Get application library directory path

 */
+(NSString*)applicationLibraryDirectory;

/*
 Append the directory path for the file name
 @param directory directory path
 @param filename file name

 */
+(NSString*)filePathWithDirectory:(NSString*)directory withfile:(NSString*)filename;

/*
 Append document path for the file name
 @param fileName file name

 */
+(NSString*)filePathWithDocumentPath:(NSString*)fileName;

/*
 Append cache document path for the file name
 @param fileName file name

 */
+(NSString*)filePathWithCachePath:(NSString*)fileName;

/*
 Append temporary path for the file name
 @param fileName file name

 */
+(NSString*)filePathWithTemporaryPath:(NSString*)fileName;

/*
 Append library document path for the file name
 @param fileName file name

 */
+(NSString*)filePathWithLibraryPath:(NSString*)fileName;

/*
 Append bundle path for the file name
 @param fileName file name

 */
+(NSString*)filePathWithBundle:(NSString*)fileName;

/*
 Check wherther the path exist
 @param directory directory path
 @return YES if exist, otherwise NO

 */
+(BOOL)checkPathExists:(NSString *)directory;

/*
 Create directory
 @param directory directory path

 */
+(void)createDirectory:(NSString*)directory;

/*
 Rename file
 @param orgFile The original file
 @param newFileName new file name

 */
+(void)renameFile:(NSString*)orgFile withNewName:(NSString*)newFileName;

/*
 Delete the file
 @param filePath file path

  */
+(void)deleteFile:(NSString*)filePath;

///*
// Generate a UUID string
// @return new UUID string
//
// */
//+(NSString*)uniqueString;

/*
 Parsing the URL Query part to a dictionary
 @param encodedString the encoded query string
 @return the dictional object

 */
+ (NSDictionary*)dictionaryByParsingURLQueryPart:(NSString *)encodedString;


/*
 Decoding URL string 
 @param escapedString escaped String
 @return unescaped String

 */
+ (NSString*)stringByURLDecodingString:(NSString*)escapedString;

/*
 Encode URL query string
 @param unescapedString unescaped query string
 @return encoded query string

 */
+ (NSString*)stringByURLEncodingString:(NSString*)unescapedString;

/*
 Check wherther the device is a iPad
 @return YES if iPad otherwise NO

 */
+(BOOL)isIPad;

/*
 Check the orientation of the device
 @return YES if Landscape otherwise NO

 */
+(BOOL)isLandscape;

/*
 Check wherther the device is retina screen
 @return YES if retina screen otherwise NO

 */
+(BOOL)isRetina;

/*
 Get the local language
 @return local language string

 */
+(NSString*)localLanguage;

/*
 Get application from the application info file
 @return version string

 */
+(NSString*)applicationVersion;


@end




