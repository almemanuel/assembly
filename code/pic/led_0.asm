; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
    
    #include "p16F628A.inc"	; Incluindo o pic de uso
				;Configura��o inicial do microcontrolador
	__CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
; P�gina de mem�ria	
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAM�RIA
; Defini��o das vari�veis
    CBLOCK  0x20
        TEMPO1
        TEMPO2
    ENDC

;In�cio do programa
    ORG     0x00
    GOTO    inicio
; Quando h� interrup��o
    ORG     0x04
    RETFIE

; O DELAY PRINCIPAL DURA 1ms, POIS POSSUI 5 INSTRU��ES (5us) E �
; RODADO 200 VEZES (TEMPO1). PORTANTO 200 * 5us = 1ms.
; O DELAY PRINCIPAL � RODADO TANTAS VEZES QUANTO FOR O VALOR DE
; TEMPO2, O QUAL � INICIADO COM O VALOR PASSADO EM W.


DELAY
	MOVWF	TEMPO2	    ;INICIA TEMPO 2 COM O VALOR
			    ;PASSADO EM W
DL1	 
	MOVLW	.200
	MOVWF	TEMPO1

DL2			    ;ESTE DELAY DURA 1ms (5*200)
	NOP
	NOP
	DECFSZ	TEMPO1,F    ;DECREMENTA TEMPO1. ACABOU?
	GOTO	DL2	    ;N�O, CONTINUA AGUARDANDO
			    ;SIM

	DECFSZ	TEMPO2,F    ;DECREMENTA TEMPO2. ACABOU?
	GOTO	DL1	    ;N�O, CONTINUA AGUARDANDO
			    ;SIM
	RETURN

inicio
	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000000'
	MOVWF	TRISA		;DEFINE ENTRADAS E SA�DAS DO PORTA
	MOVLW	B'00000000'
	MOVWF	TRISB		;DEFINE ENTRADAS E SA�DAS DO PORTB
	MOVLW	B'10000100'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'00000000'
	MOVWF	INTCON		;Desliga todas as interrup��es
	BANK0			;RETORNA PARA O BANCO Zero
	MOVLW	B'00000111'
	MOVWF	CMCON		;Desliga os comparadores e habilita os pinos como entrada e sa�da
	
start
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,0
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,1
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,2
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,3
	
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,4
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,5
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,6
	MOVLW	.250
	CALL	DELAY
	MOVLW	.250
	CALL	DELAY
	BSF		PORTB,7
	
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,7
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,6
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,5
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,4
	
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,3
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,2
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,1
	MOVLW	.200
	CALL	DELAY
	BCF		PORTB,0
	
	GOTO	start
	END	; Este final � obrigat�rio