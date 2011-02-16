{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - DeskMetrics.dpr                                 }
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

library DeskMetrics;

uses
  FastMM4,
  Windows,
  SysUtils,
  ActiveX,
  SyncObjs,
  dskMetricsInternals in 'dskMetricsInternals.pas',
  dskMetricsConsts in 'dskMetricsConsts.pas',
  dskMetricsVars in 'dskMetricsVars.pas',
  dskMetricsCPUInfo in 'dskMetricsCPUInfo.pas',
  dskMetricsCommon in 'dskMetricsCommon.pas',
  dskMetricsWinInfo in 'dskMetricsWinInfo.pas',
  dskMetricsBase64 in 'dskMetricsBase64.pas';

{ 4 GB memory }
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

{ Multi-threading }
{$define AssumeMultiThreaded}

{ Disable compiler platform warning }
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

{ Component POST Configuration }
function DeskMetricsGetPostServer: PWideChar; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := PWideChar(FAppID + FPostServer);
    except
      Result := '';
    end;
  finally
    FThreadSafe.Leave;
  end;

end;

function DeskMetricsGetPostServerA: PAnsiChar; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := PAnsiChar(DeskMetricsGetPostServer);
    except
      Result := '';
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetPostServer(FServer: PWideChar): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      FPostServer := FServer;
      Result      := True;
    except
      Result      := False;
      FPostServer := DEFAULTSERVER;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetPostServerA(FServer: PAnsiChar): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsSetPostServer(PWideChar(FServer));
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsGetPostPort: Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := FPostPort;
    except
      Result := DEFAULTPORT;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetPostPort(FPort: Integer): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      FPostPort := FPort;
      Result    := True;
    except
      Result    := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsGetPostTimeOut: Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := FPostTimeOut;
    except
      Result := DEFAULTTIMEOUT;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetPostTimeOut(FTimeOut: Integer): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      FPostTimeOut := FTimeOut;
      Result       := True;
    except
      Result       := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsGetPostWaitResponse: Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := FPostWaitResponse;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetPostWaitResponse(FEnabled: Boolean): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      FPostWaitResponse := FEnabled;
      Result            := True;
    except
      Result            := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Component Control }
function DeskMetricsStart(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FRealTime: Boolean): Boolean; stdcall;
var
  FHeader: string;
  FOperatingSystem: string;
  FHardware: string;
  FErrorID: Integer;
begin
  FThreadSafe.Enter;
  try
    Result   := False;
    FErrorID := 0;
    try
      { Set Application ID }
      _SetAppID(FApplicationID);

      if FApplicationVersion = '' then
        FAppVersion := PWideChar(_GetAppVersion)
      else
        FAppVersion := FApplicationVersion;

      if (_GetAppID <> '') and (FEnabled) then
      begin
        { JSON Header }
        FHeader           := '{"tp":"strApp","aver":"' + FAppVersion + '","ID":"' + _GetUserID + '","ss":"' + _GetSessionID + '","ts":' + _GetTimeStamp + ',';
        FOperatingSystem  := '"osv":"' + _GetOperatingSystemVersion + '","ossp":'+ _GetOperatingSystemServicePack +',"osar":' + _GetOperatingSystemArchicteture + ',"osjv":"' + _GetJavaVM + '","osnet":"' + _GetDotNetVersion + '","osnsp":' + _GetDotNetServicePack + ',"oslng":' + _GetOperatingSystemLanguage + ',"osscn":"' + _GetOperatingSystemScreen + '",';
        FHardware         := '"cnm":"' + _GetProcessorName + '","cbr":"' + _GetProcessorBrand + '","cfr":' + IntToStr(_GetProcessorFrequency) + ',"ccr":' + _GetProcessorCores + ',"car":'+ _GetProcessorArchicteture + ',"mtt":' + _GetMemoryTotal + ',"mfr":' + _GetMemoryFree + ',"dtt":' + _GetDiskTotal + ',"dfr":' + _GetDiskFree + '}';
        FJSONData         := Trim(FHeader) + Trim(FOperatingSystem) + Trim(FHardware);

        { Real-time Mode }
        if FRealTime then
        begin
          FThreadStart := TPostThread.Create(FJSONData, API_SENDDATA, FErrorID);
          FThreadStart.Resume;
        end;

        _SetStarted(True);

        Result := True;
      end;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsStartA(FApplicationID: PAnsiChar; FApplicationVersion: PWideChar; FRealTime: Boolean): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsStart(PWideChar(FApplicationID), PWideChar(FApplicationVersion), FRealTime);
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsStop: Boolean; stdcall;
var
  FSingleJSON: string;
  FCacheData: string;
