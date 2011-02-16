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

unit frmCustomerExperience;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tfrm_CustomerExperience = class(TForm)
    lblTitle: TLabel;
    lblText: TLabel;
    rbYes: TRadioButton;
    rbNo: TRadioButton;
    btnOK: TButton;
    btnCancel: TButton;
    lblPrivacy: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_CustomerExperience: Tfrm_CustomerExperience;

implementation

uses
  DeskMetrics;

{$R *.dfm}

procedure Tfrm_CustomerExperience.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_CustomerExperience.btnOKClick(Sender: TObject);
begin
  if rbYes.Checked then
    DeskMetricsSetEnabled(True)
  else
    if rbNo.Checked then
      DeskMetricsSetEnabled(False);

  Close;
end;

end.
