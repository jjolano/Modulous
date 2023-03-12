#import <Modulous/Loader.h>
#import <Modulous/Module.h>

#import <dlfcn.h>

@implementation ModulousLoader
@synthesize _modules;

+ (instancetype)loaderWithURL:(NSURL *)url {
    ModulousLoader* loader = [self new];
    [loader _loadBundlesFromURL:url];
    return loader;
}

+ (instancetype)loaderWithPath:(NSString *)path {
    NSURL* file_url = [NSURL fileURLWithPath:path isDirectory:YES];
    return [self loaderWithURL:file_url];
}

- (void)_loadBundlesFromURL:(NSURL *)url {
    NSArray<NSURL *>* bundle_urls = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:@[] options:0 error:nil];

    if(bundle_urls) {
        NSMutableDictionary<NSString *, ModulousModule *>* modules = [NSMutableDictionary new];

        for(NSURL* bundle_url in bundle_urls) {
            ModulousModule* module = [ModulousModule bundleWithURL:bundle_url];

            if(module && [module bundleIdentifier]) {
                if([modules objectForKey:[module bundleIdentifier]]) {
                    NSLog(@"[ModulousLoader] warning: skipping duplicate bundle identifier %@", [module bundleIdentifier]);
                    continue;
                }

                // if(!dlopen_preflight([[module executablePath] fileSystemRepresentation])) {
                //     NSLog(@"[ModulousLoader] warning: dlopen_preflight failed on bundle identifier %@", [module bundleIdentifier]);
                //     continue;
                // }

                [modules setObject:module forKey:[module bundleIdentifier]];
            }
        }

        _modules = [modules copy];
    }
}

- (NSArray<NSDictionary *> *)getModuleInfo {
    NSMutableArray<NSDictionary *>* infos = [NSMutableArray new];

    [_modules enumerateKeysAndObjectsUsingBlock:^(NSString* key, ModulousModule* module, BOOL* stop) {
        NSDictionary* info = [module infoDictionary];

        if(info) {
            [infos addObject:info];
        }
    }];

    return [infos copy];
}

- (NSArray<NSDictionary *> *)getModuleInfoWithIdentifers:(NSArray<NSString *> *)identifiers {
    NSMutableArray<NSDictionary *>* infos = [NSMutableArray new];

    for(NSString* identifier in identifiers) {
        ModulousModule* module = [_modules objectForKey:identifier];

        if(module) {
            NSDictionary* info = [module infoDictionary];

            if(info) {
                [infos addObject:info];
            }
        }
    }

    return [infos copy];
}

- (void)loadModules {
    [_modules enumerateKeysAndObjectsUsingBlock:^(NSString* key, ModulousModule* module, BOOL* stop) {
        [module loadModule];
    }];
}

- (void)loadModulesWithIdentifiers:(NSArray<NSString *> *)identifiers {
    for(NSString* identifier in identifiers) {
        ModulousModule* module = [_modules objectForKey:identifier];

        if(module) {
            [module loadModule];
        }
    }
}

- (instancetype)init {
    if((self = [super init])) {
        _modules = @{};
    }

    return self;
}
@end
