//
//  commonDefine.h
//
#ifdef DEBUG
#define debug(str); NSLog(@"[%@/%@]%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) , str);
#else
#define debug(str);
#endif

#ifdef DEBUG
#define printMethod(); NSLog(@"[%@/%@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
#else
#define printMethod();
#endif
