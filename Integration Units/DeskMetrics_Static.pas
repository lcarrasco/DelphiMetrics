{ **********************************************************}
{                                                           }
{     DeskMetrics - Delphi Static Unit                      }
{     Copyright (c) 2010-2011                               }
{                                                           }
{     http://deskmetrics.com                                }
{     support@deskmetrics.com                               }
{                                                           }
{ **********************************************************}

unit DeskMetrics_Static;

interface

type
  TVersionData = record
    Version: ShortString;
    DownloadURL: ShortString;
    ReleaseNote: ShortString;
    ReleaseDate: ShortString;
  end;

  function  DeskMetricsStart(FApplicationID: PWideChar; FRealTime: Boolean; FTestMode: Boolean): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsStartA(FApplicationID: PAnsiChar; FRealTime: Boolean; FTestMode: Boolean): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsStop: Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsCheckVersion(var FVersionData: TVersionData): Boolean; stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEvent(FEventCategory, FEventName: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventA(FEventCategory, FEventName: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventValue(FEventCategory, FEventName, FEventValue: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventValueA(FEventCategory, FEventName, FEventValue: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventStart(FEventCategory, FEventName: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventStartA(FEventCategory, FEventName: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventStop(FEventCategory, FEventName: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventStopA(FEventCategory, FEventName: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventCancel(FEventCategory, FEventName: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackEventCancelA(FEventCategory, FEventName: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackLog(FMessage: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackLogA(FMessage: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackCustomData(FName, FValue: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackCustomDataA(FName, FValue: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsTrackCustomDataR(FApplicationID: PWideChar; FAppVersion: PWideChar; FName: PWideChar; FValue: PWideChar; FTestMode: Boolean): Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsTrackCustomDataRA(FApplicationID: PAnsiChar; FAppVersion: PAnsiChar; FName: PAnsiChar; FValue: PAnsiChar; FTestMode: Boolean): Integer; stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackExceptions(FEnabled: Boolean); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackException(FExceptionMessage, FExceptionType: PWideChar); stdcall; external 'DeskMetrics.dll';
  procedure DeskMetricsTrackExceptionA(FExceptionMessage, FExceptionType: PAnsiChar); stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsTrackInstallation(FApplicationID: string; FAppVersion: string; FTestMode: Boolean): Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsTrackInstallationA(FApplicationID: AnsiString; FAppVersion: AnsiString; FTestMode: Boolean): Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsTrackUninstallation(FApplicationID: string; FAppVersion: string; FTestMode: Boolean): Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsTrackUninstallationA(FApplicationID: AnsiString; FAppVersion: AnsiString; FTestMode: Boolean): Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetAppVersion(FVersion: PWideChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetAppVersionA(FVersion: PAnsiChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetAppVersion: PWideChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetAppVersionA: PAnsiChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetProxy(FHostIP: PWideChar; FPort: Integer; FUserName, FPassword: PWideChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetProxyA(FHostIP: PAnsiChar; FPort: Integer; FUserName, FPassword: PAnsiChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetProxy(var FHostIP: PWideChar; var FPort: Integer): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetProxyA(var FHostIP: PAnsiChar; var FPort: Integer): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetUserID(FID: PWideChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetUserIDA(FID: PAnsiChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetComponentName: PWideChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetComponentNameA: PAnsiChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetComponentVersion: PWideChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetComponentVersionA: PAnsiChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetPostServer: PWideChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetPostServerA: PAnsiChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetPostServer(FServer: PWideChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetPostServerA(FServer: PAnsiChar): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetPostPort: Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetPostPort(FPort: Integer): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetPostTimeOut: Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetPostTimeOut(FTimeOut: Integer): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetPostWaitResponse: Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetPostWaitResponse(FEnabled: Boolean): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetJSON: PWideChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetJSONA: PAnsiChar; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetDailyNetworkUtilizationInKB: Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetDailyNetworkUtilizationInKB(FDataSize: Integer): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetMaxStorageSizeInKB: Integer; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetMaxStorageSizeInKB(FDataSize: Integer): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSetEnabled(FValue: Boolean): Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsGetEnabled: Boolean; stdcall; external 'DeskMetrics.dll';
  function  DeskMetricsSendData: Boolean; stdcall; external 'DeskMetrics.dll';

 implementation
 
 end.