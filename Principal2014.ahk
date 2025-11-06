
vars()
{
	global
	discopd = g
}


;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;******************** Script **************

^!r::Reload

::exit--::
ExitApp

;************************Consola******************

!-::
IfWinExist consola autohotkey: Bloc de notas
{
    WinActivate
}
else
{
	run C:\Users\[erased path for privacy]\consola autohotkey.txt
}
return

cierraconsola(){
IfWinExist consola autohotkey: Bloc de notas
	{
		WinActivate
		send !{f4}
		winwait Bloc de notas,,3
		send n
	}
}

!.::
IfWinExist consola autohotkey: Bloc de notas
	{
		cierraconsola()
	}
return

	;ENLACES WEB
::w.cer-::
cierraconsola()
Run www.cerebritos.cl
return
::w.cercp-::
cierraconsola()
Run www.[erased path for privacy]
return
::w.aut-::
cierraconsola()
Run www.autohotkey.com
return
::w.sep-::
cierraconsola()
Run http://www.sepomo.com/hd/index.php?lang=Spanish
return
::w.yah-::
cierraconsola()
Run https://login.yahoo.com/[erased path for privacy]
return
::w.fac-::
cierraconsola()
Run www.facebook.com
return
::fav-::
cierraconsola()
run notepad
winwait Sin
send [DEFAULT]{Enter}BASEURL=%clipboard%{Enter}URL=%clipboard%{Enter}IDList={Enter}
send ^g
winwait Guardar
send !o
sleep 200
send C:\Users\[erased path for privacy]\favGlobal\favHP
return
	;ABRIR ARCHIVOS Y PROGRAMAS
::/e:-::
cierraconsola()
vars()
run, %discopd%:\
return

::/m:-::
cierraconsola()
run, m:\
return

::/docs-::
cierraconsola()
run C:\
winactivate
click 90,238
return

::/pc-::
cierraconsola()
run C:\
winactivate
click 140,46
return

::2--::
cierraconsola()
IfWinExist Proyecto Cerebritos - Microsoft Excel
	{
		WinActivate
	}
	else
	{
		Run M:\carpeta global\pryct cbrts 2\Proyecto Cerebritos.xlsx, , UseErrorLevel
		if ErrorLevel
			MsgBox, Genio,`n`nsi quieres ver lo que está prohibido`n`nprimero debes desencriptar el archivo encripatado`n`nOK ???
	}
return

::ntp-::
cierraconsola()
run notepad
return

::indes-::
send [erased from the code for privacy]
send {tab}
send [erased from the code for privacy]
return
::@sh::[erased from the code for privacy]
::@ry::[erased from the code for privacy]

::winspy::
cierraconsola()
	run C:\Program Files\AutoHotkey\AU3_Spy.exe
	winwait Active Window Info (Shift-Alt-Tab to freeze display)
	WinMove, 0, 190
	return
::ahkf1-::
cierraconsola()
	IfWinExist AutoHotkey Help
	{
		WinActivate
	}
	else
	{
		run C:\Program Files\AutoHotkey\AutoHotkey.chm
	}
	return
::gpsahk-::
	run C:\Users\[erased path for privacy]\negocios\Ingresos extra\scriptOnlineAVL.ahk
	return
::lupo-::
cierraconsola()
	vars()
	Run %discopd%:\Ale\Lupo_PenSuite_v2010.02_Full\Lupo_PenSuite.exe
	return
::qdir-::
	cierraconsola()
	IfWinExist Q-Dir 3.95
	{
		winactivate
		winmove, 70,20
	}
	else
	{
		vars()
		Run %discopd%:\Ale\Lupo_PenSuite_v2010.02_Full\Apps\Q-Dir\Q-Dir.exe
		winwait Q-Dir 3.95
		send !aa
		winwait Abrir
		click 247,138
		keywait, Enter, D
		SetTimer, espera3, 1000
	}
	return
	
	espera3:
		IfWinExist Q-Dir 3.95
		{
			winactivate
			winmove, 70,20
		}
		SetTimer, espera3, Off
		return
::n:on-::
cierraconsola()
vars()
	Run C:\Program Files\TrueCrypt\TrueCrypt.exe
	Winwaitactive TrueCrypt
	click 160,160
	sleep 200
	send n!v{enter}
	Winwaitactive Select a TrueCrypt Volume
	send !o
	send %discopd%:\store\Virus Troyano - formatea el disco duro irremediablemente
	sleep 400
	send {enter}
	send !m
	keywait Shift, D
	sleep 300
	send {enter}
	keywait Shift, D
	send !x
	return
::m:on-::
cierraconsola()
vars()
	Run C:\Program Files\TrueCrypt\TrueCrypt.exe
	Winwaitactive TrueCrypt
	click 160,160
	sleep 200
	send m!v{enter}
	Winwaitactive Select a TrueCrypt Volume
	send !o
	send %discopd%:\rds4-gfcv
	sleep 400
	send {enter}
	send !m
	keywait Shift, D
	sleep 300
	send {enter}
	keywait Shift, D
	send !x
	return
::n:off::
cierraconsola()
	Run C:\Program Files\TrueCrypt\TrueCrypt.exe
	Winwaitactive TrueCrypt
	send n!d
	Winactivate TrueCrypt
	send s
	keywait Shift, D
	send !x
	return
::ntp+-::
cierraconsola()
	Run %discopd%:\Ale\Lupo_PenSuite_v2010.02_Full\Apps\Notepad++\Notepad++_FULL.exe
	return
