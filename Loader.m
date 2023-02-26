#import <Modulous/Loader.h>
#import <Modulous/Module.h>

@implementation ModulousLoader {
    NSArray<ModulousModule *>* _modules;
}

+ (instancetype)loaderWithURL:(NSURL *)url {
    ModulousLoader* loader = [self new];
    [loader _loadBundlesFromURL:url];
    return loader;
}

+ (instancetype)loaderWithPath:(NSString *)path {
    NSURL* file_url = [NSURL fileURLWithPath:path];
    return [self loaderWithURL:file_url];
}

- (void)_loadBundlesFromURL:(NSURL *)url {
    NSArray<NSURL *>* bundle_urls = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:@[] options:0 error:nil];

    if(bundle_urls) {
        NSMutableArray<ModulousModule *>* modules = [NSMutableArray new];

        for(NSURL* bundle_url in bundle_urls) {
            ModulousModule* module = [ModulousModule bundleWithURL:bundle_url];
            [modules addObject:module];
        }

        _modules = [_modules arrayByAddingObjectsFromArray:[modules copy]];
    }
}

- (NSArray<NSDictionary *> *)getModuleInfo {
    NSMutableArray<NSDictionary *>* infos = [NSMutableArray new];

    for(ModulousModule* module in _modules) {
        NSDictionary* info = [module infoDictionary];

        if(info) {
            [infos addObject:info];
        }
    }

    return [infos copy];
}

- (NSArray<NSDictionary *> *)getModuleInfoWithIdentifers:(NSArray<NSString *> *)identifiers {
    NSMutableArray<NSDictionary *>* infos = [NSMutableArray new];

    for(ModulousModule* module in _modules) {
        NSString* identifier = [[module infoDictionary] objectForKey:@"CFBundleIdentifier"];

        if(identifier && [identifiers containsObject:identifier]) {
            NSDictionary* info = [module infoDictionary];

            if(info) {
                [infos addObject:info];
            }
        }
    }

    return [infos copy];
}

- (void)loadModules {
    for(ModulousModule* module in _modules) {
        [module loadModule];
    }
}

- (void)loadModulesWithIdentifiers:(NSArray<NSString *> *)identifiers {
    for(ModulousModule* module in _modules) {
        NSString* identifier = [[module infoDictionary] objectForKey:@"CFBundleIdentifier"];

        if(identifier && [identifiers containsObject:identifier]) {
            [module loadModule];
        }
    }
}

- (instancetype)init {
    if((self = [super init])) {
        _modules = @[];
    }

    return self;
}
@end
