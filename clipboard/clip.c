#include "stdafx.h"
#include "windows.h"
#include "string.h"
#include <direct.h>

void PasteString(const *char )
{
    LPWSTR cwdBuffer;

    // Get the current working directory:
    if( (cwdBuffer = _wgetcwd( NULL, 0 )) == NULL )
        return 1;

    DWORD len = wcslen(cwdBuffer);
    HGLOBAL hdst;
    LPWSTR dst;

    // Allocate string for cwd
    hdst = GlobalAlloc(GMEM_MOVEABLE | GMEM_DDESHARE, (len + 1) * sizeof(WCHAR));
    dst = (LPWSTR)GlobalLock(hdst);
    memcpy(dst, cwdBuffer, len * sizeof(WCHAR));
    dst[len] = 0;
    GlobalUnlock(hdst);

    // Set clipboard data
    if (!OpenClipboard(NULL)) return GetLastError();
    EmptyClipboard();
    if (!SetClipboardData(CF_UNICODETEXT, hdst)) return GetLastError();
    CloseClipboard();

    free(cwdBuffer);
    return 0;
}