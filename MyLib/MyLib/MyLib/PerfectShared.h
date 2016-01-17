//.h
#define singleton_interface(class) + (instancetype)shared##class;
//.m
#define singleton_implementation(className)         \
static className *_instance;                        \
\
+(instancetype)shared##className{                   \
    if (_instance == nil) {                     \
        _instance = [self allocWithZone:nil];   \
    }                                           \
    return _instance;                           \
}                                               \
\
+ (id)allocWithZone:(struct _NSZone *)zone      \
{                                               \
    static dispatch_once_t onceToken;           \
    dispatch_once(&onceToken, ^{                \
        _instance = [super allocWithZone:zone]; \
    });                                         \
\
    return _instance;                           \
}                                               \
\
+(instancetype)new{                             \
    return [self alloc];                        \
}                                               \
\
+(instancetype)alloc{                           \
    NSLog(@"这是一个单例对象,请使用+ (instancetype)shared%@方法",[className class]);                           \
    return nil;                                 \
}                                               \
\
-(id)copy{                                      \
    NSLog(@"这是一个单例对象,copy将不起任何作用");   \
    return self;                                \
}                                               \
