// **********************************************************//
//                                                           //
//     DeskMetrics C/C++ DLL Header                          //
//     Copyright (c) 2010-2011                               //
//															 //
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

typedef bool (__stdcall *_DeskMetricsStart)(LPCWSTR FApplicationID, LPCWSTR FApplicationVersion);
typedef bool (__stdcall *_DeskMetricsStartA)(LPCTSTR FApplicationID, LPCTSTR FApplicationVersion);
typedef bool (__stdcall *_DeskMetricsStop)();

typedef bool (__stdcall *_DeskMetricsSendData)();

typedef void (__stdcall *_DeskMetricsTrackEvent)(LPCWSTR FEventCategory, LPCWSTR FEventName);
typedef void (__stdcall *_DeskMetricsTrackEventA)(LPCTSTR FEventCategory, LPCTSTR FEventName);

typedef void (__stdcall *_DeskMetricsTrackEventValue)(LPCWSTR FEventCategory, LPCWSTR FEventName, LPCWSTR FEventValue);
typedef void (__stdcall *_DeskMetricsTrackEventValueA)(LPCTSTR FEventCategory, LPCTSTR FEventName, LPCTSTR FEventValue);

typedef void (__stdcall *_DeskMetricsTrackEventPeriod)(LPCWSTR FEventCategory, LPCWSTR FEventName, int FEventTime, bool FEventCompleted);
typedef void (__stdcall *_DeskMetricsTrackEventPeriodA)(LPCTSTR FEventCategory, LPCTSTR FEventName, int FEventTime, bool FEventCompleted);

typedef void (__stdcall *_DeskMetricsTrackLog)(LPCWSTR FMessage);
typedef void (__stdcall *_DeskMetricsTrackLogA)(LPCTSTR FMessage);

typedef void (__stdcall *_DeskMetricsTrackCustomData)(LPCWSTR FName, LPCWSTR FValue);
typedef void (__stdcall *_DeskMetricsTrackCustomDataA)(LPCTSTR FName, LPCTSTR FValue);

typedef int (__stdcall *_DeskMetricsTrackCustomDataR)(LPCWSTR FName, LPCWSTR FValue); 
typedef int (__stdcall *_DeskMetricsTrackCustomDataRA)(LPCTSTR FName, LPCTSTR FValue); 

//typedef void (__stdcall *_DeskMetricsTrackException)(LPCWSTR FExceptionMessage, LPCWSTR FExceptionType);

typedef bool (__stdcall *_DeskMetricsSetProxy)(LPCWSTR FHostIP, int FPort, LPCWSTR FUserName, LPCWSTR FPassword);
typedef bool (__stdcall *_DeskMetricsSetProxyA)(LPCTSTR FHostIP, int FPort, LPCTSTR FUserName, LPCTSTR FPassword);

typedef bool (__stdcall *_DeskMetricsGetProxy)(LPCWSTR FHostIP, int FPort);
typedef bool (__stdcall *_DeskMetricsGetProxyA)(LPCTSTR FHostIP, int FPort);

typedef bool (__stdcall *_DeskMetricsSetUserID)(LPCWSTR FID);
typedef bool (__stdcall *_DeskMetricsSetUserIDA)(LPCTSTR FID);

typedef LPCWSTR (__stdcall *_DeskMetricsGetPostServer)();
typedef LPCTSTR (__stdcall *_DeskMetricsGetPostServerA)();

typedef bool (__stdcall *_DeskMetricsSetPostServer)(LPCWSTR FServer);
typedef bool (__stdcall *_DeskMetricsSetPostServerA)(LPCTSTR FServer);

typedef int (__stdcall *_DeskMetricsGetPostPort)();
typedef bool (__stdcall *_DeskMetricsSetPostPort)(int FPort);

typedef int (__stdcall *_DeskMetricsGetPostTimeOut)();
typedef bool (__stdcall *_DeskMetricsSetPostTimeOut)(int FTimeOut);

typedef bool (__stdcall *_DeskMetricsGetPostWaitResponse)();
typedef bool (__stdcall *_DeskMetricsSetPostWaitResponse)(bool FEnabled);

