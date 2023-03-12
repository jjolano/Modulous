#ifndef modulous_loader_h
#define modulous_loader_h

#import <Foundation/Foundation.h>
#import <Modulous/Module.h>

@interface ModulousLoader : NSObject
@property (strong, nonatomic, readonly) NSDictionary<NSString *, ModulousModule *>* _modules;

+ (instancetype)loaderWithURL:(NSURL *)url;
+ (instancetype)loaderWithPath:(NSString *)path;

- (NSArray<NSDictionary *> *)getModuleInfo;
- (NSArray<NSDictionary *> *)getModuleInfoWithIdentifers:(NSArray<NSString *> *)identifiers;

- (void)loadModules;
- (void)loadModulesWithIdentifiers:(NSArray<NSString *> *)identifiers;
@end
#endif
