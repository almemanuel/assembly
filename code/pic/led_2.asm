; ===========================================================================
;	=-=-=-=-=-=-=-   DISCIPLINA SISTEMAS MICROPROCESSADOS   -=-=-=-=-=-=-=-=
;	PROGRAMA-BASE PARA MICROCONTROLADOR PIC18F4520/4550
;	MAURICIO DOS SANTOS KASTER
;	AGO/2023
; ===========================================================================

; --- 18f4520 ---
#INCLUDE <P18F4520.INC>
	CONFIG OSC = HS
	CONFIG PWRT = ON
	CONFIG WDT = OFF
	CONFIG MCLRE = ON
	CONFIG LVP = ON
	CONFIG DEBUG = OFF

; --- 18f4550 ---
;#INCLUDE <P18F4550.INC>
;	CONFIG FOSC = HSPLL_HS
;	CONFIG LVP = OFF
;	CONFIG MCLRE = ON
;	CONFIG WDT = OFF
;	CONFIG DEBUG = OFF
;	CONFIG PWRT = ON
;	;CONFIG PLLDIV = 4
;	;CONFIG CPUDIV = OSC3_PLL4
;	;CONFIG USBDIV = 1

; ===========================================================================
; *                         DEFINICAO DAS VARIAVEIS
; ===========================================================================

	CBLOCK	0x20
		c1
		c2
		c3
	ENDC

; ===========================================================================
; *                   VETOR DE RESET DO MICROCONTROLADOR
; ===========================================================================

		ORG		0X0000		; ENDERECO DO VETOR DE RESET
		GOTO	INICIO		; DESVIA PARA O INICIO DO PROGRAMA


; ===========================================================================
;                           PROGRAMA PRINCIPAL
; ===========================================================================

INICIO
	movlw 0x00
	movwf TRISD
	movlw 0x01
	movwf PORTD
l1	rlncf PORTD,f
	call tempo
	btfss PORTD,7
	goto l1
l2	rrncf PORTD,f
	call tempo
	btfss PORTD,0
	goto l2
	goto l1

; ===========================================================================
; *                            SUBROTINAS
; ===========================================================================

tempo
	movlw .3
	movwf c3

; trecho de 50 ms
r2	movlw .130
	movwf c1
	movlw .222
	movwf c2
r1	decfsz c2,f
	goto r1
; fim do trecho

	decfsz c1,f
	goto r1
	decfsz c3,f
	goto r2
	return

; ===========================================================================
; *                            FIM DO PROGRAMA
; ===========================================================================

		END				; FIM DO PROGRAMA