typedef bool (__stdcall *_DeskMetricsSetEnabled)(bool FValue);
typedef bool (__stdcall *_DeskMetricsGetEnabled)();

typedef bool (__stdcall *_DeskMetricsSetDebugMode)(bool FEnabled);
typedef bool (__stdcall *_DeskMetricsGetDebugMode)();

typedef LPCWSTR (__stdcall *_DeskMetricsGetJSON)();
typedef LPCTSTR (__stdcall *_DeskMetricsGetJSONA)();

//////////////////////////////////////////////////////////////////////////////

bool DeskMetricsLoadLibrary ();
void DeskMetricsUnloadLibrary ();

bool DeskMetricsStart (LPCWSTR FApplicationID, LPCWSTR FApplicationVersion);
bool DeskMetricsStartA (LPCTSTR FApplicationID, LPCTSTR FApplicationVersion);

bool DeskMetricsStop ();

bool DeskMetricsSendData();

void DeskMetricsTrackEvent(LPCWSTR FEventCategory, LPCWSTR FEventName);
void DeskMetricsTrackEventA(LPCTSTR FEventCategory, LPCTSTR FEventName);

void DeskMetricsTrackEvent(LPCWSTR FEventCategory, LPCWSTR FEventName);
void DeskMetricsTrackEventA(LPCTSTR FEventCategory, LPCTSTR FEventName);

void DeskMetricsTrackEventValue(LPCWSTR FEventCategory, LPCWSTR FEventName, LPCWSTR FEventValue);
void DeskMetricsTrackEventValueA(LPCTSTR FEventCategory, LPCTSTR FEventName, LPCTSTR FEventValue);

void DeskMetricsTrackEventPeriod(LPCWSTR FEventCategory, LPCWSTR FEventName, int FEventTime, bool FEventCompleted);
void DeskMetricsTrackEventPeriodA(LPCTSTR FEventCategory, LPCTSTR FEventName, int FEventTime, bool FEventCompleted);

void DeskMetricsTrackLog(LPCWSTR FMessage);
void DeskMetricsTrackLogA(LPCTSTR FMessage);

void DeskMetricsTrackCustomData(LPCWSTR FName, LPCWSTR FValue);
void DeskMetricsTrackCustomDataA(LPCTSTR FName, LPCTSTR FValue);

int DeskMetricsTrackCustomDataR(LPCWSTR FName, LPCWSTR FValue);
int DeskMetricsTrackCustomDataRA(LPCTSTR FName, LPCTSTR FValue);

//void DeskMetricsTrackException(LPCWSTR FExceptionMessage, LPCWSTR FExceptionType);

bool DeskMetricsSetProxy (LPCWSTR FHostIP, int FPort, LPCWSTR FUserName, LPCWSTR FPassword);
bool DeskMetricsSetProxyA (LPCTSTR FHostIP, int FPort, LPCTSTR FUserName, LPCTSTR FPassword);

bool DeskMetricsSetUserID (LPCWSTR FID);
bool DeskMetricsSetUserIDA (LPCTSTR FID);

LPCWSTR DeskMetricsGetPostServer ();
LPCTSTR DeskMetricsGetPostServerA ();

bool DeskMetricsSetPostServer(LPCWSTR FServer);
bool DeskMetricsSetPostServerA(LPCTSTR FServer);

int DeskMetricsGetPostPort();
bool DeskMetricsSetPostPort(int FPort);

int DeskMetricsGetPostTimeOut();
bool DeskMetricsSetPostTimeOut(int FTimeOut);

bool DeskMetricsGetPostWaitResponse();
bool DeskMetricsSetPostWaitResponse(bool FEnabled);

bool DeskMetricsSetEnabled(bool FValue);
bool DeskMetricsGetEnabled();

bool DeskMetricsSetDebugMode(bool FEnabled);
bool DeskMetricsGetDebugMode();

LPCWSTR DeskMetricsGetJSON();
LPCTSTR DeskMetricsGetJSONA();