begin
  FThreadSafe.Enter;
  try
    Result := True;
    try
    
      { if DeskMetricsStart Thread is running -> wait }
      if FThreadStart <> nil then
      begin
        WaitForSingleObject(FThreadStart.Handle, INFINITE);
        FThreadStart.Free;
        FThreadStart := nil;
      end;

      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FJSONData   := FJSONData + ',{"tp":"stApp","ts":' + _GetTimeStamp + ',"ss":"' + _GetSessionID + '"}';
        FSingleJSON := FJSONData;

        { Exists Cache }
        FCacheData := _GetCacheData;
         if FCacheData <> '' then
          FJSONData := FJSONData + ',' + Trim(FCacheData);

        try
          { Send HTTP request }
          _SendPost(FLastErrorID, API_SENDDATA);
        finally
          FJSONData := FSingleJSON;
        end;

        { Debug / Test Mode }
        if _GetDebugMode then
          _InsertLogText('Stop', FLastErrorID);
      end;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Events }
procedure DeskMetricsTrackEvent(FEventCategory, FEventName: PWideChar); stdcall;
var
  FEventNameTemp: string;
  FEventCategoryTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FEventNameTemp     := Trim(FEventName);
        FEventCategoryTemp := Trim(FEventCategory);

        FJSONData := FJSONData + ',{"tp":"ev","ca":"' + FEventCategoryTemp + '","nm":"' + FEventNameTemp + '","fl":' + _GetFlowNumber + ',"ts":'+ _GetTimeStamp +',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventA(FEventCategory, FEventName: PAnsiChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackEvent(PWideChar(FEventCategory),PWideChar(FEventName));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventValue(FEventCategory, FEventName, FEventValue: PWideChar); stdcall;
var
  FEventNameTemp: string;
  FEventCategoryTemp: string;
  FEventValueTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FEventNameTemp     := Trim(FEventName);
        FEventCategoryTemp := Trim(FEventCategory);
        FEventValueTemp    := Trim(FEventValue);

        FJSONData := FJSONData + ',{"tp":"evV","ca":"' + FEventCategoryTemp + '","nm":"' + FEventNameTemp + '","vl":"' + FEventValueTemp + '","fl":' + _GetFlowNumber + ',"ts":'+ _GetTimeStamp +',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventValueA(FEventCategory, FEventName, FEventValue: PAnsiChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackEventValue(PWideChar(FEventCategory), PWideChar(FEventName), PWideChar(FEventValue));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventStart(FEventCategory, FEventName: PWideChar); stdcall;
var
  FEventNameTemp: string;
  FEventCategoryTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FEventNameTemp     := Trim(FEventName);
        FEventCategoryTemp := Trim(FEventCategory);

        FJSONData := FJSONData + ',{"tp":"evS","ca":"' + FEventCategoryTemp + '","nm":"' + FEventNameTemp + '","fl":' + _GetFlowNumber + ',"ts":' + _GetTimeStamp  + ',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventStartA(FEventCategory, FEventName: PWideChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackEventStart(PWideChar(FEventCategory), PWideChar(FEventName));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventStop(FEventCategory, FEventName: PWideChar); stdcall;
var
  FEventNameTemp: string;
  FEventCategoryTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FEventNameTemp     := Trim(FEventName);
        FEventCategoryTemp := Trim(FEventCategory);

        FJSONData := FJSONData + ',{"tp":"evST","ca":"' + FEventCategoryTemp + '","nm":"' + FEventNameTemp + '","fl":' + _GetFlowNumber + ',"ts":' + _GetTimeStamp  + ',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventStopA(FEventCategory, FEventName: PAnsiChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackEventStop(PWideChar(FEventCategory), PWideChar(FEventName));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventCancel(FEventCategory, FEventName: PWideChar); stdcall;
var
  FEventNameTemp: string;
  FEventCategoryTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FEventNameTemp     := Trim(FEventName);
        FEventCategoryTemp := Trim(FEventCategory);

        FJSONData := FJSONData + ',{"tp":"evC","ca":"' + FEventCategoryTemp + '","nm":"' + FEventNameTemp + '","fl":' + _GetFlowNumber + ',"ts":' + _GetTimeStamp  + ',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventCancelA(FEventCategory, FEventName: PAnsiChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackEventCancel(PWideChar(FEventCategory), PWideChar(FEventName));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventPeriod(FEventCategory, FEventName: PWideChar; FEventTime: Integer); stdcall;
