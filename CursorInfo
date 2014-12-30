#NoEnv
SendMode Input
CoordMode, mouse, Screen
#persistent
#SingleInstance Force
#Include Res\Cardellos
Menu, Tray, NoStandard
;Menu, Tray, Add,Test
Menu, Tray, Add,Reload
Menu, Battery, Add, Battery Toggle,BattTogg
Menu, Battery, Add, Battery Transparency (WIP),BattTrans
Menu, Battery, Add, Background Toggle,BattBgTogg
Menu, Tray, Add, Battery, :Battery
Menu, Wifi, Add, WiFi Toggle,WifiTogg
Menu, Tray, Add, Wifi, :WiFi
Menu, Clock, Add, Clock Toggle,ClockTogg
Menu, Clock, Add, Background Toggle (WIP),Clockbg
Menu, Tray, Add, Clock, :Clock
Menu, Hotkeys, Add, Hotkeys Toggle,HotTogg
Menu, Hotkeys, Add, NowPlaying Toggle,NPTogg
Menu, Tray, Add, Hotkeys, :Hotkeys
Menu, Tray, Add, 
Menu, Tray, Add, 
Menu, Tray, Add,About
Menu, Tray, Add,Exit,GuiClose
Menu, Tray, Default,Reload
WinGet, XWin, ID, A 
DetectHiddenWindows, on
GUI +HwndCursorInfo +E0x80000 +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
Gui,Color, 111112
WinSet, Transparent, %Trans%, CursorInfo
SetTimer, CheckFor, 1000
Gosub, CheckFor
SetTimer, FollowMouse, 10
Gosub, FollowMouse
#If BattTogg
{
	Gui, Add, Progress, w42 H18 Background000000 vBattProg HwndBattProg
}
Gui,Font, s12 cFFFFFF
#If ClockTogg
{
	Gui, Add, Text, vSee BackgroundTrans, % "MX=" MX "`nMY=" MY "`nVW=" VW "`nVH=" VH "`n" A_Hour ":" A_Min "`n" AC ":" BP
}
Gui,show, x%mX% y%mY% w42 h18, CursorInfo
WinActivate, ahk_id %XWin%
;ListVars
;#if A_TimeIdlePhysical = 144000000
;{
;	SendMessage,0x112,0xF170,2,,Program Manager
;}
return

Test:
return

BattTogg:
	Toggle(BattTogg)
	VarFile("res\Cardellos","BattTogg",BattTogg)
return
BattTrans:
	Toggle(BattTrans)
	VarFile("res\Cardellos","BattTrans",BattTrans)
return
BattBgTogg:
	Toggle(BattBgTogg)
	VarFile("res\Cardellos","BattBgTogg",BattBgTogg)
return
WifiTogg:
	Toggle(WifiTogg)
	VarFile("res\Cardellos","WifiTogg",WifiTogg)
return
ClockTogg:
	Toggle(ClockTogg)
	VarFile("res\Cardellos","ClockTogg",ClockTogg)
return
ClockBg:
	Toggle(ClockBg)
	VarFile("res\Cardellos","ClockBg",ClockBg)
return
HotTogg:
	Toggle(HotTogg)
	VarFile("res\Cardellos","HotTogg",HotTogg)
return
NPTogg:
	Toggle(NPTogg)
	VarFile("res\Cardellos","NPTogg",NPTogg)
return


CheckFor:
	SysGet, MN, MonitorCount
	If (MN = OMN)	{
		OMN:=MN
	} Else {
		OMN:=MN
		VarFile("Res\Cardellos","OMN",MN)
		Reload
	}
	If (MN = 2)	{
		MH:= VH - A_ScreenHeight
	}	Else If (MN = 1)	{
		MH:=0
	}
	VarSetCapacity(powerstatus, 1+1+1+1+4+4)
	DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)
	AC:=ReadInteger(&powerstatus,0,1,false)
	BP:=ReadInteger(&powerstatus,2,1,false)
	0R:=(0G- 255)
	0G:=Round(BP*255/100)
	If (AC == 0)	{
		Colore:=rgb2hex(-0R,0G,0)
		BG=000000
		Menu, Tray, Icon,res\%BP%.ico
		Menu, Tray, Tip,Cursor Info`nBattery at %BP%`% 
	}	Else if (Ac == 1)	{
			If (BP == 100)		{
				Colore:=000000
				BG:=FFFFFF
				Menu, Tray, Tip,Cursor Info`nBattery is fully charged
			} Else If (BP == 255){
				Colore:=FF0000
				BG:=FF0000
				Menu, Tray, Tip,Cursor Info`nBattery error
			} Else {
				Colore:=000088
				BG:=rgb2hex(-0R,0G,0)
				Menu, Tray, Tip,Cursor Info`nBattery charging at %BP%`% 
			}
		Menu, Tray, Icon,res\C%BP%.ico
	}
