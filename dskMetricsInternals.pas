{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsInternals.pas                         }
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

unit dskMetricsInternals;

interface

uses
  Classes;

{ Operating System Functions }
function _GetOperatingSystemVersion: string;
function _GetOperatingSystemServicePack: string;
function _GetOperatingSystemArchicteture: string;
function _GetOperatingSystemLanguage: string;
function _GetOperatingSystemScreen: string;

{ Plugins Functions }
function _GetJavaVM: string;
function _GetDotNetVersion: string;
function _GetDotNetServicePack: string;

{ CPU Functions }
function _GetProcessorName: string;
function _GetProcessorBrand: string;
function _GetProcessorFrequency: Integer;
function _GetProcessorArchicteture: string;
function _GetProcessorCores: string;

{ Memory Functions }
function _GetMemoryTotal: string;
function _GetMemoryFree: string;

{ Disk Functions }
function _GetDiskTotal: string;
function _GetDiskFree: string;

{ Misc Functions }
function _GetTimeStamp: string;
function _GetFlowNumber: string;

{ Internal Sessions Functions }
function _GenerateSessionID: string;
function _SetSessionID: Boolean;
function _GetSessionID: string;

{ .NET Data }
function _GetDotNetData(var FVersion: string; var FServicePack: Integer): Boolean;

{ Internal Internet / HTTP / Post Functions }
function _SendPost(var FErrorID: Integer; const FAction: string): string;

{ Proxy Configuration }
function _SetProxy(const FServerAddress: string; FPort: Integer; const FUserName, FPassword: string): Boolean;
function _GetProxy(var FServerAddress: string; var FPort: Integer): Boolean;
function _DisableProxy: Boolean;

{ Internal User ID Functions }
function _GenerateUserID: string;
function _SetUserID(const FID: string): Boolean;
function _GetUserID: string;
function _UserIDExists: Boolean;
function _SaveUserIDReg(const FUserID: string): Boolean;
function _LoadUserIDReg: string;

{ Internal General Functions }
function _SetAppID(const FApplicationID: string): Boolean;
function _GetAppID: string;
function _GetAppVersion: string;

{ Internal Debug / Test Mode }
function  _SetDebugMode(const FEnabled: Boolean): Boolean;
function  _GetDebugMode: Boolean;
function  _GetDebugData: string;
function  _DebugLog(const FFunction: string; const FErrorID: Integer): Boolean;
function _GenerateDebugFile: Boolean;

{ Internal Cache Mode }
function _CheckCacheFile: Boolean;
function _DeleteCacheFile: Boolean;
function _GetCacheData: string;
function _GetCacheSize: Int64;
function _SaveCacheFile: Boolean;

{ Component Mode Status }
function _SetStarted(const FEnabled: Boolean): Boolean;
function _GetStarted: Boolean;

{ Internal Errors Functions }
function _ErrorToString(const FErrorID: Integer): string;

{ GUID Functions }
function _GenerateGUID: string;

implementation

uses
  dskMetricsConsts, dskMetricsVars, dskMetricsBase64, dskMetricsCommon,
  {$IFDEF CPUX86}dskMetricsCPUInfo,{$ENDIF} dskMetricsWinInfo,
  Windows, SysUtils, Registry, WinInet, DateUtils;

function _SetAppID(const FApplicationID: string): Boolean;
begin
  try
    FAppID := FApplicationID;
    Result := True;
  except
    Result := False;
  end;
end;

function _GetAppID: string;
begin
  try
    Result := Trim(FAppID);
  except
    Result  := '';
  end;
end;


function _GetAppVersion: string;
begin
  try
    if FAppVersion = NULL_STR then
      Result := Trim(_GetExecutableVersion(ParamStr(0)))
    else
      Result := Trim(FAppVersion);
  except
    Result := NULL_STR;
  end;
end;

function _SetDebugMode(const FEnabled: Boolean): Boolean;
begin
  try
    FDebugMode := FEnabled;
    Result     := True;
  except
    Result     := False;
  end;
end;

function _GetDebugMode: Boolean;
begin
  try
    Result := FDebugMode;
  except
    Result := False;
  end;
