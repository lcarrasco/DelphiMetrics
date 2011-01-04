{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsWinInfo.pas                           }
{     Copyright (c) 2010-2011 DeskMetrics Limited                       }
{                                                                       }
{     http://deskmetrics.com                                            }
{     http://support.deskmetrics.com                                    }
{                                                                       }
{     support@deskmetrics.com                                           }
{                                                                       }
{     This code is provided under the DeskMetrics Modified BSD License  }
{     A copy of this license has been distributed in a file called      }
{     LICENSE with this source code.                                    }
{                                                                       }
{ **********************************************************************}

unit dskMetricsWinInfo;

interface

uses
  Windows, SysUtils;

const
  // These Windows-defined constants are required for use with TOSVersionInfoEx
  VER_NT_WORKSTATION                        = 1;
  VER_NT_DOMAIN_CONTROLLER                  = 2;
  VER_NT_SERVER                             = 3;

  PROCESSOR_ARCHITECTURE_AMD64              = 9; // x64 (AMD or Intel) *

  SM_TABLETPC     = 86;   // Detects XP Tablet Edition
  SM_MEDIACENTER  = 87;   // Detects XP Media Center Edition
  SM_STARTER      = 88;   // Detects Vista Starter Edition
  SM_SERVERR2     = 89;   // Detects Windows Server 2003 R2

type
  TWindowsPlatform = (
    ospWinNT,               // Windows NT platform
    ospWin9x,               // Windows 9x platform
    ospWin32s               // Win32s platform
  );

var
  Win32HaveExInfo: Boolean = False;
  Win32ProductType: Integer = 0;
  pvtProcessorArchitecture: Word = 0;

function _GetOperatingSystemArchictetureInternal: Integer;
function _GetWindowsVersionName: string;
function _GetWindowsChar: Char;

implementation

uses
  dskMetricsConsts, dskMetricsCommon;

function _GetOperatingSystemArchictetureInternal: Integer;
type
  TIsWow64Process = function(
    Handle: THandle;
    var Res: BOOL
  ): BOOL; stdcall;
var
  IsWow64Result: BOOL;
  IsWow64Process: TIsWow64Process;
begin
  Result := 32;
  try
      // Try to load required function from kernel32
      IsWow64Process := _LoadKernelFunc('IsWow64Process');
      if Assigned(IsWow64Process) then
      begin
        // Function is implemented: call it
        if not IsWow64Process(GetCurrentProcess, IsWow64Result) then
          Result := 32;

        // Return result of function
        if IsWow64Result then
          Result := 64;
      end
      else
        // Function not implemented: can't be running on Wow64
      Result := 32;
  except
    Result := 32;
  end;
end;

function _GetWindowsVersion: string;
  function _GetWindowsSystemWow64Folder: string;
  type
    {$IFDEF WARNDIRS}{$WARN UNSAFE_TYPE OFF}{$ENDIF}
    // type of GetSystemWow64DirectoryFn API function
    TGetSystemWow64Directory = function(lpBuffer: PChar; uSize: UINT): UINT; stdcall;
    {$IFDEF WARNDIRS}{$WARN UNSAFE_TYPE ON}{$ENDIF}
  var
    PFolder: array[0..MAX_PATH] of Char;
    GetSystemWow64Directory: TGetSystemWow64Directory;
  begin
    Result := '';
    try
      GetSystemWow64Directory := _LoadKernelFunc('GetSystemWow64DirectoryW');
      if not Assigned(GetSystemWow64Directory) then
        Exit;
      if GetSystemWow64Directory(PFolder, MAX_PATH) <> 0 then
        Result := IncludeTrailingPathDelimiter(PFolder);
    except
    end;
  end;
  function _GetWindowsSystemFolder: string;
  var
    PFolder: array[0..MAX_PATH] of Char;
  begin
    if GetSystemDirectory(PFolder, MAX_PATH) <> 0 then
      Result := IncludeTrailingPathDelimiter(PFolder)
  end;
begin
  try
    if _GetOperatingSystemArchictetureInternal = 64 then
      Result := _GetExecutableVersion(_GetWindowsSystemWow64Folder + 'kernel32.dll')
    else
      Result := _GetExecutableVersion(_GetWindowsSystemFolder + 'kernel32.dll');

    if Result = '' then
      Result := '0';
  except
    Result := '0';
  end;
end;


function _GetWindowsMajorVersion: Integer;
var
  FVersion: string;
begin
  try
    FVersion := _GetWindowsVersion;
    if FVersion <> '0' then
      Result := StrToInt(FVersion[1])
    else
      Result := Win32MajorVersion;
  except
    Result := Win32MajorVersion;
  end;
end;

function _GetWindowsMinorVersion: Integer;
var
  FVersion: string;
begin
  try
    FVersion := _GetWindowsVersion;
    if FVersion <> '0' then
      Result := StrToInt(FVersion[3])
    else
      Result := Win32MinorVersion;
  except
    Result := Win32MinorVersion;
  end;
end;

function _GetWindowsPlatform: TWindowsPlatform;
begin
  Result := ospWinNT;
  try
    case Win32Platform of
      VER_PLATFORM_WIN32_NT:      Result  := ospWinNT;
      VER_PLATFORM_WIN32_WINDOWS: Result  := ospWin9x;
      VER_PLATFORM_WIN32s:        Result  := ospWin32s;
    end;
  except
    Result := ospWinNT;
  end;
end;

function _GetWindowsIsServer: Boolean;
begin
  Result := False;
  try
    if Win32HaveExInfo then
      Result := Win32ProductType <> VER_NT_WORKSTATION;
  except
    Result := False;
  end;
end;

function _GetWindowsVersionName: string;
begin
  Result := UNKNOWN_STR;
  try
    case _GetWindowsPlatform of
      ospWin9x:  Result := 'Windows 95/98';
      ospWinNT:
      begin
        // NT platform OS
        Result := 'Windows NT';
        case _GetWindowsMajorVersion of
          5:
          begin
            // Windows 2000 or XP
            case _GetWindowsMinorVersion of
              0:
                Result := 'Windows 2000';
              1:
                Result := 'Windows XP';
              2:
              begin
                if GetSystemMetrics(SM_SERVERR2) <> 0 then
                  Result := 'Windows Server 2003 R2'
                else
                begin
                  if not _GetWindowsIsServer and
                    (pvtProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64) then
                    Result := 'Windows XP'
                  else
                    Result := 'Windows Server 2003'
                end
              end;
            end;
          end;
          6:
          begin
            case _GetWindowsMinorVersion of
              0:
                if not _GetWindowsIsServer then
                  Result := 'Windows Vista'
                else
                  Result := 'Windows Server 2008';
              1:
                if not _GetWindowsIsServer then
                  Result := 'Windows 7'
                else
                  Result := 'Windows Server 2008 R2';
            end;
          end;
        end;
      end;
    end;
  except
    Result := UNKNOWN_STR;
  end;
end;

function _GetWindowsFolder: string;
var
  FBuffer:array[0..MAX_PATH] of Char;
begin
  try
    GetWindowsDirectory(FBuffer,MAX_PATH);
    Result := IncludeTrailingPathDelimiter(_GetLongPath(StrPas(FBuffer)));
  except
    Result := '';
  end;
end;

function _GetWindowsChar: Char;
begin
  Result := 'C';
  try
    Result := _GetWindowsFolder[1];
  except
  end;
end;

procedure InitializeEx;
  {Initialise global variables with extended OS version information if possible.
  }
type
  // Function type of the GetProductInfo API function
  TGetProductInfo = function(OSMajor, OSMinor, SPMajor, SPMinor: DWORD;
    out ProductType: DWORD): BOOL; stdcall;
  // Function type of the GetNativeSystemInfo and GetSystemInfo functions
  TGetSystemInfo = procedure(var lpSystemInfo: TSystemInfo); stdcall;
var
  OSVI: TOSVersionInfoEx;           // extended OS version info structure
  POSVI: POSVersionInfo;            // pointer to OS version info structure
  GetSystemInfoFn: TGetSystemInfo;  // fn used to get system info
  SI: TSystemInfo;                  // structure from GetSystemInfo API call
begin
  // Clear the structure
  FillChar(OSVI, SizeOf(OSVI), 0);
  try
    // Get pointer to structure of non-extended type (GetVersionEx
    // requires a non-extended structure and we need this pointer to get
    // it to accept our extended structure!!)
    {$IFDEF WARNDIRS}{$WARN UNSAFE_CODE OFF}{$ENDIF}
    {$TYPEDADDRESS OFF}
    POSVI := @OSVI;
    {$TYPEDADDRESS ON}
    // Try to get exended information
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
    Win32HaveExInfo := GetVersionEx(POSVI^);
    {$IFDEF WARNDIRS}{$WARN UNSAFE_CODE ON}{$ENDIF}
    if Win32HaveExInfo then
      Win32ProductType := OSVI.wProductType;
    // Get processor architecture
    // prefer to use GetNativeSystemInfo() API call if available, otherwise use
    // GetSystemInfo()
    GetSystemInfoFn := _LoadKernelFunc('GetNativeSystemInfo');
    if not Assigned(GetSystemInfoFn) then
      GetSystemInfoFn := Windows.GetSystemInfo;
    GetSystemInfoFn(SI);
    pvtProcessorArchitecture := SI.wProcessorArchitecture;
  except
  end;
end;

initialization
  InitializeEx;

end.
