{ **********************************************************}
{                                                           }
{     DeskMetrics - Delphi Dynamic Unit                     }
{     Copyright (c) 2010-2011                               }
{                                                           }
{     http://deskmetrics.com                                }
{     support@deskmetrics.com                               }
{                                                           }
{     Author: Stuart Clennett								}												
{     Licence: GNU GPL v3									}
{															}
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

  TDMStart        = function (FApplicationID: PWideChar; FRealTime: Boolean; FTestMode: Boolean): Boolean; stdcall;
  TDMStartA       = function (FApplicationID: PAnsiChar; FRealTime: Boolean; FTestMode: Boolean): Boolean; stdcall;
  TDMStop         = function : boolean; stdcall;
  TDMCheckVersion = function (var FVersionData: TVersionData): Boolean; stdcall;
  TDMTrackEvent   = procedure (FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventA  = procedure (FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventValue = procedure(FEventCategory, FEventName, FEventValue: PWideChar); stdcall;
  TDMTrackEventValueA = procedure(FEventCategory, FEventName, FEventValue: PAnsiChar); stdcall;
  TDMTrackEventStart = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventStartA = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventStop = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventStopA = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventCancel = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventCancelA = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackLog = procedure(FMessage: PWideChar); stdcall;
  TDMTrackLogA = procedure(FMessage: PAnsiChar); stdcall;
  TDMTrackCustomData = procedure(FName, FValue: PWideChar); stdcall;
  TDMTrackCustomDataA = procedure(FName, FValue: PAnsiChar); stdcall;
  TDMTrackCustomDataR = function(FApplicationID: PWideChar; FAppVersion: PWideChar; FName: PWideChar; FValue: PWideChar; FTestMode: Boolean): Integer; stdcall;
  TDMTrackCustomDataRA = function(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar; FTestMode: Boolean): Integer; stdcall;
  TDMTrackExceptions = procedure(FEnabled: Boolean); stdcall;
  TDMTrackException = procedure(FExceptionMessage, FExceptionType: PWideChar); stdcall;
  TDMTrackExceptionA = procedure(FExceptionMessage, FExceptionType: PAnsiChar); stdcall;
  TDMTrackInstallation = function(FApplicationID: PWideChar; FAppVersion: PWideChar; FTestMode: Boolean): Integer; stdcall;
  TDMTrackInstallationA = function(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FTestMode: Boolean): Integer; stdcall;
  TDMTrackUninstallation = function(FApplicationID: PWideChar; FAppVersion: PWideChar; FTestMode: Boolean): Integer; stdcall;
  TDMTrackUninstallationA = function(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FTestMode: Boolean): Integer; stdcall;
  TDMSetAppVersion = function(FVersion: PWideChar): Boolean; stdcall;
  TDMSetAppVersionA = function(FVersion: PAnsiChar): Boolean; stdcall;
  TDMGetAppVersion = function : PWideChar; stdcall;
  TDMGetAppVersionA = function : PAnsiChar; stdcall;
  TDMSetProxy = function(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean; stdcall;
  TDMSetProxyA = function(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean; stdcall;
  TDMGetProxy = function(var FHostIP: PWideChar; var FPort: Integer): Boolean; stdcall;
  TDMGetProxyA = function(var FHostIP: PAnsiChar; var FPort: Integer): Boolean; stdcall;
  TDMSetUserID = function(FID: PWideChar): Boolean; stdcall;
  TDMSetUserIDA = function(FID: PAnsiChar): Boolean; stdcall;
  TDMGetComponentName = function : PWideChar; stdcall;
  TDMGetComponentNameA = function : PAnsiChar; stdcall;
  TDMGetComponentVersion = function : PWideChar; stdcall;
  TDMGetComponentVersionA = function : PAnsiChar; stdcall;
  TDMGetPostServer = function : PWideChar; stdcall;
  TDMGetPostServerA = function : PAnsiChar; stdcall;
  TDMSetPostServer = function(FServer: PWideChar): Boolean; stdcall;
  TDMSetPostServerA = function(FServer: PAnsiChar): Boolean; stdcall;
  TDMGetPostPort = function : Integer; stdcall;
  TDMSetPostPort = function(FPort: Integer): Boolean; stdcall;
  TDMGetPostTimeOut = function: Integer; stdcall;
  TDMSetPostTimeOut = function(FTimeOut: Integer): Boolean; stdcall;
  TDMGetPostWaitResponse = function : Boolean; stdcall;
  TDMSetPostWaitResponse = function(FEnabled: Boolean): Boolean; stdcall;
  TDMGetJSON = function : PWideChar; stdcall;
  TDMGetJSONA = function : PAnsiChar; stdcall;
  TDMGetDailyNetworkUtilizationInKB = function: Integer; stdcall;
  TDMSetDailyNetworkUtilizationInKB = function(FDataSize: Integer): Boolean; stdcall;
  TDMGetMaxStorageSizeInKB = function : Integer; stdcall;
  TDMSetMaxStorageSizeInKB = function(FDataSize: Integer): Boolean; stdcall;
  TDMSetEnabled = function(FValue: Boolean): Boolean; stdcall;
  TDMGetEnabled = function: Boolean; stdcall;
  TDMSendData = function : Boolean; stdcall;

  function  DeskMetricsStart(FApplicationID: PWideChar; FRealTime: Boolean; FTestMode: Boolean): Boolean;
  function  DeskMetricsStartA(FApplicationID: PAnsiChar; FRealTime: Boolean; FTestMode: Boolean): Boolean;
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
  function  DeskMetricsTrackCustomDataR(FApplicationID: PWideChar; FAppVersion: PWideChar; FName: PWideChar; FValue: PWideChar; FTestMode: Boolean): Integer;
  function  DeskMetricsTrackCustomDataRA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar; FTestMode: Boolean): Integer;
  procedure DeskMetricsTrackExceptions(FEnabled: Boolean);
  procedure DeskMetricsTrackException(FExceptionMessage, FExceptionType: PWideChar);
  procedure DeskMetricsTrackExceptionA(FExceptionMessage, FExceptionType: PAnsiChar);
  function  DeskMetricsTrackInstallation(FApplicationID: PWideChar; FAppVersion: PWideChar; FTestMode: Boolean): Integer;
  function  DeskMetricsTrackInstallationA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FTestMode: Boolean): Integer;
  function  DeskMetricsTrackUninstallation(FApplicationID: PWideChar; FAppVersion: PWideChar; FTestMode: Boolean): Integer;
  function  DeskMetricsTrackUninstallationA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FTestMode: Boolean): Integer;
  function  DeskMetricsSetAppVersion(FVersion: PWideChar): Boolean;
  function  DeskMetricsSetAppVersionA(FVersion: PAnsiChar): Boolean;
  function  DeskMetricsGetAppVersion: PWideChar;
  function  DeskMetricsGetAppVersionA: PAnsiChar;
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

  function  Is_DLL_Loaded : boolean;
  function  Load_DLL : boolean;
  function  Unload_DLL : boolean;

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
  PROC_DeskMetricsTrackExceptions = 'DeskMetricsTrackExceptions';
  PROC_DeskMetricsTrackException = 'DeskMetricsTrackException';
  PROC_DeskMetricsTrackExceptionA = 'DeskMetricsTrackExceptionA';
  PROC_DeskMetricsTrackInstallation = 'DeskMetricsTrackInstallation';
  PROC_DeskMetricsTrackInstallationA = 'DeskMetricsTrackInstallationA';
  PROC_DeskMetricsTrackUninstallation = 'DeskMetricsTrackUninstallation';
  PROC_DeskMetricsTrackUninstallationA = 'DeskMetricsTrackUninstallationA';
  PROC_DeskMetricsSetAppVersion = 'DeskMetricsSetAppVersion';
  PROC_DeskMetricsSetAppVersionA = 'DeskMetricsSetAppVersionA';
  PROC_DeskMetricsGetAppVersion = 'DeskMetricsGetAppVersion';
  PROC_DeskMetricsGetAppVersionA = 'DeskMetricsGetAppVersionA';
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

function GetAppPath : string;
begin
  result := IncludeTrailingPathDelimiter(ExtractFilePath(paramstr(0)));
end;

function CheckLoadDLL : boolean;
begin
  if hModule < HINSTANCE_ERROR then
  begin
    hModule := LoadLibrary(PChar(GetAppPath + DESKMETRICS_DLL));
    result := not(hModule < HINSTANCE_ERROR);
  end else
    result := TRUE;
end;

function  Is_DLL_Loaded : boolean;
begin
  result := not (hModule < HINSTANCE_ERROR);
end;

function  Load_DLL : boolean;
begin
  result := CheckLoadDLL;
end;

function  Unload_DLL : boolean;
begin
  result := false;
  if not (hModule < HINSTANCE_ERROR) then
    result := FreeLibrary(hModule);
end;

function  DeskMetricsStart(FApplicationID: PWideChar; FRealTime: Boolean; FTestMode: Boolean): Boolean;
const
  DMStart : TDMStart = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMStart := GetProcAddress(hModule, PROC_DeskMetricsStart);
    if assigned(DMStart) then
      result := DMStart(fApplicationID, fRealTime, FTestMode);
  end;
end;

function  DeskMetricsStartA(FApplicationID: PAnsiChar; FRealTime: Boolean; FTestMode: Boolean): Boolean;
const
  DMStartA : TDMStartA = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMStartA := GetProcAddress(hModule, PROC_DeskMetricsStartA);
    if assigned(DMStartA) then
      result := DMStartA(fApplicationID, fRealTime, FTestMode);
  end;
end;

function  DeskMetricsStop: Boolean;
const
  DMStop : TDMStop = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMStop := GetProcAddress(hModule, PROC_DeskMetricsStop);
    if assigned(DMStop) then
      result := DMStop;
  end;
end;

function  DeskMetricsCheckVersion(var FVersionData: TVersionData): Boolean;
const
  DMCheckVersion : TDMCheckVersion = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMCheckVersion := GetProcAddress(hModule, PROC_DeskMetricsCheckVersion);
    if Assigned(DMCheckVersion) then
      result := DMCheckVersion(fVersionData);
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

function  DeskMetricsTrackCustomDataR(FApplicationID: PWideChar; FAppVersion: PWideChar; FName: PWideChar; FValue: PWideChar; FTestMode: Boolean): Integer;
const
  DMTrackCustomDataR : TDMTrackCustomDataR = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackCustomDataR := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataR);
    if Assigned(DMTrackCustomDataR) then
      result := DMTrackCustomDataR(FApplicationID, FAppVersion, FName, FValue, FTestMode);
  end;
end;

function  DeskMetricsTrackCustomDataRA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar; FTestMode: Boolean): Integer;
const
  DMTrackCustomDataRA : TDMTrackCustomDataRA = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackCustomDataRA := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataRA);
    if Assigned(DMTrackCustomDataRA) then
      result := DMTrackCustomDataRA(FApplicationID, FAppVersion, FName, FValue, FTestMode);
  end;