end;

function _GetDebugData: string;
begin
  try
    Result := Trim(FDebugData);
  except
    Result := '';
  end;
end;

function _DebugLog(const FFunction: string; const FErrorID: Integer): Boolean;
begin
  Result       := True;
  try
    if FDebugData = '' then
    begin
      {$IFDEF CPUX86}
      FDebugData := 'DeskMetrics DLL x86 - ' + DateToStr(Now) + sLineBreak;
      {$ENDIF$}
      {$IFDEF CPUX64}
      FDebugData := 'DeskMetrics DLL x64 - ' + DateToStr(Now) + sLineBreak;
      {$ENDIF}
    end;

    FDebugData := FDebugData + '[' + TimeToStr(Now) + '] Method: ' + FFunction  + ' (Error: ' + IntToStr(FErrorID) + ' - ' + _ErrorToString(FErrorID) + ')' + sLineBreak;
  except
    Result     := False;
  end;
end;

function _GenerateDebugFile: Boolean;
var
  FFile: TStringList;
  FDebugFilePath: string;
const
  FDebugFile = 'debug.log';
begin
  Result := True;
  try
    FDebugFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + FDebugFile;

    if FileExists(FDebugFilePath) then
      DeleteFile(FDebugFilePath);

    FFile          := TStringList.Create;
    try
      FFile.Add(FDebugData);
      FFile.SaveToFile(FDebugFilePath);
    finally
      FreeAndNil(FFile);
    end;
  except
    Result := False;
  end;
end;

function _GenerateSessionID: string;
begin
  try
    Result := _GenerateGUID;
  except
    Result := '';
  end;
end;

function _SetSessionID: Boolean;
begin
  try
    FSessionID := _GenerateSessionID;
    Result     := True;
  except
    Result     := False;
    FSessionID := NULL_STR;
  end;
end;

function _GetSessionID: string;
begin
  try
    if FSessionID <> NULL_STR then
      Result := Trim(FSessionID)
    else
    begin
      if _SetSessionID then
        Result := Trim(FSessionID);
    end;
  except
    Result := NULL_STR;
  end;
end;

function _GetTimeStamp: string;
begin
  try
    Result := IntToStr(DateTimeToUnix(Now));
  except
    Result := NULL_STR;
  end;
end;

function _GetUserID: string;
begin
  try
    if FUserID = '' then
    begin
      if _UserIDExists = False then
      begin
        Result := Trim(_GenerateUserID);
        _SaveUserIDReg(Result);
      end
      else
      begin
        Result := Trim(_LoadUserIDReg);
        if Result = '' then
        begin
          Result := Trim(_GenerateUserID);
          _SaveUserIDReg(Result);
        end;
      end;
    end
    else
      Result := Trim(FUserID);
  except
    Result := '';
  end;
end;

function _SetUserID(const FID: string): Boolean;
begin
  try
    FUserID := FID;
    Result  := True;
  except
    FUserID := '';
    Result  := False;
  end;
end;

function _GenerateUserID: string;
begin
  try
    Result := _GenerateGUID;
  except
    Result := '';
  end;
end;

function _UserIDExists: Boolean;
var
  FRegistry: TRegistry;
begin
  Result := False;
  try
    FRegistry := TRegistry.Create(KEY_ALL_ACCESS OR KEY_WOW64_32KEY);
    try
      FRegistry.RootKey := REGROOTKEY;
      if FRegistry.OpenKey(REGPATH, False) then
      begin
        if FRegistry.ValueExists('ID') then
          Result := FRegistry.ReadString('ID') <> '';
      end;
    finally
      FreeAndNil(FRegistry);
    end;
  except
    Result := False;
  end;
end;

function _SaveUserIDReg(const FUserID: string): Boolean;
var
  FRegistry: TRegistry;
begin
  Result := False;
  try
    FRegistry := TRegistry.Create(KEY_ALL_ACCESS OR KEY_WOW64_32KEY);
    try
      FRegistry.RootKey := REGROOTKEY;
      if FRegistry.OpenKey(REGPATH, True) then
        FRegistry.WriteString('ID', FUserID);
    finally
      FreeAndNil(FRegistry);
    end;
  except
    Result := False;
  end;
