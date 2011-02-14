// **********************************************************//
//                                                           //
//     DeskMetrics C/C++ DLL Reference                       //
//     Copyright (c) 2010-2011                                //
//														     //
//     http://deskmetrics.com                                //
//	   support@deskmetrics.com								 //
//															 //
//     The entire contents of this file is protected by      //
//     International Copyright Laws. Unauthorized            //
//     reproduction, reverse-engineering, and distribution   //
//     of all or any portion of the code contained in this   //
//     file is strictly prohibited and may result in severe  //
//     civil and criminal penalties and will be prosecuted   //
//     to the maximum extent possible under the law.         //
//                                                           //
// **********************************************************//

#include "stdafx.h"
#include "DeskMetrics.h"
#include "windows.h"

HINSTANCE hinstLib;

bool DeskMetricsLoadLibrary ()
{
	if (hinstLib != NULL) {
		return 1;
	}
	else
	{
		hinstLib = LoadLibrary(TEXT("DeskMetrics.dll"));
		if (hinstLib != NULL) {
			return 1;
		}
	}
}

void DeskMetricsUnloadLibrary ()
{
	FreeLibrary(hinstLib);
}

bool DeskMetricsStart (LPCWSTR FApplicationID, LPCWSTR FApplicationVersion, bool FRealTime)
{	
	try
	{
		if (DeskMetricsLoadLibrary())
		{
			_DeskMetricsStart dskmtsStart;

			dskmtsStart = (_DeskMetricsStart)GetProcAddress(hinstLib, "DeskMetricsStart");
			if (dskmtsStart == NULL) {
				return false;
			}
			dskmtsStart(FApplicationID, FApplicationVersion, FRealTime);
		}
	}
	catch (...) {}
}

bool DeskMetricsStartA (LPCTSTR FApplicationID, LPCTSTR FApplicationVersion, bool FRealTime)
{	
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsStart dskmtsStart;

		dskmtsStart = (_DeskMetricsStart)GetProcAddress(hinstLib, "DeskMetricsStartA");
		if (dskmtsStart == NULL) {
			return false;
		}

		dskmtsStart(FApplicationID, FApplicationVersion, FRealTime);
	}
}

bool DeskMetricsStop () 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsStop dskmtsStop;

		dskmtsStop = (_DeskMetricsStop)GetProcAddress(hinstLib, "DeskMetricsStop");
		if (dskmtsStop == NULL) {
			return false;
		}

		dskmtsStop();
	}
}

bool DeskMetricsCheckVersion (TVERSIONDATA* FVersionData)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsCheckVersion dskmtsCheckVersion;

		dskmtsCheckVersion = (_DeskMetricsCheckVersion)GetProcAddress(hinstLib, "DeskMetricsCheckVersion");
		if (dskmtsCheckVersion == NULL) {
			return false;
		}

		return dskmtsCheckVersion(FVersionData);
	}
}

void DeskMetricsTrackEvent(LPCWSTR FEventCategory, LPCWSTR FEventName)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEvent dskmtsTrackEvent;

		dskmtsTrackEvent = (_DeskMetricsTrackEvent)GetProcAddress(hinstLib, "DeskMetricsTrackEvent");
		if (dskmtsTrackEvent == NULL) {
			return;
		}

		dskmtsTrackEvent(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventA(LPCTSTR FEventCategory, LPCTSTR FEventName)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEvent dskmtsTrackEvent;

		dskmtsTrackEvent = (_DeskMetricsTrackEvent)GetProcAddress(hinstLib, "DeskMetricsTrackEventA");
		if (dskmtsTrackEvent == NULL) {
			return;
		}

		dskmtsTrackEvent(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventValue(LPCWSTR FEventCategory, LPCWSTR FEventName, LPCWSTR FEventValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventValue dskmtsTrackEventValue;

		dskmtsTrackEventValue = (_DeskMetricsTrackEventValue)GetProcAddress(hinstLib, "DeskMetricsTrackEventValue");
		if (dskmtsTrackEventValue == NULL) {
			return;
		}

		dskmtsTrackEventValue(FEventCategory, FEventName, FEventValue);
	}
}

void DeskMetricsTrackEventValueA(LPCTSTR FEventCategory, LPCTSTR FEventName, LPCTSTR FEventValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventValue dskmtsTrackEventValue;

		dskmtsTrackEventValue = (_DeskMetricsTrackEventValue)GetProcAddress(hinstLib, "DeskMetricsTrackEventValueA");
		if (dskmtsTrackEventValue == NULL) {
			return;
		}

		dskmtsTrackEventValue(FEventCategory, FEventName, FEventValue);
	}
}

