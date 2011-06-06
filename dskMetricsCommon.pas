{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsCommon.pas                            }
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

unit dskMetricsCommon;

interface

uses
  Windows, SysUtils;

{ Windows API Functions }
function _LoadKernelFunc(const FFuncName: string): Pointer;

{ Strings Functions }
function _GetLongPath(FPath: string): string;

{ Executable Version }
function _GetExecutableVersion(const FFilePath: string): string;

implementation

uses
  dskMetricsConsts;

function _LoadKernelFunc(const FFuncName: string): Pointer;
begin
  try
    {$IFDEF WARNDIRS}{$WARN UNSAFE_TYPE OFF}{$ENDIF}
    Result := GetProcAddress(GetModuleHandle('kernel32.dll'), PChar(FFuncName));
    {$IFDEF WARNDIRS}{$WARN UNSAFE_TYPE ON}{$ENDIF}
  except
    Result := nil;
  end;
end;

function _GetLongPath(FPath: string): string;
var
  nPos:Integer;
  hSearch:THandle;
  w32FindData:TWin32FindData;
  bIsBackSlash:Boolean;
begin
  try
    FPath  := ExpandFileName(FPath);
    Result := ExtractFileDrive(FPath);
    nPos   := Length(Result);

    if Length(FPath) <= nPos then
      Exit;

    if FPath[nPos+1]= '\' then
    begin
      Result  := Result+'\';
      Inc(nPos);
    end;

    Delete(FPath,1,nPos);

    repeat
      nPos          := Pos('\',FPath);
      bIsBackSlash  := nPos > 0;

      if not(bIsBackSlash) then
        nPos  := Length(FPath)+1;

      hSearch := FindFirstFile(PChar(Result+Copy(FPath,1,nPos-1)),w32FindData);
      if hSearch<>INVALID_HANDLE_VALUE then
      begin
        try
          Result  := Result+w32FindData.cFileName;
          if bIsBackSlash then
            Result  := Result+'\';
        finally
          Windows.FindClose(hSearch);
        end;
      end
      else
      begin
        Result  := Result+FPath;
        Break;
      end;

      Delete(FPath,1,nPos);

    until Length(FPath)=0;
  except
    Result := '';
  end;
end;

function _GetExecutableVersion(const FFilePath: string): string;
var
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := NULL_STR;
  try
    InfoSize := GetFileVersionInfoSize(PChar(FFilePath), Wnd);
    if InfoSize <> 0 then
    begin
      VerBuf := AllocMem(InfoSize);
      try
        if GetFileVersionInfo(PChar(FFilePath), Wnd, InfoSize, VerBuf) then
        begin
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
            Result := Format('%d.%d',[FI.dwFileVersionMS shr 16 and $0000FFFF, FI.dwFileVersionMS and $0000FFFF])
        end;
      finally
        FreeMem(VerBuf);
      end;
    end;
  except
    Result := NULL_STR;
  end;
end;

end.
