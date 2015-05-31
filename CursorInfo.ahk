/*
======[ Settings GUI ]======
	Item Visibility Options
	- Always visible
	- Show on "Show Me" Key
	- When Status Change
	- Hidden
	Positions
	default text
	default button
	color
	CPU
	- Cores to show
	- Show BG
	Ram
	-
/	Disk
	-
	Network
	-
	Volume
	- Auto Volume
	- Full Time/On "show me" Key Press/Off
	- Number(%)/image
	- Minimum Volume
	- Maximum Volume
	Brightness
	-
	Date / calendar
	-
/	Mail
	-
	Weather
	-
/	BlueTooth
	-
	Change Tray Icon 
	-
	2/3 of screen
	-
	Battery
	-
	Clock
	-
	Hotkeys
	-
	NowPlayng
	-
	Wifi
	-
*/
#NoEnv
SendMode Input
CoordMode, mouse, Screen
SetBatchLines, -1
#persistent
#SingleInstance Force
#InstallKeybdHook
#IncludeAgain Res\Cardellos
Menu, Tray, NoStandard
;Menu, Tray, Add,Test
Menu, Tray, Add, Reload
Menu, Tray, Add, Settings, Set
Menu, Tray, Add, 
Menu, Debug, Add,Reload
Menu, Debug, Add,
Menu, Debug, Add,Vars,ListVars
;Menu, Tray, Add, About
Menu, Tray, Add, Exit,GuiClose
Menu, Tray, Default, Reload
;Menu, Tray, Default, Settings
WinGet, XWin, ID, A 
DetectHiddenWindows, on
;====================[ Put in settings ]
;====================[ End ]
SetTimer, CheckMin, 60000
Gosub, CheckMin
SetTimer, CheckSec, 1000
Gosub, CheckSec
SetTimer, CheckCen, 1
Gosub, CheckCen
#If BattTogg
{
	Gui,Main: Add, Progress, x%CaBx% y%CaBy% w42 H18 Background000000 vBattProg 
}
#If ClockTogg
{
	Gui,Main: Font, s12 cFFFFFF
	Gui,Main: Add, Text, x%CaBx% y%CaBy% vClockGui BackgroundTrans, % A_Hour ":" A_Min
}
#If CalTogg
{
	Gui,Main: Add, Progress, x%Calx% y%Caly% w18 H18 BackgroundFF0000 Vertical vCalProg 
	GuiControl,Main:, CalProg, 65
	GuiControl,Main: +cFFFFFF, CalProg
	CalTopx:=(Calx+3)
	CalTopy:=(Caly+0)
	CalBotx:=(Calx+3)
	CalBoty:=(Caly+6)
	Gui,Main: Font, s5 cFFFFFF
	Gui,Main: Add, Text, x%CalTopx% y%CalTopy% vCalWeek BackgroundTrans,% CalTop
	Gui,Main: Font, s9 c000000
	Gui,Main: Add, Text, x%CalBotx% y%CalBoty% vCalMon BackgroundTrans,% CalBot
}
#If WiFiTogg
{
	Gui,Main: Add, Picture, vWifi AltSubmit x%WiFx% y%WiFy% H18 W18, Res\Wifi\0-1.png
	Gosub, CheckMin
}
#If NetTogg
{
	If (NetDis == 1)
	{
		Gui,Main: Font, s6
		Gui,Main: Add, Text, x%Netx% y%Nety% w42 h9 BackgroundTrans cRed   vTUp, %dnRate% kb
		Gui,Main: Add, Text, x%Netx% y+1	 w42 h9 BackgroundTrans cGreen vTDn, %upRate% kb
	}
	Else If (NetDis == 2)
	{
		Gui,Main: Add, Progress, x%Netx% y%Nety% w42 h9 cRed   vPUp
		Gui,Main: Add, Progress, x%Netx% y+1 	 w42 h9 cGreen vPDn
	}
	Else If (NetDis == 3)
	{
		Gui,Main: Font, s6
		Gui,Main: Add, Progress, x%Netx% y%Nety% w42 h9 BackgroundBlack cRed   vPUp
		Gui,Main: Add, Progress, x%Netx% y+0 	 w42 h9 BackgroundBlack cGreen vPDn
		Gui,Main: Add, Text, x%Netx% y%Nety% w42 h9 BackgroundTrans cWhite vTUp, %dnRate% kb
		Gui,Main: Add, Text, x%Netx% y+1	 w42 h9 BackgroundTrans cWhite vTDn, %upRate% kb
	}
}
#If (ClockTogg == 1) OR (BattTogg == 1) OR (NetTogg == 1)
{
	GUI,Main: +HwndCursorInfo +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
	Gui,Main: Color, 111112
	Gui,Main: show, x%GUIPosx% y%GUIPosy% w82 h56, CursorInfo
	WinSet, TransColor, 111112 %Trans%, CursorInfo
} 
WinActivate, ahk_id %XWin%
return