end;

function _LoadUserIDReg: string;
var
  FRegistry: TRegistry;
begin
  Result := '';
  try
    FRegistry := TRegistry.Create(KEY_ALL_ACCESS OR KEY_WOW64_32KEY);
    try
      FRegistry.RootKey := REGROOTKEY;
      if FRegistry.OpenKey(REGPATH, False) then
      begin
        if FRegistry.ValueExists('ID') then;
          Result := FRegistry.ReadString('ID');
      end;
    finally
      FreeAndNil(FRegistry);
    end;
  except
    Result := '';
  end;
end;

function _GetFlowNumber: string;
begin
  try
    FFlowNumber := FFlowNumber + 1;
    Result      := IntToStr(FFlowNumber);
  except
    Result := '-1';
  end;
end;

function _GetOperatingSystemVersion: string;
begin
  try
    Result := Trim(_GetWindowsVersionName);
  except
    Result := NULL_STR;
  end;
end;

function _GetOperatingSystemServicePack: string;
begin
  try
    if Win32CSDVersion = '' then
      Result := '0'
    else
      if Pos('Pack 1', Win32CSDVersion) > 0 then
        Result := '1'
      else
        if Pos('Pack 2', Win32CSDVersion) > 0 then
          Result := '2'
        else
          if Pos('Pack 3', Win32CSDVersion) > 0 then
            Result := '3'
          else
            if Pos('Pack 4', Win32CSDVersion) > 0 then
              Result := '4'
            else
              if Pos('Pack 5', Win32CSDVersion) > 0 then
                Result := '5'
              else
                if Pos('Pack 6', Win32CSDVersion) > 0 then
                  Result := '6'
                else
                  Result := Trim(Win32CSDVersion);
  except
    Result := NULL_STR;
  end;
end;

function _GetOperatingSystemArchicteture: string;
begin
  try
    Result := Trim(IntToStr(_GetOperatingSystemArchictetureInternal));
  except
    Result := NULL_STR;
  end;
end;

function _GetOperatingSystemLanguage: string;
begin
  try
    Result := Trim(IntToStr(GetSystemDefaultLCID));
  except
    Result := NULL_STR;
  end;
end;

function _GetOperatingSystemScreen: string;
var
  FHeight, FWidth: Integer;
begin
  try
    FHeight := GetSystemMetrics(SM_CXSCREEN); { Screen height in pixels }
    FWidth  := GetSystemMetrics(SM_CYSCREEN); { Screen width in pixels  }
    Result  := Trim(IntToStr(FHeight) + 'x' + IntToStr(FWidth));
  except
    Result := NULL_STR;
  end;
end;

function _GetJavaVM: string;
var
  FRegistry: TRegistry;
begin
  Result := NONE_STR;
  try
    FRegistry := TRegistry.Create(KEY_ALL_ACCESS);
    try
      {$IFDEF CPUX64}
      { try 64-bit branch }
      FRegistry.RootKey := HKEY_LOCAL_MACHINE;
      if FRegistry.OpenKeyReadOnly('\SOFTWARE\JavaSoft\Java Runtime Environment') then
      begin
        if FRegistry.ValueExists('CurrentVersion') then
          Result := Trim(FRegistry.ReadString('CurrentVersion'));
      end;
      {$ENDIF}

      { try 32-bit branch }
      if Result = NONE_STR then
      begin
        FRegistry.Access := KEY_ALL_ACCESS OR KEY_WOW64_32KEY;
        if FRegistry.OpenKeyReadOnly('\SOFTWARE\JavaSoft\Java Runtime Environment') then
        begin
          if FRegistry.ValueExists('CurrentVersion') then
            Result := Trim(FRegistry.ReadString('CurrentVersion'));
        end;
      end;

    finally
      FreeAndNil(FRegistry);
    end;
  except
    Result := NULL_STR;
  end;
end;

function _GetDotNetData(var FVersion: string; var FServicePack: Integer): Boolean;
var
  FRegistry: TRegistry;
