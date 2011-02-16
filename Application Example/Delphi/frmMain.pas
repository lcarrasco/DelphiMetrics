{ **********************************************************************}
{                                                                       }
{     DeskMetrics - Application Example (Delphi)                        }
{     Copyright (c) 2010-2011 DeskMetrics Limited                       }
{                                                                       }
{     http://deskmetrics.com                                            }
{     support@deskmetrics.com                                           }
{                                                                       }
{     This code is provided under the DeskMetrics Modified BSD License  }
{     A copy of this license has been distributed in a file called      }
{     LICENSE with this source code.                                    }
{                                                                       }
{ **********************************************************************}

unit frmMain;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, Dialogs,
  jpeg, pngimage;

type
  Tfrm_Main = class(TForm)
    imgLogo: TImage;
    pnlData: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    btnCustomData: TButton;
    btnCustomDataR: TButton;
    btnLogs: TButton;
    btnSetProxy: TButton;
    btnTrackEvent: TButton;
    btnTrackEventValue: TButton;
    btnTrackWindow: TButton;
    bvlLine: TBevel;
    edtCustomData: TEdit;
    edtCustomDataR: TEdit;
    edtLogs: TEdit;
    edtProxyPass: TEdit;
    edtProxyPort: TEdit;
    edtProxyServer: TEdit;
    edtProxyUser: TEdit;
    Label2: TLabel;
    lblConfigProxy: TLabel;
    lblTrackingCustomData: TLabel;
    lblTrackingEvents: TLabel;
    lblTrackingLog: TLabel;
    lblTrackingWindows: TLabel;
    lblZipCode: TLabel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    Label4: TLabel;
    Bevel3: TBevel;
    btnTrackException: TButton;
    btnTrackEventTime: TButton;
    Label1: TLabel;
    Bevel6: TBevel;
    btnTrackLicense: TButton;
    Label3: TLabel;
    Bevel7: TBevel;
    btnSync: TButton;
    lblDLLStatus: TLabel;
    pnlLicense: TPanel;
    rbFree: TRadioButton;
    rbDemo: TRadioButton;
    rbCracked: TRadioButton;
    rbTrial: TRadioButton;
    rbRegistered: TRadioButton;
    btnTrackAll: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnTrackEventValueClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnCustomDataClick(Sender: TObject);
    procedure btnCustomDataRClick(Sender: TObject);
    procedure btnSetProxyClick(Sender: TObject);
    procedure btnTrackWindowClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTrackEventClick(Sender: TObject);
    procedure btnTrackExceptionClick(Sender: TObject);
    procedure btnTrackEventTimeClick(Sender: TObject);
    procedure btnTrackLicenseClick(Sender: TObject);
    procedure btnSyncClick(Sender: TObject);
    procedure btnTrackAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Main: Tfrm_Main;

const
  // SET YOUR APPLICATION ID
  FApplicationID = 'YOUR APPLICATION ID';

implementation

uses
  DeskMetrics, { Component Unit }
  frmAnotherWindow, frmCustomerExperience;

{$R *.dfm}

procedure Tfrm_Main.btnTrackEventValueClick(Sender: TObject);
begin
  // Tracks a simple event with its retuned value
  if rb1.Checked then
    DeskMetricsTrackEventValue('Game', 'Level', PWideChar(rb1.Caption))
  else
    DeskMetricsTrackEventValue('Game', 'Level', PWideChar(rb2.Caption));
end;

procedure Tfrm_Main.btnTrackExceptionClick(Sender: TObject);
begin
  try
    raise Exception.Create('Error!');
  except
    on E: Exception do
      DeskMetricsTrackException(E);
  end;
  // Tracks an exception
end;

procedure Tfrm_Main.btnTrackLicenseClick(Sender: TObject);
begin
  // Tracks a license
  // IMPORTANT! The custom data category must to be "License"

  if (rbFree.Checked) then
    DeskMetricsTrackCustomData('License', 'F');

  if (rbTrial.Checked) then
    DeskMetricsTrackCustomData('License', 'T');

  if (rbDemo.Checked) then
    DeskMetricsTrackCustomData('License', 'D');

  if (rbRegistered.Checked) then
    DeskMetricsTrackCustomData('License', 'R');

  if (rbCracked.Checked) then
    DeskMetricsTrackCustomData('License', 'C');
end;

procedure Tfrm_Main.btnSendClick(Sender: TObject);
begin
  // Sends a simple log message
  DeskMetricsTrackLog(PWideChar(edtLogs.Text));
end;

procedure Tfrm_Main.btnCustomDataRClick(Sender: TObject);
var
  CustomDataResult: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    // Sends a custom data to server and wait a response
    CustomDataResult := DeskMetricsTrackCustomDataR(FApplicationID, '1.0', 'Email', PWideChar(edtCustomDataR.Text));
  finally
    Screen.Cursor := crDefault;
  end;

  // Data stored successfully
  if CustomDataResult = 0 then
    ShowMessage('OK! Data sent.')
  else
    // An error occurred
    ShowMessage('Sorry! Try again later.');
end;

procedure Tfrm_Main.btnCustomDataClick(Sender: TObject);
begin
  // Tracks a custom data
  DeskMetricsTrackCustomData('ZipCode', PWideChar(edtCustomData.Text));
end;

procedure Tfrm_Main.btnSetProxyClick(Sender: TObject);
begin
  // Set proxy configuration
  DeskMetricsSetProxy(
    PWideChar(edtProxyServer.Text),
    StrToInt(edtProxyPort.Text),
    PWideChar(edtProxyUser.Text),
    PWideChar(edtProxyPass.Text)
  );

  // To disable proxy you should use:
  // DeskMetricsSetProxy(PWideChar(''), 0, PWideChar(''), PWideChar(''));
end;

procedure Tfrm_Main.btnSyncClick(Sender: TObject);
begin
  DeskMetricsSendData;
end;

procedure Tfrm_Main.btnTrackAllClick(Sender: TObject);
var
  FCounter: integer;
begin
  for FCounter := 0 to pred(frm_Main.ComponentCount) do
  begin
    if frm_Main.Components[FCounter] is TButton then
    begin
      OutputDebugString(PChar((frm_Main.Components[FCounter] as TButton).Name));

      if (frm_Main.Components[FCounter] as TButton).Name = 'btnSetProxy' then
        Continue;

      if (frm_Main.Components[FCounter] as TButton).Name = 'btnTrackAll' then
        Continue;

      (frm_Main.Components[FCounter] as TButton).OnClick(Self);
    end;
  end;
end;

procedure Tfrm_Main.btnTrackEventClick(Sender: TObject);
begin
  // Tracks a button click
  DeskMetricsTrackEvent('Buttons','MyButton');
end;

procedure Tfrm_Main.btnTrackEventTimeClick(Sender: TObject);
begin
  // Tracks a period
  DeskMetricsTrackEventPeriod('EventsPeriod', 'MyEvent', 50);
  // 50 == 50 seconds
end;

procedure Tfrm_Main.btnTrackWindowClick(Sender: TObject);
begin
  // Show a window
  frmAnother.ShowModal;
end;

procedure Tfrm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // TIP! You can use this method to prevent the user needs to wait
  // until the component has finished sending all data gathered
  Self.Visible := False;

  // Finishes the DeskMetrics component (required)
  DeskMetricsStop;
end;

procedure Tfrm_Main.FormShow(Sender: TObject);
begin
  frm_CustomerExperience.ShowModal;

  if (DeskMetricsGetEnabled = True) then
  begin
    // Starts the DeskMetrics component (required)
    // IMPORTANT! Do not forget to set your application ID
    DeskMetricsStart(FApplicationID, '1.0', True);

    // Tracks a window event
    // IMPORTANT! The event category must to be "Window"
    DeskMetricsTrackEvent('Window', 'MainWindow');
  end;

  // Shows informations about the component
  if DeskMetricsDllLoaded then
    lblDLLStatus.Caption := 'DLL Loaded'
  else
    lblDLLStatus.Caption := 'DLL Not Found';
end;

end.