void DeskMetricsTrackEventStart(LPCWSTR FEventCategory, LPCWSTR FEventName) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventStart dskmtsTrackEventStart;

		dskmtsTrackEventStart = (_DeskMetricsTrackEventStart)GetProcAddress(hinstLib, "DeskMetricsTrackEventStart");
		if (dskmtsTrackEventStart == NULL) {
			return;
		}

		dskmtsTrackEventStart(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventStartA(LPCTSTR FEventCategory, LPCTSTR FEventName) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventStart dskmtsTrackEventStart;

		dskmtsTrackEventStart = (_DeskMetricsTrackEventStart)GetProcAddress(hinstLib, "DeskMetricsTrackEventStartA");
		if (dskmtsTrackEventStart == NULL) {
			return;
		}

		dskmtsTrackEventStart(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventStop(LPCWSTR FEventCategory, LPCWSTR FEventName) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventStop dskmtsTrackEventStop;

		dskmtsTrackEventStop = (_DeskMetricsTrackEventStop)GetProcAddress(hinstLib, "DeskMetricsTrackEventStop");
		if (dskmtsTrackEventStop == NULL) {
			return;
		}

		dskmtsTrackEventStop(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventStopA(LPCTSTR FEventCategory, LPCTSTR FEventName) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventStop dskmtsTrackEventStop;

		dskmtsTrackEventStop = (_DeskMetricsTrackEventStop)GetProcAddress(hinstLib, "DeskMetricsTrackEventStopA");
		if (dskmtsTrackEventStop == NULL) {
			return;
		}

		dskmtsTrackEventStop(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventCancel(LPCWSTR FEventCategory, LPCWSTR FEventName) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventCancel dskmtsTrackEventCancel;

		dskmtsTrackEventCancel = (_DeskMetricsTrackEventCancel)GetProcAddress(hinstLib, "DeskMetricsTrackEventCancel");
		if (dskmtsTrackEventCancel == NULL) {
			return;
		}

		dskmtsTrackEventCancel(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventCancelA(LPCTSTR FEventCategory, LPCTSTR FEventName) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventCancel dskmtsTrackEventCancel;

		dskmtsTrackEventCancel = (_DeskMetricsTrackEventCancel)GetProcAddress(hinstLib, "DeskMetricsTrackEventCancelA");
		if (dskmtsTrackEventCancel == NULL) {
			return;
		}

		dskmtsTrackEventCancel(FEventCategory, FEventName);
	}
}

void DeskMetricsTrackEventPeriod(LPCWSTR FEventCategory, LPCWSTR FEventName, int FEventTime) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventPeriod dskmtsTrackEventPeriod;

		dskmtsTrackEventPeriod = (_DeskMetricsTrackEventPeriod)GetProcAddress(hinstLib, "DeskMetricsTrackEventPeriod");
		if (dskmtsTrackEventPeriod == NULL) {
			return;
		}

		dskmtsTrackEventPeriod(FEventCategory, FEventName, FEventTime);
	}
}


void DeskMetricsTrackEventPeriodA(LPCTSTR FEventCategory, LPCTSTR FEventName, int FEventTime) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventPeriodA dskmtsTrackEventPeriodA;

		dskmtsTrackEventPeriodA = (_DeskMetricsTrackEventPeriodA)GetProcAddress(hinstLib, "DeskMetricsTrackEventPeriodA");
		if (dskmtsTrackEventPeriodA == NULL) {
			return;
		}

		dskmtsTrackEventPeriodA(FEventCategory, FEventName, FEventTime);
	}
}


void DeskMetricsTrackLog(LPCWSTR FMessage)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackLog dskmtsTrackLog;

		dskmtsTrackLog = (_DeskMetricsTrackLog)GetProcAddress(hinstLib, "DeskMetricsTrackLog");
		if (dskmtsTrackLog == NULL) {
			return;
		}

		dskmtsTrackLog(FMessage);
	}
}	

void DeskMetricsTrackLogA(LPCTSTR FMessage)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackLog dskmtsTrackLog;

		dskmtsTrackLog = (_DeskMetricsTrackLog)GetProcAddress(hinstLib, "DeskMetricsTrackLogA");
		if (dskmtsTrackLog == NULL) {
			return;
		}

		dskmtsTrackLog(FMessage);
	}
}	