begin
  Result := True;
  try
    FVersion     := NONE_STR;
    FServicePack := -1;

    FRegistry := TRegistry.Create(KEY_ALL_ACCESS);
    try
      FRegistry.RootKey := HKEY_LOCAL_MACHINE;

      if FRegistry.OpenKeyReadOnly('SOFTWARE\Microsoft\NET Framework Setup\NDP\v4') then
      begin
        FVersion     := '4.0';
        FServicePack := 0;
        Exit;
      end;

      if FRegistry.OpenKeyReadOnly('SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5') then
      begin
        FVersion := '3.5';

        if FRegistry.ValueExists('SP') then
          FServicePack := FRegistry.ReadInteger('SP');

        Exit;
      end;

      if FRegistry.OpenKeyReadOnly('SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0') then
      begin
        FVersion := '3.0';

        if FRegistry.ValueExists('SP') then
          FServicePack := FRegistry.ReadInteger('SP');

        Exit;
      end;

      if FRegistry.OpenKeyReadOnly('SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727') then
      begin
        FVersion := '2.0.50727';

        if FRegistry.ValueExists('SP') then
          FServicePack := FRegistry.ReadInteger('SP');

        Exit;
      end;

      if FRegistry.OpenKeyReadOnly('SOFTWARE\Microsoft\NET Framework Setup\NDP\v1.1.4322') then
      begin
        FVersion := '1.1.4322';

        if FRegistry.ValueExists('SP') then
          FServicePack := FRegistry.ReadInteger('SP');

        Exit;
      end;

      if FRegistry.OpenKeyReadOnly('SOFTWARE\Microsoft\.NETFramework\policy\v1.0') then
      begin
        FVersion := '1.0';

        if FRegistry.ValueExists('SP') then
          FServicePack := FRegistry.ReadInteger('SP');

        Exit;
      end;
    finally
      FreeAndNil(FRegistry);
    end;
  except
    Result := False;
  end;
end;

function _GetDotNetVersion: string;
var
  FVersion: string;
  FServicePack: Integer;
begin
  try
    _GetDotNetData(FVersion, FServicePack);
    if FVersion <> '' then
      Result := Trim(FVersion)
    else
      Result := NULL_STR;
  except
    Result := NULL_STR;
  end;
end;

function _GetDotNetServicePack: string;
var
  FVersion: string;
  FServicePack: Integer;
begin
  try
    _GetDotNetData(FVersion, FServicePack);
    if FServicePack > 0 then
      Result := Trim(IntToStr(FServicePack))
    else
      Result := NULL_STR;
  except
    Result := NULL_STR;
  end;
end;

function _GetProcessorName: string;
var
  FRegistry: TRegistry;
begin
  try
    FRegistry := TRegistry.Create(KEY_ALL_ACCESS);
    try
      FRegistry.RootKey := HKEY_LOCAL_MACHINE;
      if FRegistry.OpenKeyReadOnly('\HARDWARE\DESCRIPTION\System\CentralProcessor\0') then
      begin
        if FRegistry.ValueExists('ProcessorNameString') then
          Result := FRegistry.ReadString('ProcessorNameString');

        if Result <> '' then
          Result := StringReplace(Result, '(R)', '', [rfReplaceAll,rfIgnoreCase]);

        if Result <> '' then
          Result := StringReplace(Result, '(TM)', '', [rfReplaceAll,rfIgnoreCase]);

        Result := StringReplace(Result, '  ', '', [rfReplaceAll, rfIgnoreCase]);
        Result := Trim(Result);
      end;
    finally
      FreeAndNil(FRegistry);
    end;
  except
    Result := NULL_STR;
  end;
end;

function _GetProcessorBrand: string;
var
  FProcessorBrand: string;
begin
  try
      FProcessorBrand  := _GetProcessorName;

      { Detect Intel CPUs }
      if (Pos('Intel', FProcessorBrand) > 0)   or
         (Pos('Pentium', FProcessorBrand) > 0) or
         (Pos('Celeron', FProcessorBrand) > 0) or
         (Pos('GenuineIntel', FProcessorBrand) > 0)
      then
      begin
        Result := 'Intel';
        Exit;
      end;

      { Detect AMD CPUs }
      if (Pos('AMD', FProcessorBrand) > 0) or
         (Pos('Athlon', FProcessorBrand) > 0) or
         (Pos('Sempron', FProcessorBrand) > 0)
      then
      begin
        Result := 'AMD';
        Exit;
      end;
  except
    Result := NULL_STR;
  end;
