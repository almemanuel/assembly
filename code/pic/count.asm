; DISCIPLINA SISTEMAS MICROPROCESSADOS
; PROGRAMA-BASE PARA MICROCONTROLADOR PIC18F4520/4550
; MAURICIO DOS SANTOS KASTER
; AGO/2023

#INCLUDE <P18F4520.INC>
    CONFIG OSC = HS
    CONFIG PWRT = ON
    CONFIG WDT = OFF
    CONFIG MCLRE = ON
    CONFIG LVP = ON
    CONFIG DEBUG = OFF

CBLOCK 0x20
    CONT
    LimiteInferior
    LimiteSuperior
    ContagemAux
    ContagemAux2
    W_TEMP
    STATUS_TEMP
    BSR_TEMP
    Contagem
ENDC

ORG 0X0000
    GOTO INICIO

ORG 0x0008
    MOVWF W_TEMP
    MOVFF STATUS,STATUS_TEMP
    MOVFF BSR,BSR_TEMP
    GOTO HIGH_PRIORITY

ORG 0x0018
    MOVWF W_TEMP
    MOVFF STATUS,STATUS_TEMP
    MOVFF BSR,BSR_TEMP
    GOTO LOW_PRIORITY

LOW_PRIORITY
    GOTO FIMINT

HIGH_PRIORITY
    GOTO FIMINT

FIMINT
    MOVFF BSR_TEMP,BSR
    MOVF W_TEMP,W
    MOVFF STATUS_TEMP,STATUS
    RETFIE

INICIO
    movlw 0
    movwf LimiteInferior
    movlw 9
    movwf LimiteSuperior
    movlw 0
    movwf Contagem

    movlw 0
    movwf W_TEMP
    movwf STATUS_TEMP
    movwf BSR_TEMP

ITEM_A
    movf Contagem, W
    call MostrarNumero

    incf Contagem, F
    movf Contagem, W
    subwf LimiteSuperior, W
    btfss STATUS, C
    goto ITEM_A

    movlw 9
    movwf Contagem

ITEM_B
    movf Contagem, W
    call MostrarNumero

    decf Contagem, F
    movf Contagem, W
    subwf LimiteInferior, W
    btfss STATUS, C
    goto ITEM_B

    movlw 0
    movwf Contagem

ITEM_C
    movf Contagem, W
    call MostrarNumero

    incf LimiteSuperior, F
    decf LimiteInferior, F
    movf LimiteInferior, W
    subwf LimiteSuperior, W
    btfss STATUS, C
    goto ITEM_C

    GOTO INICIO

MostrarNumero
    ; Configurar o display para modo de escrita
    BSF     PORTD, 5       ; RS = 1 (Modo de Escrita)
    BCF     PORTD, 6       ; RW = 0 (Escrever)
    
    ; Enviar comando para posicionar o cursor na primeira linha, primeira coluna
    MOVLW   0x80           ; Código de comando para posicionar cursor no início
    CALL    EnviarComando  ; Chama a sub-rotina EnviarComando
    
    ; Enviar o número que desejamos mostrar
    MOVF    CONT, W        ; Carrega o valor de CONT no registrador W
    ADDLW   '0'            ; Converte para o formato ASCII
    CALL    EnviarDado     ; Chama a sub-rotina EnviarDado
    
    RETURN


EnviarComando
    ; Envia o comando no registrador W para o display
    MOVWF   PORTD          ; Envia o comando para o PORTD
    BSF     PORTD, 7       ; Pulsa o pino E
    NOP                     ; Pequeno atraso
    BCF     PORTD, 7       ; Desliga o pulso do pino E
    NOP                     ; Pequeno atraso
    RETURN

EnviarDado
    ; Envia o dado no registrador W para o display
    MOVWF   PORTD          ; Envia o dado para o PORTD
    BSF     PORTD, 7       ; Pulsa o pino E
    NOP                     ; Pequeno atraso
    BCF     PORTD, 7       ; Desliga o pulso do pino E
    NOP                     ; Pequeno atraso
    RETURN

; FIM DO PROGRAMA
END
