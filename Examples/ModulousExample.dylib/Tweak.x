#import <Modulous/Loader.h>

%ctor {
	ModulousLoader* loader = [ModulousLoader loaderWithPath:@"/Library/Modulous/Modules"];
	[loader loadModules];
}
