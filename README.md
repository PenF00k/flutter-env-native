# env_native

A plugin to get native variables from Android resources and iOS configs.
The plugin provides static methods for getting resources variables on Android and
xcconfig variables on iOS.

## How to use
### Android
Add variables to your resource file
```
<resources>
    <string name="test_string">From Russia with love</string>
    <integer name="test_int">42</integer>
</resources>
```
### iOS
Add variables to your .xcconfig file
```
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
#include "Generated.xcconfig"

test_string = From Russia with love
test_int = 42
```
Add variables to Info.plist file
```
<key>test_string</key>
<string>$(test_string)</string>
<key>test_int</key>
<string>$(test_int)</string>
```
### Flutter
To get variables from Flutter you need to call static methods
```
final s = await EnvNative.getString('test_string');
final i = await EnvNative.getInt('test_int');
```