return

FollowMouse:
	SysGet, VX, 76
	SysGet, VY, 77
	SysGet, VW, 78
	SysGet, VH, 79
	MX:=MX+MXO
	MY:=MY+MYO
	Ms:=My+18
	WinMove, CursorInfo, , %mX%, %mY%
	If BattTogg	{
		GuiControl, Show, BattProg
		GuiControl,, BattProg, %BP%
		GuiControl, Move, BattProg, x0 y0
		If BattBgTogg	{
			GuiControl, +c%Colore% +Background%BG%, BattProg,
		} Else {
			GuiControl, +c%Colore% +BackgroundTrans, BattProg,
		}
	} Else {
		GuiControl, Hide, BattProg
	}
	If ClockTogg {
		GuiControl, Show, See
		GuiControl,, See, % A_Hour ":" A_Min
		GuiControl, Move, See, x0 y0
	} Else {
		GuiControl, Hide, See
	}
	GuiControl,Move, PP , x0 y%Ms% W2000
	winset,alwaysontop,on, CursorInfo
	WinSet, TransColor, %BG% 150, BattProg
	MouseGetPos,mx,my
return

getWiFiSignalStrength(SSID, tmpFileName) ;by jbscout
{
	RunWait, %comspec% /c netsh wlan show networks mode=bssid > %tmpFilename%, , Hide
	FileRead, Var, %tmpFilename%
	RexExStr := "sUmi)SSID\s*(\d+)\s*:\s*" . SSID  . ".+Signal\s*:\s*(\d+)%"
	If (RegExMatch(Var, RexExStr, SSID_Strength)) 
	{
		return SSID_Strength2
	}
	return -1
}

getConnectedSSID(tmpFileName) ;by jbscout
{
	RunWait, %comspec% /c netsh wlan show interface > %tmpFilename%, , Hide
	FileRead, Var, %tmpFilename%
	RexExStr := "mi)State\s*:\s*connected\s*SSID\s*:\s*(.+)"
	If (RegExMatch(Var, RexExStr, SSID)) 
	{
		return SSID1
	}
	return -1
}

isWiFiNetworkVisible(SSID, tmpFileName="") ;by jbscout
{
	if(tmpFileName == "")
	{
		nameForFile := A_ScriptName . "_" . A_ThisFunc . ".txt"
		tmpFilename := getTempFilename(nameForFile)
	}
	
	RunWait, %comspec% /c netsh wlan show networks mode=bssid > %tmpFilename%, , Hide
	FileRead, Var, %tmpFilename%
	RexExStr := "i)SSID\s*(\d+)\s*:\s*" . SSID
	; infomsgbox(RexExStr,3)
	If (RegExMatch(Var, RexExStr, SSID_Strength)) 
	{
		return true
	}
	return false
}

getTempFilename(shortFilename) ;by jbscout
{ ; creates a full path filename based on the Windows Temp directory
	; Input variables
	; 	shortFilename -> the short filename of the temp file you wish to use (e.g., demo.htm)
	; Output variables
	; 	fullFileName -> the full path filename of the temp file you wish to use (e.g., C:\Temp\demo.htm)

	WinTmpDir = %A_Temp%
	; EnvGet, WinTmpDir, TEMP
	fullFilename = %WinTmpDir%\%shortFilename%
	return fullFilename
}

ReadInteger( p_address, p_offset, p_size, p_hex=true ){
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
} 

rgb2hex(R=0,G=0,B=0,H=0){ ; just me
    H := ((H = 1) ? "#" : ((H = 2) ? "0x" : ""))
    VarSetCapacity(Hex, 17 << !!A_IsUnicode, 0)
    DllCall("Shlwapi.dll\wnsprintf", "Str", Hex, "Int", 17, "Str", "%016I64X", "UInt64", (R << 16) + (G << 8) + B, "Int")
    return H SubStr(Hex, StrLen(Hex) - 6 + 1)
}

