{ **********************************************************}
{                                                           }
{     DeskMetrics - Application Example (Delphi)            }
{     Copyright (c) 2010-2011                               }
{                                                           }
{     http://deskmetrics.com                                }
{     support@deskmetrics.com                               }
{                                                           }
{     The entire contents of this file is protected by      }
{     International Copyright Laws. Unauthorized            }
{     reproduction, reverse-engineering, and distribution   }
{     of all or any portion of the code contained in this   }
{     file is strictly prohibited and may result in severe  }
{     civil and criminal penalties and will be prosecuted   }
{     to the maximum extent possible under the law.         }
{                                                           }
{ **********************************************************}

program AppExample;

uses
  Forms,
  frmMain in 'frmMain.pas' {frm_Main},
  frmCustomerExperience in 'frmCustomerExperience.pas' {frm_CustomerExperience};

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.CreateForm(Tfrm_CustomerExperience, frm_CustomerExperience);
  Application.Run;
end.