void DeskMetricsTrackCustomData(LPCWSTR FName, LPCWSTR FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackCustomData dskmtsTrackCustomData;

		dskmtsTrackCustomData = (_DeskMetricsTrackCustomData)GetProcAddress(hinstLib, "DeskMetricsTrackCustomData");
		if (dskmtsTrackCustomData == NULL) {
			return;
		}

		dskmtsTrackCustomData(FName, FValue);
	}
}

void DeskMetricsTrackCustomDataA(LPCTSTR FName, LPCTSTR FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackCustomData dskmtsTrackCustomData;

		dskmtsTrackCustomData = (_DeskMetricsTrackCustomData)GetProcAddress(hinstLib, "DeskMetricsTrackCustomDataA");
		if (dskmtsTrackCustomData == NULL) {
			return;
		}

		dskmtsTrackCustomData(FName, FValue);
	}
}

int DeskMetricsTrackCustomDataR(LPCWSTR FApplicationID, LPCWSTR FAppVersion, LPCWSTR FName, LPCWSTR FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackCustomDataR dskmtsTrackCustomDataR;

		dskmtsTrackCustomDataR = (_DeskMetricsTrackCustomDataR)GetProcAddress(hinstLib, "DeskMetricsTrackCustomDataR");
		if (dskmtsTrackCustomDataR == NULL) {
			return -1;
		}

		return dskmtsTrackCustomDataR(FApplicationID, FAppVersion, FName, FValue);
	}
}

int DeskMetricsTrackCustomDataRA(LPCTSTR FApplicationID, LPCTSTR FAppVersion, LPCTSTR FName, LPCTSTR FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackCustomDataR dskmtsTrackCustomDataR;

		dskmtsTrackCustomDataR = (_DeskMetricsTrackCustomDataR)GetProcAddress(hinstLib, "DeskMetricsTrackCustomDataRA");
		if (dskmtsTrackCustomDataR == NULL) {
			return -1;
		}

		return dskmtsTrackCustomDataR(FApplicationID, FAppVersion, FName, FValue);
	}
}

//void DeskMetricsTrackException(LPCWSTR FExceptionMessage, LPCWSTR FExceptionType)
//{
//	if (DeskMetricsLoadLibrary())
//	{
//		_DeskMetricsTrackException dskmtsTrackException;
//
//		dskmtsTrackException = (_DeskMetricsTrackException)GetProcAddress(hinstLib, "DeskMetricsTrackException");
//		if (dskmtsTrackException == NULL) {
//			return;
//		}
//
//		dskmtsTrackException(FExceptionMessage, FExceptionType);
//	}
//}

int DeskMetricsTrackInstallation(LPCWSTR FApplicationID, LPCWSTR FAppVersion, bool FTestMode)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackInstallationA dskmtsTrackInstallationA;

		dskmtsTrackInstallationA = (_DeskMetricsTrackInstallationA)GetProcAddress(hinstLib, "DeskMetricsTrackInstallation");
		if (dskmtsTrackInstallationA == NULL) {
			return -1;
		}

		return dskmtsTrackInstallationA(FApplicationID, FAppVersion, FTestMode);
	}
}

int DeskMetricsTrackInstallationA(LPCTSTR FApplicationID, LPCTSTR FAppVersion)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackInstallationA dskmtsTrackInstallationA;

		dskmtsTrackInstallationA = (_DeskMetricsTrackInstallationA)GetProcAddress(hinstLib, "DeskMetricsTrackInstallationA");
		if (dskmtsTrackInstallationA == NULL) {
			return -1;
		}

		return dskmtsTrackInstallationA(FApplicationID, FAppVersion);
	}
}

int DeskMetricsTrackUninstallation(LPCWSTR FApplicationID, LPCWSTR FAppVersion)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackUninstallationA dskmtsTrackUninstallationA;

		dskmtsTrackUninstallationA = (_DeskMetricsTrackUninstallationA)GetProcAddress(hinstLib, "DeskMetricsTrackUninstallation");
		if (dskmtsTrackUninstallationA == NULL) {
			return -1;
		}

		return dskmtsTrackUninstallationA(FApplicationID, FAppVersion);
	}
}

