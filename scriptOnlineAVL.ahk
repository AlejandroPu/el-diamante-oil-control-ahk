ruta := "D:\Mis Documentos HD\dinero\transportes El Diamante"
vars2()
{
	global
	desde = 1				;// desde qué camión
	hasta = 24				;// hasta qué camión
	desfase = 0				;// camión 1 de excel en gps será 1+desfase
}


;// Resumen de scripts 
	;// ^!t 
	;// editarems- 
	;// w.cop1- 
	;// gps- 
	;// emstif- 
	;// ^m 			406
	;// /libro- 
;// Lista de funciones 
	;// buscaPos( nombreImagen, xPlus, yPlus) {						;// función hecha para w.cop1
	;// evaluames()
	;// ultimodiadelmes(mes)
	;// esperaShift()
	;// cierraconsola2()
	;// monthPutName(nOfMonth){						;// It receive a number as string of two digits, return the name of the month as %realName%
	
^!t::Reload

::editarems-::
	cierraconsola3("")
	Run, C:\Program Files\Notepad++\notepad++.exe "D:\Mis Documentos HD\dinero\transportes El Diamante\scriptOnlineAVL.ahk", ,max
return

::w.cop1-::
	cierraconsola3("")
	sleep, 500
	MsgBox, 4, , `¿ Desea descargar el informe del mes actual`?`nNo`, para descargar el del mes pasado`.
	selMenuPos = 5											;// selMenuPos es el desfase con el eje Y al momento de buscar la opción en el menú correspondiente
	IfMsgBox No
		selMenuPos = -5
	sleep, 500
	
	;run https://www.copec.cl/wp7/wps/myportal	;// Navegar a web de Copec
	run https://tctcliente.copec.cl/
							;// buscar coordenadas de casilleros rut y contraseña
	buscaPos( "imagenInicioSesion", 80, 5)		;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus 
	click %posX%, %posY%				;// hace click dentro del casillero de rut

	sleep, 500
	send [erased from this code for privacy]{tab}[erased from this code for privacy]{enter}					;// ingresa rut y contraseña


															;// buscar coordenadas del menu TCT
	buscaPos( "imagenInicioSesion2", 0, 5)					;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus
	mousemove %posX%, %posY%								;// abre menu TCT

															;// busca opción productos
	buscaPos( "imagenInicioSesion3", 0, 5)					;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus
	click %posX%, %posY%									;// click en opción productos del menu TCT
	msgbox, hasta aquí todo ok
															;// busca opción Rendimientos diarios o Informes 
	buscaPos( "imagenInicioSesion4b", 0, selMenuPos)			;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus
	click %posX%, %posY%									;// click en Rendimientos diarios	

															;// busca opción Descargar Excel
	buscaPos( "imagenInicioSesion5", 15, 12)				;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus
	click %posX%, %posY%									;// click en Descargar Excel
	WinWait Guardar como

	click 154,60											;// click para colocar ruta donde guardar
	sleep 500
	send D:\Descargas HD\InformesEMS{Enter}{Tab}			;// {Tab} permite que send !n pueda activar el casillero del nombre del archivo a guardar 
	sleep, 500
	send !n
	sleep, 500
	clipboard =
	Send, ^c												;// se copia el nombre del archivo que se guardará
	ClipWait, 1
	send !g	

	buscaPos( "imagenInicioSesion6b", 60, 30)				;// una vez la descarga está lista, abre el archivo
	Run D:\Descargas HD\InformesEMS\%clipboard%				;// abre el archivo del informe de copec
	Sleep, 2000
	MsgBox, script finalizado puede continuar con VBA
return

buscaPos( nombreImagen, xPlus, yPlus) {						;// función hecha para w.cop1
	CoordMode Pixel, Window  	;// Interprets the coordinates below as relative to the screen rather than the active window.
	encontrada := 0		;// solo para el caso de nombreImagen = imagenInicioSesion6
	contador := 0		;// lleva la cuenta de las vueltas del loop de la siguiente línea
	contadorExceso := 0
	Loop
	{
		Sleep, 200
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *2 D:\[erased for privacy]\imgs\%nombreImagen%.PNG
		if ( nombreImagen == "imagenInicioSesion2" )
		{
			sleep 200
			click 100, 400											;// elimina el popup publicitario de la página, después de logearse
			sleep 200
		}
		contador := contador + 1
		Sleep, 200
		condicion := ( ErrorLevel != 1 ) || ( contador > 10 )		;// condicion = ( se encontró la imagen ) o ( ha intentado encontrarla más de 10 veces)
		
																	;// cuando nombreImagen es "imagenInicioSesion6" hay que esperar que el archivo se descarge,
																	;// luego esta función simplemente permite que el script continúe.
		if ( ( nombreImagen == "imagenInicioSesion6" )||( contador <= 20) )	;// IF- ( caso nombreImagen = imagenInicioSesion6) o ( ha intentado encontrarla menos de 20 veces )
		{
			condicion := 0											;// anula la condicion anterior, para aplicar esta condición especial en el proceso de descarga del archivo
			if ( ErrorLevel != 1 )									;// IF- se encontró la imagen
				encontrada := encontrada + 1
			if (encontrada == 3)									;// IF- el proceso de encontrar la imagen ha ocurrido esta cantidad de veces
				condicion := 1										;//			para evitar identificación falsa de la imagen, por cambios durante proceso de descarga
		}	
		if ( contador > 20 )
		{
				condicion := 1
				contadorExceso := 1
		}		
		;// msgBox % " ErrorLevel: " . ErrorLevel . " , contador: " . contador . " , encontrada(solo descarga): " . encontrada . " , condición(encontrada=4): " . condicion
	}
	Until (condicion)
	
	if ErrorLevel = 2
		MsgBox No se pudo llevar a cabo la búsqueda de la imágen.
	else if ErrorLevel = 1
	{
		MsgBox No fue posible encontrar la imágen en la pantalla.
	}
	else if contadorExceso = 1
	{
		MsgBox El script espero demasiado tiempo sin poder detectar una descarga exitosa.
	}
	else
	{
		global posX := FoundX + xPlus
		global posY := FoundY + yPlus
	}	
}

::gps-::
	cierraconsola3("")
	sleep 1000
	Run, C:\Users\retac\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Navman Wireless\OnlineAVL2.appref-ms
	winwait Conectado a Navman Wireless OnlineAVL 2
	sleep 1000
	click 100,160
	sleep 1000
	send [erased from this code for privacy]{Enter}
return

;----------------------------------------------EMSTIF
::emstif-::
	cierraconsola3("")
	sleep 1000
	guardo1vez = 0		; ya guardó un informe? si lo hizo, ya está guardando en la carpeta correcta
	vars2()
	desdeoriginal :=desde
	hastaoriginal :=hasta
	InputBox, desde, ingreso de la variable "desde", La variable "desde" es %desde%. ingresa nueva variable Si ingresas una variable menor se ocupara la original,
	InputBox, hasta, ingreso de la variable "hasta", La variable "hasta" es %hasta%. Ingresa nueva variable "hasta". Si ingresas una variable menor o nada se ocupara la original,
	InputBox, tipoInforme, Tipo de informe, Ingrese tipo de informe deseado( TIF - EXC(Default) - CSV - XML)
	InputBox, tiempoNext, Tiempo loop seleccion camion, Tiempo loop seleccion camion( en milisegundos - default = 1000)
	if (desde = "")
		desde := desdeoriginal
	if (hasta = "")
		hasta := hastaoriginal
	if (tipoInforme = "")
		tipoInforme := "EXC" ; TIF EXC CSV XML
	if (tiempoNext = "")
		tiempoNext = 1000

    if desde > %desdeoriginal%
    {
	if desde > %hasta%
	{
		msgbox Variable "desde" es mayor que "hasta". Corrije las variables al principio del programa y ejecuta de nuevo el script.
		return
	}
	avance :=desde-(desfase+1)
	WinActivate Navman
	sleep 500
	Loop, %avance%
	{
		send {Down}
		sleep %tiempoNext%
	}
    }
    else
	desde=%desdeoriginal%
 PrincipioEms2:
	cuenta := 9
	Run, %ruta%\%desde%.txt							;// Open txt of periods to consult
	winwait %desde%
	sleep 1000
	send {down}
	send {Down}+{Right}+{Right}^c					;// look if final day = "fi"
	Sleep, 200
	diafinal=%clipboard%
	send {home}{Up}
	Sleep, 200
	while diafinal != "fi"
	{
		cuenta += 1
		;--------------------------------------------declarando variables fecha de inicio
		winactivate %desde%				;copia dia inicial
		send +{Right}+{Right}^c
		Sleep, 200
		diainicial=%clipboard%
		send {Right}{Right}+{Right}+{Right}+{Right}^c		;copia el mes inicial
		Sleep, 200
		evaluames()
		mesinicial=%clipboard%
		send {Right}{Right}+{Right}+{Right}^c		;copia hora inicial
		Sleep, 200
		horainicial=%clipboard%
		send {Right}{Right}+{Right}+{Right}^c				;copia minutos inicial
		Sleep, 200
		minutosinicial=%clipboard%
		;--------------------------------------------declarando variables fecha Término
		send {Down}{Home}+{Right}+{Right}^c			;copia dia final
		Sleep, 200
		diafinal=%clipboard%
		send {Right}{Right}+{Right}+{Right}+{Right}^c		;copia el mes final
		Sleep, 200
		evaluames()
		mesfinal=%clipboard%
		send {Right}{Right}+{Right}+{Right}^c		;copia hora final
		Sleep, 200
		horafinal=%clipboard%
		send {Right}{Right}+{Right}+{Right}^c				;copia minutos final y ubica el cursor al inicio de la línea
		Sleep, 200
		minutosfinal=%clipboard%
		send {Home}
		;--------------------------------------------corrección de variables iniciales
		ultimodiadelmesvar = mesinicial-1
		ultimodiadelmes(ultimodiadelmesvar)
		ultimodia=%clipboard%
		if (minutosinicial<10)
		{
			minutosinicial+=50
				if (horainicial=00)
				{
				horainicial=23
					if (diainicial=01)
					{
					diainicial=ultimodia
					mesinicial-=1
					}
					else
					{
					diainicial-=1
					}
				}
				else
				{
				horainicial-=1
				}
			}
		else
		{
			minutosinicial-=10
		}
		;--------------------------------------------corrección de variables finales
		ultimodiadelmesvar = mesfinal-1
		ultimodiadelmes(ultimodiadelmesvar)
		ultimodia=%clipboard%
		if (minutosfinal<10)
		{
			minutosfinal+=50
				if (horafinal=00)
				{
				horafinal=23
					if (diafinal=01)
					{
					diafinal=ultimodia
					mesfinal-=1
					}
					else
					{
					diafinal-=1
					}
				}
				else
				{
				horafinal-=1
				}
		}
		else
		{
			minutosfinal-=10
		}
		;--------------------------------------------corrección de año
		FormatTime, anioActual, , yyyy
		FormatTime, mesActual, , M
		
		;// Si dato mesinicial es de Septiembre a Diciembre, y mes actual es de Enero a Mayo,
		;//				entonces añoInicial es año pasado y añoFinal es año actual
		;// sino, anioInicial = anioFinal = año actual
		if ( ( mesinicial > 9 ) AND ( mesActual < 5 ) )
		{
			anioInicial := anioActual - 1
			;// si mesfinal > 9, anioFinal es anioActual - 1
			if ( mesfinal > 9 )
				anioFinal := anioActual - 1
			else
				anioFinal := anioActual
		} else {
			anioInicial := anioActual
			anioFinal := anioActual
		}

		;--------------------------------------------colocar datos en solicitud de ems
		WinActivate Navman
		sleep 500
		send !r
		send ep{enter}
		WinWait Criterios		;coloca dia inicial
		winactivate
		;MsgBox anio %anioInicial% mes %mesinicial% anio %anioFinal% mes %mesfinal%
		sleep 800
		click 144,583
		sleep, 200
		send {Right}{Right}
		sleep, 200
		send %anioInicial%{left}		;esto se coloca a principios de año
		sleep, 700					;cuando "Criterios..." abre con el nuevo año
		send %mesinicial%{left}
		sleep, 200
		send %diainicial%
	;			sleep, 500					;(después de año nuevo)
	;			send {Right}{Right}{Down}			; bcxbf
		send {Tab}
		sleep, 200
		send %horainicial%{Right}
		sleep, 200
		send %minutosinicial%{Tab}
		sleep, 200
		send {Right}{Right}%anioFinal%
		sleep, 200
		send {left}
		sleep, 700
		send %mesfinal%{left}
		sleep, 200
		send %diafinal%{Tab}
		sleep, 200
		send %horafinal%{Right}
		sleep, 200
		send %minutosfinal%
		sleep 200
		send !i
		winwait, Visualizador, , 120
		if ErrorLevel
		{
		    send {enter}
		}
		winwait, Visualizador, , 60
		if ErrorLevel
		{
			goto, sigInforme
			MsgBox Ha pasado 3 minutos sin entregar el informe
			return
		}
										;DEBE ESTAR EL INFORME EMS EN PANTALLA
		IfWinExist, Visualizador
		    WinActivate
		else
		    sleep 20000
		winwait, Visualizador, , 10
		if ErrorLevel
		{
			MsgBox El Visualizador de informes no aparece
			return
		}
		sleep 500
		guardarInformetif:
			sleep 500
			click 444, 56
			sleep 1000
			if (tipoInforme = "TIF")
				click 480, 220
			else if (tipoInforme = "EXC")
				click 480, 192
			else if (tipoInforme = "CSV")
			{
				MouseMove, 400, 109, 15
				click 480, 109
			}
			else if (tipoInforme = "XML")
				click 480, 83
			else
				msgbox ningún tipo seleccionado
			
			WinWait, Guardar, ,2
			sleep, 300
			;IfWinExist, Guardar
			;	WinActivate
			If ErrorLevel
			{
				goto, guardarInformetif
			}
			if( guardo1vez == 0 ){
				click 155, 60
				;buscaPos( "guardaInformeUrl", 2, 10)		;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus 
				;click %posX%, %posY%						;// hace click dentro del casillero de rut
				Sleep, 500
				;click 800,62
				;Sleep, 500
				SendInput {Raw}%ruta%\informes
				send {enter}
				guardo1vez = 1
				sleep 500
			}
			;click 155, 60
			;sleep, 500			
			click 300, 175
			sleep, 500
			Send, !n
			;buscaPos( "guardaInformeNombre", 130, 20)		;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus 
			;click %posX%, %posY%							;// hace click dentro del casillero de rut
			Sleep, 500
			Send, {Home}
			Sleep, 400
			Send, +{End}
			Sleep, 500
			SendInput {Raw}informe%desde%_%cuenta%_%mesinicial%-%diainicial%_%horainicial%-%minutosinicial%
			;Send, informe%desde%_%mesinicial%-%diainicial%_%horainicial%-%minutosinicial%
			sleep, 500
			send {enter}s
			Loop {
				winactivate Visualizador
				sleep, 500
				ifWinExist, Visualizador
					send !{f4}											;cierra el visualizador
				sleep, 500
			} Until !WinExist("Visualizador de Informes")
			sleep, 500
			winactivate %desde%								;// mira si dia final="fi"
			sleep, 500
			send {Down}+{Right}+{Right}^c	
			Sleep, 200
			diafinal=%clipboard%
			send {home}{Up}
			Sleep, 200
	} 														;// while diafinal != "fi"
	sleep, 500
	send !{f4}												;// cierra txt fuente
	sleep, 500
	sigInforme:
	sleep, 3000
	desde+=1
	if (desde>hasta)
	{
		MsgBox desde es mayor a %hasta% y esto deberia terminar
		cierraconsola3("")
		return
	}
	WinActivate Navman
	sleep, 2000
	send {Down}
	sleep, 2000
	goto, PrincipioEms2
return

; probar qué pasa cuando pasan 3 minutos esperando el informe, con winwait cualquierCosa
;---------------------------------------------- FIN EMSTIF

::prueba-::
	; utilizar para probar lo que sea
				cierraconsola3("")
				;CoordMode, ToolTip|Pixel|Mouse|Caret|Menu [, Screen|Window|Client]
				;CoordMode, ToolTip, Screen
				sleep 3000
				buscaPos( "guardaInformeNombre", 130, 10)		;// funcion(nombreImagen, xPlus, yPlus). Devuelve pos (x,y) de la imagen + los respectivos plus 
				click %posX%, %posY%							;// hace click dentro del casillero de rut
				;click 155, 60
				;MsgBox, pos %posX% %posY% 

return

^m::
	MouseClickDrag, L, 780, 1010, 0, 77, 5
	sleep 200
	MouseClickDrag, L,586,90,660,250,1
return

evaluames()
{
	if (clipboard="ene")||(clipboard="jan")
	{
		clipboard=01
	}
	if (clipboard="feb")
	{
		clipboard=02
	}
	if (clipboard="mar")
	{
		clipboard=03
	}
	if (clipboard="abr")||(clipboard="apr")
	{
		clipboard=04
	}
	if (clipboard="may")
	{
		clipboard=05
	}
	if (clipboard="jun")
	{
		clipboard=06
	}
	if (clipboard="jul")
	{
		clipboard=07
	}
	if (clipboard="ago")||(clipboard="aug")
	{
		clipboard=08
	}
	if (clipboard="sep")
	{
		clipboard=09
	}
	if (clipboard="oct")
	{
		clipboard=10
	}
	if (clipboard="nov")
	{
		clipboard=11
	}
	if (clipboard="dic")||(clipboard="dec")
	{
		clipboard=12
	}
}

ultimodiadelmes(mes)
{
	if (mes=01)
	{
		clipboard=31
	}
	if (mes=02)
	{
		clipboard=28
	}
	if (mes=03)
	{
		clipboard=31
	}
	if (mes=04)
	{
		clipboard=30
	}
	if (mes=05)
	{
		clipboard=31
	}
	if (mes=06)
	{
		clipboard=30
	}
	if (mes=07)
	{
		clipboard=31
	}
	if (mes=08)
	{
		clipboard=31
	}
	if (mes=09)
	{
		clipboard=30
	}
	if (mes=10)
	{
		clipboard=31
	}
	if (mes=11)
	{
		clipboard=30
	}
	if (mes=12)
	{
		clipboard=31
	}
}

::/libro-::																	;// abre un informe final EMS o el archivo macros
	instruccion1 := "Ingrese año del informe(en 2 dígitos)o nombre del archivo( ej: macros): "
	instruccion2 := "Ingrese mes del informe(en 2 dígitos, ej: 01): "
	SendInput {Raw}%instruccion1%
	Input, year,V *, {enter}.{esc}{tab},
	if (StrLen(year) == 2) {
		SendInput {Raw}%instruccion2%
		input, month,V *, {enter}.{esc}{tab},
		cierraconsola3("")
		monthName := monthPutName(month)
		run, %ruta%\(%year%%month%) %monthName% 20%year%.xlsx
	}
	else {
		cierraconsola3("")
		Run, %ruta%\%year%.xlsm
	}
return

monthPutName(nOfMonth){						;// It receive a number as string of two digits, return the name of the month as %realName%
		realName := "otro mes"
		if ( nOfMonth == "01" )
			realName := "Enero"
		else if ( nOfMonth == "02" )
			realName := "Febrero"
		else if ( nOfMonth == "03" )
			realName := "Marzo"
		else if ( nOfMonth == "04" )
			realName := "Abril"
		else if ( nOfMonth == "05" )
			realName := "Mayo"
		else if ( nOfMonth == "06" )
			realName := "Junio"
		else if ( nOfMonth == "07" )
			realName := "Julio"
		else if ( nOfMonth == "08" )
			realName := "Agosto"
		else if ( nOfMonth == "09" )
			realName := "Septiembre"
		else if ( nOfMonth == "10" )
			realName := "Octubre"
		else if ( nOfMonth == "11" )
			realName := "Noviembre"
		else if ( nOfMonth == "12" )
			realName := "Diciembre"
	return %realName%
}

esperaShift(){
	keywait Shift, D
	keywait Shift, R
}

cierraconsola2(){
IfWinExist consola
	{
		WinActivate
		send !{f4}
		winwait Bloc de notas
		send n
		sleep 300
	}
}
cierraconsola3(consola){
	IfWinExist consola%consola%.txt: Bloc de notas
	{
		sleep 500
		WinActivate
		send !A
		send l
		winwait Bloc de notas,,2
		if ErrorLevel
		    return
		send n
	}
	IfWinExist *consola%consola%.txt: Bloc de notas
	{
		sleep 500
		WinActivate
		send !A
		send l
		winwait Bloc de notas,,2
		if ErrorLevel
		    return
		send n
	}
}

; help
	;CoordMode, ToolTip|Pixel|Mouse|Caret|Menu [, Screen|Window|Client]
		;CoordMode, ToolTip, Screen