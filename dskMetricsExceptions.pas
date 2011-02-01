{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsExceptions.pas                        }
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

unit dskMetricsExceptions;

interface

uses
  SysUtils, Classes, JclDebug, dskMetricsVars;

implementation

function GetExceptionStackInfoProc(P: PExceptionRecord): Pointer;
var
  LLines: TStringList;
  LText: String;
  LResult: PChar;
begin
  try
    LLines := TStringList.Create;
    try
      JclLastExceptStackListToStrings(LLines, True, True, True, True);
      LText := LLines.Text;
      LResult := StrAlloc(Length(LText));
      StrCopy(LResult, PChar(LText));
      Result := LResult;
    finally
      LLines.Free;
    end;
  except
  end;
end;

function GetStackInfoStringProc(Info: Pointer): string;
begin
  try
    Result := string(PChar(Info));
  except
    Result := '';
  end;
end;

procedure CleanUpStackInfoProc(Info: Pointer);
begin
  try
    StrDispose(PChar(Info));
  except
  end;
end;

initialization
  if JclStartExceptionTracking then
  begin
    FException.GetExceptionStackInfoProc := GetExceptionStackInfoProc;
    FException.GetStackInfoStringProc    := GetStackInfoStringProc;
    FException.CleanUpStackInfoProc      := CleanUpStackInfoProc;
  end;

finalization
  if JclExceptionTrackingActive then
  begin
    FException.GetExceptionStackInfoProc := nil;
    FException.GetStackInfoStringProc    := nil;
    FException.CleanUpStackInfoProc      := nil;
    JclStopExceptionTracking;
  end;
end.

