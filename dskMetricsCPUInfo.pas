{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsCPUInfo.pas                           }
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

unit dskMetricsCPUInfo;

interface

uses
  Windows, SysUtils;

type
  TPDWord = ^DWORD;

  TQProcessorArchitecture = (
    paUnknown,    // Unknown architecture
    paX64,        // X64 (AMD or Intel)
    paIA64,       // Intel Itanium processor family (IPF)
    paX86         // Intel 32 bit
  );

  TQProcessorRegisters = record
    EAX,
    EBX,
    ECX,
    EDX: Cardinal;
  end;

  TQProcessorVendor = (
    cvUnknown, cvAMD, cvCentaur, cvCyrix, cvIntel,
    cvTransmeta, cvNexGen, cvRise, cvUMC, cvNSC, cvSiS
  );
  {Note: when changing TVendor, also change VendorStr array below}

  TQProcessorInstructions =
    (isFPU, {80x87}
    isTSC, {RDTSC}
    isCX8, {CMPXCHG8B}
    isSEP, {SYSENTER/SYSEXIT}
    isCMOV, {CMOVcc, and if isFPU, FCMOVcc/FCOMI}
    isMMX, {MMX}
    isFXSR, {FXSAVE/FXRSTOR}
    isSSE, {SSE}
    isSSE2, {SSE2}
    isSSE3, {SSE3*}
    isMONITOR, {MONITOR/MWAIT*}
    isCX16, {CMPXCHG16B*}
    isX64, {AMD AMD64* or Intel EM64T*}
    isExMMX, {MMX+ - AMD only}
    isEx3DNow, {3DNow!+ - AMD only}
    is3DNow, {3DNow! - AMD only}
    isHTT, {HyperThreading}
    isVME,  {Virtualization}
    isSSSE3 {SSSE3}
    );

  {Note: when changing TInstruction, also change InstructionSupportStr below
         * - instruction(s) not supported in Delphi 7 assembler}
  TQInstructionSupport = set of TQProcessorInstructions;

const
  // These constants are required when examining the
  // TSystemInfo.wProcessorArchitecture member
  // Only constants marked * are currently defined in the MS 2008 SDK
  //
  PROCESSOR_ARCHITECTURE_UNKNOWN    = $FFFF; // Unknown architecture.
  PROCESSOR_ARCHITECTURE_INTEL          = 0; // x86 *
  PROCESSOR_ARCHITECTURE_MIPS           = 1; // MIPS architecture
  PROCESSOR_ARCHITECTURE_ALPHA          = 2; // Alpha architecture
  PROCESSOR_ARCHITECTURE_PPC            = 3; // PPC architecture
  PROCESSOR_ARCHITECTURE_SHX            = 4; // SHX architecture
  PROCESSOR_ARCHITECTURE_ARM            = 5; // ARM  architecture
  PROCESSOR_ARCHITECTURE_IA64           = 6; // Intel Itanium Processor Family *
  PROCESSOR_ARCHITECTURE_ALPHA64        = 7; // Alpha64 architecture
  PROCESSOR_ARCHITECTURE_MSIL           = 8; // MSIL architecture
  PROCESSOR_ARCHITECTURE_AMD64          = 9; // x64 (AMD or Intel) *
  PROCESSOR_ARCHITECTURE_IA32_ON_WIN64 = 10; // IA32 on Win64 architecture


  //
  // These constants are provided in case the obsolete
  // TSystemInfo.dwProcessorType needs to be used.
  // Constants marked Windows CE are only used on Windows mobile and are only
  // provided here for completeness.
  // Only constants marked * are defined in the MS SDK 6.1
  //
  PROCESSOR_INTEL_386     = 386;   // Intel i386 processor *
  PROCESSOR_INTEL_486     = 486;   // Intel i486 processor *
  PROCESSOR_INTEL_PENTIUM = 586;   // Intel Pentium processor *
  PROCESSOR_INTEL_IA64    = 2200;  // Intel IA64 processor *
  PROCESSOR_AMD_X8664     = 8664;  // AMD X86 64 processor *
  PROCESSOR_MIPS_R4000    = 4000;  // MIPS R4000, R4101, R3910 processor
  PROCESSOR_ALPHA_21064   = 21064; // Alpha 210 64 processor
  PROCESSOR_PPC_601       = 601;   // PPC 601 processor
  PROCESSOR_PPC_603       = 603;   // PPC 603 processor
  PROCESSOR_PPC_604       = 604;   // PPC 604 processor
  PROCESSOR_PPC_620       = 620;   // PPC 620 processor
  PROCESSOR_HITACHI_SH3   = 10003; // Hitachi SH3 processor (Windows CE)
  PROCESSOR_HITACHI_SH3E  = 10004; // Hitachi SH3E processor (Windows CE)
  PROCESSOR_HITACHI_SH4   = 10005; // Hitachi SH4 processor (Windows CE)
  PROCESSOR_MOTOROLA_821  = 821;   // Motorola 821 processor (Windows CE)
  PROCESSOR_SHx_SH3       = 103;   // SHx SH3 processor (Windows CE)
  PROCESSOR_SHx_SH4       = 104;   // SHx SH4 processor (Windows CE)
  PROCESSOR_STRONGARM     = 2577;  // StrongARM processor (Windows CE)
  PROCESSOR_ARM720        = 1824;  // ARM 720 processor (Windows CE)
  PROCESSOR_ARM820        = 2080;  // ARM 820 processor (Windows CE)
  PROCESSOR_ARM920        = 2336;  // ARM 920 processor (Windows CE)
  PROCESSOR_ARM_7TDMI     = 70001; // ARM 7TDMI processor (Windows CE)
  PROCESSOR_OPTIL         = $494F; // MSIL processor

  QInstructionSupportStr:
  array[Low(TQProcessorInstructions)..High(TQProcessorInstructions)] of ShortString =
    ('FPU', 'TSC', 'CX8', 'SEP', 'CMOV', 'MMX', 'FXSR', 'SSE', 'SSE2', 'SSE3',
    'MONITOR', 'CX16', 'X64', 'MMX+', '3DNow!+', '3DNow!', 'HyperThreading', 'Virtualization', 'SSSE3');