end;

procedure DeskMetricsTrackExceptions(FEnabled: Boolean);
const
  DMTrackExceptions : TDMTrackExceptions = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackExceptions := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataR);
    if Assigned(DMTrackExceptions) then
      DMTrackExceptions(FEnabled);
  end;
end;

procedure DeskMetricsTrackException(FExceptionMessage, FExceptionType: PWideChar);
const
  DMTrackException : TDMTrackException = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackException := GetProcAddress(hModule, PROC_DeskMetricsTrackException);
    if Assigned(DMTrackException) then
      DMTrackException(FExceptionMessage, FExceptionType);
  end;
end;

procedure DeskMetricsTrackExceptionA(FExceptionMessage, FExceptionType: PAnsiChar);
const
  DMTrackExceptionA : TDMTrackExceptionA = nil;
begin
  if CheckLoadDLL then
  begin
    @DMTrackExceptionA := GetProcAddress(hModule, PROC_DeskMetricsTrackExceptionA);
    if Assigned(DMTrackExceptionA) then
      DMTrackExceptionA(FExceptionMessage, FExceptionType);
  end;
end;

function  DeskMetricsTrackInstallation(FApplicationID: PWideChar; FAppVersion: PWideChar; FTestMode: Boolean): Integer;
const
  DMTrackInstallation : TDMTrackInstallation = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackInstallation := GetProcAddress(hModule, PROC_DeskMetricsTrackInstallation);
    if Assigned(DMTrackInstallation) then
      result := DMTrackInstallation(FApplicationID, FAppVersion, FTestMode);
  end;
