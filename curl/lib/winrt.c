/***************************************************************************
 *                                  _   _ ____  _
 *  Project                     ___| | | |  _ \| |
 *                             / __| | | | |_) | |
 *                            | (__| |_| |  _ <| |___
 *                             \___|\___/|_| \_\_____|
 *
 * Copyright (C) 1998 - 2011, Daniel Stenberg, <daniel@haxx.se>, et al.
 *
 * This software is licensed as described in the file COPYING, which
 * you should have received as part of this distribution. The terms
 * are also available at http://curl.haxx.se/docs/copyright.html.
 *
 * You may opt to use, copy, modify, merge, publish, distribute and/or sell
 * copies of the Software, and permit persons to whom the Software is
 * furnished to do so, under the terms of the COPYING file.
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
 * KIND, either express or implied.
 *
 ***************************************************************************/

#include <Windows.h>
#include "curl_setup.h"

#ifdef WINRT

#include "winrt.h"

/* this must be the last include file */
#include "memdebug.h"

void WinRT_Sleep(DWORD dwMilliseconds)
{
  static HANDLE singletonEvent = NULL;

  HANDLE sleepEvent = singletonEvent;
  HANDLE previousEvent = NULL;

  /* Demand create the event */
  if(!sleepEvent) {
    sleepEvent = CreateEventEx(NULL, NULL, CREATE_EVENT_MANUAL_RESET, EVENT_ALL_ACCESS);

    if(!sleepEvent)
      return;

    previousEvent = InterlockedCompareExchangePointerRelease(&singletonEvent, sleepEvent, NULL);

    if(previousEvent) {
      /* Back out if multiple threads try to demand create at the same time */
      CloseHandle(sleepEvent);
      sleepEvent = previousEvent;
    }
  }

  /* Emulate sleep by waiting with timeout on an event that is never signalled. */
  WaitForSingleObjectEx(sleepEvent, dwMilliseconds, false);
}

#endif /* #ifdef WINRT */