var
  FEventNameTemp: string;
  FEventCategoryTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
     if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FEventNameTemp     := Trim(FEventName);
        FEventCategoryTemp := Trim(FEventCategory);

        FJSONData := FJSONData + ',{"tp":"evP","ca":"' + FEventCategoryTemp + '","nm":"' + FEventNameTemp + '","tm":' + IntToStr(FEventTime) + ',"fl":' + _GetFlowNumber + ',"ts":' + _GetTimeStamp  + ',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackEventPeriodA(FEventCategory, FEventName: PAnsiChar; FEventTime: Integer); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackEventPeriod(PWideChar(FEventCategory), PWideChar(FEventName), FEventTime);
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Logs }
procedure DeskMetricsTrackLog(FMessage: PWideChar); stdcall;
var
  FMessageTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FMessageTemp  := Trim(FMessage);

        FJSONData     := FJSONData + ',{"tp":"lg","ms":"' + FMessageTemp + '","fl":' + _GetFlowNumber + ',"ts":'+ _GetTimeStamp +',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackLogA(FMessage: PAnsiChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackLog(PWideChar(FMessage));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Custom Data }
procedure DeskMetricsTrackCustomData(FName, FValue: PWideChar); stdcall;
var
  FNameTemp: string;
  FValueTemp: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FNameTemp   := Trim(FName);
        FValueTemp  := Trim(FValue);

        FJSONData   := FJSONData + ',{"tp":"ctD","nm":"' + FNameTemp + '","vl":"' + FValueTemp + '","fl":' + _GetFlowNumber + ',"ts":'+ _GetTimeStamp +',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

procedure DeskMetricsTrackCustomDataA(FName, FValue: PAnsiChar); stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      DeskMetricsTrackCustomData(PWideChar(FName), PWideChar(FValue));
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsTrackCustomDataR(FApplicationID: PWideChar; FApplicationVersion: PWideChar; FName: PWideChar; FValue: PWideChar): Integer; stdcall;
var
  FJSONTemp: string;
  FNameTemp: string;
  FValueTemp: string;
  FErrorID: Integer;
begin
  FThreadSafe.Enter;
  try
    try
      FJSONTemp     := FJSONData;
      try
        FNameTemp     := Trim(FName);
        FValueTemp    := Trim(FValue);

        { Set Application ID }
        _SetAppID(FApplicationID);

        FJSONData := '{"tp":"ctDR","nm":"' + FNameTemp + '","vl":"' + FValueTemp + '","aver":"' + FApplicationVersion + '","ID":"' + _GetUserID + '","fl":' + _GetFlowNumber + ',"ts":'+ _GetTimeStamp +',"ss":"' + _GetSessionID + '"}';

        { Send HTTP request }
        _SendPost(FErrorID, API_SENDDATA);
        Result := FErrorID;

        { Debug / Test Mode }
        if _GetDebugMode then
          _InsertLogText('TrackCustomDataR', FErrorID);
      finally
        FJSONData := FJSONTemp;
      end;
    except
      Result := -1;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsTrackCustomDataRA(FApplicationID: PAnsiChar; FApplicationVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar): Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsTrackCustomDataR(PWideChar(FApplicationID), PWideChar(FApplicationVersion), PWideChar(FName), PWideChar(FValue));
    except
      Result := -1;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Exceptions }
procedure DeskMetricsTrackException(FExpectionObject: Exception); stdcall;
var
  FExMessage, FExStack, FExSource, FExTarget: string;
begin
  FThreadSafe.Enter;
  try
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        FExMessage  := FExpectionObject.Message;
        FExStack    := FExpectionObject.StackTrace;
        FExSource   := '';
        FExTarget   := FExpectionObject.ClassName;

        FJSONData   := FJSONData + ',{"tp":"exC","msg":"' + FExMessage + '","stk":"' + FExStack + '","src":"' + FExSource + '","tgs":"' + FExTarget + '","fl":' + _GetFlowNumber + ',"ts":'+ _GetTimeStamp +',"ss":"' + _GetSessionID + '"}';
      end;
    except
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{Installations}
function DeskMetricsTrackInstallation(FApplicationID: string; FApplicationVersion: string): Integer; stdcall;
var
  FErrorID: Integer;
