[![Build Status](https://travis-ci.org/liuchungui/BGSession.svg?branch=master)](https://travis-ci.org/liuchungui/BGSession)
[![codecov.io](https://codecov.io/github/liuchungui/BGSession/coverage.svg?branch=master)](https://codecov.io/github/liuchungui/BGSession?branch=master)


BGSession is a lightweight local data storage in one case, it can automatically synchronize their attributes value to NSUserDefaults.

##Install

```
source 'https://github.com/CocoaPods/Specs.git'
pod 'BGSession'
```

##Usage   
Only need to inherit the BGSession, and then add the corresponding property.

Example:

```
    DemoSession *session = [DemoSession sharedSession];
    session.userName = @"Jack";
    session.userId = @"1";
    session.firstTimeUse = YES;
    session.cityLng = 138.88383384;
    session.cityLat = 63.8484848;
    session.cityId = @1838;
```

