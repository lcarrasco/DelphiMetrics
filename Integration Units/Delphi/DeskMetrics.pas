{ **********************************************************}
{                                                           }
{     DeskMetrics - Delphi Dynamic Unit                     }
{     Copyright (c) 2010-2011                               }
{                                                           }
{     http://deskmetrics.com                                }
{     support@deskmetrics.com                               }
{                                                           }
{     Author: Stuart Clennett	 (GNU GPL v3)							    }
{														                              	}
{ **********************************************************}

unit DeskMetrics;

interface

uses SysUtils;

type
  TDMStart                = function(FApplicationID: PWideChar; FApplicationVersion: PWideChar): Boolean; stdcall;
  TDMStartA               = function(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar): Boolean; stdcall;
  TDMStop                 = function: Boolean; stdcall;
  TDMTrackEvent           = procedure(FEventCategory, FEventName: PWideChar); stdcall;
  TDMTrackEventA          = procedure(FEventCategory, FEventName: PAnsiChar); stdcall;
  TDMTrackEventValue      = procedure(FEventCategory, FEventName, FEventValue: PWideChar); stdcall;
  TDMTrackEventValueA     = procedure(FEventCategory, FEventName, FEventValue: PAnsiChar); stdcall;
  TDMTrackEventPeriod     = procedure(FEventCategory, FEventName: PWideChar; FEventTime: Integer; FEventCompleted: Boolean); stdcall;
  TDMTrackEventPeriodA    = procedure(FEventCategory, FEventName: PAnsiChar; FEventTime: Integer; FEventCompleted: Boolean); stdcall;
  TDMTrackLog             = procedure(FMessage: PWideChar); stdcall;
  TDMTrackLogA            = procedure(FMessage: PAnsiChar); stdcall;
  TDMTrackCustomData      = procedure(FName, FValue: PWideChar); stdcall;
  TDMTrackCustomDataA     = procedure(FName, FValue: PAnsiChar); stdcall;
  TDMTrackCustomDataR     = function(FName: PWideChar; FValue: PWideChar): Integer; stdcall;
  TDMTrackCustomDataRA    = function(FName: PAnsiChar; FValue: PAnsiChar): Integer; stdcall;
  TDMTrackException 	    = procedure(FExpectionObject: Exception); stdcall;
  TDMSetProxy             = function(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean; stdcall;
  TDMSetProxyA            = function(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean; stdcall;
  TDMGetProxy             = function(var FHostIP: PWideChar; var FPort: Integer): Boolean; stdcall;
  TDMGetProxyA            = function(var FHostIP: PAnsiChar; var FPort: Integer): Boolean; stdcall;
  TDMSetUserID            = function(FID: PWideChar): Boolean; stdcall;
  TDMSetUserIDA           = function(FID: PAnsiChar): Boolean; stdcall;
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
  TDMSetEnabled            = function(FValue: Boolean): Boolean; stdcall;
  TDMGetEnabled            = function:Boolean; stdcall;
  TDMSendData              = function:Boolean; stdcall;
  TDMGetDebugMode          = function:Boolean; stdcall;
  TDMSetDebugMode          = function(FEnabled: Boolean): Boolean; stdcall;

  function  DeskMetricsStart(FApplicationID: PWideChar; FApplicationVersion: PWideChar): Boolean;
  function  DeskMetricsStartA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar): Boolean;
  function  DeskMetricsStop: Boolean;
  procedure DeskMetricsTrackEvent(FEventCategory, FEventName: PWideChar);
  procedure DeskMetricsTrackEventA(FEventCategory, FEventName: PAnsiChar);
  procedure DeskMetricsTrackEventValue(FEventCategory, FEventName, FEventValue: PWideChar);
  procedure DeskMetricsTrackEventValueA(FEventCategory, FEventName, FEventValue: PAnsiChar);
  procedure DeskMetricsTrackEventPeriod(FEventCategory, FEventName: PWideChar; FEventTime: Integer; FEventCanceled: Boolean);
  procedure DeskMetricsTrackEventPeriodA(FEventCategory, FEventName: PAnsiChar; FEventTime: Integer; FEventCanceled: Boolean);
  procedure DeskMetricsTrackLog(FMessage: PWideChar);
  procedure DeskMetricsTrackLogA(FMessage: PAnsiChar);
  procedure DeskMetricsTrackCustomData(FName, FValue: PWideChar);
  procedure DeskMetricsTrackCustomDataA(FName, FValue: PAnsiChar);
  function  DeskMetricsTrackCustomDataR(FName: PWideChar; FValue: PWideChar): Integer;
  function  DeskMetricsTrackCustomDataRA(FName: PAnsiChar; FValue: PAnsiChar): Integer;
  procedure DeskMetricsTrackException(FExpectionObject: Exception);
  function  DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean;
  function  DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean;
  function  DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean;
  function  DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean;
  function  DeskMetricsSetUserID(FID: PWideChar): Boolean;
  function  DeskMetricsSetUserIDA(FID: PAnsiChar): Boolean;
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
  function  DeskMetricsSetEnabled(FValue: Boolean): Boolean;
  function  DeskMetricsGetEnabled: Boolean;
  function  DeskMetricsSendData: Boolean;
  function  DeskMetricsGetDebugMode: Boolean;
  function  DeskMetricsSetDebugMode(FEnabled: Boolean): Boolean;

  function  DeskMetricsDllLoaded: Boolean;
  function  Load_DLL: Boolean;
  function  Unload_DLL: Boolean;

const
  EMPTY_STRING = '';
  NO_INTEGER_VALUE = 0;

implementation

uses Windows;

var
  hModule : THandle;

const
  DESKMETRICS_DLL = 'DeskMetrics.dll';

  PROC_DeskMetricsStart = 'DeskMetricsStart';
  PROC_DeskMetricsStartA = 'DeskMetricsStartA';
  PROC_DeskMetricsStop = 'DeskMetricsStop';
  PROC_DeskMetricsTrackEvent = 'DeskMetricsTrackEvent';
  PROC_DeskMetricsTrackEventA = 'DeskMetricsTrackEventA';
  PROC_DeskMetricsTrackEventValue = 'DeskMetricsTrackEventValue';
  PROC_DeskMetricsTrackEventValueA = 'DeskMetricsTrackEventValueA';
  PROC_DeskMetricsTrackEventPeriod = 'DeskMetricsTrackEventPeriod';
  PROC_DeskMetricsTrackEventPeriodA = 'DeskMetricsTrackEventPeriodA';
  PROC_DeskMetricsTrackLog = 'DeskMetricsTrackLog';
  PROC_DeskMetricsTrackLogA = 'DeskMetricsTrackLogA';
  PROC_DeskMetricsTrackCustomData = 'DeskMetricsTrackCustomData';
  PROC_DeskMetricsTrackCustomDataA = 'DeskMetricsTrackCustomDataA';
  PROC_DeskMetricsTrackCustomDataR = 'DeskMetricsTrackCustomDataR';
  PROC_DeskMetricsTrackCustomDataRA = 'DeskMetricsTrackCustomDataRA';
  PROC_DeskMetricsTrackException = 'DeskMetricsTrackException';
  PROC_DeskMetricsSetProxy = 'DeskMetricsSetProxy';
  PROC_DeskMetricsSetProxyA = 'DeskMetricsSetProxyA';
  PROC_DeskMetricsGetProxy = 'DeskMetricsGetProxy';
  PROC_DeskMetricsGetProxyA = 'DeskMetricsGetProxyA';
  PROC_DeskMetricsSetUserID = 'DeskMetricsSetUserID';
  PROC_DeskMetricsSetUserIDA = 'DeskMetricsSetUserIDA';
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
  PROC_DeskMetricsSetEnabled = 'DeskMetricsSetEnabled';
  PROC_DeskMetricsGetEnabled = 'DeskMetricsGetEnabled';
  PROC_DeskMetricsSendData = 'DeskMetricsSendData';
  PROC_DeskMetricsGetDebugMode = 'DeskMetricsGetDebugMode';
  PROC_DeskMetricsSetDebugMode = 'DeskMetricsSetDebugMode';

function GetAppPath : string;
begin
  try
    Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  except
    Result := '';
  end;
end;

function CheckLoadDLL : Boolean;
begin
  try
    if hModule < HINSTANCE_ERROR then
    begin
      hModule := LoadLibrary(PChar(GetAppPath + DESKMETRICS_DLL));
      Result := not(hModule < HINSTANCE_ERROR);
    end
    else
      Result := True;
  except
    Result := False;
  end;
end;

function  DeskMetricsDllLoaded : Boolean;
begin
  try
    Result := not (hModule < HINSTANCE_ERROR);
  except
    Result := False;
  end;
end;

function  Load_DLL : boolean;
begin
  try
    Result := CheckLoadDLL;
  except
    Result := False;
  end;
end;

function  Unload_DLL : boolean;
begin
  try
    Result := False;
    if not (hModule < HINSTANCE_ERROR) then
      Result := FreeLibrary(hModule);
  except
    Result := False;
  end;
end;

function  DeskMetricsStart(FApplicationID: PWideChar; FApplicationVersion: PWideChar): Boolean;
const
  DMStart : TDMStart = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMStart := GetProcAddress(hModule, PROC_DeskMetricsStart);
      if Assigned(DMStart) then
        Result := DMStart(FApplicationID, FApplicationVersion);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsStartA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar): Boolean;
const
  DMStartA : TDMStartA = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMStartA := GetProcAddress(hModule, PROC_DeskMetricsStartA);
      if Assigned(DMStartA) then
        Result := DMStartA(FApplicationID, FApplicationVersion);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsStop: Boolean;
const
  DMStop : TDMStop = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMStop := GetProcAddress(hModule, PROC_DeskMetricsStop);
      if Assigned(DMStop) then
        Result := DMStop;
    end;
  except
    Result := False;
  end;
end;

procedure DeskMetricsTrackEvent(FEventCategory, FEventName: PWideChar);
const
  DMTrackEvent : TDMTrackEvent = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackEvent := GetProcAddress(hModule, PROC_DeskMetricsTrackEvent);
      if Assigned(DMTrackEvent) then
        DMTrackEvent(FEventCategory, fEventName);
    end;
  except
  end;
end;

procedure DeskMetricsTrackEventA(FEventCategory, FEventName: PAnsiChar);
const
  DMTrackEventA : TDMTrackEventA = nil;
begin
  try
  if CheckLoadDLL then
  begin
    @DMTrackEventA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventA);
    if Assigned(DMTrackEventA) then
      DMTrackEventA(FEventCategory, fEventName);
  end;
  except
  end;