begin
  FThreadSafe.Enter;
  try
    try
      { Set Application ID }
      _SetAppID(FApplicationID);

      { Check Version }
      if FApplicationVersion = '' then
        FApplicationVersion := NULL_STR;

      { JSON Data }
      FJSONData := '{"tp":"ist","aver":"' + FApplicationVersion + '","ID":"' + _GetUserID + '","ts":' + _GetTimeStamp + ',"ss":"' + _GetSessionID + '"}';

      { Send HTTP request }
      _SendPost(FErrorID, API_SENDDATA);
      Result := FErrorID;
    except
      Result := -1;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsTrackInstallationA(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsTrackInstallation(WideString(FApplicationID), WideString(FAppVersion));
    except
      Result := -1;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Uninstallations }
function DeskMetricsTrackUninstallation(FApplicationID: string; FApplicationVersion: string): Integer; stdcall;
var
  FErrorID: Integer;
begin
  FThreadSafe.Enter;
  try
    try
      { Set Application ID }
      _SetAppID(FApplicationID);

      { Check Version }
      if FApplicationVersion = '' then
        FApplicationVersion := NULL_STR;

      { JSON Data }
      FJSONData := '{"tp":"ust","aver":"' + FApplicationVersion + '","ID":"' + _GetUserID + '","ts":' + _GetTimeStamp + ',"ss":"' + _GetSessionID + '"}';

      { Send HTTP request }
      _SendPost(FErrorID, API_SENDDATA);
      Result := FErrorID;

      { Debug / Test Mode }
      if _GetDebugMode then
        _InsertLogText('TrackUninstallation', FErrorID);
    except
      Result := -1;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsTrackUninstallationA(FApplicationID: AnsiString; FApplicationVersion: AnsiString): Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsTrackUninstallation(WideString(FApplicationID), WideString(FApplicationVersion));
    except
      Result := -1;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

/////////////////////////////////
//      Proxy Configuration    //
/////////////////////////////////

function DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName: PWideChar; FPassword: PWideChar): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := _SetProxy(FHostIP, FPort, FUserName, FPassword);
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName: PAnsiChar; FPassword: PAnsiChar): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsSetProxy(PWideChar(FHostIP), FPort, PWideChar(FUserName), PWideChar(FPassword));
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      StrPCopy(FHostIP, FProxyServer);
      FPort  := FProxyPort;
      Result := True;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsGetProxy(PWideChar(FHostIP), FPort);
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////

{ Manual Configuration }
function DeskMetricsSetUserID(FUserID: PWideChar): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := _SetUserID(FUserID);
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetUserIDA(FUserID: PAnsiChar): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := DeskMetricsSetUserID(PWideChar(FUserID));
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Component JSON Data }

function DeskMetricsGetJSON: PWideChar; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := PWideChar(FJSONData);
    except
      Result := ERROR_STR;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsGetJSONA: PAnsiChar; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := PAnsiChar(DeskMetricsGetJSON);
    except
      Result := ERROR_STR;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Component Data Configuration }
function DeskMetricsGetEnabled: Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := FEnabled;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetEnabled(FValue: Boolean): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      FEnabled := FValue;
      Result   := True;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function  DeskMetricsGetDailyNetworkUtilizationInKB: Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := _GetMaxDailyNetwork;
    except
      Result := MAXDAILYNETWORK;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetDailyNetworkUtilizationInKB(FDataSize: Integer): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := _SetMaxDailyNetwork(FDataSize);
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function  DeskMetricsGetMaxStorageSizeInKB: Integer; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := _GetMaxStorageFile;
    except
      Result := MAXSTORAGEDATA;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

function DeskMetricsSetMaxStorageSizeInKB(FDataSize: Integer): Boolean; stdcall;
begin
  FThreadSafe.Enter;
  try
    try
      Result := _SetMaxStorageFile(FDataSize);
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Manually Send Data}

function DeskMetricsSendData: Boolean; stdcall;
var
  FErrorID: Integer;
begin
  FThreadSafe.Enter;
  try
    Result := True;
    try
      if (_GetStarted) and (_GetAppID <> '') and (FEnabled) then
      begin
        { Send HTTP request }
        _SendPost(FErrorID, API_SENDDATA);

        { Sent ? }
        Result := FErrorID = 0;

        if _GetDebugMode then
          _InsertLogText('SendData', FErrorID);
      end;
    except
      Result := False;
    end;
  finally
    FThreadSafe.Leave;
  end;
end;

{ Debug Mode }
function DeskMetricsSetDebugMode(FEnabled: Boolean): Boolean; stdcall;
begin
  try
    Result := _SetDebugMode(FEnabled);
  except
    Result := False;
  end;
