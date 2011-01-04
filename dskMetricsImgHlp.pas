{ **********************************************************************}
{                                                                       }
{     DeskMetrics DLL - dskMetricsImgHlp.pas                            }
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

//  Declarations copied from the "Project JEDI API Header Library"
//  http://www.delphi-jedi.org/apilibrary.html

{$WARN SYMBOL_PLATFORM OFF}

unit dskMetricsImgHlp;

interface

uses
  Windows, SysUtils;

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

type
  PIMAGE_OPTIONAL_HEADER32 = ^IMAGE_OPTIONAL_HEADER32;
  {$EXTERNALSYM PIMAGE_OPTIONAL_HEADER32}
  _IMAGE_OPTIONAL_HEADER = record
    //
    // Standard fields.
    //
    Magic: Word;
    MajorLinkerVersion: Byte;
    MinorLinkerVersion: Byte;
    SizeOfCode: DWORD;
    SizeOfInitializedData: DWORD;
    SizeOfUninitializedData: DWORD;
    AddressOfEntryPoint: DWORD;
    BaseOfCode: DWORD;
    BaseOfData: DWORD;
    //
    // NT additional fields.
    //
    ImageBase: DWORD;
    SectionAlignment: DWORD;
    FileAlignment: DWORD;
    MajorOperatingSystemVersion: Word;
    MinorOperatingSystemVersion: Word;
    MajorImageVersion: Word;
    MinorImageVersion: Word;
    MajorSubsystemVersion: Word;
    MinorSubsystemVersion: Word;
    Win32VersionValue: DWORD;
    SizeOfImage: DWORD;
    SizeOfHeaders: DWORD;
    CheckSum: DWORD;
    Subsystem: Word;
    DllCharacteristics: Word;
    SizeOfStackReserve: DWORD;
    SizeOfStackCommit: DWORD;
    SizeOfHeapReserve: DWORD;
    SizeOfHeapCommit: DWORD;
    LoaderFlags: DWORD;
    NumberOfRvaAndSizes: DWORD;
    DataDirectory: array [0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES - 1] of IMAGE_DATA_DIRECTORY;
  end;
  {$EXTERNALSYM _IMAGE_OPTIONAL_HEADER}
  IMAGE_OPTIONAL_HEADER32 = _IMAGE_OPTIONAL_HEADER;
  {$EXTERNALSYM IMAGE_OPTIONAL_HEADER32}
  TImageOptionalHeader32 = IMAGE_OPTIONAL_HEADER32;
  PImageOptionalHeader32 = PIMAGE_OPTIONAL_HEADER32;

  PIMAGE_NT_HEADERS32 = ^IMAGE_NT_HEADERS32;
  {$EXTERNALSYM PIMAGE_NT_HEADERS32}
  _IMAGE_NT_HEADERS = record
    Signature: DWORD;
    FileHeader: IMAGE_FILE_HEADER;
    OptionalHeader: IMAGE_OPTIONAL_HEADER32;
  end;
  {$EXTERNALSYM _IMAGE_NT_HEADERS}
  IMAGE_NT_HEADERS32 = _IMAGE_NT_HEADERS;
  {$EXTERNALSYM IMAGE_NT_HEADERS32}
  TImageNtHeaders32 = IMAGE_NT_HEADERS32;
  PImageNtHeaders32 = PIMAGE_NT_HEADERS32;

  TImgSecHdrMisc = record
    case Integer of
      0: (PhysicalAddress: DWORD);
      1: (VirtualSize: DWORD);
  end;

  PIMAGE_SECTION_HEADER = ^IMAGE_SECTION_HEADER;
  {$EXTERNALSYM PIMAGE_SECTION_HEADER}
  _IMAGE_SECTION_HEADER = record
    Name: array [0..IMAGE_SIZEOF_SHORT_NAME - 1] of BYTE;
    Misc: TImgSecHdrMisc;
    VirtualAddress: DWORD;
    SizeOfRawData: DWORD;
    PointerToRawData: DWORD;
    PointerToRelocations: DWORD;
    PointerToLinenumbers: DWORD;
    NumberOfRelocations: WORD;
    NumberOfLinenumbers: WORD;
    Characteristics: DWORD;
  end;
  {$EXTERNALSYM _IMAGE_SECTION_HEADER}
  IMAGE_SECTION_HEADER = _IMAGE_SECTION_HEADER;
  {$EXTERNALSYM IMAGE_SECTION_HEADER}
  TImageSectionHeader = IMAGE_SECTION_HEADER;
  PImageSectionHeader = PIMAGE_SECTION_HEADER;

  PLOADED_IMAGE = ^LOADED_IMAGE;
  {$EXTERNALSYM PLOADED_IMAGE}
  _LOADED_IMAGE = record
    ModuleName: LPSTR;
    hFile: THANDLE;
    MappedAddress: PUCHAR;
    FileHeader: PIMAGE_NT_HEADERS32;
    LastRvaSection: PIMAGE_SECTION_HEADER;
    NumberOfSections: ULONG;
    Sections: PIMAGE_SECTION_HEADER;
    Characteristics: ULONG;
    fSystemImage: ByteBool;
    fDOSImage: ByteBool;
    Links: LIST_ENTRY;
    SizeOfImage: ULONG;
  end;
  {$EXTERNALSYM _LOADED_IMAGE}
  LOADED_IMAGE = _LOADED_IMAGE;
  {$EXTERNALSYM LOADED_IMAGE}
  TLoadedImage = LOADED_IMAGE;
  PLoadedImage = PLOADED_IMAGE;

type
  TImageLoad = function (DllName: LPSTR; DllPath: LPSTR) : PLOADED_IMAGE; stdcall;
  TImageUnload = function (const LoadedImage: LOADED_IMAGE) : BOOL; stdcall;

function IsLargeAddressAware (const sExeName: TFileName) : Boolean;

var
  ImageLoad : TImageLoad = NIL;
  ImageUnload : TImageUnload = NIL;

implementation

(* ---- *)

function IsLargeAddressAware (const sExeName: TFileName) : Boolean;

resourcestring
  cLoadErr = 'Error loading funtions from "imagehlp.dll"';

var
    pLoadedImage : PLOADED_IMAGE;
    sDllName : AnsiString;

begin
    if not (Assigned (ImageLoad)) then
        raise EOSError.Create (cLoadErr);

    sDllName     := AnsiString (ExtractFileName (sExeName));
    pLoadedImage := ImageLoad (PAnsiChar (sDLLName), PAnsiChar (sDLLName));

    Win32Check (pLoadedImage <> NIL);

    Result      := (pLoadedImage^.Characteristics and IMAGE_FILE_LARGE_ADDRESS_AWARE) <> 0;

    Win32Check (ImageUnload (pLoadedImage^));
end; { IsLargeAddressAware }

(* ---- *)

const
  cImageHlp = 'imagehlp.dll';

var
  hImageHlp: THandle;

initialization
  hImageHlp := LoadLibrary (cImageHlp);

  if (hImageHlp <> 0) then
  begin
    ImageLoad   := GetProcAddress (hImageHlp, 'ImageLoad');
    ImageUnload := GetProcAddress (hImageHlp, 'ImageUnload');
    Assert (Assigned (ImageLoad) and Assigned (ImageUnload));
  end; { if }

finalization
  if (hImageHlp <> 0) then
    FreeLibrary (hImageHlp);
end.


