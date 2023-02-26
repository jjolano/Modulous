#import <Modulous/Module.h>
#import <dlfcn.h>

@implementation ModulousModule
- (BOOL)loadModule {
    NSString* module_executable = [[self infoDictionary] objectForKey:@"CFBundleExecutable"];

    if(module_executable) {
        NSString* module_path = [[self bundlePath] stringByAppendingPathComponent:module_executable];

        if(module_path) {
            void* handle = dlopen([module_path fileSystemRepresentation], RTLD_LAZY);

            if(handle) {
                return YES;
            }
        }
    }

    return NO;
}
@end
