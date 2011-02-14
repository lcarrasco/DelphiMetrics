{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsConsts.pas                            }
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

unit dskMetricsConsts;

interface

uses
  Windows;

const
  { DeskMetrics Server / HTTP Consts }
  USERAGENT          = 'DeskMetricsDLL';
  DEFAULTSERVER      = '.api.deskmetrics.com';
  DEFAULTPORT        = 443; {https}
  DEFAULTPROXYPORT   = 8080;
  DEFAULTTIMEOUT     = 8000; {8 seconds}

  { DeskMetrics Data }
  MAXSTORAGEDATA     = 51200; {50 KB}
  MAXDAILYNETWORK    = -1; {Unlimited}

  { DeskMetrics Strings Consts }
  NULL_STR           = 'null';
  NONE_STR           = 'none';
  UNKNOWN_STR        = 'Unknown';
  ERROR_STR          = 'Error';

  { DeskMetrics Registry Consts }
  REGROOTKEY         = DWORD($80000001); {HKEY_CURRENT_USER}
  REGPATH            = '\SOFTWARE\dskMetrics\';

  { DeskMetrics Test / Debug Consts }
  LOGFILENAME        = 'dskMetrics.log';

  { DeskMetrics - WebService API Calls }
  API_SENDDATA       = '/sendData';

  { DeskMetrics Wininet Consts }
  READBUFFERSIZE     = 4096;
  WINETDLL           = 'WININET.DLL';

  INTERNET_PER_CONN_FLAGS               = 1;
  INTERNET_PER_CONN_PROXY_SERVER        = 2;
  INTERNET_PER_CONN_PROXY_BYPASS        = 3;
  INTERNET_PER_CONN_AUTOCONFIG_URL      = 4;
  INTERNET_PER_CONN_AUTODISCOVERY_FLAGS = 5;

  PROXY_TYPE_DIRECT         = $00000001;   // direct to net
  PROXY_TYPE_PROXY          = $00000002;   // via named proxy

  INTERNET_OPTION_PER_CONNECTION_OPTION   = 75;

  { DeskMetrics Wininet Types }
  type
   INTERNET_PER_CONN_OPTION = record
      dwOption: DWORD;
      Value: record
         case Integer of
            1: (dwValue: DWORD);
            2: (pszValue: PAnsiChar);
            3: (ftValue: TFileTime);
      end;
  end;

   LPINTERNET_PER_CONN_OPTION = ^INTERNET_PER_CONN_OPTION;
   INTERNET_PER_CONN_OPTION_LIST = record
      dwSize: DWORD;
      pszConnection: LPTSTR;
      dwOptionCount: DWORD;
      dwOptionError: DWORD;
      pOptions: LPINTERNET_PER_CONN_OPTION;
   end;
   LPINTERNET_PER_CONN_OPTION_LIST = ^INTERNET_PER_CONN_OPTION_LIST;

implementation

end.
