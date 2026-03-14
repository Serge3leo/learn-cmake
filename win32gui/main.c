// vim:set sw=4 ts=8 et fileencoding=utf8:
// SPDX-License-Identifier: BSD-3-Clause

// Andrew M. Steane, Exeter College, Oxford University and Centre for Quantum
// Computing, Oxford Unverisity This page: started 2007, updated 2009

#include <windows.h>

int WINAPI WinMain(HINSTANCE hThisInstance, HINSTANCE hPrevInstance,
                   LPSTR lpCmdLine, int nCmdShow) {
    // TODO: MessageBoxTimeout для CTest
    // https://stackoverflow.com/questions/3091300/messagebox-with-timeout-or-closing-a-messagebox-from-another-thread

    MessageBox(NULL, "Yes, I remember Adlestrop", "A minimal windows program",
               MB_OK);
    return 0;
}