end;

function _GetProcessorFrequency: Integer;
begin
  try
    Result := 0;
  except
    Result := 0;
  end;
end;

function _GetProcessorArchicteture: string;
begin
  {$IFDEF CPUX64}
  try
    Result := '64';
  except
    Result := NULL_STR;
  end;
  {$ENDIF}

  {$IFDEF CPUX86}
  try
    Result := Trim(_GetProcessorArchitectureInternal);
    if (Result = '32') and ((_GetProcessorCores = '4') or (_GetProcessorCores = '2') or (_GetProcessorCores = '6') or (_GetProcessorCores = '8')) then
      Result := '64';
  except
    Result := NULL_STR;
  end;
  {$ENDIF}
end;

function _GetProcessorCores: string;
var
  FProcessorName: string;
begin
  Result := '1';
  try
    FProcessorName := UpperCase(_GetProcessorName);

    if (Pos(UpperCase('DualCore'), FProcessorName) > 0)  or  (Pos(UpperCase('Dual Core'), FProcessorName) > 0) or
       (Pos(UpperCase('Core 2'), FProcessorName) > 0)     or (Pos(UpperCase('Core2Duo'), FProcessorName) > 0) or
       (Pos(UpperCase('Core2 Duo'), FProcessorName) > 0)  or (Pos(UpperCase('X2'), FProcessorName) > 0) or
       (Pos(UpperCase('i3'), FProcessorName) > 0)         or (Pos(UpperCase('Athlon II'), FProcessorName) > 0) or
       (Pos(UpperCase('Dual-Core'), FProcessorName) > 0)
    then
      Result := '2'
    else
      if (Pos(UpperCase('X3'), FProcessorName) > 0) then
        Result := '3'
      else
        if (Pos(UpperCase('Quad'), FProcessorName) > 0) or (Pos(UpperCase('i5'), FProcessorName) > 0) or
           (Pos(UpperCase('X4'), FProcessorName) > 0) then
          Result := '4'
        else
          if  (Pos(UpperCase('i7'), FProcessorName) > 0)then
            Result := '6'
          else
            if (Pos(UpperCase('V8'), FProcessorName) > 0) or (Pos(UpperCase('8-core'), FProcessorName) > 0)then
              Result := '8'
  except
    Result := NULL_STR;
  end;
end;

function _GetMemoryTotal: string;
var
  recMemoryStatus: TMemoryStatus;
begin
  try
    recMemoryStatus.dwLength := SizeOf(recMemoryStatus);
    GlobalMemoryStatus(recMemoryStatus);
    Result := Trim(IntToStr(recMemoryStatus.dwTotalPhys));
  except
    Result := NULL_STR;
  end;
end;

function _GetMemoryFree: string;
var
  recMemoryStatus: TMemoryStatus;
begin
  try
    recMemoryStatus.dwLength := SizeOf(recMemoryStatus);
    GlobalMemoryStatus(recMemoryStatus);
    Result := Trim(IntToStr(recMemoryStatus.dwAvailPhys));
  except
    Result := NULL_STR;
  end;
end;

function _GetDiskTotal: string;
begin
  try
    Result := Trim(IntToStr(DiskSize(Ord(_GetWindowsChar) - 64)));
  except
    Result := NULL_STR;
  end;
end;

function _GetDiskFree: string;
begin
  try
    Result := Trim(IntToStr(DiskFree(Ord(_GetWindowsChar) - 64)));
  except
    Result := NULL_STR;
  end;
end;

function _SendPost(var FErrorID: Integer; const FAction: string): string;
var
  FJSONTemp: string;
  hint,hconn,hreq:hinternet;
  hdr: UTF8String;
  buf:array[0..READBUFFERSIZE-1] of PAnsiChar;
  bufsize:dword;
  i,flags:integer;
  data: UTF8String;
  dwSize, dwFlags: DWORD;
