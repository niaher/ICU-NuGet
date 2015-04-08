# ICU - NuGet Packages
This project aims at providing NuGet packages for [ICU libraries][icu].

## ICU4C-55.1-bin32
This package contains *.dll files taken from [http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-Win32-msvc10.zip][icu-55x32], namely:

* icu/bin/icudt55.dll
* icu/bin/icuin55.dll
* icu/bin/icuio55.dll
* icu/bin/icule55.dll
* icu/bin/iculx55.dll
* icu/bin/icutu55.dll
* icu/bin/icuuc55.dll

## ICU4C-55.1-lib32
This package contains *.lib and *.h files taken from [http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-Win32-msvc10.zip][icu-55x32], namely:

* icu/lib/icudt.lib
* icu/lib/icuin.lib
* icu/lib/icuio.lib
* icu/lib/icule.lib
* icu/lib/iculx.lib
* icu/lib/icutu.lib
* icu/lib/icuuc.lib
* icu/include/*

## Directory structure
The directory structure of this project is depicted below:

* *~/Build* - contains PowerShell scripts for to building and publishing NuGet packages.
* *~/ICU4C-55.1* - contains ICU4C files (extracted from [http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-Win32-msvc10.zip][icu-55x32]/icu/*).
* *~/ICU4C-55.1-** - definition of the corresponding NuGet package.

[icu]:site.icu-project.org
[icu-55x32]:http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-Win32-msvc10.zip
