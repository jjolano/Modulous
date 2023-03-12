#import <Modulous/Module.h>
#import <dlfcn.h>

@implementation ModulousModule

- (BOOL)loadModule {
    if(_handle) {
        // already loaded
        return YES;
    }

    NSString* module_executable = [self executablePath];

    if(module_executable) {
        _handle = dlopen([module_executable fileSystemRepresentation], RTLD_LAZY);

        if(_handle) {
            NSLog(@"[Modulous] module '%@' loaded", [self bundleIdentifier]);
            return YES;
        }
    }

    return NO;
}

- (instancetype)init {
    if((self = [super init])) {
        _handle = NULL;
    }

    return self;
}

@end
