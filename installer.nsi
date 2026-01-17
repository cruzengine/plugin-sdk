!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"

Name "Cruz Plugin SDK"
OutFile "pluginsdk-installer.exe"
InstallDir "$PROGRAMFILES\cruz\plugin-sdk"
SetCompress auto
SetCompressor lzma

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY

Var ADD_TO_PATH_VAR
Var ADD_TO_PATH_STATE
Page custom AddToPathPage LeaveAddToPathPage
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Function AddToPathPage
  nsDialogs::Create 1018
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}
  ${NSD_CreateCheckBox} 20u 20u 200u 10u "Add CLI to PATH"
  Pop $ADD_TO_PATH_VAR
  ${NSD_SetState} $ADD_TO_PATH_VAR 1
  nsDialogs::Show
FunctionEnd

Function LeaveAddToPathPage
  ${NSD_GetState} $ADD_TO_PATH_VAR $ADD_TO_PATH_STATE
FunctionEnd

Section "Install"
  SetOutPath "$INSTDIR"
  File /r "out\*"
  WriteUninstaller "$INSTDIR\uninstall.exe"
  StrCmp $ADD_TO_PATH_STATE 1 0 +3
    ReadRegStr $0 HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path"
    StrCpy $1 "$INSTDIR"
    ${If} $0 == ""
      StrCpy $0 "$1"
    ${Else}
      StrCpy $0 "$0;$1"
    ${EndIf}
    WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path" "$0"
    System::Call 'User32::SendMessageTimeoutA(i 0xffff, i 0x1A, i 0, i "Environment", i 0, i 5000, *i .r1)'
SectionEnd

Section "Uninstall"
  RMDir /r "$INSTDIR"
SectionEnd