type
 TQCPUFeatures =
    ({in EDX}
    cfFPU, cfVME, cfDE, cfPSE, cfTSC, cfMSR, cfPAE, cfMCE,
    cfCX8, cfAPIC, cf_d10, cfSEP, cfMTRR, cfPGE, cfMCA, cfCMOV,
    cfPAT, cfPSE36, cfPSN, cfCLFSH, cf_d20, cfDS, cfACPI, cfMMX,
    cfFXSR, cfSSE, cfSSE2, cfSS, cfHTT, cfTM, cfIA_64, cfPBE,
    {in ECX}
    cfSSE3, cf_c1, cf_c2, cfMON, cfDS_CPL, cf_c5, cf_c6, cfEIST,
    cfTM2, cfSSSE3, cfCID, cf_c11, cf_c12, cfCX16, cfxTPR, cf_c15,
    cf_c16, cf_c17, cf_c18, cf_c19, cf_c20, cf_c21, cf_c22, cf_c23,
    cf_c24, cf_c25, cf_c26, cf_c27, cf_c28, cf_c29, cf_c30, cf_c31);
  TQCPUFeatureSet = set of TQCPUFeatures;

  TQCPUExtendedFeatures =
    (cefFPU, cefVME, cefDE, cefPSE, cefTSC, cefMSR, cefPAE, cefMCE,
    cefCX8, cefAPIC, cef_10, cefSEP, cefMTRR, cefPGE, cefMCA, cefCMOV,
    cefPAT, cefPSE36, cef_18, ceMPC, ceNX, cef_21, cefExMMX, cefMMX,
    cefFXSR, cef_25, cef_26, cef_27, cef_28, cefLM, cefEx3DNow, cef3DNow);
  TCpuExtendedFeatureSet = set of TQCPUExtendedFeatures;

 TQFastCodeTarget =
    (fctRTLReplacement, {not specific to any CPU}
    fctBlended, {not specific to any CPU, requires FPU, MMX and CMOV}
    fctP3, {Pentium/Celeron 3}
    fctPM, {Pentium/Celeron M (Banias and Dothan)}
    fctP4, {Pentium/Celeron/Xeon 4 without SSE3 (Willamette,
                         Foster, Foster MP, Northwood, Prestonia, Gallatin)}
    fctP4_SSE3, {Pentium/Celeron 4 with SSE3 (Prescott)}
    fctP4_64, {Pentium/Xeon 4 with EM64T (some Prescott, and Nocona)}
    fctK7, {Athlon/Duron without SSE (Thunderbird and Spitfire)}
    fctK7_SSE, {Athlon/Duron/Sempron with SSE (Palomino, Morgan,
                         Thoroughbred, Applebred, Barton)}
    fctK8, {Opteron/Athlon FX/Athlon 64 (Clawhammer, Sledgehammer,
                         Newcastle)}
    fctK8_SSE3); {Opteron/Athlon FX/Athlon 64 with SSE3 (future)}
  {Note: when changing TFastCodeTarget, also change FastCodeTargetStr array
         below}

  TQProcessorVendorStr = string[12];

  TQCPUInfo = record
    Vendor: TQProcessorVendor;
    Signature: Cardinal;
    EffType: Byte;
    EffFamily: Byte; {ExtendedFamily + Family}
    EffFamilyEx: Byte;
    EffModel: Byte; {(ExtendedModel shl 4) + Model}
    EffModelEx: Byte;
    EffStepping: Byte;
    CodeL1CacheSize, {KB or micro-ops for Pentium 4}
      DataL1CacheSize, {KB}
      L2CacheSize, {KB}
      L3CacheSize: Word; {KB}
    HyperThreading: Boolean;
    Virtualization: Boolean;
    InstructionSupport: TQInstructionSupport;
  end;

  TFormatTemp = (ftCelsius, ftFahrenheit);