int DeskMetricsTrackUninstallationA(LPCTSTR FApplicationID, LPCTSTR FAppVersion)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackUninstallationA dskmtsTrackUninstallationA;

		dskmtsTrackUninstallationA = (_DeskMetricsTrackUninstallationA)GetProcAddress(hinstLib, "DeskMetricsTrackUninstallationA");
		if (dskmtsTrackUninstallationA == NULL) {
			return -1;
		}

		return dskmtsTrackUninstallationA(FApplicationID, FAppVersion);
	}
}

bool DeskMetricsSetProxy (LPCWSTR FHostIP, int FPort, LPCWSTR FUserName, LPCWSTR FPassword)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetProxy dskmtsSetProxy;

		dskmtsSetProxy = (_DeskMetricsSetProxy)GetProcAddress(hinstLib, "DeskMetricsSetProxy");
		if (dskmtsSetProxy == NULL) {
			return 0;
		}

		return dskmtsSetProxy(FHostIP, FPort, FUserName, FPassword);
	}
}

bool DeskMetricsSetProxyA (LPCTSTR FHostIP, int FPort, LPCTSTR FUserName, LPCTSTR FPassword)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetProxy dskmtsSetProxy;

		dskmtsSetProxy = (_DeskMetricsSetProxy)GetProcAddress(hinstLib, "DeskMetricsSetProxyA");
		if (dskmtsSetProxy == NULL) {
			return 0;
		}

		return dskmtsSetProxy(FHostIP, FPort, FUserName, FPassword);
	}
}

bool DeskMetricsGetProxy (LPCWSTR FHostIP, int FPort)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetProxy dskmtsGetProxy;

		dskmtsGetProxy = (_DeskMetricsGetProxy)GetProcAddress(hinstLib, "DeskMetricsGetProxy");
		if (dskmtsGetProxy == NULL) {
			return 0;
		}

		return dskmtsGetProxy(FHostIP, FPort);
	}
}

bool DeskMetricsGetProxyA (LPCTSTR FHostIP, int FPort)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetProxy dskmtsGetProxy;

		dskmtsGetProxy = (_DeskMetricsGetProxy)GetProcAddress(hinstLib, "DeskMetricsGetProxyA");
		if (dskmtsGetProxy == NULL) {
			return 0;
		}

		return dskmtsGetProxy(FHostIP, FPort);
	}
}

bool DeskMetricsSetUserID (LPCWSTR FID)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetUserID dskmtsSetUserID;

		dskmtsSetUserID = (_DeskMetricsSetUserID)GetProcAddress(hinstLib, "DeskMetricsSetUserID");
		if (dskmtsSetUserID == NULL) {
			return 0;
		}

		return dskmtsSetUserID(FID);
	}
}

bool DeskMetricsSetUserIDA (LPCTSTR FID)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetUserID dskmtsSetUserID;

		dskmtsSetUserID = (_DeskMetricsSetUserID)GetProcAddress(hinstLib, "DeskMetricsSetUserIDA");
		if (dskmtsSetUserID == NULL) {
			return 0;
		}

		return dskmtsSetUserID(FID);
	}
}

LPCWSTR DeskMetricsGetComponentName ()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetComponentName dskmtsGetComponentName;

		dskmtsGetComponentName = (_DeskMetricsGetComponentName)GetProcAddress(hinstLib, "DeskMetricsGetComponentName");
		if (dskmtsGetComponentName == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetComponentName());
	}
}

LPCTSTR DeskMetricsGetComponentNameA ()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetComponentName dskmtsGetComponentName;

		dskmtsGetComponentName = (_DeskMetricsGetComponentName)GetProcAddress(hinstLib, "DeskMetricsGetComponentNameA");
		if (dskmtsGetComponentName == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetComponentName());
	}
}

LPCWSTR DeskMetricsGetComponentVersion ()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetComponentVersion dskmtsGetComponentVersion;

		dskmtsGetComponentVersion = (_DeskMetricsGetComponentVersion)GetProcAddress(hinstLib, "DeskMetricsGetComponentVersion");
		if (dskmtsGetComponentVersion == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetComponentVersion());
	}
}

LPCTSTR DeskMetricsGetComponentVersionA ()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetComponentVersion dskmtsGetComponentVersion;

		dskmtsGetComponentVersion = (_DeskMetricsGetComponentVersion)GetProcAddress(hinstLib, "DeskMetricsGetComponentVersionA");
		if (dskmtsGetComponentVersion == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetComponentVersion());
	}
}