Set:
	Gui,Set: New,, Settings
	Gui,Set: Add, Button, x490 y445 w100 h30 gGuiSetClose, Close
	Gui,Set: Add, Text,X10 y462 center w130, Created by Cardellos
	Gui,Set: Add, TreeView, x10 y10 h450 w130  AltSubmit gClick
		P00:=TV_Add("Main")
		P01:=TV_Add("Battery")
		P02:=TV_Add("Clock")
		P03:=TV_Add("Hotkeys")
		P04:=TV_Add("NowPlaying")
		P05:=TV_Add("Wifi")
		P06:=TV_Add("Volume")
		P07:=TV_Add("Calendar")
;		P08:=TV_Add("Disk (WIP)")
;		P09:=TV_Add("NetWork (WIP)")
;		P10:=TV_Add("CPU (WIP)")
;		P11:=TV_Add("Brightness (WIP)")
;		P12:=TV_Add("Ram (WIP)")
	Gui,Set: Add, GroupBox, x150 ym w440 h430 section vOptionTitle, %OptionTitle%
	Gui,Set: Add, Tab2, x150 y30 w0 h0 -Wrap vMyTab, Zero|One|Two|Three|Four|Five|Six|Seven|Eight|Nine|Ten|Eleven|Twelve
	Gui,Set: Tab, Zero
		GuiControl,, OptionTitle, Main Settings
		ctrls=1
		Gui,Set: Add, Checkbox, xs+10 ys+30 Checked%GuiTrans% gGuiTrans, Gui Transparency
		Gui,Set: Add, Edit, xs+10 ys+45 gTrans, %Trans%
		Gui,Set: Add, Text, xs+40 ys+50 , Gui Transparency
;		Gui, Add, Text, x155 y50, Enter "Show Me" Key
;		Gui, Add, Hotkey, y+5 vHK1 gGuiLabel
;		Gui, Add, CheckBox, x+5 vCB1 Checked%ErrorLevel%, Use WinKey?
;		Gui,Set: Add, Button, gButtonsLabel, Button 1
;		Gui,Set: Add, Edit, gEditsLabel, Edit box 2
;		Gui,Set: Add, ListBox, gLBLabel, Item1|Item2|Item3
	Gui,Set: Tab, One
		Gui,Set: Add, Checkbox, Checked%BattTogg%  gBattTogg, Show Battery
		Gui,Set: Add, GroupBox, w420 h300 section, Battery Options
		Gui,Set: Add, Checkbox, xs+10 ys+15 Checked%BattBgTogg% gBattBgTogg, Show Battery Background
;		Gui,Set: Add, Edit, xs+10 ys+60 gTrans, %BG%
;		Gui,Set: Add, Text, xs+90 ys+65 , Battery Transparency Color
	Gui,Set: Tab, Two                  
		Gui,Set: Add, Checkbox, Checked%ClockTogg% gClockTogg, Show Clock
		Gui,Set: Add, Checkbox, Checked%ClockBg% gClockBg, Show Clock Background (Only works if battery is disabled)
	Gui,Set: Tab, Three                
		Gui,Set: Add, Checkbox, Checked%HotTogg% gHotTogg, Enable Hotkeys
	Gui,Set: Tab, Four                 
		Gui,Set: Add, Checkbox, Checked%NPTogg% gNPTogg, Enable NowPlaying
	Gui,Set: Tab, Five                 
		Gui,Set: Add, Checkbox, Checked%WifiTogg% gWifiTogg, Enable Wifi
		Gui,Set: Add, Checkbox, Checked%WhyfiTogg% gWhyfiTogg, Enable Whyfi
	Gui,Set: Tab, Six
		Gui,Set: Add, Checkbox, Checked%VolTogg%  gVolTogg, Auto Volume
	Gui,Set: Tab, Seven
		Gui,Set: Add, Text,, Select Month or Week On the Top or Bottom
	Gui,Set: Tab, Eight
	Gui,Set: Tab, Nine
	Gui,Set: Tab, Ten
	Gui,Set: Tab, Eleven
	Gui,Set: Tab, Twelve
	GUI,Set: +HwndSet -Resize -Disabled -MinimizeBox -MaximizeBox
	Gui,Set: Show, W600 H480, CursorInfo Settings ; x30 y-720