end;

function  DeskMetricsTrackInstallationA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FTestMode: Boolean): Integer;
const
  DMTrackInstallationA : TDMTrackInstallationA = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackInstallationA := GetProcAddress(hModule, PROC_DeskMetricsTrackInstallationA);
    if Assigned(DMTrackInstallationA) then
      result := DMTrackInstallationA(FApplicationID, FAppVersion, FTestMode);
  end;
end;

function  DeskMetricsTrackUninstallation(FApplicationID: PWideChar; FAppVersion: PWideChar; FTestMode: Boolean): Integer;
const
  DMTrackUninstallation : TDMTrackUninstallation = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackUninstallation := GetProcAddress(hModule, PROC_DeskMetricsTrackUninstallation);
    if Assigned(DMTrackUninstallation) then
      result := DMTrackUninstallation(FApplicationID, FAppVersion, FTestMode);
  end;
end;

function  DeskMetricsTrackUninstallationA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FTestMode: Boolean): Integer;
const
  DMTrackUninstallationA : TDMTrackUninstallationA = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMTrackUninstallationA := GetProcAddress(hModule, PROC_DeskMetricsTrackUninstallationA);
    if Assigned(DMTrackUninstallationA) then
      result := DMTrackUninstallationA(FApplicationID, FAppVersion, FTestMode);
  end;