const
  QVendorIDString: array[Low(TQProcessorVendor)..High(TQProcessorVendor)] of TQProcessorVendorStr =
  ('',
    'AuthenticAMD', 'CentaurHauls', 'CyrixInstead', 'GenuineIntel',
    'GenuineTMx86', 'NexGenDriven', 'RiseRiseRise', 'UMC UMC UMC ',
    'Geode by NSC', 'SiS SiS SiS');

  FastCodeTargetStr:
  array[Low(TQFastCodeTarget)..High(TQFastCodeTarget)] of ShortString =
    ('RTLReplacement', 'Blended', 'P3', 'PM', 'P4', 'P4_SSE3', 'P4_64',
    'K7', 'K7_SSE', 'K8', 'K8_SSE3');

  { Features Data }
  IntelLowestSEPSupportSignature = $633;
  K7DuronA0Signature = $630;
  C3Samuel2EffModel = 7;
  C3EzraEffModel = 8;
  PMBaniasEffModel = 9;
  PMDothanEffModel = $D;
  P3LowestEffModel = 7;

function _GetProcessorFrequencyInternal: Integer;
function _GetProcessorArchitectureInternal: string;
function _GetProcessorVendorInternal: string;

var
  ProcessorData: TQCPUInfo;
  { Get all processor information }
  FastCodeTarget: TQFastCodeTarget;

  SI: TSystemInfo;
  pvtProcessorArchitecture: Word = 0;
  {Records processor architecture information}

  NtQuerySystemInformation: function(infoClass: DWORD;
    buffer: Pointer;
    bufSize: DWORD;
    returnSize: TPDword): DWORD; stdcall = nil;
    liOldIdleTime: LARGE_INTEGER = ();
    liOldSystemTime: LARGE_INTEGER = ();
    Usage: Double;

  FCPUName, FCodename, FRevision, FTech: string;
  { Information about specified processor }

implementation

uses
  dskMetricsCommon;

function IsCPUID_Available: Boolean; register;
begin
  try
    asm
      PUSHFD                 {save EFLAGS to stack}
      POP     EAX            {store EFLAGS in EAX}
      MOV     EDX, EAX       {save in EDX for later testing}
      XOR     EAX, $200000;  {flip ID bit in EFLAGS}
      PUSH    EAX            {save new EFLAGS value on stack}
      POPFD                  {replace current EFLAGS value}
      PUSHFD                 {get new EFLAGS}
      POP     EAX            {store new EFLAGS in EAX}
      XOR     EAX, EDX       {check if ID bit changed}
      JZ      @exit          {no, CPUID not available}
      MOV     EAX, True      {yes, CPUID is available}
      @exit:
    end;
  except
  end;
end;

function IsFPU_Available: Boolean;
var
  _FCW, _FSW: Word;