end;

procedure DeskMetricsTrackEventValue(FEventCategory, FEventName, FEventValue: PWideChar);
const
  DMTrackEventValue : TDMTrackEventValue = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackEventValue := GetProcAddress(hModule, PROC_DeskMetricsTrackEventValue);
      if Assigned(DMTrackEventValue) then
        DMTrackEventValue(FEventCategory, fEventName, fEventValue);
    end;
  except
  end;
end;

procedure DeskMetricsTrackEventValueA(FEventCategory, FEventName, FEventValue: PAnsiChar);
const
  DMTrackEventValuea : TDMTrackEventValueA = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackEventValueA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventValueA);
      if Assigned(DMTrackEventValueA) then
        DMTrackEventValueA(FEventCategory, fEventName, fEventValue);
    end;
  except
  end;
end;

procedure DeskMetricsTrackEventPeriod(FEventCategory, FEventName: PWideChar; FEventTime: Integer; FEventCanceled: Boolean);
const
  DMTrackEventPeriod : TDMTrackEventPeriod = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackEventPeriod := GetProcAddress(hModule, PROC_DeskMetricsTrackEventPeriod);
      if Assigned(DMTrackEventPeriod) then
        DMTrackEventPeriod(FEventCategory, FEventName, FEventTime, FEventCanceled);
    end;
  except
  end;
