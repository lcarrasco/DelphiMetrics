{ **********************************************************}
{                                                           }
{     DeskMetrics - Delphi Dynamic Unit                     }
{     Copyright (c) 2010-2011                               }
{                                                           }
{     http://deskmetrics.com                                }
{     support@deskmetrics.com                               }
{                                                           }
{     Author: Stuart Clennett							                	}
{     Licence: GNU GPL v3								                  	}
{															                              }
{ **********************************************************}

unit DeskMetrics_Dynamic;

interface

type
  TVersionData = record
    Version: ShortString;
    DownloadURL: ShortString;
    ReleaseNote: ShortString;
    ReleaseDate: ShortString;
  end;

  TDMStart                = function(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FRealTime: Boolean): Boolean; stdcall;
  TDMStartA               = function(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FRealTime: Boolean): Boolean; stdcall;
  TDMStop                 = function: Boolean; stdcall;
  TDMCheckVersion         = function(var FVersionData: TVersionData): Boolean; stdcall;
  TDMTrackEvent           = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventA          = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventValue      = procedure(FEventCategory, FEventName, FEventValue: PWideChar); stdcall;
  TDMTrackEventValueA     = procedure(FEventCategory, FEventName, FEventValue: PAnsiChar); stdcall;
  TDMTrackEventStart      = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventStartA     = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventStop       = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventStopA      = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventCancel     = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventCancelA    = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackLog             = procedure(FMessage: PWideChar); stdcall;
  TDMTrackLogA            = procedure(FMessage: PAnsiChar); stdcall;
  TDMTrackCustomData      = procedure(FName, FValue: PWideChar); stdcall;
  TDMTrackCustomDataA     = procedure(FName, FValue: PAnsiChar); stdcall;
  TDMTrackCustomDataR     = function(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FName: PWideChar; FValue: PWideChar): Integer; stdcall;
  TDMTrackCustomDataRA    = function(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar): Integer; stdcall;
  TDMTrackInstallation    = function(FApplicationID: string; FApplicationVersion: string): Integer; stdcall;
  TDMTrackInstallationA   = function(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer; stdcall;
  TDMTrackUninstallation  = function(FApplicationID: string; FApplicationVersion: string): Integer; stdcall;
  TDMTrackUninstallationA = function(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer; stdcall;
  TDMSetProxy             = function(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean; stdcall;
  TDMSetProxyA            = function(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean; stdcall;
  TDMGetProxy             = function(var FHostIP: PWideChar; var FPort: Integer): Boolean; stdcall;
  TDMGetProxyA            = function(var FHostIP: PAnsiChar; var FPort: Integer): Boolean; stdcall;
  TDMSetUserID            = function(FID: PWideChar): Boolean; stdcall;
  TDMSetUserIDA           = function(FID: PAnsiChar): Boolean; stdcall;
  TDMGetComponentName     = function:PWideChar; stdcall;
  TDMGetComponentNameA    = function:PAnsiChar; stdcall;
  TDMGetComponentVersion  = function:PWideChar; stdcall;
  TDMGetComponentVersionA = function:PAnsiChar; stdcall;
  TDMGetPostServer        = function:PWideChar; stdcall;
  TDMGetPostServerA       = function:PAnsiChar; stdcall;
  TDMSetPostServer        = function(FServer: PWideChar): Boolean; stdcall;
  TDMSetPostServerA       = function(FServer: PAnsiChar): Boolean; stdcall;
  TDMGetPostPort          = function:Integer; stdcall;
  TDMSetPostPort          = function(FPort: Integer): Boolean; stdcall;
  TDMGetPostTimeOut       = function:Integer; stdcall;
  TDMSetPostTimeOut       = function(FTimeOut: Integer): Boolean; stdcall;
  TDMGetPostWaitResponse  = function:Boolean; stdcall;
  TDMSetPostWaitResponse  = function(FEnabled: Boolean): Boolean; stdcall;
  TDMGetJSON              = function:PWideChar; stdcall;
  TDMGetJSONA             = function:PAnsiChar; stdcall;
  TDMGetDailyNetworkUtilizationInKB = function: Integer; stdcall;
  TDMSetDailyNetworkUtilizationInKB = function(FDataSize: Integer): Boolean; stdcall;
  TDMGetMaxStorageSizeInKB = function: Integer; stdcall;
  TDMSetMaxStorageSizeInKB = function(FDataSize: Integer): Boolean; stdcall;
  TDMSetEnabled            = function(FValue: Boolean): Boolean; stdcall;
  TDMGetEnabled            = function:Boolean; stdcall;
  TDMSendData              = function:Boolean; stdcall;
  TDMGetDebugMode          = function:Boolean; stdcall;
  TDMSetDebugMode          = function(FEnabled: Boolean): Boolean; stdcall;
  // TDMTrackExceptions = procedure(FEnabled: Boolean); stdcall;
  // TDMTrackException = procedure(FExceptionMessage, FExceptionType: PWideChar); stdcall;
  // TDMTrackExceptionA = procedure(FExceptionMessage, FExceptionType: PAnsiChar); stdcall;

  function  DeskMetricsStart(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FRealTime: Boolean): Boolean;
  function  DeskMetricsStartA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FRealTime: Boolean): Boolean;
  function  DeskMetricsStop: Boolean;
  function  DeskMetricsCheckVersion(var FVersionData: TVersionData): Boolean;
  procedure DeskMetricsTrackEvent(FEventCategory, FEventName: PWideChar);
  procedure DeskMetricsTrackEventA(FEventCategory, FEventName: PAnsiChar);
  procedure DeskMetricsTrackEventValue(FEventCategory, FEventName, FEventValue: PWideChar);
  procedure DeskMetricsTrackEventValueA(FEventCategory, FEventName, FEventValue: PAnsiChar);
  procedure DeskMetricsTrackEventStart(FEventCategory, FEventName: PWideChar);
  procedure DeskMetricsTrackEventStartA(FEventCategory, FEventName: PAnsiChar);
  procedure DeskMetricsTrackEventStop(FEventCategory, FEventName: PWideChar);
  procedure DeskMetricsTrackEventStopA(FEventCategory, FEventName: PAnsiChar);
  procedure DeskMetricsTrackEventCancel(FEventCategory, FEventName: PWideChar);
  procedure DeskMetricsTrackEventCancelA(FEventCategory, FEventName: PAnsiChar);
  procedure DeskMetricsTrackLog(FMessage: PWideChar);
  procedure DeskMetricsTrackLogA(FMessage: PAnsiChar);
  procedure DeskMetricsTrackCustomData(FName, FValue: PWideChar);
  procedure DeskMetricsTrackCustomDataA(FName, FValue: PAnsiChar);
  function  DeskMetricsTrackCustomDataR(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FName: PWideChar; FValue: PWideChar): Integer;
  function  DeskMetricsTrackCustomDataRA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar): Integer;
  function  DeskMetricsTrackInstallation(FApplicationID: string; FApplicationVersion: string): Integer;
  function  DeskMetricsTrackInstallationA(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer;
  function  DeskMetricsTrackUninstallation(FApplicationID: string; FApplicationVersion: string): Integer;
  function  DeskMetricsTrackUninstallationA(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer;
  function  DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean;
  function  DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean;
  function  DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean;
  function  DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean;
  function  DeskMetricsSetUserID(FID: PWideChar): Boolean;
  function  DeskMetricsSetUserIDA(FID: PAnsiChar): Boolean;
  function  DeskMetricsGetComponentName: PWideChar;
  function  DeskMetricsGetComponentNameA: PAnsiChar;
  function  DeskMetricsGetComponentVersion: PWideChar;
  function  DeskMetricsGetComponentVersionA: PAnsiChar;
  function  DeskMetricsGetPostServer: PWideChar;
  function  DeskMetricsGetPostServerA: PAnsiChar;
  function  DeskMetricsSetPostServer(FServer: PWideChar): Boolean;
  function  DeskMetricsSetPostServerA(FServer: PAnsiChar): Boolean;
  function  DeskMetricsGetPostPort: Integer;
  function  DeskMetricsSetPostPort(FPort: Integer): Boolean;
  function  DeskMetricsGetPostTimeOut: Integer;
  function  DeskMetricsSetPostTimeOut(FTimeOut: Integer): Boolean;
  function  DeskMetricsGetPostWaitResponse: Boolean;
  function  DeskMetricsSetPostWaitResponse(FEnabled: Boolean): Boolean;
  function  DeskMetricsGetJSON: PWideChar;
  function  DeskMetricsGetJSONA: PAnsiChar;
  function  DeskMetricsGetDailyNetworkUtilizationInKB: Integer;
  function  DeskMetricsSetDailyNetworkUtilizationInKB(FDataSize: Integer): Boolean;
  function  DeskMetricsGetMaxStorageSizeInKB: Integer;
  function  DeskMetricsSetMaxStorageSizeInKB(FDataSize: Integer): Boolean;
  function  DeskMetricsSetEnabled(FValue: Boolean): Boolean;
  function  DeskMetricsGetEnabled: Boolean;
  function  DeskMetricsSendData: Boolean;
  function  DeskMetricsGetDebugMode: Boolean;
  function  DeskMetricsSetDebugMode(FEnabled: Boolean): Boolean;
  // procedure DeskMetricsTrackExceptions(FEnabled: Boolean);
  // procedure DeskMetricsTrackException(FExceptionMessage, FExceptionType: PWideChar);
  // procedure DeskMetricsTrackExceptionA(FExceptionMessage, FExceptionType: PAnsiChar);

  function  DeskMetricsDllLoaded: Boolean;
  function  Load_DLL: Boolean;
  function  Unload_DLL: Boolean;

const
  EMPTY_STRING = '';
  NO_INTEGER_VALUE = 0;

implementation

uses SysUtils, Windows;

var
  hModule : THandle;

const
  DESKMETRICS_DLL = 'DeskMetrics.DLL';

  PROC_DeskMetricsStart = 'DeskMetricsStart';
  PROC_DeskMetricsStartA = 'DeskMetricsStartA';
  PROC_DeskMetricsStop = 'DeskMetricsStop';
  PROC_DeskMetricsCheckVersion  = 'DeskMetricsCheckVersion';
  PROC_DeskMetricsTrackEvent = 'DeskMetricsTrackEvent';
  PROC_DeskMetricsTrackEventA = 'DeskMetricsTrackEventA';
  PROC_DeskMetricsTrackEventValue = 'DeskMetricsTrackEventValue';
  PROC_DeskMetricsTrackEventValueA = 'DeskMetricsTrackEventValueA';
  PROC_DeskMetricsTrackEventStart = 'DeskMetricsTrackEventStart';
  PROC_DeskMetricsTrackEventStartA = 'DeskMetricsTrackEventStartA';
  PROC_DeskMetricsTrackEventStop = 'DeskMetricsTrackEventStop';
  PROC_DeskMetricsTrackEventStopA = 'DeskMetricsTrackEventStopA';
  PROC_DeskMetricsTrackEventCancel = 'DeskMetricsTrackEventCancel';
  PROC_DeskMetricsTrackEventCancelA = 'DeskMetricsTrackEventCancelA';
  PROC_DeskMetricsTrackLog = 'DeskMetricsTrackLog';
  PROC_DeskMetricsTrackLogA = 'DeskMetricsTrackLogA';
  PROC_DeskMetricsTrackCustomData = 'DeskMetricsTrackCustomData';
  PROC_DeskMetricsTrackCustomDataA = 'DeskMetricsTrackCustomDataA';
  PROC_DeskMetricsTrackCustomDataR = 'DeskMetricsTrackCustomDataR';
  PROC_DeskMetricsTrackCustomDataRA = 'DeskMetricsTrackCustomDataRA';
  PROC_DeskMetricsTrackInstallation = 'DeskMetricsTrackInstallation';
  PROC_DeskMetricsTrackInstallationA = 'DeskMetricsTrackInstallationA';
  PROC_DeskMetricsTrackUninstallation = 'DeskMetricsTrackUninstallation';
  PROC_DeskMetricsTrackUninstallationA = 'DeskMetricsTrackUninstallationA';
  PROC_DeskMetricsSetProxy = 'DeskMetricsSetProxy';
  PROC_DeskMetricsSetProxyA = 'DeskMetricsSetProxyA';
  PROC_DeskMetricsGetProxy = 'DeskMetricsGetProxy';
  PROC_DeskMetricsGetProxyA = 'DeskMetricsGetProxyA';
  PROC_DeskMetricsSetUserID = 'DeskMetricsSetUserID';
  PROC_DeskMetricsSetUserIDA = 'DeskMetricsSetUserIDA';
  PROC_DeskMetricsGetComponentName = 'DeskMetricsGetComponentName';
  PROC_DeskMetricsGetComponentNameA = 'DeskMetricsGetComponentNameA';
  PROC_DeskMetricsGetComponentVersion = 'DeskMetricsGetComponentVersion';
  PROC_DeskMetricsGetComponentVersionA = 'DeskMetricsGetComponentVersionA';
  PROC_DeskMetricsGetPostServer = 'DeskMetricsGetPostServer';
  PROC_DeskMetricsGetPostServerA = 'DeskMetricsGetPostServerA';
  PROC_DeskMetricsSetPostServer = 'DeskMetricsSetPostServer';
  PROC_DeskMetricsSetPostServerA = 'DeskMetricsSetPostServerA';
  PROC_DeskMetricsGetPostPort = 'DeskMetricsGetPostPort';
  PROC_DeskMetricsSetPostPort = 'DeskMetricsSetPostPort';
  PROC_DeskMetricsGetPostTimeOut = 'DeskMetricsGetPostTimeOut';
  PROC_DeskMetricsSetPostTimeOut = 'DeskMetricsSetPostTimeOut';
  PROC_DeskMetricsGetPostWaitResponse = 'DeskMetricsGetPostWaitResponse';
  PROC_DeskMetricsSetPostWaitResponse = 'DeskMetricsSetPostWaitResponse';
  PROC_DeskMetricsGetJSON = 'DeskMetricsGetJSON';
  PROC_DeskMetricsGetJSONA = 'DeskMetricsGetJSONA';
  PROC_DeskMetricsGetDailyNetworkUtilizationInKB = 'DeskMetricsGetDailyNetworkUtilizationInKB';
  PROC_DeskMetricsSetDailyNetworkUtilizationInKB = 'DeskMetricsSetDailyNetworkUtilizationInKB';
  PROC_DeskMetricsGetMaxStorageSizeInKB = 'DeskMetricsGetMaxStorageSizeInKB';
  PROC_DeskMetricsSetMaxStorageSizeInKB = 'DeskMetricsSetMaxStorageSizeInKB';
  PROC_DeskMetricsSetEnabled = 'DeskMetricsSetEnabled';
  PROC_DeskMetricsGetEnabled = 'DeskMetricsGetEnabled';
  PROC_DeskMetricsSendData = 'DeskMetricsSendData';
  PROC_DeskMetricsGetDebugMode = 'DeskMetricsGetDebugMode';
  PROC_DeskMetricsSetDebugMode = 'DeskMetricsSetDebugMode';
  // PROC_DeskMetricsTrackExceptions = 'DeskMetricsTrackExceptions';
  // PROC_DeskMetricsTrackException = 'DeskMetricsTrackException';
  // PROC_DeskMetricsTrackExceptionA = 'DeskMetricsTrackExceptionA';

function GetAppPath : string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

function CheckLoadDLL : boolean;
begin
  if hModule < HINSTANCE_ERROR then
  begin
    hModule := LoadLibrary(PChar(GetAppPath + DESKMETRICS_DLL));
    Result := not(hModule < HINSTANCE_ERROR);
  end else
    Result := TRUE;
end;

function  DeskMetricsDllLoaded : boolean;
begin
  Result := not (hModule < HINSTANCE_ERROR);
end;

function  Load_DLL : boolean;
begin
  Result := CheckLoadDLL;
end;

function  Unload_DLL : boolean;
begin
  Result := false;
  if not (hModule < HINSTANCE_ERROR) then
    Result := FreeLibrary(hModule);
end;

function  DeskMetricsStart(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FRealTime: Boolean): Boolean;
const
  DMStart : TDMStart = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMStart := GetProcAddress(hModule, PROC_DeskMetricsStart);
    if assigned(DMStart) then
      Result := DMStart(FApplicationID, FApplicationVersion, FRealTime);
  end;
end;

function  DeskMetricsStartA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FRealTime: Boolean): Boolean;
const
  DMStartA : TDMStartA = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMStartA := GetProcAddress(hModule, PROC_DeskMetricsStartA);
    if assigned(DMStartA) then
      Result := DMStartA(FApplicationID, FApplicationVersion, FRealTime);
  end;
end;

function  DeskMetricsStop: Boolean;
const
  DMStop : TDMStop = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMStop := GetProcAddress(hModule, PROC_DeskMetricsStop);
    if assigned(DMStop) then
      Result := DMStop;
  end;
end;

function  DeskMetricsCheckVersion(var FVersionData: TVersionData): Boolean;
const
  DMCheckVersion : TDMCheckVersion = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMCheckVersion := GetProcAddress(hModule, PROC_DeskMetricsCheckVersion);
    if Assigned(DMCheckVersion) then
      Result := DMCheckVersion(fVersionData);
  end;
end;

procedure DeskMetricsTrackEvent(FEventCategory, FEventName: PWideChar);
const
  DMTrackEvent : TDMTrackEvent = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEvent := GetProcAddress(hModule, PROC_DeskMetricsTrackEvent);
    if Assigned(DMTrackEvent) then
      DMTrackEvent(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventA(FEventCategory, FEventName: PAnsiChar);
const
  DMTrackEventA : TDMTrackEventA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventA);
    if Assigned(DMTrackEventA) then
      DMTrackEventA(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventValue(FEventCategory, FEventName, FEventValue: PWideChar);
const
  DMTrackEventValue : TDMTrackEventValue = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventValue := GetProcAddress(hModule, PROC_DeskMetricsTrackEventValue);
    if Assigned(DMTrackEventValue) then
      DMTrackEventValue(FEventCategory, fEventName, fEventValue);
  end;
end;

procedure DeskMetricsTrackEventValueA(FEventCategory, FEventName, FEventValue: PAnsiChar);
const
  DMTrackEventValuea : TDMTrackEventValueA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventValueA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventValueA);
    if Assigned(DMTrackEventValueA) then
      DMTrackEventValueA(FEventCategory, fEventName, fEventValue);
  end;
end;

procedure DeskMetricsTrackEventStart(FEventCategory, FEventName: PWideChar);
const
  DMTrackEventStart : TDMTrackEventStart = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventStart := GetProcAddress(hModule, PROC_DeskMetricsTrackEventStart);
    if Assigned(DMTrackEventStart) then
      DMTrackEventStart(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventStartA(FEventCategory, FEventName: PAnsiChar);
const
  DMTrackEventStartA : TDMTrackEventStartA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventStartA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventStartA);
    if Assigned(DMTrackEventStartA) then
      DMTrackEventStartA(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventStop(FEventCategory, FEventName: PWideChar);
const
  DMTrackEventStop : TDMTrackEventStop = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventStop := GetProcAddress(hModule, PROC_DeskMetricsTrackEventStop);
    if Assigned(DMTrackEventStop) then
      DMTrackEventStop(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventStopA(FEventCategory, FEventName: PAnsiChar);
const
  DMTrackEventStopA : TDMTrackEventStopA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventStopA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventStopA);
    if Assigned(DMTrackEventStopA) then
      DMTrackEventStopA(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventCancel(FEventCategory, FEventName: PWideChar);
const
  DMTrackEventCancel : TDMTrackEventCancel = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventCancel := GetProcAddress(hModule, PROC_DeskMetricsTrackEventCancel);
    if Assigned(DMTrackEventCancel) then
      DMTrackEventCancel(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackEventCancelA(FEventCategory, FEventName: PAnsiChar);
const
  DMTrackEventCancelA : TDMTrackEventCancelA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackEventCancelA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventCancelA);
    if Assigned(DMTrackEventCancelA) then
      DMTrackEventCancelA(FEventCategory, fEventName);
  end;
end;

procedure DeskMetricsTrackLog(FMessage: PWideChar);
const
  DMTrackLog : TDMTrackLog = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackLog := GetProcAddress(hModule, PROC_DeskMetricsTrackLog);
    if Assigned(DMTrackLog) then
      DMTrackLog(FMessage);
  end;
end;

procedure DeskMetricsTrackLogA(FMessage: PAnsiChar);
const
  DMTrackLogA : TDMTrackLogA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackLogA := GetProcAddress(hModule, PROC_DeskMetricsTrackLogA);
    if Assigned(DMTrackLogA) then
      DMTrackLogA(FMessage);
  end;
end;

procedure DeskMetricsTrackCustomData(FName, FValue: PWideChar);
const
  DMTrackCustomData : TDMTrackCustomData = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackCustomData := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomData);
    if Assigned(DMTrackCustomData) then
      DMTrackCustomData(FName, FValue);
  end;
end;

procedure DeskMetricsTrackCustomDataA(FName, FValue: PAnsiChar);
const
  DMTrackCustomDataA : TDMTrackCustomDataA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackCustomDataA := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataA);
    if Assigned(DMTrackCustomDataA) then
      DMTrackCustomDataA(FName, FValue);
  end;
end;

function  DeskMetricsTrackCustomDataR(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FName: PWideChar; FValue: PWideChar): Integer;
const
  DMTrackCustomDataR : TDMTrackCustomDataR = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackCustomDataR := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataR);
    if Assigned(DMTrackCustomDataR) then
      Result := DMTrackCustomDataR(FApplicationID, FApplicationVersion, FName, FValue);
  end;
end;

function  DeskMetricsTrackCustomDataRA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar): Integer;
const
  DMTrackCustomDataRA : TDMTrackCustomDataRA = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackCustomDataRA := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataRA);
    if Assigned(DMTrackCustomDataRA) then
      Result := DMTrackCustomDataRA(FApplicationID, FApplicationVersion, FName, FValue);
  end;
end;

function  DeskMetricsTrackInstallation(FApplicationID: string; FApplicationVersion: string): Integer;
const
  DMTrackInstallation : TDMTrackInstallation = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackInstallation := GetProcAddress(hModule, PROC_DeskMetricsTrackInstallation);
    if Assigned(DMTrackInstallation) then
      Result := DMTrackInstallation(FApplicationID, FApplicationVersion);
  end;
end;

function  DeskMetricsTrackInstallationA(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer;
const
  DMTrackInstallationA : TDMTrackInstallationA = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackInstallationA := GetProcAddress(hModule, PROC_DeskMetricsTrackInstallationA);
    if Assigned(DMTrackInstallationA) then
      Result := DMTrackInstallationA(FApplicationID, FApplicationVersion);
  end;
end;

function  DeskMetricsTrackUninstallation(FApplicationID: string; FApplicationVersion: string): Integer;
const
  DMTrackUninstallation : TDMTrackUninstallation = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackUninstallation := GetProcAddress(hModule, PROC_DeskMetricsTrackUninstallation);
    if Assigned(DMTrackUninstallation) then
      Result := DMTrackUninstallation(FApplicationID, FApplicationVersion);
  end;
end;

function  DeskMetricsTrackUninstallationA(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer;
const
  DMTrackUninstallationA : TDMTrackUninstallationA = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackUninstallationA := GetProcAddress(hModule, PROC_DeskMetricsTrackUninstallationA);
    if Assigned(DMTrackUninstallationA) then
      Result := DMTrackUninstallationA(FApplicationID, FApplicationVersion);
  end;
end;

function  DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean;
const
  DMSetProxy : TDMSetProxy = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetProxy := GetProcAddress(hModule, PROC_DeskMetricsSetProxy);
    if Assigned(DMSetProxy) then
      Result := DMSetProxy(FHostIP, FPort, FUserName, fPassword);
  end;
end;

function  DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean;
const
  DMSetProxyA : TDMSetProxyA = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetProxyA := GetProcAddress(hModule, PROC_DeskMetricsSetProxyA);
    if Assigned(DMSetProxyA) then
      Result := DMSetProxyA(FHostIP, FPort, FUserName, fPassword);
  end;
end;

function  DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean;
const
  DMGetProxy : TDMGetProxy = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMGetProxy := GetProcAddress(hModule, PROC_DeskMetricsGetProxy);
    if Assigned(DMGetProxy) then
      Result := DMGetProxy(FHostIP, FPort);
  end;
end;

function  DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean;
const
  DMGetProxyA : TDMGetProxyA = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMGetProxyA := GetProcAddress(hModule, PROC_DeskMetricsGetProxyA);
    if Assigned(DMGetProxyA) then
      Result := DMGetProxyA(FHostIP, FPort);
  end;
end;

function  DeskMetricsSetUserID(FID: PWideChar): Boolean;
const
  DMSetUserID : TDMSetUserID = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetUserID := GetProcAddress(hModule, PROC_DeskMetricsSetUserID);
    if Assigned(DMSetUserID) then
      Result := DMSetUserID(FID);
  end;
end;

function  DeskMetricsSetUserIDA(FID: PAnsiChar): Boolean;
const
  DMSetUserIDA : TDMSetUserIDA = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetUserIDA := GetProcAddress(hModule, PROC_DeskMetricsSetUserIDA);
    if Assigned(DMSetUserIDA) then
      Result := DMSetUserIDA(FID);
  end;
end;

function  DeskMetricsGetComponentName: PWideChar;
const
  DMGetComponentName : TDMGetComponentName = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentName := GetProcAddress(hModule, PROC_DeskMetricsGetComponentName);
    if Assigned(DMGetComponentName) then
      Result := DMGetComponentName;
  end;
end;

function  DeskMetricsGetComponentNameA: PAnsiChar;
const
  DMGetComponentNameA : TDMGetComponentNameA = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentNameA := GetProcAddress(hModule, PROC_DeskMetricsGetComponentNameA);
    if Assigned(DMGetComponentNameA) then
      Result := DMGetComponentNameA;
  end;
end;

function  DeskMetricsGetComponentVersion: PWideChar;
const
  DMGetComponentVersion : TDMGetComponentVersion = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentVersion := GetProcAddress(hModule, PROC_DeskMetricsGetComponentVersion);
    if Assigned(DMGetComponentVersion) then
      Result := DMGetComponentVersion;
  end;
end;

function  DeskMetricsGetComponentVersionA: PAnsiChar;
const
  DMGetComponentVersionA : TDMGetComponentVersionA = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentVersionA := GetProcAddress(hModule, PROC_DeskMetricsGetComponentVersionA);
    if Assigned(DMGetComponentVersionA) then
      Result := DMGetComponentVersionA;
  end;
end;

function  DeskMetricsGetPostServer: PWideChar;
const
  DMGetPostServer : TDMGetPostServer = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetPostServer := GetProcAddress(hModule, PROC_DeskMetricsGetPostServer);
    if Assigned(DMGetPostServer) then
      Result := DMGetPostServer;
  end;
end;

function  DeskMetricsGetPostServerA: PAnsiChar;
const
  DMGetPostServerA : TDMGetPostServerA = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetPostServerA := GetProcAddress(hModule, PROC_DeskMetricsGetPostServerA);
    if Assigned(DMGetPostServerA) then
      Result := DMGetPostServerA;
  end;
end;

function  DeskMetricsSetPostServer(FServer: PWideChar): Boolean;
const
  DMSetPostServer : TDMSetPostServer = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostServer := GetProcAddress(hModule, PROC_DeskMetricsSetPostServer);
    if Assigned(DMSetPostServer) then
      Result := DMSetPostServer(FServer);
  end;
end;

function  DeskMetricsSetPostServerA(FServer: PAnsiChar): Boolean;
const
  DMSetPostServerA : TDMSetPostServerA = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostServerA := GetProcAddress(hModule, PROC_DeskMetricsSetPostServerA);
    if Assigned(DMSetPostServerA) then
      Result := DMSetPostServerA(FServer);
  end;
end;

function  DeskMetricsGetPostPort: Integer;
const
  DMGetPostPort : TDMGetPostPort = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetPostPort := GetProcAddress(hModule, PROC_DeskMetricsGetPostPort);
    if Assigned(DMGetPostPort) then
      Result := DMGetPostPort;
  end;
end;

function  DeskMetricsSetPostPort(FPort: Integer): Boolean;
const
  DMSetPostPort : TDMSetPostPort = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostPort := GetProcAddress(hModule, PROC_DeskMetricsSetPostPort);
    if Assigned(DMSetPostPort) then
      Result := DMSetPostPort(FPort);
  end;
end;

function  DeskMetricsGetPostTimeOut: Integer;
const
  DMGetPostTimeOut : TDMGetPostTimeOut = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetPostTimeOut := GetProcAddress(hModule, PROC_DeskMetricsGetPostTimeOut);
    if Assigned(DMGetPostTimeOut) then
      Result := DMGetPostTimeOut;
  end;
end;

function  DeskMetricsSetPostTimeOut(FTimeOut: Integer): Boolean;
const
  DMSetPostTimeOut : TDMSetPostTimeOut = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostTimeOut := GetProcAddress(hModule, PROC_DeskMetricsSetPostTimeOut);
    if Assigned(DMSetPostTimeOut) then
      Result := DMSetPostTimeOut(FTimeOut);
  end;
end;

function  DeskMetricsGetPostWaitResponse: Boolean;
const
  DMGetPostWaitResponse : TDMGetPostWaitResponse = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMGetPostWaitResponse := GetProcAddress(hModule, PROC_DeskMetricsGetPostWaitResponse);
    if Assigned(DMGetPostWaitResponse) then
      Result := DMGetPostWaitResponse;
  end;
end;

function  DeskMetricsSetPostWaitResponse(FEnabled: Boolean): Boolean;
const
  DMSetPostWaitResponse : TDMSetPostWaitResponse = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostWaitResponse := GetProcAddress(hModule, PROC_DeskMetricsSetPostWaitResponse);
    if Assigned(DMSetPostWaitResponse) then
      Result := DMSetPostWaitResponse(FEnabled);
  end;
end;

function  DeskMetricsGetJSON: PWideChar;
const
  DMGetJSON : TDMGetJSON = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetJSON := GetProcAddress(hModule, PROC_DeskMetricsGetJSON);
    if Assigned(DMGetJSON) then
      Result := DMGetJSON;
  end;
end;

function  DeskMetricsGetJSONA: PAnsiChar;
const
  DMGetJSONA : TDMGetJSONA = nil;
begin
  Result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetJSONA := GetProcAddress(hModule, PROC_DeskMetricsGetJSONA);
    if Assigned(DMGetJSONA) then
      Result := DMGetJSONA;
  end;
end;

function  DeskMetricsGetDailyNetworkUtilizationInKB: Integer;
const
  DMGetDailyNetworkUtilizationInKB : TDMGetDailyNetworkUtilizationInKB = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetDailyNetworkUtilizationInKB := GetProcAddress(hModule, PROC_DeskMetricsGetDailyNetworkUtilizationInKB);
    if Assigned(DMGetDailyNetworkUtilizationInKB) then
      Result := DMGetDailyNetworkUtilizationInKB;
  end;
end;

function  DeskMetricsSetDailyNetworkUtilizationInKB(FDataSize: Integer): Boolean;
const
  DMSetDailyNetworkUtilizationInKB : TDMSetDailyNetworkUtilizationInKB = nil;
begin
  Result := False;
  if CheckLoadDLL then
  begin
    @DMSetDailyNetworkUtilizationInKB := GetProcAddress(hModule, PROC_DeskMetricsSetDailyNetworkUtilizationInKB);
    if Assigned(DMSetDailyNetworkUtilizationInKB) then
      Result := DMSetDailyNetworkUtilizationInKB(FDataSize);
  end;
end;

function  DeskMetricsGetMaxStorageSizeInKB: Integer;
const
  DMGetMaxStorageSizeInKB : TDMGetMaxStorageSizeInKB = nil;
begin
  Result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetMaxStorageSizeInKB := GetProcAddress(hModule, PROC_DeskMetricsGetMaxStorageSizeInKB);
    if Assigned(DMGetMaxStorageSizeInKB) then
      Result := DMGetMaxStorageSizeInKB;
  end;
end;

function  DeskMetricsSetMaxStorageSizeInKB(FDataSize: Integer): Boolean;
const
  DMSetMaxStorageSizeInKB : TDMSetMaxStorageSizeInKB = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetMaxStorageSizeInKB := GetProcAddress(hModule, PROC_DeskMetricsSetMaxStorageSizeInKB);
    if Assigned(DMSetMaxStorageSizeInKB) then
      Result := DMSetMaxStorageSizeInKB(FDataSize);
  end;
end;

function  DeskMetricsSetEnabled(FValue: Boolean): Boolean;
const
  DMSetEnabled : TDMSetEnabled = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetEnabled := GetProcAddress(hModule, PROC_DeskMetricsSetEnabled);
    if Assigned(DMSetEnabled) then
      Result := DMSetEnabled(FValue);
  end;
end;

function  DeskMetricsGetEnabled: Boolean;
const
  DMGetEnabled : TDMGetEnabled = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMGetEnabled := GetProcAddress(hModule, PROC_DeskMetricsGetEnabled);
    if Assigned(DMGetEnabled) then
      Result := DMGetEnabled;
  end;
end;

function  DeskMetricsSendData: Boolean;
const
  DMSendData : TDMSendData = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSendData := GetProcAddress(hModule, PROC_DeskMetricsSendData);
    if Assigned(DMSendData) then
      Result := DMSendData;
  end;
end;

function  DeskMetricsGetDebugMode: Boolean;
const
  DMGetDebugMode : TDMGetDebugMode = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMGetDebugMode := GetProcAddress(hModule, PROC_DeskMetricsGetDebugMode);
    if Assigned(DMGetDebugMode) then
      Result := DMGetDebugMode;
  end;
end;

function  DeskMetricsSetDebugMode(FEnabled: Boolean): Boolean;
const
  DMSetDebugMode : TDMSetDebugMode = nil;
begin
  Result := false;
  if CheckLoadDLL then
  begin
    @DMSetDebugMode := GetProcAddress(hModule, PROC_DeskMetricsSetDebugMode);
    if Assigned(DMSetDebugMode) then
      Result := DMSetDebugMode(FEnabled);
  end;
end;

//procedure DeskMetricsTrackExceptions(FEnabled: Boolean);
//const
//  DMTrackExceptions : TDMTrackExceptions = nil;
//begin
//  if CheckLoadDLL then
//  begin
//    @DMTrackExceptions := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataR);
//    if Assigned(DMTrackExceptions) then
//      DMTrackExceptions(FEnabled);
//  end;
//end;
//
//procedure DeskMetricsTrackException(FExceptionMessage, FExceptionType: PWideChar);
//const
//  DMTrackException : TDMTrackException = nil;
//begin
//  if CheckLoadDLL then
//  begin
//    @DMTrackException := GetProcAddress(hModule, PROC_DeskMetricsTrackException);
//    if Assigned(DMTrackException) then
//      DMTrackException(FExceptionMessage, FExceptionType);
//  end;
//end;
//
//procedure DeskMetricsTrackExceptionA(FExceptionMessage, FExceptionType: PAnsiChar);
//const
//  DMTrackExceptionA : TDMTrackExceptionA = nil;
//begin
//  if CheckLoadDLL then
//  begin
//    @DMTrackExceptionA := GetProcAddress(hModule, PROC_DeskMetricsTrackExceptionA);
//    if Assigned(DMTrackExceptionA) then
//      DMTrackExceptionA(FExceptionMessage, FExceptionType);
//  end;
//end;

initialization
  hModule := 0;

finalization
  if not(hModule < HINSTANCE_ERROR) then
    FreeLibrary(hModule);

end.