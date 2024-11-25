@echo on
setlocal enabledelayedexpansion
set PKG_CONFIG_PATH=%LIBRARY_PREFIX%\lib\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig
set "MESON_RSP_THRESHOLD=320000"

meson setup _build -Dprefix=%LIBRARY_PREFIX% -Dbuildtype=release -Ddefault_library=shared -Dlapack=custom -Dcustom_libraries="-L%LIBRARY_PREFIX%\bin,lapack,blas" -Dfortran_link_args=-Wl,--stack=16777216 -Dc_link_args=-Wl,--stack=16777216
if %ERRORLEVEL% neq 0 exit 1

meson compile -C _build
if %ERRORLEVEL% neq 0 exit 1

meson test -C _build --no-rebuild --print-errorlogs

meson install -C _build --no-rebuild
if %ERRORLEVEL% neq 0 exit 1
