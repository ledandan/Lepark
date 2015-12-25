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

#import "Utility.h"

@implementation Utility

+(BOOL)isIPad
{
	static int device = -1;
	if (device == -1) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			device = YES;
		}
		else
#endif
		{
			device = NO;
		}
	}
	return device;
}

+(BOOL)isLandscape
{
	return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
}

+(BOOL)isRetina
{
    if ( [UIScreen instancesRespondToSelector:@selector(scale)] == YES ) {
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        if (scale > 1.0) {
            return YES;
        }
    }
    return NO;
}


+(NSString*)localLanguage
{
	NSLocale* curentLocale = [NSLocale currentLocale];
	NSString *localIdentifier = [curentLocale localeIdentifier];
	return localIdentifier;
}

+(NSString*)applicationVersion
{
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

//+(NSString*)uniqueString
//{
//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//    CFRelease(uuid);
//    NSString *aNSString = (__bridge NSString *)uuidStr;
//    return aNSString;
//}


+ (NSDictionary*)dictionaryByParsingURLQueryPart:(NSString *)encodedString {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *parts = [encodedString componentsSeparatedByString:@"&"];
    
    for (NSString *part in parts) {
        if ([part length] == 0) {
            continue;
        }
        
        NSRange index = [part rangeOfString:@"="];
        NSString *key;
        NSString *value;
        
        if (index.location == NSNotFound) {
            key = part;
            value = @"";
        } else {
            key = [part substringToIndex:index.location];
            value = [part substringFromIndex:index.location + index.length];
        }
        
        if (key && value) {
            [result setObject:[Utility stringByURLDecodingString:value]
                       forKey:[Utility stringByURLDecodingString:key]];
        }
    }
    return result;
}

#pragma mark - Directory Related Functions
+(NSString*)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString*)applicationCacheDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString*)applicationTempDirectory
{
	return NSTemporaryDirectory();
}

+(NSString*)applicationLibraryDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - File & File Path Related Functions
+(NSString*)filePathWithDocumentPath:(NSString*)fileName
{
	return [[Utility applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
}

+(NSString*)filePathWithCachePath:(NSString*)fileName
{
	return [[Utility applicationCacheDirectory] stringByAppendingPathComponent:fileName];
}

+(NSString*)filePathWithTemporaryPath:(NSString*)fileName
{
	return [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
}

+(NSString*)filePathWithLibraryPath:(NSString*)fileName
{
	return [[Utility applicationLibraryDirectory] stringByAppendingPathComponent:fileName];
}

+(NSString*)filePathWithBundle:(NSString*)fileName
{
	NSString* theFileName = [[fileName lastPathComponent] stringByDeletingPathExtension];
	return [[NSBundle mainBundle] pathForResource:theFileName ofType:[fileName pathExtension]];
}

+(NSString*)filePathWithDirectory:(NSString*)directory withfile:(NSString*)filename
{
    return [[Utility filePathWithDocumentPath:directory] stringByAppendingPathComponent:filename];
}

+(BOOL)checkPathExists:(NSString *)directory
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:directory])
        return YES;
    else
        return NO;
}

+(void)createDirectory:(NSString*)directory 
{
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error])
		NSLog(@"Error: Create folder failed %@", directory);
}

+(void)renameFile:(NSString*)thisFile withNewName:(NSString*)newFileName 
{
	NSError *error;
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager fileExistsAtPath:thisFile]) return;
	
	if([fileManager fileExistsAtPath:newFileName])
		[fileManager removeItemAtPath:newFileName error:nil];
	
	// Attempt the move
	if ([fileManager moveItemAtPath:thisFile toPath:newFileName error:&error] != YES)
		NSLog(@"Unable to move file: %@", [error localizedDescription]);
}

+(void)deleteFile:(NSString*)filePath 
{
	NSError *error;
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:filePath])	
		[fileManager removeItemAtPath:filePath error:&error];	
}

+(void)setStretchableImageOfImageView:(UIImageView*)imageView
{
    UIImage *img = imageView.image;
    if(img != nil)
    {
        img = [img stretchableImageWithLeftCapWidth:20.0 topCapHeight:20.0];
        imageView.image = img;
    }
}

+(void)setStretchableImageOfButton:(UIButton*)button
{
    UIImage *img = [button backgroundImageForState:UIControlStateNormal];
    if(img != nil)
    {
        img = [img stretchableImageWithLeftCapWidth:20.0 topCapHeight:20.0];
        [button setBackgroundImage:img forState:UIControlStateNormal];
    }
    
    img = [button backgroundImageForState:UIControlStateSelected];
    if(img != nil)
    {
        img = [img stretchableImageWithLeftCapWidth:20.0 topCapHeight:20.0];
        [button setBackgroundImage:img forState:UIControlStateSelected];
    }
}

+ (NSString*)stringByURLDecodingString:(NSString*)escapedString {
    return [[escapedString stringByReplacingOccurrencesOfString:@"+" withString:@" "]
            stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString*)stringByURLEncodingString:(NSString*)unescapedString {
    NSString* result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                           kCFAllocatorDefault,
                                                                           (CFStringRef)unescapedString,
                                                                           NULL, // characters to leave unescaped
                                                                           (CFStringRef)@":!*();@/&?#[]+$,='%’\"",
                                                                           kCFStringEncodingUTF8));
    return result;
}

@end