;	Gui,Set: Add, Text,,% "TO DO `n Item Visibility Options `n - Always visible `n - Show on 'Show Me' Key `n - When Status Change `n - Hidden `n Positions `n default text `n default button `n color `n CPU `n - Cores to show `n - Show BG `n Ram `n Disk `n Network `n Volume `n - Auto Volume `n - Number(%)/image `n Brightness `n Date / calendar `n Mail `n Weather `n BlueTooth `n Change Tray Icon `n 2/3 of screen"
return

BattTogg:
	Toggle(BattTogg)
	VarFile("res\Cardellos","BattTogg",BattTogg)
return
GuiTrans:
	Toggle(GuiTrans)
	VarFile("res\Cardellos","GuiTrans",GuiTrans)
return
Trans:
	VarFile("res\Cardellos","Trans",Trans)
return
BattBgTogg:
	Toggle(BattBgTogg)
	VarFile("res\Cardellos","BattBgTogg",BattBgTogg)
return
WifiTogg:
	Toggle(WifiTogg)
	VarFile("res\Cardellos","WifiTogg",WifiTogg)
return
WhyfiTogg:
	Toggle(WhyfiTogg)
	VarFile("res\Cardellos","WhyfiTogg",WhyfiTogg)
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
VolTogg:
	Toggle(VolTogg)
	VarFile("res\Cardellos","VolTogg",VolTogg)
return
CalTogg:
	Toggle(CalTogg)
	VarFile("res\Cardellos","CalTogg",CalTogg)
return
NetTogg:
	Toggle(NetTogg)
	VarFile("res\Cardellos","NetTogg",NetTogg)
return
Click:
	If (A_GuiEvent == "Normal")
	{
		If (A_EventInfo == P00)
		{
			GuiControl,, OptionTitle, Main Settings
			GuiControl, Choose, MyTab, Zero
		}
		Else If (A_EventInfo == P01)
		{
			GuiControl,, OptionTitle, Battery
			GuiControl, Choose, MyTab, One
		}
		Else If (A_EventInfo == P02)
		{
			GuiControl,, OptionTitle, Clock
			GuiControl, Choose, MyTab, Two
		}
		Else If (A_EventInfo == P03)
		{
			GuiControl,, OptionTitle, Hotkeys
			GuiControl, Choose, MyTab, Three
		}
		Else If (A_EventInfo == P04)
		{
			GuiControl,, OptionTitle, NowPlaying
			GuiControl, Choose, MyTab, Four
		}
		Else If (A_EventInfo == P05)
		{
			GuiControl,, OptionTitle, Wifi
			GuiControl, Choose, MyTab, Five
		}
		Else If (A_EventInfo == P06)
		{
			GuiControl,, OptionTitle, Volume
			GuiControl, Choose, MyTab, Six
		}
		Else If (A_EventInfo == P07)
		{
			GuiControl,, OptionTitle, Calendar
			GuiControl, Choose, MyTab, Seven
		}
		Else If (A_EventInfo == P08)
		{
			GuiControl,, OptionTitle, Disk
			GuiControl, Choose, MyTab, Eight
		}
		Else If (A_EventInfo == P09)
		{
			GuiControl,, OptionTitle, NetWork
			GuiControl, Choose, MyTab, Nine
		}
		Else If (A_EventInfo == P10)
		{
			GuiControl,, OptionTitle, CPU 
			GuiControl, Choose, MyTab, Ten
		}
		Else If (A_EventInfo == P11)
		{
			GuiControl,, OptionTitle, Brightness
			GuiControl, Choose, MyTab, Eleven
		}
		Else If (A_EventInfo == P12)
		{
			GuiControl,, OptionTitle, Ram
			GuiControl, Choose, MyTab, Twelve
		}
	}
Return
Test:
return
CheckMin:
	If CalTogg
	{
		GuiControl,Main:, CalWeek, % CalTop
		GuiControl,Main:, CalMon, % CalBot
		If (CalTopSel == 1)
		{
			CalTop:=A_DDD
		}
		Else If (CalTopSel == 2)
		{
			CalTop:=A_MMM
		}
		If (CalBotSel == 1)
		{
			CalBot:=A_DD
		}
		Else If (CalBotSel == 2)
		{
			CalBot:=A_MM
		}
	}
	If WifiTogg
	{
		Whyfi:=getConnectedSSID(1)
		Sig:=getWiFiSignalStrength(Whyfi, 1)
		If (Sig == 0)
		{
			GuiControl,Main: , Wifi, Res\Wifi\0-%WiFIco%.png
		}
		Else If (Sig > 0) And (Sig <= 20)
		{
			GuiControl,Main: , Wifi, Res\Wifi\1-%WiFIco%.png
		}
		Else If (Sig > 20) And (Sig <= 40)
		{
			GuiControl,Main: , Wifi, Res\Wifi\2-%WiFIco%.png
		}
		Else If (Sig > 40) And (Sig <= 60)
		{
			GuiControl,Main: , Wifi, Res\Wifi\3-%WiFIco%.png
		}
		Else If (Sig > 60) And (Sig <= 80)
		{
			GuiControl,Main: , Wifi, Res\Wifi\4-%WiFIco%.png
		}
		Else If (Sig > 80) And (Sig <= 100)
		{
			GuiControl,Main: , Wifi, Res\Wifi\5-%WiFIco%.png
		}
	}