::flzla-::
cierraconsola()
	Run %discopd%:\Ale\Lupo_PenSuite_v2010.02_Full\Apps\FileZilla\FileZilla.exe
	Winwaitactive FileZilla
	winmove, 388,132
	send ^s{enter}
	return
::gimp-::
cierraconsola()
	Run %discopd%:\Ale\Lupo_PenSuite_v2010.02_Full\Apps\GIMP Portable\GIMPPortable.exe
	return
::pnt-::
cierraconsola()
	run C:\Windows\System32\mspaint.exe
	return

;---------------------------------------------------------------------- < exclusivo netbook hp
::5mil-::
	cierraconsola()
	run C:\Users\[erased path for privacy]\Negocios\[erased path for privacy].ods
return

^!c::
	send {PrintScreen}
	run C:\Windows\System32\mspaint.exe
	Sleep, 1000
	send ^v
return

::arregla-::
	send {Down}{Backspace}
return

::montar-::
cierraconsola()
	Run C:\Program Files\TrueCrypt\TrueCrypt.exe
	Winwaitactive TrueCrypt
	click 160,160
	sleep 200
	send o
	keywait Shift, D
	send !v{enter}
	Winwaitactive Select a TrueCrypt Volume
	keywait Shift, D
	send {enter}
	send !m
	sleep 300
	keywait Shift, D
	sleep 300
	send {enter}
	keywait Shift, D
	send !x
return

::desmon-::
cierraconsola()
	Run C:\Program Files\TrueCrypt\TrueCrypt.exe
	Winwaitactive TrueCrypt
	send n
	keywait Shift, D
	send !d
	Winactivate TrueCrypt
	send s
	sleep 300
	keywait Shift, D
	send !x
return
;____________________________________DOCUMENTOS EN NOTEPAD____________________________________________

::editar1-::
	Run notepad
	winwait Sin 
	send ^a
	winwait Abrir
	send !o
	send C:\[erased path for privacy]\Documents\Principal.ahk
	sleep 500
	send {enter}
	msgbox, 4, , fin del script, Do you want close the console?
	IfMsgBox, Yes
	{	cierraconsola()
	}
	IfMsgBox, No
	{
		WinActivate consola
	}
return

::editar2-::
	Run notepad
	WinWait Sin
	send ^a
	WinWait Abrir
	send !o
	send C:\Users\[erased path for privacy]\negocios\Ingresos extra\scriptOnlineAVL.ahk
	sleep 500
	send {enter}
	msgbox, 4, , fin del script, Do you want close the console?
	IfMsgBox, Yes
	{
		cierraconsola()
	}
return

::editarhp-::
	Run notepad
	WinWait Sin
	send ^a
	WinWait Abrir
	send !o
	send C:\Users\[erased path for privacy]\teclas extra.ahk
	sleep 500
	send {enter}
	msgbox, 4, , fin del script, Do you want close the console?
	IfMsgBox, Yes
	{
		cierraconsola()
	}
return
;---------------------------------------------------------------------------- exclusivo netbook hp>

::1--::
cierraconsola()
	IfWinExist tareas
	{
		WinActivate
	}
	else
	{
		Run, M:\carpeta global\tareas.rtf, , UseErrorLevel
		if ErrorLevel
			MsgBox, Genio,`n`nsi quieres ver lo que está prohibido`n`nprimero debes desencriptar el archivo encripatado`n`nOK ???
	}
return

;*************************************CARPETA VIZ ***************************************************
::tempo-::
	vars()
	run %discopd%:\store\tempo.txt
	msgbox, 4, , fin del script, Do you want close the console?
	IfMsgBox, Yes
	{	cierraconsola()
	}
	IfMsgBox, No
	{
		WinActivate consola
	}
return

::thoughts-::
	run M:\carpeta global\VIZ\thoughts.txt
	msgbox, 4, , fin del script, Do you want close the console?
	IfMsgBox, Yes
	{	cierraconsola()
	}
	IfMsgBox, No
	{
		WinActivate consola
	}
return

::soc-::
	run M:\carpeta global\VIZ\soc.txt
	cierraconsola()
return

::filo-::
	run M:\carpeta global\VIZ\filo.txt
	msgbox, 4, , fin del script, Do you want close the console?
	IfMsgBox, Yes
	{
		cierraconsola()
	}
return

::sico-::
	run M:\carpeta global\VIZ\sico.kpf.komodoproject
	cierraconsola()
return

::lang-::
	run M:\carpeta global\VIZ\language.txt
	cierraconsola()
return

::noncom-::
	run M:\carpeta global\VIZ\ideas no comerciales.txt
	cierraconsola()
return

::cliente-::
	run M:\carpeta global\VIZ\cliente.txt
	cierraconsola()
return

::will-::
	run M:\carpeta global\VIZ\will.komodoproject
	cierraconsola()
return

;************************************************************************
;___________________________________________________________________________________________

	; HTML CSS
::html-::<html>{enter}{enter}<head>{enter}{tab}<title></title>{enter}</head>{enter}{enter}<body>{enter}</body>{enter}{enter}</html>
::style-::<style>{enter}</style>
::aclass::a:link{tab}{tab}{{}{}}{enter}a:visited{tab}{{}{}}{enter}a:active{tab}{{}{}}{enter}a:hover{tab}{tab}{{}{}}
::table-::<table><tr><td>{enter}</td></tr></table>
	;JAVASCRIPT
::<s::<script language="javascript">{enter}{tab}{enter}</script>
::docw::document.write("");
::gete::document.getElementById('')
::ifmie::if (navigator.appName=="Microsoft Internet Explorer"){}
