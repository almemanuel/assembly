; Configurações do PIC
#include <p16f877a.inc>
__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _HS_OSC

; Definição de constantes
COUNT_MAX    equ 9
COUNT_MIN    equ 0

; Definição de registradores
COUNT        equ 0x30

; Inicialização
   org 0x00
   goto start

; Interrupção de reset
   org 0x04
   goto start

start:
   ; Configuração dos pinos
   bsf STATUS, RP0      ; Muda para o banco 1
   movlw b'00000000'
   tris PORTB           ; Configura todos os pinos de PORTB como saídas
   bcf STATUS, RP0      ; Muda de volta para o banco 0

   ; Inicialização do contador
   movlw COUNT_MIN
   movwf COUNT

loop:
   ; Atualiza display ou qualquer outra ação aqui

   ; Incrementa ou decrementa
   incfsz COUNT, f
   goto loop
   movlw COUNT_MAX
   movwf COUNT
   decfsz COUNT, f
   goto loop

   end