end;

procedure DeskMetricsTrackEventPeriodA(FEventCategory, FEventName: PAnsiChar; FEventTime: Integer; FEventCanceled: Boolean);
const
  DMTrackEventPeriodA : TDMTrackEventPeriodA = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackEventPeriodA := GetProcAddress(hModule, PROC_DeskMetricsTrackEventPeriodA);
      if Assigned(DMTrackEventPeriodA) then
        DMTrackEventPeriodA(FEventCategory, FEventName, FEventTime, FEventCanceled);
    end;
  except
  end;
end;

procedure DeskMetricsTrackLog(FMessage: PWideChar);
const
  DMTrackLog : TDMTrackLog = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackLog := GetProcAddress(hModule, PROC_DeskMetricsTrackLog);
      if Assigned(DMTrackLog) then
        DMTrackLog(FMessage);
    end;
  except
  end;
end;

procedure DeskMetricsTrackLogA(FMessage: PAnsiChar);
const
  DMTrackLogA : TDMTrackLogA = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackLogA := GetProcAddress(hModule, PROC_DeskMetricsTrackLogA);
      if Assigned(DMTrackLogA) then
        DMTrackLogA(FMessage);
    end;
  except
  end;
end;

procedure DeskMetricsTrackCustomData(FName, FValue: PWideChar);
const
  DMTrackCustomData : TDMTrackCustomData = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackCustomData := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomData);
      if Assigned(DMTrackCustomData) then
        DMTrackCustomData(FName, FValue);
    end;
  except
  end;