end;

function DeskMetricsGetDebugMode: Boolean; stdcall;
begin
  try
    Result := _GetDebugMode;
  except
    Result := False;
  end;
end;

{ DLL Control }

procedure OnDLLLoad;
begin
  FThreadSafe  := TCriticalSection.Create;
end;

procedure OnDLLUnload;
begin
  _CheckCacheFile;

  if FThreadStart <> nil then
  begin
    CloseHandle(FThreadStart.Handle);
    FThreadStart := nil;
  end;

  if FThreadStop <> nil then
  begin
    CloseHandle(FThreadStop.Handle);
    FThreadStop := nil;
  end;

  if Assigned(FThreadSafe) then
    FreeAndNil(FThreadSafe);
end;

procedure DeskMetricsDLLProc(dwReason: Integer);
begin
  case dwReason of
    DLL_PROCESS_ATTACH: OnDLLLoad;
    DLL_PROCESS_DETACH: OnDLLUnload;
  end;
end;

exports
 DeskMetricsStart,
 DeskMetricsStartA,
 DeskMetricsStop,
 DeskMetricsTrackEvent,
 DeskMetricsTrackEventA,
 DeskMetricsTrackEventValue,
 DeskMetricsTrackEventValueA,
 DeskMetricsTrackEventStart,
 DeskMetricsTrackEventStartA,
 DeskMetricsTrackEventStop,
 DeskMetricsTrackEventStopA,
 DeskMetricsTrackEventCancel,
 DeskMetricsTrackEventCancelA,
 DeskMetricsTrackEventPeriod,
 DeskMetricsTrackEventPeriodA,
 DeskMetricsTrackLog,
 DeskMetricsTrackLogA,
 DeskMetricsTrackCustomData,
 DeskMetricsTrackCustomDataA,
 DeskMetricsTrackCustomDataR,
 DeskMetricsTrackCustomDataRA,
 DeskMetricsTrackInstallation,
 DeskMetricsTrackInstallationA,
 DeskMetricsTrackUninstallation,
 DeskMetricsTrackUninstallationA,
 DeskMetricsTrackException,
 DeskMetricsSetEnabled,
 DeskMetricsGetEnabled,
 DeskMetricsSetProxy,
 DeskMetricsSetProxyA,
 DeskMetricsGetProxy,
 DeskMetricsGetProxyA,
 DeskMetricsSetUserID,
 DeskMetricsSetUserIDA,
 DeskMetricsGetPostServer,
 DeskMetricsGetPostServerA,
 DeskMetricsSetPostServer,
 DeskMetricsSetPostServerA,
 DeskMetricsGetPostPort,
 DeskMetricsSetPostPort,
 DeskMetricsGetPostTimeOut,
 DeskMetricsSetPostTimeOut,
 DeskMetricsGetPostWaitResponse,
 DeskMetricsSetPostWaitResponse,
 DeskMetricsGetJSON,
 DeskMetricsGetJSONA,
 DeskMetricsGetDailyNetworkUtilizationInKB,
 DeskMetricsSetDailyNetworkUtilizationInKB,
 DeskMetricsGetMaxStorageSizeInKB,
 DeskMetricsSetMaxStorageSizeInKB,
 DeskMetricsSendData,
 DeskMetricsSetDebugMode,
 DeskMetricsGetDebugMode;

begin
  { DLL Management }
  DllProc             := DeskMetricsDLLProc;
  DllProc(DLL_PROCESS_ATTACH);

  { Default Values }
  FThreadSafe.Enter;
  try
    IsMultiThread     := True;

    FJSONData         := '';
    FLastErrorID      := -1;
    FStarted          := False;
    FStopped          := False;
    FEnabled          := True;
    FAppID            := '';
    FAppVersion       := NULL_STR;
    FUserID           := '';
    FSessionID        := NULL_STR;
    FFlowNumber       := 0;
    FPostServer       := DEFAULTSERVER;
    FPostPort         := DEFAULTPORT;
    FPostTimeOut      := DEFAULTTIMEOUT;
    FPostAgent        := USERAGENT;
    FPostWaitResponse := False;
    FDailyData        := MAXDAILYNETWORK;
    FCurrentDailyData := 0;
    FMaxStorage       := MAXSTORAGEDATA;
    FProxyServer      := '';
    FProxyPort        := DEFAULTPROXYPORT;
    FProxyUser        := '';
    FProxyPass        := '';
  finally
    FThreadSafe.Leave;
  end;
end.