FormatSeconds(NumberOfSeconds){  ; Convert the specified number of seconds to hh:mm:ss format.
    time = 19990101  ; *Midnight* of an arbitrary date.
    time += %NumberOfSeconds%, seconds
    FormatTime, mmss, %time%, mm:ss
    return mmss  ; This method is used to support more than 24 hours worth of sections.
}

Toggle(ByRef Togg){ ; by Cardellos
	If Togg = 0
		Togg:=1
	Else
		Togg:=0
}

VarFile(File,Var,Put,Find="",After="=",Before="`n"){ ; by Cardellos
	FileRead what, %File%
	start := InStr(what, Var)
	If (start > 0)	{
		start := InStr(what, After,, start)
		If (start > 0)	{
			end := InStr(what, Before,, start)
			If (end > 0)	{
				If Not Find	{
					StringMid endPart, what, end
					StringLeft what, what, start
					what = %what%%put%%endPart%
					FileDelete, %File%
					FileAppend %what%, %File%
				}	Else	{
					StringMid endPart, what, end
					StringLeft what, what, end - 1
					what := RegExReplace(what, Find, Put,,, start)
					what = %what%%endPart%
					FileDelete, %File%
					FileAppend %what%, %File%
				}
			}	Else	{
				MsgBox 20,, Bad format of '%File%'! `n No %Before%`nAppend to the end of the file?
				IfMsgBox, Yes
					FileAppend %before%, %File%	
			}
		}	Else	{
			MsgBox 16,, Bad format of '%File%'! `n No %After%
		}
	}	Else	{
		MsgBox 20,, '%Var%' not found in '%File%'! `nDo you want to create it?
		IfMsgBox, Yes
			FileAppend %Var%%After%%Put%%before%, %File%	
	}
}

GetWinPos(){ ; by Cardellos
	Global
	WinGetClass, WClass, A
	WinGetPos, X, Y, W, H, A
;	VarFile("Res\Cardellos", WClass "X", X)
;	VarFile("Res\Cardellos", WClass "Y", Y)
;	VarFile("Res\Cardellos", WClass "W", W)
;	VarFile("Res\Cardellos", WClass "H", H)
	WinGet, WHwnd, Id, A
	MA:=MonFromWin(WHwnd)
	SysGet, MA, MonitorWorkArea, %MA%
	MAX:=Round(MARight/2)
	MAY:=Round(MABottom/2)
}

MonFromWin(windowHandle){ ; by shinywong
	; Starts with 1.
	monitorIndex := 1

	VarSetCapacity(monitorInfo, 40)
	NumPut(40, monitorInfo)
	
	if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2)) 
		&& DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) 
	{
		monitorLeft   := NumGet(monitorInfo,  4, "Int")
		monitorTop    := NumGet(monitorInfo,  8, "Int")
		monitorRight  := NumGet(monitorInfo, 12, "Int")
		monitorBottom := NumGet(monitorInfo, 16, "Int")
		workLeft      := NumGet(monitorInfo, 20, "Int")
		workTop       := NumGet(monitorInfo, 24, "Int")
		workRight     := NumGet(monitorInfo, 28, "Int")
		workBottom    := NumGet(monitorInfo, 32, "Int")
		isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

		SysGet, monitorCount, MonitorCount

		Loop, %monitorCount%
		{
			SysGet, tempMon, Monitor, %A_Index%

			; Compare location to determine the monitor index.
			if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
				and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom))
			{
				monitorIndex := A_Index
				break
			}
		}
	}
	
	return monitorIndex
}

