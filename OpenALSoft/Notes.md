# Steam Deck Issue and Fix
There is an issue with this library that causes it to not work on the Steam Deck. The broken revision is the following:

```
Revision: 33cd77b81b1dce9a5b55ec7e215315c500f9d0bf
Author: Chris Robinson <chris.kcat@gmail.com>
Date: 11/8/2023 4:01:14 PM
Message:
Use the C++ standard's regular modified Bessel function

----
Modified: common/polyphase_resampler.cpp
Modified: core/bsinc_tables.cpp
```

You will need to check out the commit before this one to have the code work.

## Fix
There is a fix on the anomalous branch that reverts the changes in the breaking commit. This fixes the library and it will work from master with just this change.

As a result this repo runs off the `anomalous` branch instead of `master`.