end;

function  DeskMetricsSetAppVersion(FVersion: PWideChar): Boolean;
const
  DMSetAppVersion : TDMSetAppVersion = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetAppVersion := GetProcAddress(hModule, PROC_DeskMetricsSetAppVersion);
    if Assigned(DMSetAppVersion) then
      DMSetAppVersion(FVersion);
  end;
end;

function  DeskMetricsSetAppVersionA(FVersion: PAnsiChar): Boolean;
const
  DMSetAppVersionA : TDMSetAppVersionA = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetAppVersionA := GetProcAddress(hModule, PROC_DeskMetricsSetAppVersionA);
    if Assigned(DMSetAppVersionA) then
      DMSetAppVersionA(FVersion);
  end;
end;

function  DeskMetricsGetAppVersion: PWideChar;
const
  DMGetAppVersion : TDMGetAppVersion = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetAppVersion := GetProcAddress(hModule, PROC_DeskMetricsGetAppVersion);
    if Assigned(DMGetAppVersion) then
      result := DMGetAppVersion;
  end;
end;

function  DeskMetricsGetAppVersionA: PAnsiChar;
const
  DMGetAppVersionA : TDMGetAppVersionA = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetAppVersionA := GetProcAddress(hModule, PROC_DeskMetricsGetAppVersionA);
    if Assigned(DMGetAppVersionA) then
      result := DMGetAppVersionA;
  end;
end;

function  DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean;
const
  DMSetProxy : TDMSetProxy = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetProxy := GetProcAddress(hModule, PROC_DeskMetricsSetProxy);
    if Assigned(DMSetProxy) then
      result := DMSetProxy(FHostIP, FPort, FUserName, fPassword);
  end;
end;

function  DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean;
const
  DMSetProxyA : TDMSetProxyA = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetProxyA := GetProcAddress(hModule, PROC_DeskMetricsSetProxyA);
    if Assigned(DMSetProxyA) then
      result := DMSetProxyA(FHostIP, FPort, FUserName, fPassword);
  end;
end;

function  DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean;
const
  DMGetProxy : TDMGetProxy = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMGetProxy := GetProcAddress(hModule, PROC_DeskMetricsGetProxy);
    if Assigned(DMGetProxy) then
      result := DMGetProxy(FHostIP, FPort);
  end;
end;

function  DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean;
const
  DMGetProxyA : TDMGetProxyA = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMGetProxyA := GetProcAddress(hModule, PROC_DeskMetricsGetProxyA);
    if Assigned(DMGetProxyA) then
      result := DMGetProxyA(FHostIP, FPort);
  end;
end;

function  DeskMetricsSetUserID(FID: PWideChar): Boolean;
const
  DMSetUserID : TDMSetUserID = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetUserID := GetProcAddress(hModule, PROC_DeskMetricsSetUserID);
    if Assigned(DMSetUserID) then
      result := DMSetUserID(FID);
  end;
end;

function  DeskMetricsSetUserIDA(FID: PAnsiChar): Boolean;
const
  DMSetUserIDA : TDMSetUserIDA = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetUserIDA := GetProcAddress(hModule, PROC_DeskMetricsSetUserIDA);
    if Assigned(DMSetUserIDA) then
      result := DMSetUserIDA(FID);
  end;
end;