#If HotTogg = 1
{	
	!F1::
	WinGet, cT, Transparent, A
	if (cT = 150)	{
		WinSet, Transparent, OFF, A
	}	else	{
		WinSet, Transparent, 150, A
	}
	return
	!F2::
	WinMinimize, A
	return
	!F3::
	WinGet,WMinMax, MinMax, A
	If (WMinMax != 0)
	{
		WinRestore, A
	} Else {
		WinMaximize, A
	}
	return
	!F5::
	WinSet, AlwaysOnTop, Toggle
	return
	F8::
	Run "A:\!ns\Aud\Winamp\winamp.exe"
	return
	!F8::
	SendInput {F8}
	return
	F9::
	SendInput {Media_Play_Pause}
	return
	!F9::
	SendInput {F9}
	return
	F10::
	SendInput {Media_Stop}
	return
	!F10::
	SendInput {F10}
	return
	F11::
	SendInput {Media_Prev}
	return
	!F11::
	SendInput {F11}
	return
	F12::
	SendInput {Media_Next}
	return
	!F12::
	SendInput {F12}
	return
	#Up::
		GetWinPos()
		WinRestore, A
		WinMove, A,, 0, 0, MARight, MAY
	return
	#Down::
		GetWinPos()
		WinRestore, A
		WinMove, A,, 0, MAY, MARight, MAY
	return
;	#Left::
;		GetWinPos()
;		WinRestore, A
;		WinMove, A,, 0, 0, MAX, MABottom
;	return
;	#Right::
;		GetWinPos()
;		WinRestore, A
;		WinMove, A,, MAX, 0, MAX, MABottom
;	return
	#Home::
		GetWinPos()
		WinRestore, A
		WinMove, A,, 0, 0, MAX, MAY
	return
	#End::
		GetWinPos()
		WinRestore, A
		WinMove, A,, 0, MAY, MAX, MAY
	return
	#Pgup::
		GetWinPos()
		WinRestore, A
		WinMove, A,, MAX, 0, MAX, MAY
	return
	#Pgdn::
		GetWinPos()
		WinRestore, A
		WinMove, A,, MAX, MAY, MAX, MAY
	return
}

#If NPTogg = 1
{
	PrintScreen::
		#EscapeChar \ ;============[ Based on Purkki's "NowPlaying" ]
		SetTitleMatchMode 2
		DetectHiddenWindows On
		IfWinExist, VLC media player
		{
			WinGetTitle, vlcTitle
			NPSong:=VLC()
		} Else IfWinExist, - Winamp	
		{
			WinGetTitle, winampTitle
			song := RegExReplace(winampTitle, "^[0-9]*\. (.*) - Winamp$", "$1")
			TE:=Winamp("0")
			TT:=Winamp("1")
			TE:=TE/1000
			TE:=FormatSeconds(TE)
			TT:=FormatSeconds(TT)
			NPSong:= RegExReplace(Song, "([!\+\^#])", "{$1}")
		}
		Gui,2: Font, s12 cFFFFFF
		Gui,2: Add, Text, x0 y0 vPP Hidden BackgroundTrans, % NPSong " " TE "/" TT
		Sleep, 300
		GUI,2: +HwndCursorInfo2 +E0x80000 +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
		Gui,2: Color, 111112
		WinSet, Transparent, %Trans%, CursorInfo2
		Gui,2: show, x%mX% y%mS% h18 NA, CursorInfo2
		GuiControl, 2: Show, PP
		If WifiTogg
		{
			Whyfi:=getConnectedSSID(1)
			Sig:=getWiFiSignalStrength(Whyfi, 1)
			Sleep, 1000
			Gui,2: Destroy
			Gui,3: Font, s12 cFFFFFF
			Gui,3: Add, Text, x0 y0 vPP Hidden BackgroundTrans, % "Wifi=" Sig "%@" WhyFi
			Sleep, 300
			GUI,3: +HwndCursorInfo2 +E0x80000 +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
			Gui,3: Color, 111112
			WinSet, Transparent, %Trans%, CursorInfo2
			Gui,3: show, x%mX% y%mS% h18 NA, CursorInfo2
			GuiControl, 3: Show, PP
			Sleep, 3000
			Gui,3: Destroy
		} Else {
			Sleep, 3000
			Gui,2: Destroy
		}
		
	Return
	!PrintScreen::
	SendInput {PrintScreen}
	Return
}

VLC(){
	VLCURL:="http://:1@127.0.0.1:8080/requests/status.xml?%A_Hour%%A_Min%%A_Sec%"
	UrlDownloadToFile, VLCURL ,Vlcstatus
	FileRead, FullPage, Vlcstatus
	Filename=siU)\<info name\=\"filename\"\>(.*?)\<\/info\>