return
CheckSec:
	If GuiTrans
	{
		WinSet, TransColor, 111112 %Trans%, CursorInfo
	} Else {
		WinSet, TransColor, 111112 255, CursorInfo
	}
*/	
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
		Menu, Tray, Icon,res\Battery.icl,%BP%
		Menu, Tray, Tip,Cursor Info`nBattery at %BP%`% 
	}	Else if (Ac == 1)	{
			If (BP == 100)		{
				Colore:=000000
				BG:=FFFFFF
				Menu, Tray, Tip,Cursor Info`nBattery is fully charged
				Menu, Tray, Icon,res\Charging.icl,%BP%
			} Else If (BP == 255) {
				Colore:=FF0000
				BG:=FF0000
				Menu, Tray, Tip,Cursor Info`nBattery error
				Menu, Tray, Icon,res\Icon.icl,4
			} Else {
				Colore:=000088
				BG:=rgb2hex(-0R,0G,0)
				Menu, Tray, Tip,Cursor Info`nBattery charging at %BP%`% 
				Menu, Tray, Icon,res\Charging.icl,%BP%
			}
	}
	If VolTogg
	{
		SoundGet, MVol
		If (A_Hour > 22) AND (A_hour < 6) AND (VolDn == 0) AND (MVol >= 25)
		{
			SetTimer, VolUp, Off
			SetTimer, VolDn, %VolTimer%
			Gosub, VolDn
			VolDn = 1
			VolUp = 0
		} 
		If (A_Hour > 6) AND (A_hour < 14) AND (VolUp == 0)
		{
			SetTimer, VolDn, Off
			SetTimer, VolUp, %VolTimer%
			Gosub, VolUp
			VolDn = 0
			VolUp = 1
		} 
		If (A_Hour > 14) AND (A_Hour < 22)		
		{
			SetTimer, VolDn, Off
			SetTimer, VolUp, Off
			VolDn = 0
			VolUp = 0
		}
		If (MVol == 100) AND (VolUp == 1)
		{
			SetTimer, VolUp, Off
		}
		If (MVol == 0) AND (VolDn == 1)
		{
			SetTimer, VolDn, Off
		}
	}
	If CalTogg
	{
		If (CalTopSel == 1)
		{
			CalTop:=A_DDD
		}
		Else If (CalTopSel == 2)
		{
			CalTop:=A_MMM
		}
		
		If (CalBotSel == 1)
		{
			CalBot:=A_DD
		}
		Else If (CalBotSel == 2)
		{
			CalBot:=A_MM
		}
	}
	If WifiTogg
	{
	}
	If NetTogg
	{
		upNew := 0
		dnNew := 0
		
		GetIfTable(tb)
		
		Loop, % DecodeInteger(&tb)
		{
			;Include this codes to exclude the loopback interface.
;			If DecodeInteger(&tb + 4 + 860 * (A_Index - 1) + 516) = 24
;			Continue
			upNew += DecodeInteger(&tb + 4 + 860 * (A_Index - 1) + 576)		; Total Outgoing Octets
			dnNew += DecodeInteger(&tb + 4 + 860 * (A_Index - 1) + 552)		; Total Incoming Octets
		}
		
		upRate := Round((upNew - upOld) / 1024)
		dnRate := Round((dnNew - dnOld) / 1024)
		
		If (NetDis == 1)
		{
			GuiControl,Main: , TUp, %upRate% kb
			GuiControl,Main: , TDn, %dnRate% kb
		}
		Else If (NetDis == 2)
		{
			GuiControl,Main: , PUp, %upRate%
			GuiControl,Main: , PDn, %dnRate%
		}		
		Else If (NetDis == 3)
		{
			GuiControl,Main: , TUp, %upRate% kb
			GuiControl,Main: , TDn, %dnRate% kb
			GuiControl,Main: , PUp, %upRate%
			GuiControl,Main: , PDn, %dnRate%
		}		
		Else If (NetDis == 4)
		{
			GuiControl,Main: , GUp, %upRate%
			GuiControl,Main: , GDn, %dnRate%
		}		
		upOld := upNew
		dnOld := dnNew
	}
