{ **********************************************************}
{                                                           }
{     DeskMetrics - Application Example (Delphi)            }
{     Copyright (c) 2010-2011 DeskMetrics Limited           }
{                                                           }
{     http://deskmetrics.com                                }
{     support@deskmetrics.com                               }
{                                                           }
{ **********************************************************}

unit frmAnotherWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmAnother = class(TForm)
    btnQuit: TButton;
    procedure btnQuitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnother: TfrmAnother;

implementation

{$R *.dfm}

uses
  DeskMetrics_Static; { Component Unit }

procedure TfrmAnother.btnQuitClick(Sender: TObject);
begin
  // Tracks a button click
  DeskMetricsTrackEvent('AnotherWindow', 'QuitButton');

  // Close window
  Close;
end;

procedure TfrmAnother.FormShow(Sender: TObject);
begin
  // Tracks a window event
  // IMPORTANT! The event category must to be "Window"
  DeskMetricsTrackEvent('Window', 'AnotherWindow');
end;

end.