function  DeskMetricsGetComponentName: PWideChar;
const
  DMGetComponentName : TDMGetComponentName = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentName := GetProcAddress(hModule, PROC_DeskMetricsGetComponentName);
    if Assigned(DMGetComponentName) then
      result := DMGetComponentName;
  end;
end;

function  DeskMetricsGetComponentNameA: PAnsiChar;
const
  DMGetComponentNameA : TDMGetComponentNameA = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentNameA := GetProcAddress(hModule, PROC_DeskMetricsGetComponentNameA);
    if Assigned(DMGetComponentNameA) then
      result := DMGetComponentNameA;
  end;
end;

function  DeskMetricsGetComponentVersion: PWideChar;
const
  DMGetComponentVersion : TDMGetComponentVersion = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentVersion := GetProcAddress(hModule, PROC_DeskMetricsGetComponentVersion);
    if Assigned(DMGetComponentVersion) then
      result := DMGetComponentVersion;
  end;
end;

function  DeskMetricsGetComponentVersionA: PAnsiChar;
const
  DMGetComponentVersionA : TDMGetComponentVersionA = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetComponentVersionA := GetProcAddress(hModule, PROC_DeskMetricsGetComponentVersionA);
    if Assigned(DMGetComponentVersionA) then
      result := DMGetComponentVersionA;
  end;
end;

function  DeskMetricsGetPostServer: PWideChar;
const
  DMGetPostServer : TDMGetPostServer = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetPostServer := GetProcAddress(hModule, PROC_DeskMetricsGetPostServer);
    if Assigned(DMGetPostServer) then
      result := DMGetPostServer;
  end;
end;

function  DeskMetricsGetPostServerA: PAnsiChar;
const
  DMGetPostServerA : TDMGetPostServerA = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetPostServerA := GetProcAddress(hModule, PROC_DeskMetricsGetPostServerA);
    if Assigned(DMGetPostServerA) then
      result := DMGetPostServerA;
  end;
end;

function  DeskMetricsSetPostServer(FServer: PWideChar): Boolean;
const
  DMSetPostServer : TDMSetPostServer = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostServer := GetProcAddress(hModule, PROC_DeskMetricsSetPostServer);
    if Assigned(DMSetPostServer) then
      result := DMSetPostServer(FServer);
  end;
end;

function  DeskMetricsSetPostServerA(FServer: PAnsiChar): Boolean;
const
  DMSetPostServerA : TDMSetPostServerA = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostServerA := GetProcAddress(hModule, PROC_DeskMetricsSetPostServerA);
    if Assigned(DMSetPostServerA) then
      result := DMSetPostServerA(FServer);
  end;
end;

function  DeskMetricsGetPostPort: Integer;
const
  DMGetPostPort : TDMGetPostPort = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetPostPort := GetProcAddress(hModule, PROC_DeskMetricsGetPostPort);
    if Assigned(DMGetPostPort) then
      result := DMGetPostPort;
  end;
end;

function  DeskMetricsSetPostPort(FPort: Integer): Boolean;
const
  DMSetPostPort : TDMSetPostPort = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostPort := GetProcAddress(hModule, PROC_DeskMetricsSetPostPort);
    if Assigned(DMSetPostPort) then
      result := DMSetPostPort(FPort);
  end;
end;

function  DeskMetricsGetPostTimeOut: Integer;
const
  DMGetPostTimeOut : TDMGetPostTimeOut = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetPostTimeOut := GetProcAddress(hModule, PROC_DeskMetricsGetPostTimeOut);
    if Assigned(DMGetPostTimeOut) then
      result := DMGetPostTimeOut;
  end;
end;

function  DeskMetricsSetPostTimeOut(FTimeOut: Integer): Boolean;
const
  DMSetPostTimeOut : TDMSetPostTimeOut = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostTimeOut := GetProcAddress(hModule, PROC_DeskMetricsSetPostTimeOut);
    if Assigned(DMSetPostTimeOut) then
      result := DMSetPostTimeOut(FTimeOut);
  end;
end;

function  DeskMetricsGetPostWaitResponse: Boolean;
const
  DMGetPostWaitResponse : TDMGetPostWaitResponse = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMGetPostWaitResponse := GetProcAddress(hModule, PROC_DeskMetricsGetPostWaitResponse);
    if Assigned(DMGetPostWaitResponse) then
      result := DMGetPostWaitResponse;
  end;
end;