return
VolUp:
	SoundSet, +2.5
return
VolDn:
	SoundSet, -2.5
return
CheckCen:
	SysGet, VX, 76
	SysGet, VY, 77
	SysGet, VW, 78
	SysGet, VH, 79
	MouseGetPos,mx,my
	GUIPosx:=(Mx+GxO)
	GUIPosy:=(My-19+GyO)
	Gosub, Slots
	WinMove, CursorInfo, , %GUIPosx%, %GUIPosy%
	winset,alwaysontop,on, CursorInfo
	If BattTogg	{
		GuiControl,Main: Show, BattProg
		GuiControl,Main:, BattProg, %BP%
		If BattBgTogg	{
			GuiControl,Main: +c%Colore% +Background%BG%, BattProg,
		} Else {
			GuiControl,Main: +c%Colore% +BackgroundTrans, BattProg,
		}
	} Else {
		GuiControl,Main: Hide, BattProg
	}
	If ClockTogg {
		GuiControl,Main: Show, ClockGui
		GuiControl,Main:, ClockGui, % A_Hour ":" A_Min
	} Else {
		GuiControl,Main: Hide, ClockGui
	}
	
	WinSet, TransColor, %BG% 150, BattProg
return
Slots:
	
	If (Slot1 == "CaB")
	{
		CaBx:=Slot1x
		CaBy:=Slot1y
	}
	Else If (Slot1 == "Cal")
	{
		Calx:=Slot1x
		Caly:=Slot1y
	}
	Else If (Slot1 == "WiF")
	{
		WiFx:=Slot1x
		WiFy:=Slot1y
	}
	Else If (Slot1 == "Vol")
	{
		Volx:=Slot1x
		Voly:=Slot1y
	}
	Else If (Slot1 == "Dis")
	{
		Disx:=Slot1x
		Disy:=Slot1y
	}
	Else If (Slot1 == "Net")
	{
		Netx:=Slot1x
		Nety:=Slot1y
	}
	Else If (Slot1 == "CPU")
	{
		CPUx:=Slot1x
		CPUy:=Slot1y
	}
	Else If (Slot1 == "Ram")
	{
		Ramx:=Slot1x
		Ramy:=Slot1y
	}
	Else If (Slot1 == "Mai")
	{
		Maix:=Slot1x
		Maiy:=Slot1y
	}
	Else If (Slot1 == "Wea")
	{
		Weax:=Slot1x
		Weay:=Slot1y
	}
	Else If (Slot1 == "Blu")
	{
		Blux:=Slot1x
		Bluy:=Slot1y
	}
	If (Slot2 == "CaB")
	{
		CaBx:=Slot2x
		CaBy:=Slot2y
	}
	Else If (Slot2 == "Cal")
	{
		Calx:=Slot2x
		Caly:=Slot2y
	}
	Else If (Slot2 == "WiF")
	{
		WiFx:=Slot2x
		WiFy:=Slot2y
	}
	Else If (Slot2 == "Vol")
	{
		Volx:=Slot2x
		Voly:=Slot2y
	}
	Else If (Slot2 == "Dis")
	{
		Disx:=Slot2x
		Disy:=Slot2y
	}
	Else If (Slot2 == "Net")
	{
		Netx:=Slot2x
		Nety:=Slot2y
	}
	Else If (Slot2 == "CPU")
	{
		CPUx:=Slot2x
		CPUy:=Slot2y
	}
	Else If (Slot2 == "Ram")
	{
		Ramx:=Slot2x
		Ramy:=Slot2y
	}
	Else If (Slot2 == "Mai")
	{
		Maix:=Slot2x
		Maiy:=Slot2y
	}
	Else If (Slot2 == "Wea")
	{
		Weax:=Slot2x
		Weay:=Slot2y
	}
	Else If (Slot2 == "Blu")
	{
		Blux:=Slot2x
		Bluy:=Slot2y
	}
	If (Slot3 == "CaB")
	{
		CaBx:=Slot3x
		CaBy:=Slot3y
	}
	Else If (Slot3 == "Cal")
	{
		Calx:=Slot3x
		Caly:=Slot3y
	}
	Else If (Slot3 == "WiF")
	{
		WiFx:=Slot3x
		WiFy:=Slot3y
	}
	Else If (Slot3 == "Vol")
	{
		Volx:=Slot3x
		Voly:=Slot3y
	}
	Else If (Slot3 == "Dis")
	{
		Disx:=Slot3x
		Disy:=Slot3y
	}
	Else If (Slot3 == "Net")
	{
		Netx:=Slot3x
		Nety:=Slot3y
	}
	Else If (Slot3 == "CPU")
	{
		CPUx:=Slot3x
		CPUy:=Slot3y
	}
	Else If (Slot3 == "Ram")
	{
		Ramx:=Slot3x
		Ramy:=Slot3y
	}
	Else If (Slot3 == "Mai")
	{
		Maix:=Slot3x
		Maiy:=Slot3y
	}
	Else If (Slot3 == "Wea")
	{
		Weax:=Slot3x
		Weay:=Slot3y
	}
	Else If (Slot3 == "Blu")
	{
		Blux:=Slot3x
		Bluy:=Slot3y
	}
	If (Slot4 == "CaB")
	{
		CaBx:=Slot4x
		CaBy:=Slot4y
	}
	Else If (Slot4 == "Cal")
	{
		Calx:=Slot4x
		Caly:=Slot4y
	}
	Else If (Slot4 == "WiF")
	{
		WiFx:=Slot4x
		WiFy:=Slot4y
	}
	Else If (Slot4 == "Vol")
	{
		Volx:=Slot4x
		Voly:=Slot4y
	}
	Else If (Slot4 == "Dis")
	{
		Disx:=Slot4x
		Disy:=Slot4y
	}
	Else If (Slot4 == "Net")
	{
		Netx:=Slot4x
		Nety:=Slot4y
	}
	Else If (Slot4 == "CPU")
	{
		CPUx:=Slot4x
		CPUy:=Slot4y
	}
	Else If (Slot4 == "Ram")
	{
		Ramx:=Slot4x
		Ramy:=Slot4y
	}
	Else If (Slot4 == "Mai")
	{
		Maix:=Slot4x
		Maiy:=Slot4y
	}
	Else If (Slot4 == "Wea")
	{
		Weax:=Slot4x
		Weay:=Slot4y
	}
	Else If (Slot4 == "Blu")
	{
		Blux:=Slot4x
		Bluy:=Slot4y
	}
	If (Slot5 == "CaB")
	{
		CaBx:=Slot5x
		CaBy:=Slot5y
	}
	Else If (Slot5 == "Cal")
	{
		Calx:=Slot5x
		Caly:=Slot5y
	}
	Else If (Slot5 == "WiF")
	{
		WiFx:=Slot5x
		WiFy:=Slot5y
	}
	Else If (Slot5 == "Vol")
	{
		Volx:=Slot5x
		Voly:=Slot5y
	}
	Else If (Slot5 == "Dis")
	{
		Disx:=Slot5x
		Disy:=Slot5y
	}
	Else If (Slot5 == "Net")
	{
		Netx:=Slot5x
		Nety:=Slot5y
	}
	Else If (Slot5 == "CPU")
	{
		CPUx:=Slot5x
		CPUy:=Slot5y
	}
	Else If (Slot5 == "Ram")
	{
		Ramx:=Slot5x
		Ramy:=Slot5y
	}
	Else If (Slot5 == "Mai")
	{
		Maix:=Slot5x
		Maiy:=Slot5y
	}
	Else If (Slot5 == "Wea")
	{
		Weax:=Slot5x
		Weay:=Slot5y
	}
	Else If (Slot5 == "Blu")
	{
		Blux:=Slot5x
		Bluy:=Slot5y
	}
	If (Slot6 == "CaB")
	{
		CaBx:=Slot6x
		CaBy:=Slot6y
	}
	Else If (Slot6 == "Cal")
	{
		Calx:=Slot6x
		Caly:=Slot6y
	}
	Else If (Slot6 == "WiF")
	{
		WiFx:=Slot6x
		WiFy:=Slot6y
	}
	Else If (Slot6 == "Vol")
	{
		Volx:=Slot6x
		Voly:=Slot6y
	}
	Else If (Slot6 == "Dis")
	{
		Disx:=Slot6x
		Disy:=Slot6y
	}
	Else If (Slot6 == "Net")
	{
		Netx:=Slot6x
		Nety:=Slot6y
	}
	Else If (Slot6 == "CPU")
	{
		CPUx:=Slot6x
		CPUy:=Slot6y
	}
	Else If (Slot6 == "Ram")
	{
		Ramx:=Slot6x
		Ramy:=Slot6y
	}
	Else If (Slot6 == "Mai")
	{
		Maix:=Slot6x
		Maiy:=Slot6y
	}
	Else If (Slot6 == "Wea")
	{
		Weax:=Slot6x
		Weay:=Slot6y
	}
	Else If (Slot6 == "Blu")
	{
		Blux:=Slot6x
		Bluy:=Slot6y
	}
	If (Slot7 == "CaB")
	{
		CaBx:=Slot7x
		CaBy:=Slot7y
	}
	Else If (Slot7 == "Cal")
	{
		Calx:=Slot7x
		Caly:=Slot7y
	}
	Else If (Slot7 == "WiF")
	{
		WiFx:=Slot7x
		WiFy:=Slot7y
	}
	Else If (Slot7 == "Vol")
	{
		Volx:=Slot7x
		Voly:=Slot7y
	}
	Else If (Slot7 == "Dis")
	{
		Disx:=Slot7x
		Disy:=Slot7y
	}
	Else If (Slot7 == "Net")
	{
		Netx:=Slot7x
		Nety:=Slot7y
	}
	Else If (Slot7 == "CPU")
	{
		CPUx:=Slot7x
		CPUy:=Slot7y
	}
	Else If (Slot7 == "Ram")
	{
		Ramx:=Slot7x
		Ramy:=Slot7y
	}
	Else If (Slot7 == "Mai")
	{
		Maix:=Slot7x
		Maiy:=Slot7y
	}
	Else If (Slot7 == "Wea")
	{
		Weax:=Slot7x
		Weay:=Slot7y
	}
	Else If (Slot7 == "Blu")
	{
		Blux:=Slot7x
		Bluy:=Slot7y
	}
	If (Slot8 == "CaB")
	{
		CaBx:=Slot8x
		CaBy:=Slot8y
	}
	Else If (Slot8 == "Cal")
	{
		Calx:=Slot8x
		Caly:=Slot8y
	}
	Else If (Slot8 == "WiF")
	{
		WiFx:=Slot8x
		WiFy:=Slot8y
	}
	Else If (Slot8 == "Vol")
	{
		Volx:=Slot8x
		Voly:=Slot8y
	}
	Else If (Slot8 == "Dis")
	{
		Disx:=Slot8x
		Disy:=Slot8y
	}
	Else If (Slot8 == "Net")
	{
		Netx:=Slot8x
		Nety:=Slot8y
	}
	Else If (Slot8 == "CPU")
	{
		CPUx:=Slot8x
		CPUy:=Slot8y
	}
	Else If (Slot8 == "Ram")
	{
		Ramx:=Slot8x
		Ramy:=Slot8y
	}
	Else If (Slot8 == "Mai")
	{
		Maix:=Slot8x
		Maiy:=Slot8y
	}
	Else If (Slot8 == "Wea")
	{
		Weax:=Slot8x
		Weay:=Slot8y
	}
	Else If (Slot8 == "Blu")
	{
		Blux:=Slot8x
		Bluy:=Slot8y
	}