;	Reg=siU)<a href\=\"http\:\/\/www\.videolan\.org\">(.*?)\<\/a\>
	RegExMatch(FullPage,Filename,Get)
	listvars
	return Get1
}

Winamp(O){ ; by Cardellos
    DetectHiddenWindows On
	SendMessage 0x400,O,105,,ahk_class Winamp v1.x
    return ErrorLevel
}
	
;==[Close]
GuiClose:
ExitApp
ListVars:
ListVars
return
Reload:
Reload
return
About:
	Gui,99: color, 191919
	Gui,99: +caption +toolwindow -alwaysontop -border -Resize +LastFound
	Gui,99: Add, Picture, x545 y0 gX99,res\X.png
	Gui,99: show, w565 h462, About
	Gui,99: font, cFF0000,  Lucida console
	Gui,99: Add, Text, x-40 y10,|          /$$$$$$                                  /$$                     /$$
	Gui,99: Add, Text, xp yp+16,|         /$$__  $$                                | $$                    | $$
	Gui,99: Add, Text, xp yp+16,|        | $$  \__/  /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$$
	Gui,99: Add, Text, xp yp+16,|        | $$       /$$__  $$ /$$__  $$ |____  $$|_  $$_/   /$$__  $$ /$$__  $$
	Gui,99: Add, Text, xp yp+16,|        | $$      | $$  \__/| $$$$$$$$  /$$$$$$$  | $$    | $$$$$$$$| $$  | $$
	Gui,99: Add, Text, xp yp+16,|        | $$    $$| $$      | $$_____/ /$$__  $$  | $$ /$$| $$_____/| $$  | $$
	Gui,99: Add, Text, xp yp+16,|        |  $$$$$$/| $$      |  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$$|  $$$$$$$
	Gui,99: Add, Text, xp yp+16,|         \______/ |__/       \_______/ \_______/   \___/   \_______/ \_______/
	Gui,99: Add, Text, xp yp+16,|
	Gui,99: Add, Text, xp yp+16,|                                    /$$
	Gui,99: Add, Text, xp yp+16,|                                   | $$
	Gui,99: Add, Text, xp yp+16,|                                   | $$$$$$$  /$$   /$$
	Gui,99: Add, Text, xp yp+16,|                                   | $$__  $$| $$  | $$
	Gui,99: Add, Text, xp yp+16,|                                   | $$  \ $$| $$  | $$
	Gui,99: Add, Text, xp yp+16,|                                   | $$  | $$| $$  | $$
	Gui,99: Add, Text, xp yp+16,|                                   | $$$$$$$/|  $$$$$$$
	Gui,99: Add, Text, xp yp+16,|                                   |_______/  \____  $$
	Gui,99: Add, Text, xp yp+16,|                                              /$$  | $$
	Gui,99: Add, Text, xp yp+16,|                                             |  $$$$$$/
	Gui,99: Add, Text, xp yp+16,|                                              \______/
	Gui,99: Add, Text, xp yp+16,|        /$$$$$$                            /$$           /$$ /$$
	Gui,99: Add, Text, xp yp+16,|       /$$__  $$                          | $$          | $$| $$
	Gui,99: Add, Text, xp yp+16,|      | $$  \__/  /$$$$$$   /$$$$$$   /$$$$$$$  /$$$$$$ | $$| $$  /$$$$$$   /$$$$$$$
	Gui,99: Add, Text, xp yp+16,|      | $$       |____  $$ /$$__  $$ /$$__  $$ /$$__  $$| $$| $$ /$$__  $$ /$$_____/
	Gui,99: Add, Text, xp yp+16,|      | $$        /$$$$$$$| $$  \__/| $$  | $$| $$$$$$$$| $$| $$| $$  \ $$|  $$$$$$
	Gui,99: Add, Text, xp yp+16,|      | $$    $$ /$$__  $$| $$      | $$  | $$| $$_____/| $$| $$| $$  | $$ \____  $$
	Gui,99: Add, Text, xp yp+16,|      |  $$$$$$/|  $$$$$$$| $$      |  $$$$$$$|  $$$$$$$| $$| $$|  $$$$$$/ /$$$$$$$/
	Gui,99: Add, Text, xp yp+16,|       \______/  \_______/|__/       \_______/ \_______/|__/|__/ \______/ |_______/
return
X99:
	Gui,99:destroy
return
