setlocal EnableExtensions EnableDelayedExpansion
@echo on

:: set pkg-config path so that host deps can be found
set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig"

:: meson options
set ^"MESON_OPTIONS=^
  --prefix="%LIBRARY_PREFIX%" ^
  --wrap-mode=nofallback ^
  --buildtype=release ^
  --backend=ninja ^
 ^"

:: configure build using meson
meson setup builddir !MESON_OPTIONS!
if errorlevel 1 exit 1

:: print results of build configuration
meson configure builddir
if errorlevel 1 exit 1

ninja -v -C builddir -j %CPU_COUNT%
if errorlevel 1 exit 1

ninja -C builddir install -j %CPU_COUNT%
if errorlevel 1 exit 1
