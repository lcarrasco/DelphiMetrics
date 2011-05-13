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
	try
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
	catch (...) {}
	return 0;
}

void DeskMetricsUnloadLibrary ()
{
	FreeLibrary(hinstLib);
}

bool DeskMetricsStart (LPCWSTR FApplicationID, LPCWSTR FApplicationVersion)
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
			dskmtsStart(FApplicationID, FApplicationVersion);
			return true;
		}
	}
	catch (...) {}
	return 0;
}

bool DeskMetricsStartA (LPCTSTR FApplicationID, LPCTSTR FApplicationVersion)
{	
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsStart dskmtsStart;

		dskmtsStart = (_DeskMetricsStart)GetProcAddress(hinstLib, "DeskMetricsStartA");
		if (dskmtsStart == NULL) {
			return false;
		}

		dskmtsStart(FApplicationID, FApplicationVersion);
		return true;
	}
	return false;
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
		return true;
	}
	return false;
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

void DeskMetricsTrackEventPeriod(LPCWSTR FEventCategory, LPCWSTR FEventName, int FEventTime, bool FEventCompleted) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventPeriod dskmtsTrackEventPeriod;

		dskmtsTrackEventPeriod = (_DeskMetricsTrackEventPeriod)GetProcAddress(hinstLib, "DeskMetricsTrackEventPeriod");
		if (dskmtsTrackEventPeriod == NULL) {
			return;
		}

		dskmtsTrackEventPeriod(FEventCategory, FEventName, FEventTime, FEventCompleted);
	}
}


void DeskMetricsTrackEventPeriodA(LPCTSTR FEventCategory, LPCTSTR FEventName, int FEventTime, bool FEventCompleted) 
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackEventPeriodA dskmtsTrackEventPeriodA;

		dskmtsTrackEventPeriodA = (_DeskMetricsTrackEventPeriodA)GetProcAddress(hinstLib, "DeskMetricsTrackEventPeriodA");
		if (dskmtsTrackEventPeriodA == NULL) {
			return;
		}

		dskmtsTrackEventPeriodA(FEventCategory, FEventName, FEventTime, FEventCompleted);
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

int DeskMetricsTrackCustomDataR(LPCWSTR FName, LPCWSTR FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackCustomDataR dskmtsTrackCustomDataR;

		dskmtsTrackCustomDataR = (_DeskMetricsTrackCustomDataR)GetProcAddress(hinstLib, "DeskMetricsTrackCustomDataR");
		if (dskmtsTrackCustomDataR == NULL) {
			return -1;
		}

		return dskmtsTrackCustomDataR(FName, FValue);
	}
	return -1;
}

int DeskMetricsTrackCustomDataRA(LPCTSTR FName, LPCTSTR FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsTrackCustomDataR dskmtsTrackCustomDataR;

		dskmtsTrackCustomDataR = (_DeskMetricsTrackCustomDataR)GetProcAddress(hinstLib, "DeskMetricsTrackCustomDataRA");
		if (dskmtsTrackCustomDataR == NULL) {
			return -1;
		}

		return dskmtsTrackCustomDataR(FName, FValue);
	}
	return -1;
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

bool DeskMetricsSetProxy (LPCWSTR FHostIP, int FPort, LPCWSTR FUserName, LPCWSTR FPassword)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetProxy dskmtsSetProxy;

		dskmtsSetProxy = (_DeskMetricsSetProxy)GetProcAddress(hinstLib, "DeskMetricsSetProxy");
		if (dskmtsSetProxy == NULL) {
			return false;
		}

		return dskmtsSetProxy(FHostIP, FPort, FUserName, FPassword);
	}
	return false;
}

bool DeskMetricsSetProxyA (LPCTSTR FHostIP, int FPort, LPCTSTR FUserName, LPCTSTR FPassword)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetProxy dskmtsSetProxy;

		dskmtsSetProxy = (_DeskMetricsSetProxy)GetProcAddress(hinstLib, "DeskMetricsSetProxyA");
		if (dskmtsSetProxy == NULL) {
			return false;
		}

		return dskmtsSetProxy(FHostIP, FPort, FUserName, FPassword);
	}
	return false;
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
	return false;
}

bool DeskMetricsGetProxyA (LPCTSTR FHostIP, int FPort)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetProxy dskmtsGetProxy;

		dskmtsGetProxy = (_DeskMetricsGetProxy)GetProcAddress(hinstLib, "DeskMetricsGetProxyA");
		if (dskmtsGetProxy == NULL) {
			return false;
		}

		return dskmtsGetProxy(FHostIP, FPort);
	}
	return false;
}

bool DeskMetricsSetUserID (LPCWSTR FID)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetUserID dskmtsSetUserID;

		dskmtsSetUserID = (_DeskMetricsSetUserID)GetProcAddress(hinstLib, "DeskMetricsSetUserID");
		if (dskmtsSetUserID == NULL) {
			return false;
		}

		return dskmtsSetUserID(FID);
	}
	return false;
}