end;

procedure DeskMetricsTrackCustomDataA(FName, FValue: PAnsiChar);
const
  DMTrackCustomDataA : TDMTrackCustomDataA = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackCustomDataA := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataA);
      if Assigned(DMTrackCustomDataA) then
        DMTrackCustomDataA(FName, FValue);
    end;
  except
  end;
end;

function  DeskMetricsTrackCustomDataR(FName: PWideChar; FValue: PWideChar): Integer;
const
  DMTrackCustomDataR : TDMTrackCustomDataR = nil;
begin
  Result := NO_INTEGER_VALUE;
  try
    if CheckLoadDLL then
    begin
      @DMTrackCustomDataR := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataR);
      if Assigned(DMTrackCustomDataR) then
        Result := DMTrackCustomDataR(FName, FValue);
    end;
  except
    Result := NO_INTEGER_VALUE;
  end;
end;

function  DeskMetricsTrackCustomDataRA(FName: PAnsiChar; FValue: PAnsiChar): Integer;
const
  DMTrackCustomDataRA : TDMTrackCustomDataRA = nil;
begin
  Result := NO_INTEGER_VALUE;
  try
    if CheckLoadDLL then
    begin
      @DMTrackCustomDataRA := GetProcAddress(hModule, PROC_DeskMetricsTrackCustomDataRA);
      if Assigned(DMTrackCustomDataRA) then
        Result := DMTrackCustomDataRA(FName, FValue);
    end;
  except
    Result := NO_INTEGER_VALUE;
  end;
end;

procedure DeskMetricsTrackException(FExpectionObject: Exception);
const
  DMTrackException : TDMTrackException = nil;
begin
  try
    if CheckLoadDLL then
    begin
      @DMTrackException := GetProcAddress(hModule, PROC_DeskMetricsTrackException);
      if Assigned(DMTrackException) then
        DMTrackException(FExpectionObject);
    end;
  except
  end;
end;

function  DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean;
const
  DMSetProxy : TDMSetProxy = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetProxy := GetProcAddress(hModule, PROC_DeskMetricsSetProxy);
      if Assigned(DMSetProxy) then
        Result := DMSetProxy(FHostIP, FPort, FUserName, fPassword);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean;
const
  DMSetProxyA : TDMSetProxyA = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetProxyA := GetProcAddress(hModule, PROC_DeskMetricsSetProxyA);
      if Assigned(DMSetProxyA) then
        Result := DMSetProxyA(FHostIP, FPort, FUserName, fPassword);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean;