begin
  try
    asm
      MOV     EAX, False     {initialize return register}
      MOV     _FSW, $5A5A    {store a non-zero value}
      FNINIT                 {must use non-wait form}
      FNSTSW  _FSW           {store the status}
      CMP     _FSW, 0        {was the correct status read?}
      JNE     @exit          {no, FPU not available}
      FNSTCW  _FCW           {yes, now save control word}
      MOV     DX, _FCW       {get the control word}
      AND     DX, $103F      {mask the proper status bits}
      CMP     DX, $3F        {is a numeric processor installed?}
      JNE     @exit          {no, FPU not installed}
      MOV     EAX, True      {yes, FPU is installed}
      @exit:
    end;
  except
  end;
end;

procedure GetCPUID(Param: Cardinal; var Registers: TQProcessorRegisters);
begin
  try
    asm
      PUSH    EBX                         {save affected registers}
      PUSH    EDI
      MOV     EDI, Registers
      XOR     EBX, EBX                    {clear EBX register}
      XOR     ECX, ECX                    {clear ECX register}
      XOR     EDX, EDX                    {clear EDX register}
      DB $0F, $A2                         {CPUID opcode}
      MOV     TQProcessorRegisters(EDI).&EAX, EAX   {save EAX register}
      MOV     TQProcessorRegisters(EDI).&EBX, EBX   {save EBX register}
      MOV     TQProcessorRegisters(EDI).&ECX, ECX   {save ECX register}
      MOV     TQProcessorRegisters(EDI).&EDX, EDX   {save EDX register}
      POP     EDI                         {restore registers}
      POP     EBX
    end;
  except
  end;
end;

procedure GetCPUVendor;
var
  VendorStr: TQProcessorVendorStr;
  Registers: TQProcessorRegisters;
begin
  try
    {call CPUID function 0}
    GetCPUID(0, Registers);

    {get vendor string}
    SetLength(VendorStr, 12);
    Move(Registers.EBX, VendorStr[1], 4);
    Move(Registers.EDX, VendorStr[5], 4);
    Move(Registers.ECX, VendorStr[9], 4);

    {get CPU vendor from vendor string}
    ProcessorData.Vendor := High(TQProcessorVendor);
    while (VendorStr <> QVendorIDString[ProcessorData.Vendor]) and
      (ProcessorData.Vendor > Low(TQProcessorVendor)) do
      Dec(ProcessorData.Vendor);
  except
  end;
end;

procedure GetCPUFeatures;
{preconditions: 1. maximum CPUID must be at least $00000001
                2. GetCPUVendor must have been called}
type
  _Int64 = packed record
    Lo: Longword;
    Hi: Longword;
  end;
var
  Registers: TQProcessorRegisters;
  CpuFeatures: TQCPUFeatureSet;
begin
  try
    {call CPUID function $00000001}
    GetCPUID($00000001, Registers);

    {get CPU signature}
    ProcessorData.Signature := Registers.EAX;

    {extract effective processor family and model}
    ProcessorData.EffType := (ProcessorData.Signature and $00003000) shr 12;
    ProcessorData.EffFamily := (ProcessorData.Signature and $00000F00) shr 8;
    ProcessorData.EffFamilyEx := ProcessorData.Signature shr 8 and $F;;
    ProcessorData.EffModel := (ProcessorData.Signature and $000000F0) shr 4;
    ProcessorData.EffModelEx := ProcessorData.Signature shr 4 and $F;
    ProcessorData.EffStepping := (ProcessorData.Signature and $0000000F);

    if ProcessorData.EffFamily = $F then
    begin
      ProcessorData.EffFamily := ProcessorData.EffFamily + (ProcessorData.Signature and $0FF00000 shr 20);
      ProcessorData.EffModel := ProcessorData.EffModel + (ProcessorData.Signature and $000F0000 shr 12);
    end;

    {get CPU features}
    Move(Registers.EDX, _Int64(CpuFeatures).Lo, 4);
    Move(Registers.ECX, _Int64(CpuFeatures).Hi, 4);

    {get instruction support}
    if cfFPU in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isFPU);
    if cfTSC in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isTSC);
    if cfCX8 in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isCX8);
    if cfSEP in CpuFeatures then
    begin
      Include(ProcessorData.InstructionSupport, isSEP);
      {for Intel CPUs, qualify the processor family and model to ensure that the
       SYSENTER/SYSEXIT instructions are actually present - see Intel Application
       Note AP-485}
      if (ProcessorData.Vendor = cvIntel) and
        (ProcessorData.Signature and $0FFF3FFF < IntelLowestSEPSupportSignature) then
        Exclude(ProcessorData.InstructionSupport, isSEP);
    end;
    if cfCMOV in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isCMOV);
    if cfFXSR in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isFXSR);
    if cfMMX in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isMMX);
    if cfSSE in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isSSE);
    if cfSSE2 in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isSSE2);
    if cfSSE3 in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isSSE3);
    if (ProcessorData.Vendor = cvIntel) and (cfMON in CpuFeatures) then
      Include(ProcessorData.InstructionSupport, isMONITOR);
    if cfCX16 in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isCX16);
    if cfSSSE3 in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isSSSE3);
    if cfHTT in CpuFeatures then
      Include(ProcessorData.InstructionSupport, isHTT);
  except
  end;