function  DeskMetricsSetPostWaitResponse(FEnabled: Boolean): Boolean;
const
  DMSetPostWaitResponse : TDMSetPostWaitResponse = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetPostWaitResponse := GetProcAddress(hModule, PROC_DeskMetricsSetPostWaitResponse);
    if Assigned(DMSetPostWaitResponse) then
      result := DMSetPostWaitResponse(FEnabled);
  end;
end;

function  DeskMetricsGetJSON: PWideChar;
const
  DMGetJSON : TDMGetJSON = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetJSON := GetProcAddress(hModule, PROC_DeskMetricsGetJSON);
    if Assigned(DMGetJSON) then
      result := DMGetJSON;
  end;
end;

function  DeskMetricsGetJSONA: PAnsiChar;
const
  DMGetJSONA : TDMGetJSONA = nil;
begin
  result := EMPTY_STRING;
  if CheckLoadDLL then
  begin
    @DMGetJSONA := GetProcAddress(hModule, PROC_DeskMetricsGetJSONA);
    if Assigned(DMGetJSONA) then
      result := DMGetJSONA;
  end;
end;

function  DeskMetricsGetDailyNetworkUtilizationInKB: Integer;
const
  DMGetDailyNetworkUtilizationInKB : TDMGetDailyNetworkUtilizationInKB = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetDailyNetworkUtilizationInKB := GetProcAddress(hModule, PROC_DeskMetricsGetDailyNetworkUtilizationInKB);
    if Assigned(DMGetDailyNetworkUtilizationInKB) then
      result := DMGetDailyNetworkUtilizationInKB;
  end;
end;

function  DeskMetricsSetDailyNetworkUtilizationInKB(FDataSize: Integer): Boolean;
const
  DMSetDailyNetworkUtilizationInKB : TDMSetDailyNetworkUtilizationInKB = nil;
begin
  result := False;
  if CheckLoadDLL then
  begin
    @DMSetDailyNetworkUtilizationInKB := GetProcAddress(hModule, PROC_DeskMetricsSetDailyNetworkUtilizationInKB);
    if Assigned(DMSetDailyNetworkUtilizationInKB) then
      result := DMSetDailyNetworkUtilizationInKB(FDataSize);
  end;
end;

function  DeskMetricsGetMaxStorageSizeInKB: Integer;
const
  DMGetMaxStorageSizeInKB : TDMGetMaxStorageSizeInKB = nil;
begin
  result := NO_INTEGER_VALUE;
  if CheckLoadDLL then
  begin
    @DMGetMaxStorageSizeInKB := GetProcAddress(hModule, PROC_DeskMetricsGetMaxStorageSizeInKB);
    if Assigned(DMGetMaxStorageSizeInKB) then
      result := DMGetMaxStorageSizeInKB;
  end;
end;

function  DeskMetricsSetMaxStorageSizeInKB(FDataSize: Integer): Boolean;
const
  DMSetMaxStorageSizeInKB : TDMSetMaxStorageSizeInKB = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetMaxStorageSizeInKB := GetProcAddress(hModule, PROC_DeskMetricsSetMaxStorageSizeInKB);
    if Assigned(DMSetMaxStorageSizeInKB) then
      result := DMSetMaxStorageSizeInKB(FDataSize);
  end;
end;

function  DeskMetricsSetEnabled(FValue: Boolean): Boolean;
const
  DMSetEnabled : TDMSetEnabled = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSetEnabled := GetProcAddress(hModule, PROC_DeskMetricsSetEnabled);
    if Assigned(DMSetEnabled) then
      result := DMSetEnabled(FValue);
  end;
end;

function  DeskMetricsGetEnabled: Boolean;
const
  DMGetEnabled : TDMGetEnabled = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMGetEnabled := GetProcAddress(hModule, PROC_DeskMetricsGetEnabled);
    if Assigned(DMGetEnabled) then
      result := DMGetEnabled;
  end;
end;

function  DeskMetricsSendData: Boolean;
const
  DMSendData : TDMSendData = nil;
begin
  result := false;
  if CheckLoadDLL then
  begin
    @DMSendData := GetProcAddress(hModule, PROC_DeskMetricsSendData);
    if Assigned(DMSendData) then
      result := DMSendData;
  end;
end;

initialization
  hModule := 0;

finalization
  if not(hModule < HINSTANCE_ERROR) then
    FreeLibrary(hModule);

end.