const
  DMGetProxy : TDMGetProxy = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMGetProxy := GetProcAddress(hModule, PROC_DeskMetricsGetProxy);
      if Assigned(DMGetProxy) then
        Result := DMGetProxy(FHostIP, FPort);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean;
const
  DMGetProxyA : TDMGetProxyA = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMGetProxyA := GetProcAddress(hModule, PROC_DeskMetricsGetProxyA);
      if Assigned(DMGetProxyA) then
        Result := DMGetProxyA(FHostIP, FPort);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSetUserID(FID: PWideChar): Boolean;
const
  DMSetUserID : TDMSetUserID = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetUserID := GetProcAddress(hModule, PROC_DeskMetricsSetUserID);
      if Assigned(DMSetUserID) then
        Result := DMSetUserID(FID);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSetUserIDA(FID: PAnsiChar): Boolean;
const
  DMSetUserIDA : TDMSetUserIDA = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetUserIDA := GetProcAddress(hModule, PROC_DeskMetricsSetUserIDA);
      if Assigned(DMSetUserIDA) then
        Result := DMSetUserIDA(FID);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetPostServer: PWideChar;
const
  DMGetPostServer : TDMGetPostServer = nil;
begin
  Result := EMPTY_STRING;
  try
    if CheckLoadDLL then
    begin
      @DMGetPostServer := GetProcAddress(hModule, PROC_DeskMetricsGetPostServer);
      if Assigned(DMGetPostServer) then
        Result := DMGetPostServer;
    end;
  except
    Result := EMPTY_STRING;
  end;
end;

function  DeskMetricsGetPostServerA: PAnsiChar;
const
  DMGetPostServerA : TDMGetPostServerA = nil;
begin
  Result := EMPTY_STRING;
  try
    if CheckLoadDLL then
    begin
      @DMGetPostServerA := GetProcAddress(hModule, PROC_DeskMetricsGetPostServerA);
      if Assigned(DMGetPostServerA) then
        Result := DMGetPostServerA;
    end;
  except
    Result := EMPTY_STRING;
  end;
end;

function  DeskMetricsSetPostServer(FServer: PWideChar): Boolean;
const
  DMSetPostServer : TDMSetPostServer = nil;
begin
  Result := False;
  try
  if CheckLoadDLL then
  begin
    @DMSetPostServer := GetProcAddress(hModule, PROC_DeskMetricsSetPostServer);
    if Assigned(DMSetPostServer) then
      Result := DMSetPostServer(FServer);
  end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSetPostServerA(FServer: PAnsiChar): Boolean;
const
  DMSetPostServerA : TDMSetPostServerA = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetPostServerA := GetProcAddress(hModule, PROC_DeskMetricsSetPostServerA);
      if Assigned(DMSetPostServerA) then
        Result := DMSetPostServerA(FServer);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetPostPort: Integer;
const
  DMGetPostPort : TDMGetPostPort = nil;
begin
  Result := NO_INTEGER_VALUE;
  try
    if CheckLoadDLL then
    begin
      @DMGetPostPort := GetProcAddress(hModule, PROC_DeskMetricsGetPostPort);
      if Assigned(DMGetPostPort) then
        Result := DMGetPostPort;
    end;
  except
    Result := NO_INTEGER_VALUE;
  end;
end;

function  DeskMetricsSetPostPort(FPort: Integer): Boolean;
const
  DMSetPostPort : TDMSetPostPort = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetPostPort := GetProcAddress(hModule, PROC_DeskMetricsSetPostPort);
      if Assigned(DMSetPostPort) then
        Result := DMSetPostPort(FPort);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetPostTimeOut: Integer;
const
  DMGetPostTimeOut : TDMGetPostTimeOut = nil;