LPCWSTR DeskMetricsGetPostServer ()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetPostServer dskmtsGetPostServer;

		dskmtsGetPostServer = (_DeskMetricsGetPostServer)GetProcAddress(hinstLib, "DeskMetricsGetPostServer");
		if (dskmtsGetPostServer == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetPostServer());
	}
}

LPCTSTR DeskMetricsGetPostServerA ()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetPostServer dskmtsGetPostServer;

		dskmtsGetPostServer = (_DeskMetricsGetPostServer)GetProcAddress(hinstLib, "DeskMetricsGetPostServerA");
		if (dskmtsGetPostServer == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetPostServer());
	}
}

bool DeskMetricsSetPostServer(LPCWSTR FServer)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostServer dskmtsSetPostServer;

		dskmtsSetPostServer = (_DeskMetricsSetPostServer)GetProcAddress(hinstLib, "DeskMetricsSetPostServer");
		if (dskmtsSetPostServer == NULL) {
			return 0;
		}

		return dskmtsSetPostServer(FServer);
	}
}

bool DeskMetricsSetPostServerA(LPCTSTR FServer)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostServer dskmtsSetPostServer;

		dskmtsSetPostServer = (_DeskMetricsSetPostServer)GetProcAddress(hinstLib, "DeskMetricsSetPostServerA");
		if (dskmtsSetPostServer == NULL) {
			return 0;
		}

		return dskmtsSetPostServer(FServer);
	}
}

int DeskMetricsGetPostPort()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetPostPort dskmtsGetPostPort;

		dskmtsGetPostPort = (_DeskMetricsGetPostPort)GetProcAddress(hinstLib, "DeskMetricsGetPostPort");
		if (dskmtsGetPostPort == NULL) {
			return -1;
		}

		return dskmtsGetPostPort();
	}
}

bool DeskMetricsSetPostPort(int FPort)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostPort dskmtsSetPostPort;

		dskmtsSetPostPort = (_DeskMetricsSetPostPort)GetProcAddress(hinstLib, "DeskMetricsSetPostPort");
		if (dskmtsSetPostPort == NULL) {
			return 0;
		}

		return dskmtsSetPostPort(FPort);
	}
}

int DeskMetricsGetPostTimeOut()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetPostTimeOut dskmtsGetPostTimeOut;

		dskmtsGetPostTimeOut = (_DeskMetricsGetPostTimeOut)GetProcAddress(hinstLib, "DeskMetricsGetPostTimeOut");
		if (dskmtsGetPostTimeOut == NULL) {
			return -1;
		}

		return dskmtsGetPostTimeOut();
	}
}

bool DeskMetricsSetPostTimeOut(int FTimeOut)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostTimeOut dskmtsSetPostTimeOut;

		dskmtsSetPostTimeOut = (_DeskMetricsSetPostTimeOut)GetProcAddress(hinstLib, "DeskMetricsSetPostTimeOut");
		if (dskmtsSetPostTimeOut == NULL) {
			return 0;
		}

		return dskmtsSetPostTimeOut(FTimeOut);
	}
}

bool DeskMetricsGetPostWaitResponse()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetPostWaitResponse dskmtsGetPostWaitResponse;

		dskmtsGetPostWaitResponse = (_DeskMetricsGetPostWaitResponse)GetProcAddress(hinstLib, "DeskMetricsGetPostWaitResponse");
		if (dskmtsGetPostWaitResponse == NULL) {
			return 0;
		}

		return dskmtsGetPostWaitResponse();
	}
}

bool DeskMetricsSetPostWaitResponse(bool FEnabled)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostWaitResponse dskmtsSetPostWaitResponse;

		dskmtsSetPostWaitResponse = (_DeskMetricsSetPostWaitResponse)GetProcAddress(hinstLib, "DeskMetricsSetPostWaitResponse");
		if (dskmtsSetPostWaitResponse == NULL) {
			return 0;
		}

		return dskmtsSetPostWaitResponse(FEnabled);
	}
}

bool DeskMetricsSetEnabled(bool FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetEnabled dskmtsSetEnabled;

		dskmtsSetEnabled = (_DeskMetricsSetEnabled)GetProcAddress(hinstLib, "DeskMetricsSetEnabled");
		if (dskmtsSetEnabled == NULL) {
			return 0;
		}

		return dskmtsSetEnabled(FValue);
	}
}

