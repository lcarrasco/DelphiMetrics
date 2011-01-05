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
  SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, Dialogs,
  jpeg, pngimage;

type
  Tfrm_Main = class(TForm)
    lblComponentName: TLabel;
    lblComponentVersion: TLabel;
    imgLogo: TImage;
    pnlData: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    btnCheckVersion: TButton;
    btnCustomData: TButton;
    btnCustomDataR: TButton;
    btnEventCancel: TButton;
    btnEventStart: TButton;
    btnEventStop: TButton;
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
    Label1: TLabel;
    Label2: TLabel;
    lblCheckNewVersion: TLabel;
    lblConfigProxy: TLabel;
    lblTrackingCustomData: TLabel;
    lblTrackingEvents: TLabel;
    lblTrackingLog: TLabel;
    lblTrackingWindows: TLabel;
    lblZipCode: TLabel;
    Label3: TLabel;
    Bevel6: TBevel;
    Label4: TLabel;
    Bevel7: TBevel;
    btnFeatureA: TButton;
    btnFeatureB: TButton;
    rb1: TRadioButton;
    rb2: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure btnTrackEventValueClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnCustomDataClick(Sender: TObject);
    procedure btnCustomDataRClick(Sender: TObject);
    procedure btnEventStopClick(Sender: TObject);
    procedure btnEventStartClick(Sender: TObject);
    procedure btnSetProxyClick(Sender: TObject);
    procedure btnCheckVersionClick(Sender: TObject);
    procedure btnTrackWindowClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTrackEventClick(Sender: TObject);
    procedure btnEventCancelClick(Sender: TObject);
    procedure btnFeatureAClick(Sender: TObject);
    procedure btnFeatureBClick(Sender: TObject);
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
  DeskMetrics_Dynamic, { Component Unit }
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

procedure Tfrm_Main.btnEventCancelClick(Sender: TObject);
begin
  // Cancels a timed event
  DeskMetricsTrackEventCancel('EventX', 'Sum');

  btnEventStart.Enabled  := True;
  btnEventStop.Enabled   := False;
  btnEventCancel.Enabled := False;
end;

procedure Tfrm_Main.btnEventStartClick(Sender: TObject);
begin  // Starts a timed event
  DeskMetricsTrackEventStart('EventX', 'Sum');

  btnEventStart.Enabled  := False;
  btnEventStop.Enabled   := True;
  btnEventCancel.Enabled := True;
end;

procedure Tfrm_Main.btnEventStopClick(Sender: TObject);
begin
  // Stops a timed event
  DeskMetricsTrackEventStop('EventX', 'Sum');

  btnEventStart.Enabled  := True;
  btnEventStop.Enabled   := False;
  btnEventCancel.Enabled := False;
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

procedure Tfrm_Main.btnCheckVersionClick(Sender: TObject);
var
  VersionChecked: Boolean;
  MyNewVersion: TVersionData;
begin
  Screen.Cursor := crHourGlass;
  try
    // Check if there is a new versions of this application
    VersionChecked := DeskMetricsCheckVersion(MyNewVersion);
  finally
    Screen.Cursor := crDefault;
  end;

  // Has received a response from the server?
  if VersionChecked then
  begin
    // Is there a new version available?
    if (MyNewVersion.Version <> '') then
    begin
      ShowMessage('New version available: ' + string(MyNewVersion.Version));
      ShowMessage('Release Date: '          + string(MyNewVersion.ReleaseDate));
      ShowMessage('Download URL: '          + string(MyNewVersion.DownloadURL));
      ShowMessage('Release Note: '          + string(MyNewVersion.ReleaseNote));
    end
    else
      // You're already using the latest version
      ShowMessage('Version up-to-date.');
  end
  else
    // An error occurred
    ShowMessage('Sorry! Check your internet connection and try again.');
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

procedure Tfrm_Main.btnTrackEventClick(Sender: TObject);
begin
  // Tracks a button click
  DeskMetricsTrackEvent('Buttons','MyButton');
end;

procedure Tfrm_Main.btnTrackWindowClick(Sender: TObject);
begin
  // Show a window
  frmAnother.ShowModal;
end;

procedure Tfrm_Main.btnFeatureAClick(Sender: TObject);
begin
  // Tracks a feature
  // IMPORTANT! The event category must to be "Feature"
  DeskMetricsTrackEvent('Feature','Feature A');
end;

procedure Tfrm_Main.btnFeatureBClick(Sender: TObject);
begin
  // Tracks a feature
  // IMPORTANT! The event category must to be "Window"
  DeskMetricsTrackEvent('Feature','Feature B');
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
  begin
    lblComponentName.Caption    := DeskMetricsGetComponentName;
    lblComponentVersion.Caption := 'Component Version: ' + DeskMetricsGetComponentVersion;
  end
  else
    lblComponentName.Caption    := 'DLL Not Found';
end;

end.