return

GetIfTable(ByRef tb, bOrder = True){ ; By Sean
	nSize := 4 + 860 * GetNumberOfInterfaces() + 8
	VarSetCapacity(tb, nSize)
	Return DllCall("iphlpapi\GetIfTable", "Uint", &tb, "UintP", nSize, "int", bOrder)
}
GetIfEntry(ByRef tb, idx){ ; By Sean
   VarSetCapacity(tb, 860)
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", &tb + 512, "Uint", 4, "Uint", idx)
   Return DllCall("iphlpapi\GetIfEntry", "Uint", &tb)
}
GetNumberOfInterfaces(){ ; By Sean
   DllCall("iphlpapi\GetNumberOfInterfaces", "UintP", nIf)
   Return nIf
}
DecodeInteger(ptr){ ; By Sean
   Return *ptr | *++ptr << 8 | *++ptr << 16 | *++ptr << 24
}

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
		if (cT = Trans)	{
			WinSet, Transparent, OFF, A
		}	else	{
			WinSet, Transparent, %Trans%, A
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
		SimpleNP:=1
		Gosub, GetPlaying
		SimpleNP:=0
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
		SimpleNP:=1
		Sleep, 300
		Gosub, GetPlaying
		SimpleNP:=0
	return
	!F11::
		SendInput {F11}
	return
	F12::
		SendInput {Media_Next}
		SimpleNP:=1
		Sleep, 300
		Gosub, GetPlaying
		SimpleNP:=0
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
;	XButton1::
;		if WinActive("VLC media player") WinActive("Winamp") {
;			Send {Media_Prev}
;		}
;	XButton2::
;		if WinActive("VLC media player") WinActive("Winamp") {
;			Send {Media_Next}
;		}
	~MButton::
		if WinActive("ahk_class WorkerW") {
			SendMessage, 0x112, 0xF170, 2,, Program Manager
		} Else If WinActive("Winamp","ahk_class BaseWindow_RootWnd") {
			Send {Media_Play_Pause}
		} Else If WinActive(,"ahk_class QWidget") {
			Send {Media_Play_Pause}
		}
	return
}
#If NPTogg = 1
{
	PrintScreen::
		SimpleNP:=0
		Gosub, GetPlaying
		If WifiTogg
		{
			ToolTip, % "Wifi=" Sig "%@" WhyFi
			Sleep, 3000
			ToolTip,
;			Sleep, 1000
;			Gui,2: Destroy
;			Gui,3: Font, s12 cFFFFFF
;			Gui,3: Add, Text, x0 y0 vPP Hidden BackgroundTrans, % "Wifi=" Sig "%@" WhyFi
;			Sleep, 300
;			GUI,3: +HwndClockAndBattery2 +E0x80000 +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
;			Gui,3: Color, 111112
;			WinSet, Transparent, %Trans%, ClockAndBattery2
;			Gui,3: show, x%mX% y%mS% h18 NA, ClockAndBattery2
;			GuiControl, 3: Show, PP
;			Sleep, 3000
;			Gui,3: Destroy
		} Else {
;			Sleep, 3000
;			Gui,2: Destroy
		}		
	Return
	!PrintScreen::
	SendInput {PrintScreen}
	Return
}
GetPlaying:
	#EscapeChar \ ;============[ Based on Purkki's "NowPlaying" ]
	SetTitleMatchMode 2
	DetectHiddenWindows On
	IfWinExist, VLC media player
	{
		WinGetTitle, vlcTitle
		NPSong:=VLC()
		ToolTip, % NPSong " " TE "/" TT
		Sleep, 3000
		ToolTip,
;		Gui,2: Font, s12 cFFFFFF
;		Gui,2: Add, Text, x0 y0 vPP Hidden BackgroundTrans, % NPSong " " TE "/" TT
;		Sleep, 300
;		GUI,2: +HwndClockAndBattery2 +E0x80000 +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
;		Gui,2: Color, 111112
;		WinSet, Transparent, %Trans%, ClockAndBattery2
;		Gui,2: show, x%mX% y%mS% h18 NA, ClockAndBattery2
;		GuiControl, 2: Show, PP
	} 
	Else IfWinExist, - Winamp	
	{
		WinGetTitle, winampTitle
		song := RegExReplace(winampTitle, "^[0-9]*\. (.*) - Winamp$", "$1")
		TE:=Winamp("0")
		TT:=Winamp("1")
		TE:=TE/1000
		TE:=FormatSeconds(TE)
		TT:=FormatSeconds(TT)
		NPSong:= RegExReplace(Song, "([!\+\^#])", "{$1}")
		If SimpleNP
		{
			ToolTip, % NPSong
			Sleep, 1500
		} Else {
			ToolTip, % NPSong " " TE "/" TT
			Sleep, 3000
		}
		ToolTip,
;		Gui,2: Font, s12 cFFFFFF
;		Gui,2: Add, Text, x0 y0 vPP Hidden BackgroundTrans, % NPSong " " TE "/" TT
;		Sleep, 300
;		GUI,2: +HwndClockAndBattery2 +E0x80000 +E0x20 +toolwindow -caption -border -Resize +LastFound +AlwaysOnTop +Disabled
;		Gui,2: Color, 111112
;		WinSet, Transparent, %Trans%, ClockAndBattery2
;		Gui,2: show, x%mX% y%mS% h18 NA, ClockAndBattery2
;		GuiControl, 2: Show, PP
	}
return
VLC(){ ; by Cardellos
	VLCURL:="http://:1@127.0.0.1:8080/requests/status.xml?%A_Hour%%A_Min%%A_Sec%"
	UrlDownloadToFile, VLCURL ,Vlcstatus
	FileRead, FullPage, Vlcstatus
	Filename=siU)\<info name\=\"filename\"\>(.*?)\<\/info\>
	RegExMatch(FullPage,Filename,Get)
	If Not (Get="")
	{
		return Get1
	} Else {
		Errorname=siU)\<h1\>(.*?)\<\/h1\>
		RegExMatch(FullPage,Errorname,Error)
		ToolTip, %Error1%
		Sleep 3000
		ToolTip,
	}
}
Winamp(O){ ; by Cardellos
    DetectHiddenWindows On
	SendMessage 0x400,O,105,,ahk_class Winamp v1.x
    return ErrorLevel
}
	
;==[Close]
GuiClose:
ExitApp
GuiSetClose:
	Gui,Set: Destroy
return
CancelSMG:
	Gui,SMG: Destroy
return
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