begin
  Result := NO_INTEGER_VALUE;
  try
    if CheckLoadDLL then
    begin
      @DMGetPostTimeOut := GetProcAddress(hModule, PROC_DeskMetricsGetPostTimeOut);
      if Assigned(DMGetPostTimeOut) then
        Result := DMGetPostTimeOut;
    end;
  except
    Result := NO_INTEGER_VALUE;
  end;
end;

function  DeskMetricsSetPostTimeOut(FTimeOut: Integer): Boolean;
const
  DMSetPostTimeOut : TDMSetPostTimeOut = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetPostTimeOut := GetProcAddress(hModule, PROC_DeskMetricsSetPostTimeOut);
      if Assigned(DMSetPostTimeOut) then
        Result := DMSetPostTimeOut(FTimeOut);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetPostWaitResponse: Boolean;
const
  DMGetPostWaitResponse : TDMGetPostWaitResponse = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMGetPostWaitResponse := GetProcAddress(hModule, PROC_DeskMetricsGetPostWaitResponse);
      if Assigned(DMGetPostWaitResponse) then
        Result := DMGetPostWaitResponse;
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSetPostWaitResponse(FEnabled: Boolean): Boolean;
const
  DMSetPostWaitResponse : TDMSetPostWaitResponse = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetPostWaitResponse := GetProcAddress(hModule, PROC_DeskMetricsSetPostWaitResponse);
      if Assigned(DMSetPostWaitResponse) then
        Result := DMSetPostWaitResponse(FEnabled);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetJSON: PWideChar;
const
  DMGetJSON : TDMGetJSON = nil;
begin
  Result := EMPTY_STRING;
  try
    if CheckLoadDLL then
    begin
      @DMGetJSON := GetProcAddress(hModule, PROC_DeskMetricsGetJSON);
      if Assigned(DMGetJSON) then
        Result := DMGetJSON;
    end;
  except
    Result := EMPTY_STRING;
  end;
end;

function  DeskMetricsGetJSONA: PAnsiChar;
const
  DMGetJSONA : TDMGetJSONA = nil;
begin
  Result := EMPTY_STRING;
  try
    if CheckLoadDLL then
    begin
      @DMGetJSONA := GetProcAddress(hModule, PROC_DeskMetricsGetJSONA);
      if Assigned(DMGetJSONA) then
        Result := DMGetJSONA;
    end;
  except
    Result := EMPTY_STRING;
  end;
end;

function  DeskMetricsSetEnabled(FValue: Boolean): Boolean;
const
  DMSetEnabled : TDMSetEnabled = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetEnabled := GetProcAddress(hModule, PROC_DeskMetricsSetEnabled);
      if Assigned(DMSetEnabled) then
        Result := DMSetEnabled(FValue);
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetEnabled: Boolean;
const
  DMGetEnabled : TDMGetEnabled = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMGetEnabled := GetProcAddress(hModule, PROC_DeskMetricsGetEnabled);
      if Assigned(DMGetEnabled) then
        Result := DMGetEnabled;
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSendData: Boolean;
const
  DMSendData : TDMSendData = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSendData := GetProcAddress(hModule, PROC_DeskMetricsSendData);
      if Assigned(DMSendData) then
        Result := DMSendData;
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsGetDebugMode: Boolean;
const
  DMGetDebugMode : TDMGetDebugMode = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMGetDebugMode := GetProcAddress(hModule, PROC_DeskMetricsGetDebugMode);
      if Assigned(DMGetDebugMode) then
        Result := DMGetDebugMode;
    end;
  except
    Result := False;
  end;
end;

function  DeskMetricsSetDebugMode(FEnabled: Boolean): Boolean;
const
  DMSetDebugMode : TDMSetDebugMode = nil;
begin
  Result := False;
  try
    if CheckLoadDLL then
    begin
      @DMSetDebugMode := GetProcAddress(hModule, PROC_DeskMetricsSetDebugMode);
      if Assigned(DMSetDebugMode) then
        Result := DMSetDebugMode(FEnabled);
    end;
  except
    Result := False;
  end;
end;

initialization
  hModule := 0;

finalization
  if not(hModule < HINSTANCE_ERROR) then
    FreeLibrary(hModule);

end.