end;

procedure GetCPUExtendedFeatures;
{preconditions: maximum extended CPUID >= $80000001}
var
  Registers: TQProcessorRegisters;
  CpuExFeatures: TCpuExtendedFeatureSet;
begin
  try
    {call CPUID function $80000001}
    GetCPUID($80000001, Registers);

    {get CPU extended features}
    CPUExFeatures := TCPUExtendedFeatureSet(Registers.EDX);

    {get instruction support}
    if cefLM in CpuExFeatures then
      Include(ProcessorData.InstructionSupport, isX64);
    if cefExMMX in CpuExFeatures then
      Include(ProcessorData.InstructionSupport, isExMMX);
    if cefEx3DNow in CpuExFeatures then
      Include(ProcessorData.InstructionSupport, isEx3DNow);
    if cef3DNow in CpuExFeatures then
      Include(ProcessorData.InstructionSupport, is3DNow);
   { if cefVME in CpuExFeatures then
      Include(ProcessorData.InstructionSupport, isVME);
      HyperThreading falta}
  except
  end;
end;

procedure GetProcessorCacheInfo;
{preconditions: 1. maximum CPUID must be at least $00000002
                2. GetCPUVendor must have been called}
type
  TConfigDescriptor = packed array[0..15] of Byte;
var
  Registers: TQProcessorRegisters;
  i, j: Integer;
  QueryCount: Byte;
begin
  try
    {call CPUID function 2}
    GetCPUID($00000002, Registers);
    QueryCount := Registers.EAX and $FF;
    for i := 1 to QueryCount do
    begin
      for j := 1 to 15 do
        with ProcessorData do
          {decode configuration descriptor byte}
          case TConfigDescriptor(Registers)[j] of
            $06: CodeL1CacheSize := 8;
            $08: CodeL1CacheSize := 16;
            $0A: DataL1CacheSize := 8;
            $0C: DataL1CacheSize := 16;
            $22: L3CacheSize := 512;
            $23: L3CacheSize := 1024;
            $25: L3CacheSize := 2048;
            $29: L3CacheSize := 4096;
            $2C: DataL1CacheSize := 32;
            $30: CodeL1CacheSize := 32;
            $39: L2CacheSize := 128;
            $3B: L2CacheSize := 128;
            $3C: L2CacheSize := 256;
            $40: {no 2nd-level cache or, if processor contains a valid 2nd-level
                  cache, no 3rd-level cache}
              if L2CacheSize <> 0 then
                L3CacheSize := 0;
            $41: L2CacheSize := 128;
            $42: L2CacheSize := 256;
            $43: L2CacheSize := 512;
            $44: L2CacheSize := 1024;
            $45: L2CacheSize := 2048;
            $60: DataL1CacheSize := 16;
            $66: DataL1CacheSize := 8;
            $67: DataL1CacheSize := 16;
            $68: DataL1CacheSize := 32;
            $70: if not (ProcessorData.Vendor in [cvCyrix, cvNSC]) then
                CodeL1CacheSize := 12; {K micro-ops}
            $71: CodeL1CacheSize := 16; {K micro-ops}
            $72: CodeL1CacheSize := 32; {K micro-ops}
            $78: L2CacheSize := 1024;
            $79: L2CacheSize := 128;
            $7A: L2CacheSize := 256;
            $7B: L2CacheSize := 512;
            $7C: L2CacheSize := 1024;
            $7D: L2CacheSize := 2048;
            $7F: L2CacheSize := 512;
            $80: if ProcessorData.Vendor in [cvCyrix, cvNSC] then
              begin {Cyrix and NSC only - 16 KB unified L1 cache}
                CodeL1CacheSize := 8;
                DataL1CacheSize := 8;
              end;
            $82: L2CacheSize := 256;
            $83: L2CacheSize := 512;
            $84: L2CacheSize := 1024;
            $85: L2CacheSize := 2048;
            $86: L2CacheSize := 512;
            $87: L2CacheSize := 1024;
          end;
      if i < QueryCount then
        GetCPUID(2, Registers);
    end;
  except
  end;
