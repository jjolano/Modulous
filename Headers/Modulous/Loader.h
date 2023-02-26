#ifndef modulous_loader_h
#define modulous_loader_h

#import <Foundation/Foundation.h>

@interface ModulousLoader : NSObject
+ (instancetype)loaderWithURL:(NSURL *)url;
+ (instancetype)loaderWithPath:(NSString *)path;

- (void)loadModules;
- (void)loadModulesWithIdentifiers:(NSArray<NSString *> *)identifiers;
@end
#endif