bool DeskMetricsSetUserIDA (LPCTSTR FID)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetUserID dskmtsSetUserID;

		dskmtsSetUserID = (_DeskMetricsSetUserID)GetProcAddress(hinstLib, "DeskMetricsSetUserIDA");
		if (dskmtsSetUserID == NULL) {
			return false;
		}

		return dskmtsSetUserID(FID);
	}
	return false;
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
	return LPCWSTR("");
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
	return LPCWSTR("");
}

bool DeskMetricsSetPostServer(LPCWSTR FServer)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostServer dskmtsSetPostServer;

		dskmtsSetPostServer = (_DeskMetricsSetPostServer)GetProcAddress(hinstLib, "DeskMetricsSetPostServer");
		if (dskmtsSetPostServer == NULL) {
			return false;
		}
		return dskmtsSetPostServer(FServer);
	}
	return false;
}

bool DeskMetricsSetPostServerA(LPCTSTR FServer)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostServer dskmtsSetPostServer;

		dskmtsSetPostServer = (_DeskMetricsSetPostServer)GetProcAddress(hinstLib, "DeskMetricsSetPostServerA");
		if (dskmtsSetPostServer == NULL) {
			return false;
		}

		return dskmtsSetPostServer(FServer);
	}
	return false;
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
	return -1;
}

bool DeskMetricsSetPostPort(int FPort)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostPort dskmtsSetPostPort;

		dskmtsSetPostPort = (_DeskMetricsSetPostPort)GetProcAddress(hinstLib, "DeskMetricsSetPostPort");
		if (dskmtsSetPostPort == NULL) {
			return false;
		}

		return dskmtsSetPostPort(FPort);
	}
	return false;
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
	return -1;
}

bool DeskMetricsSetPostTimeOut(int FTimeOut)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostTimeOut dskmtsSetPostTimeOut;

		dskmtsSetPostTimeOut = (_DeskMetricsSetPostTimeOut)GetProcAddress(hinstLib, "DeskMetricsSetPostTimeOut");
		if (dskmtsSetPostTimeOut == NULL) {
			return false;
		}

		return dskmtsSetPostTimeOut(FTimeOut);
	}
	return false;
}

bool DeskMetricsGetPostWaitResponse()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetPostWaitResponse dskmtsGetPostWaitResponse;

		dskmtsGetPostWaitResponse = (_DeskMetricsGetPostWaitResponse)GetProcAddress(hinstLib, "DeskMetricsGetPostWaitResponse");
		if (dskmtsGetPostWaitResponse == NULL) {
			return false;
		}

		return dskmtsGetPostWaitResponse();
	}
	return false;
}

bool DeskMetricsSetPostWaitResponse(bool FEnabled)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetPostWaitResponse dskmtsSetPostWaitResponse;

		dskmtsSetPostWaitResponse = (_DeskMetricsSetPostWaitResponse)GetProcAddress(hinstLib, "DeskMetricsSetPostWaitResponse");
		if (dskmtsSetPostWaitResponse == NULL) {
			return false;
		}

		return dskmtsSetPostWaitResponse(FEnabled);
	}
	return false;
}

bool DeskMetricsSetEnabled(bool FValue)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetEnabled dskmtsSetEnabled;

		dskmtsSetEnabled = (_DeskMetricsSetEnabled)GetProcAddress(hinstLib, "DeskMetricsSetEnabled");
		if (dskmtsSetEnabled == NULL) {
			return false;
		}

		return dskmtsSetEnabled(FValue);
	}
	return false;
}

bool DeskMetricsGetEnabled()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetEnabled dskmtsGetEnabled;

		dskmtsGetEnabled = (_DeskMetricsGetEnabled)GetProcAddress(hinstLib, "DeskMetricsGetEnabled");
		if (dskmtsGetEnabled == NULL) {
			return false;
		}

		return dskmtsGetEnabled();
	}
	return false;
}

bool DeskMetricsSetDebugMode(bool FEnabled)
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsSetDebugMode dskmtsSetDebugMode;

		dskmtsSetDebugMode = (_DeskMetricsSetDebugMode)GetProcAddress(hinstLib, "DeskMetricsSetDebugMode");
		if (dskmtsSetDebugMode == NULL) {
			return false;
		}

		return dskmtsSetDebugMode(FEnabled);
	}
	return false;
}

bool DeskMetricsGetDebugMode()
{
	if (DeskMetricsLoadLibrary())
	{
		_DeskMetricsGetDebugMode dskmtsGetDebugMode;

		dskmtsGetDebugMode = (_DeskMetricsGetDebugMode)GetProcAddress(hinstLib, "DeskMetricsGetDebugMode");
		if (dskmtsGetDebugMode == NULL) {
			return false;
		}

		return dskmtsGetDebugMode();
	}
	return false;
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
	return LPCWSTR("");
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
	return LPCWSTR("");
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
	return false;
}