end;

procedure GetExtendedProcessorCacheInfo;
{preconditions: 1. maximum extended CPUID must be at least $80000006
                2. GetCPUVendor and GetCPUFeatures must have been called}
var
  Registers: TQProcessorRegisters;
begin
  try
    {call CPUID function $80000005}
    GetCPUID($80000005, Registers);

    {get L1 cache size}
    {Note: Intel does not support function $80000005 for L1 cache size, so ignore.
           Cyrix returns CPUID function 2 descriptors (already done), so ignore.}
    if not (ProcessorData.Vendor in [cvIntel, cvCyrix]) then
    begin
      ProcessorData.CodeL1CacheSize := Registers.EDX shr 24;
      ProcessorData.DataL1CacheSize := Registers.ECX shr 24;
    end;

    {call CPUID function $80000006}
    GetCPUID($80000006, Registers);

    {get L2 cache size}
    if (ProcessorData.Vendor = cvAMD) and (ProcessorData.Signature and $FFF = K7DuronA0Signature) then
      {workaround for AMD Duron Rev A0 L2 cache size erratum - see AMD Technical
       Note TN-13}
      ProcessorData.L2CacheSize := 64
    else if (ProcessorData.Vendor = cvCentaur) and (ProcessorData.EffFamily = 6) and
      (ProcessorData.EffModel in [C3Samuel2EffModel, C3EzraEffModel]) then
      {handle VIA (Centaur) C3 Samuel 2 and Ezra non-standard encoding}
      ProcessorData.L2CacheSize := Registers.ECX shr 24
    else {standard encoding}
      ProcessorData.L2CacheSize := Registers.ECX shr 16;
  except
  end;
end;

procedure VerifyOSSupportForXMMRegisters;
begin
  try
    {try a SSE instruction that operates on XMM registers}
    try
      asm
        DB $0F, $54, $C0  // ANDPS XMM0, XMM0
      end
    except
      on E: Exception do
      begin
        {if it fails, assume that none of the SSE instruction sets are available}
        Exclude(ProcessorData.InstructionSupport, isSSE);
        Exclude(ProcessorData.InstructionSupport, isSSE2);
        Exclude(ProcessorData.InstructionSupport, isSSE3);
      end;
    end;
  except
  end;
end;

procedure GetCPUInfo;
var
  Registers: TQProcessorRegisters;
  MaxCPUID: Cardinal;
  MaxExCPUID: Cardinal;
begin
  {initialize - just to be sure}
  FillChar(ProcessorData, SizeOf(ProcessorData), 0);

  try
    if not IsCPUID_Available then
    begin
      if IsFPU_Available then
        Include(ProcessorData.InstructionSupport, isFPU);
    end
    else
    begin
      {get maximum CPUID input value}
      GetCPUID($00000000, Registers);
      MaxCPUID := Registers.EAX;

      {get CPU vendor - Max CPUID will always be >= 0}
      GetCPUVendor;

      {get CPU features if available}
      if MaxCPUID >= $00000001 then
        GetCPUFeatures;

      {get cache info if available}
      if MaxCPUID >= $00000002 then
        GetProcessorCacheInfo;

      {get maximum extended CPUID input value}
      GetCPUID($80000000, Registers);
      MaxExCPUID := Registers.EAX;

      {get CPU extended features if available}
      if MaxExCPUID >= $80000001 then
        GetCPUExtendedFeatures;

      {verify operating system support for XMM registers}
      if isSSE in ProcessorData.InstructionSupport then
        VerifyOSSupportForXMMRegisters;

      {get extended cache features if available}
      {Note: ignore processors that only report L1 cache info,
             i.e. have a MaxExCPUID = $80000005}
      if MaxExCPUID >= $80000006 then
        GetExtendedProcessorCacheInfo;
    end;
  except
  end;