begin
  FErrorID  := 0;
  try
    FJSONTemp := FJSONData;

    { check type - WebService API Call }
    if FAction = API_SENDDATA then
    begin
      hdr       := UTF8Encode('Content-Type: application/json');
      data      := UTF8Encode('[' + FJSONTemp + ']');
    end;

    hint := InternetOpenW(PWideChar(FPostAgent),INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
    if hint = nil then
    begin
      FErrorID := 2;
      Exit;
    end;

    try
      { Set HTTP request timeout }
      if FPostTimeOut > 0 then
      begin
        InternetSetOption(hint, INTERNET_OPTION_CONNECT_TIMEOUT, @FPostTimeOut, SizeOf(FPostTimeOut));
        InternetSetOption(hint, INTERNET_OPTION_SEND_TIMEOUT,    @FPostTimeOut, SizeOf(FPostTimeOut));
        InternetSetOption(hint, INTERNET_OPTION_RECEIVE_TIMEOUT, @FPostTimeOut, SizeOf(FPostTimeOut));
      end;

      { Set HTTP port }
      hconn := InternetConnect(hint,PChar(FAppID + FPostServer),FPostPort,nil,nil,INTERNET_SERVICE_HTTP,0,1);
      if hconn = nil then
      begin
        FErrorID := 3;
        Exit;
      end;

      try
        if FPostPort = INTERNET_DEFAULT_HTTPS_PORT then
          flags := INTERNET_FLAG_NO_UI or INTERNET_FLAG_SECURE or INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID
        else
          flags := INTERNET_FLAG_NO_UI;

        hreq := HttpOpenRequest(hconn, 'POST', PChar(FAction), nil, nil, nil, flags, 1);
        if Assigned(hreq) and (FPostPort = INTERNET_DEFAULT_HTTPS_PORT) then
        begin
          dwSize := SizeOf(dwFlags);
          if (InternetQueryOption(hreq, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, dwSize)) then
          begin
            dwFlags := dwFlags or SECURITY_FLAG_IGNORE_UNKNOWN_CA;
            if not (InternetSetOption(hreq, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, dwSize)) then
              FErrorID := 4;
          end
          else
            FErrorID := 5;  //InternetQueryOption failed
        end;

        if hreq = nil then
        begin
          FErrorID := 2;
          Exit;
        end;

        try
          if HttpSendRequestA(hreq,PAnsiChar(hdr),Length(hdr), PAnsiChar(Data),Length(Data)) then
          begin
            if (FPostWaitResponse) then
            begin
              { Read server Response }
              bufsize := READBUFFERSIZE;
              while (bufsize > 0) do
              begin
                if not InternetReadFile(hreq,@buf,READBUFFERSIZE,bufsize) then
                begin
                  FErrorID := 7;
                  Break;
                end;

                if (bufsize > 0) and (bufsize <= READBUFFERSIZE) then
                begin
                  for i := 0 to bufsize - 1 do
                    Result := Result + string(buf[i]);
                end;
              end;
            end;
          end
          else
            FErrorID := 6;
        finally
          InternetCloseHandle(hreq);
        end;
      finally
        InternetCloseHandle(hconn);
      end;
    finally
      InternetCloseHandle(hint);
    end;
  except
    Result   := '';
    FErrorID := 5;
  end;
end;

function _SetProxy(const FServerAddress: string; FPort: Integer; const FUserName, FPassword: string): Boolean;
var
  list: INTERNET_PER_CONN_OPTION_LIST;
  dwBufSize: DWORD;
  hInternet, hInternetConnect: Pointer;
  Options: array[1..3] of INTERNET_PER_CONN_OPTION;
begin
  Result := False;
  try
    if FServerAddress = '' then
    begin
      Result := _DisableProxy;
      Exit;
    end;

    if FPort <= 0 then
      FPort := DEFAULTPROXYPORT;

    dwBufSize                 := SizeOf(list);
    list.dwSize               := SizeOf(list);
    list.pszConnection        := nil;
    list.dwOptionCount        := High(Options);
    Options[1].dwOption       := INTERNET_PER_CONN_FLAGS;
    Options[1].Value.dwValue  := PROXY_TYPE_DIRECT or PROXY_TYPE_PROXY;
    Options[2].dwOption       := INTERNET_PER_CONN_PROXY_SERVER;
    Options[2].Value.pszValue := PAnsiChar(AnsiString(FServerAddress));
    Options[3].dwOption       := INTERNET_PER_CONN_PROXY_BYPASS;
    Options[3].Value.pszValue := '<local>';
    list.pOptions             := @Options;

    hInternet := InternetOpen(PChar('DeskMetrics'), INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
    if hInternet <> nil then
    try
      hInternetConnect := InternetConnect(hInternet, PChar(FServerAddress), FPort, PChar(FUserName), PChar(FPassword),INTERNET_SERVICE_HTTP, 0, 0);
      if hInternetConnect <> nil then
      begin
        Result := InternetSetOption(hInternet, INTERNET_OPTION_PER_CONNECTION_OPTION, @list, dwBufSize);
        if Result then
          Result := InternetSetOption(hInternet, INTERNET_OPTION_REFRESH, nil, 0);
      end;

      if Result then
      begin
        FProxyServer := FServerAddress;
        FProxyPort   := FPort;
        FProxyUser   := FUserName;
        FProxyPass   := FPassword;
      end;
    finally
      InternetCloseHandle(hInternet)
    end;
  except
    Result := False;
  end;
end;

function _GetProxy(var FServerAddress: string; var FPort: Integer): Boolean;
begin
  Result           := True;
  try
    FServerAddress := FProxyServer;
    FPort          := FProxyPort;
  except
    Result         := False;
  end;
end;

function _DisableProxy: Boolean;
var
  list: INTERNET_PER_CONN_OPTION_LIST;
  dwBufSize: DWORD;
  hInternet: Pointer;
  Options: array[1..3] of INTERNET_PER_CONN_OPTION;
begin
  Result := False;
  try
    dwBufSize                 := SizeOf(list);
    list.dwSize               := SizeOf(list);
    list.pszConnection        := nil;
    list.dwOptionCount        := High(Options);
    Options[1].dwOption       := INTERNET_PER_CONN_FLAGS;
    Options[1].Value.dwValue  := PROXY_TYPE_DIRECT or PROXY_TYPE_PROXY;
    Options[2].dwOption       := INTERNET_PER_CONN_PROXY_SERVER;
    Options[2].Value.pszValue := PAnsiChar('');
    Options[3].dwOption       := INTERNET_PER_CONN_PROXY_BYPASS;
    Options[3].Value.pszValue := '<local>';
    list.pOptions             := @Options;

    hInternet := InternetOpen(PChar('DeskMetrics'), INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
    if hInternet <> nil then
    try
      Result := InternetSetOption(hInternet, INTERNET_OPTION_PER_CONNECTION_OPTION, @list, dwBufSize);
      if Result then
        Result := InternetSetOption(hInternet, INTERNET_OPTION_REFRESH, nil, 0);
    finally
      InternetCloseHandle(hInternet)
    end;
  except
    Result := False;
  end;
end;

function _ErrorToString(const FErrorID: Integer): string;
begin
  try
    case FErrorID of
      0, 1:   Result := 'OK';
      2:      Result := 'Could not open HTTP component (InternetOpen)';
      3:      Result := 'Could not connect to server (InternetConnect)';
      4:      Result := 'Could not modify HTTP options (InternetSetOption)';
      5:      Result := 'Could not modify HTTP security parameters (InternetQueryOption)';
      6:      Result := 'Could not send HTTP request to server (HttpSendRequest)';
      7:      Result := 'Could not read server response (InternetReadFile)';
      8:      Result := 'Could not detect internet connection (InternetGetConnectedState)';
      9:      Result := 'Exceeded the available bandwidth';
      -8:     Result := 'Empty POST data';
      -9:     Result := 'Invalid JSON file';
      -10:    Result := 'Missing required JSON data';
      -11:    Result := 'AppID not found';
      -12:    Result := 'UserID not found';
      -13:    Result := 'Use POST Request';
      -14:    Result := 'Application version not found';
    else
      Result := UNKNOWN_STR;
    end;
  except
    Result := UNKNOWN_STR;
  end;
end;

function _GenerateGUID: string;
var
  FGUIDString: string;
  FGUID: TGUID;
begin
  try
    CreateGUID(FGUID);
    FGUIDString := GUIDToString(FGUID);

    Result      := StringReplace(FGUIDString, '{', '', [rfReplaceAll, rfIgnoreCase]);
    Result      := StringReplace(Result, '}', '', [rfReplaceAll, rfIgnoreCase]);
    Result      := StringReplace(Result, '-', '', [rfReplaceAll, rfIgnoreCase]);
    Result      := Trim(Result);
  except
    Result := '00000000000000000000000000000000';
  end;
end;

function _SetStarted(const FEnabled: Boolean): Boolean;
begin
  Result   := True;
  try
    FStarted := FEnabled;
  except
    Result   := False;
  end;
end;

function _GetStarted: Boolean;
begin
  try
    Result := FStarted;
  except
    Result := False;
  end;
end;

{ Internal Cache Mode }

function _CheckCacheFile: Boolean;
begin
  Result := True;
  try
    if (FLastErrorID = 0) then
      _DeleteCacheFile
    else
      _SaveCacheFile;
  except
    Result := False;
  end;
end;

function _GetCacheData: string;
var
  FData: string;
  FFileName: string;
  FTempFolder: string;
  FFile: TextFile;
begin
  Result := '';
  try
    FTempFolder := _GetTemporaryFolder;

    if (FTempFolder = '') or (DirectoryExists(FTempFolder) = False) then
    begin
      Result := '';
      Exit;
    end;

    FFileName := FTempFolder + _GetAppID + '.dsmk';

    AssignFile(FFile, FFileName);
    if FileExists(FFileName) then
    begin
      try
        Reset(FFile);
        ReadLn(FFile, FData);
        Result := string(Base64DecodeStr(AnsiString(FData)));
      finally
        CloseFile(FFile);
      end;
    end;
  except
    Result := '';
  end;
end;

function _GetCacheSize: Int64;
var
  FFileName: string;
  FTempFolder: string;
  FSearchRec: TSearchRec;
begin
  Result := -1;
  try
    if (FTempFolder = '') or (DirectoryExists(FTempFolder) = False) then
    begin
      Result := -1;
      Exit;
    end;

    FFileName := FTempFolder + _GetAppID + '.dsmk';

    if FileExists(FFileName) then
    begin
      try
        if FindFirst(FFileName, faAnyFile, FSearchRec) = 0 then
          Result := Int64(FSearchRec.FindData.nFileSizeHigh) shl Int64(32) + Int64(FSearchRec.FindData.nFileSizeLow);
      finally
        FindClose(FSearchRec);
      end;
    end;
  except
    Result := -1;
  end;
end;

function _SaveCacheFile: Boolean;
var
  FTempFolder: string;
  FFileName: string;
  FFile: TextFile;
begin
  Result := True;
  try
    FTempFolder := _GetTemporaryFolder;

    if (FTempFolder = '') or (DirectoryExists(FTempFolder) = False) then
    begin
      Result := False;
      Exit;
    end;

    FFileName := FTempFolder + _GetAppID + '.dsmk';

    AssignFile(FFile, FFileName);
    try
      if FileExists(FFileName) then
      begin
        Append(FFile);
        Write(FFile, Base64EncodeStr(','));
      end
      else
        Rewrite(FFile);

      Write(FFile, Base64EncodeStr(AnsiString(FJSONData)));

      SetFileAttributes(PChar(FFileName), faHidden);
    finally
      CloseFile(FFile);
    end;
  except
    Result := False;
  end;
end;

function _DeleteCacheFile: Boolean;
var
  FFileName: string;
begin
  Result := True;
  try
    FFileName := _GetTemporaryFolder + _GetAppID + '.dsmk';
    if FileExists(FFileName) then
    begin
      SetFileAttributes(PChar(FFileName), faArchive);
      Result := SysUtils.DeleteFile(FFileName);
    end;
  except
    Result := False;
  end;
end;

end.
