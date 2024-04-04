Led			EQU P1
Contar			EQU	P3.0
Reset			EQU	P3.1

CSEG	AT	0000H
JMP		Inicio
CSEG	At 0050H
	
Inicio:
	MOV Led, #00000000b					;Estado inicial (Desligado)
	CALL fun
	
TestarContar:
	JB Contar, TestarReset				;Se Contar = 1 -> TestarIr
	
	MOV A, Led							;Led para ACC
	CJNE A, #9, ContarUm				;Se Led != 10 Contar 1
	JMP Inicio							;Se Led == 10 Inicio
	
ContarUm:
	MOV A, Led							;Led para ACC
	Inc A								;Acc++
	MOV Led, A							;ACC para Led (Apresenta)
	CALL fun							;Temporizador
	JMP TestarContar					;Voltar a testar botão

TestarReset:
	JB Reset, TestarContar				;Se Reset = 1 -> TestarContar
	JMP Inicio


Fun:
	MOV R1, #0xFF
	MOV R2, #0xFF
	MOV R3, #0x7
	Loop: 
		DJNZ R1, Loop
		DJNZ R2, Loop
		DJNZ R3, Loop
	RET

JMP Inicio
END