end;

procedure GetFastCodeTarget;
{precondition: GetCPUInfo must have been called}
begin
  try
    {as default, select blended target if there is at least FPU, MMX, and CMOV
     instruction support, otherwise select RTL Replacement target}
    if [isFPU, isMMX, isCMOV] <= ProcessorData.InstructionSupport then
      FastCodeTarget := fctBlended
    else
      FastCodeTarget := fctRTLReplacement;

    case ProcessorData.Vendor of
      cvIntel:
        case ProcessorData.EffFamily of
          6: {Intel P6, P2, P3, PM}
            if ProcessorData.EffModel in [PMBaniasEffModel, PMDothanEffModel] then
              FastCodeTarget := fctPM
            else if ProcessorData.EffModel >= P3LowestEffModel then
              FastCodeTarget := fctP3;
          $F: {Intel P4}
            if isX64 in ProcessorData.InstructionSupport then
              FastCodeTarget := fctP4_64
            else if isSSE3 in ProcessorData.InstructionSupport then
              FastCodeTarget := fctP4_SSE3
            else
              FastCodeTarget := fctP4;
        end;
      cvAMD:
        case ProcessorData.EffFamily of
          6: {AMD K7}
            if isSSE in ProcessorData.InstructionSupport then
              FastCodeTarget := fctK7_SSE
            else
              FastCodeTarget := fctK7;
          $F: {AMD K8}
            if isSSE3 in ProcessorData.InstructionSupport then
              FastCodeTarget := fctK8_SSE3
            else
              FastCodeTarget := fctK8;
        end;
    end;
  except
  end;
end;

function _GetProcessorArchitectureInternal: string;
begin
  Result := '32';
  try
    if isX64 in ProcessorData.InstructionSupport then
        Result :=  '64'
    else
      Result := '32';
  except
    Result := '32'; //Assume 32 bits processor
  end;
end;

function _GetProcessorVendorInternal: string;
begin
  Result := '';
  try
    Result := string(QVendorIDString[ProcessorData.Vendor]);

    { Easy read of user }
    if Result = 'AuthenticAMD' then
      Result := 'AMD'
    else
      if Result = 'GenuineIntel' then
        Result := 'Intel'
      else
      if Result = 'GenuineTMx86' then
        Result := 'Transmeta'
      else
        if Result = 'CentaurHauls' then
          Result := 'VIA'
        else
          if Result = 'Geode by NSC' then
            Result := 'NationalSemi'
  except
    Result := '';
  end;
end;

function _GetProcessorFrequencyInternal: Integer;
const
  DelayTime = 500;
  ID_BIT    = $200000;
var
  TimerHi, TimerLo: DWORD;
  PriorityClass, Priority: Integer;
begin
  try
    PriorityClass := GetPriorityClass(GetCurrentProcess);
    Priority      := GetThreadPriority(GetCurrentThread);

    SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
    SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

    Sleep(10);
    asm
      dw 310Fh // rdtsc
      mov TimerLo, eax
      mov TimerHi, edx
    end;
    Sleep(DelayTime);
    asm
      dw 310Fh // rdtsc
      sub eax, TimerLo
      sbb edx, TimerHi
      mov TimerLo, eax
      mov TimerHi, edx
    end;

    SetThreadPriority(GetCurrentThread, Priority);
    SetPriorityClass(GetCurrentProcess, PriorityClass);

    Result := Round(TimerLo / (1000.0 * DelayTime));
  except
    Result := 0;
  end;
end;

procedure InitializeEx;
type
  // Function type of the GetNativeSystemInfo and GetSystemInfo functions
  TGetSystemInfo = procedure(var lpSystemInfo: TSystemInfo); stdcall;
var
  GetSystemInfoFn: TGetSystemInfo;  // fn used to get system info
begin
  try
    { Extract function from kernel and execute }
      GetSystemInfoFn := _LoadKernelFunc('GetNativeSystemInfo');
    if not Assigned(GetSystemInfoFn) then
      GetSystemInfoFn := Windows.GetSystemInfo;
    GetSystemInfoFn(SI);
  except
  end;
end;

initialization
  { Processor Data Initialization }
  try
    InitializeEx;
    GetCPUInfo;
    GetFastCodeTarget;
  except
  end;

end.