bool DeskMetricsGetEnabled()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetEnabled dskmtsGetEnabled;

		dskmtsGetEnabled = (_DeskMetricsGetEnabled)GetProcAddress(hinstLib, "DeskMetricsGetEnabled");
		if (dskmtsGetEnabled == NULL) {
			return 0;
		}

		return dskmtsGetEnabled();
	}
}

bool DeskMetricsSetDebugMode(bool FEnabled)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetDebugMode dskmtsSetDebugMode;

		dskmtsSetDebugMode = (_DeskMetricsSetDebugMode)GetProcAddress(hinstLib, "DeskMetricsSetDebugMode");
		if (dskmtsSetDebugMode == NULL) {
			return 0;
		}

		return dskmtsSetDebugMode(FEnabled);
	}
}

bool DeskMetricsGetDebugMode()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetDebugMode dskmtsGetDebugMode;

		dskmtsGetDebugMode = (_DeskMetricsGetDebugMode)GetProcAddress(hinstLib, "DeskMetricsGetDebugMode");
		if (dskmtsGetDebugMode == NULL) {
			return 0;
		}

		return dskmtsGetDebugMode();
	}
}


LPCWSTR DeskMetricsGetJSON()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetJSON dskmtsGetJSON;

		dskmtsGetJSON = (_DeskMetricsGetJSON)GetProcAddress(hinstLib, "DeskMetricsGetJSON");
		if (dskmtsGetJSON == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetJSON());
	}
}

LPCTSTR DeskMetricsGetJSONA()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetJSON dskmtsGetJSON;

		dskmtsGetJSON = (_DeskMetricsGetJSON)GetProcAddress(hinstLib, "DeskMetricsGetJSONA");
		if (dskmtsGetJSON == NULL) {
			return LPCWSTR("");
		}

		return LPCWSTR(dskmtsGetJSON());
	}
}

int DeskMetricsGetDailyNetworkUtilizationInKB()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetDailyNetworkUtilizationInKB dskmtsGetDailyNetworkUtilizationInKB;

		dskmtsGetDailyNetworkUtilizationInKB = (_DeskMetricsGetDailyNetworkUtilizationInKB)GetProcAddress(hinstLib, "DeskMetricsGetDailyNetworkUtilizationInKB");
		if (dskmtsGetDailyNetworkUtilizationInKB == NULL) {
			return -1;
		}

		return dskmtsGetDailyNetworkUtilizationInKB();
	}
}

bool DeskMetricsSetDailyNetworkUtilizationInKB(int FDataSize)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetDailyNetworkUtilizationInKB dskmtsSetDailyNetworkUtilizationInKB;

		dskmtsSetDailyNetworkUtilizationInKB = (_DeskMetricsSetDailyNetworkUtilizationInKB)GetProcAddress(hinstLib, "DeskMetricsSetDailyNetworkUtilizationInKB");
		if (dskmtsSetDailyNetworkUtilizationInKB == NULL) {
			return 0;
		}

		return dskmtsSetDailyNetworkUtilizationInKB(FDataSize);
	}
}

int DeskMetricsGetMaxStorageSizeInKB()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetMaxStorageSizeInKB dskmtsGetMaxStorageSizeInKB;

		dskmtsGetMaxStorageSizeInKB = (_DeskMetricsGetMaxStorageSizeInKB)GetProcAddress(hinstLib, "DeskMetricsGetMaxStorageSizeInKB");
		if (dskmtsGetMaxStorageSizeInKB == NULL) {
			return -1;
		}

		return dskmtsGetMaxStorageSizeInKB();
	}
}

bool DeskMetricsSetMaxStorageSizeInKB(int FDataSize)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetMaxStorageSizeInKB dskmtsSetMaxStorageSizeInKB;

		dskmtsSetMaxStorageSizeInKB = (_DeskMetricsSetMaxStorageSizeInKB)GetProcAddress(hinstLib, "DeskMetricsSetMaxStorageSizeInKB");
		if (dskmtsSetMaxStorageSizeInKB == NULL) {
			return 0;
		}

		return dskmtsSetMaxStorageSizeInKB(FDataSize);
	}
}

bool DeskMetricsSendData()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSendData dskmtsSendData;

		dskmtsSendData = (_DeskMetricsSendData)GetProcAddress(hinstLib, "DeskMetricsSendData");
		if (dskmtsSendData == NULL) {
			return false;
		}

		return dskmtsSendData();
	}
}
