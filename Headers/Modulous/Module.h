#ifndef modulous_module_h
#define modulous_module_h

#import <Foundation/Foundation.h>

@interface ModulousModule : NSBundle {
    void* _handle;
}

- (BOOL)loadModule;
@end
#endif
