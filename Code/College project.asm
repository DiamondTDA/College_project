
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;College project.c,4 :: 		void interrupt()
;College project.c,5 :: 		{if(intf_bit==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;College project.c,6 :: 		{intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;College project.c,7 :: 		if(fl==3)
	MOVF       _fl+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;College project.c,8 :: 		fl=-1;
	MOVLW      255
	MOVWF      _fl+0
L_interrupt1:
;College project.c,9 :: 		fl++;}}
	INCF       _fl+0, 1
L_interrupt0:
L_end_interrupt:
L__interrupt43:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;College project.c,12 :: 		void main() {
;College project.c,13 :: 		trisb.b0 = 1;
	BSF        TRISB+0, 0
;College project.c,14 :: 		portd = 0;
	CLRF       PORTD+0
;College project.c,15 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;College project.c,16 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;College project.c,17 :: 		intedg_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;College project.c,18 :: 		trisd = 0b00000000;
	CLRF       TRISD+0
;College project.c,19 :: 		trisc = 0b00000000;
	CLRF       TRISC+0
;College project.c,20 :: 		adcon1 = 7;
	MOVLW      7
	MOVWF      ADCON1+0
;College project.c,21 :: 		trisa = 0b111001;
	MOVLW      57
	MOVWF      TRISA+0
;College project.c,22 :: 		porta = 0;
	CLRF       PORTA+0
;College project.c,23 :: 		portd = 0;
	CLRF       PORTD+0
;College project.c,24 :: 		portc = 0b11111111;
	MOVLW      255
	MOVWF      PORTC+0
;College project.c,25 :: 		while(1)
L_main2:
;College project.c,26 :: 		{if(fl%2==0){
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;College project.c,27 :: 		manual();
	CALL       _manual+0
;College project.c,28 :: 		}
	GOTO       L_main5
L_main4:
;College project.c,30 :: 		automatic();}}
	CALL       _automatic+0
L_main5:
	GOTO       L_main2
;College project.c,31 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_automatic:

;College project.c,32 :: 		void automatic(){
;College project.c,33 :: 		while(1){
L_automatic6:
;College project.c,34 :: 		porta =0;
	CLRF       PORTA+0
;College project.c,35 :: 		portc = 0b11000011;
	MOVLW      195
	MOVWF      PORTC+0
;College project.c,36 :: 		for(i = 20;i > 0;i--){
	MOVLW      20
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_automatic8:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic46
	MOVF       _i+0, 0
	SUBLW      0
L__automatic46:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic9
;College project.c,37 :: 		if(fl%2==0) {return;}
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_automatic11
	GOTO       L_end_automatic
L_automatic11:
;College project.c,38 :: 		portd = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;College project.c,39 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic12:
	DECFSZ     R13+0, 1
	GOTO       L_automatic12
	DECFSZ     R12+0, 1
	GOTO       L_automatic12
	DECFSZ     R11+0, 1
	GOTO       L_automatic12
	NOP
	NOP
;College project.c,36 :: 		for(i = 20;i > 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;College project.c,40 :: 		}
	GOTO       L_automatic8
L_automatic9:
;College project.c,41 :: 		portc = 0b10101100;
	MOVLW      172
	MOVWF      PORTC+0
;College project.c,42 :: 		for(i = 3;i > 0;i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_automatic13:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic47
	MOVF       _i+0, 0
	SUBLW      0
L__automatic47:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic14
;College project.c,43 :: 		if(fl%2==0) {return;}
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_automatic16
	GOTO       L_end_automatic
L_automatic16:
;College project.c,44 :: 		portd = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;College project.c,45 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic17:
	DECFSZ     R13+0, 1
	GOTO       L_automatic17
	DECFSZ     R12+0, 1
	GOTO       L_automatic17
	DECFSZ     R11+0, 1
	GOTO       L_automatic17
	NOP
	NOP
;College project.c,42 :: 		for(i = 3;i > 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;College project.c,46 :: 		}
	GOTO       L_automatic13
L_automatic14:
;College project.c,47 :: 		porta = 0b000100;
	MOVLW      4
	MOVWF      PORTA+0
;College project.c,48 :: 		portc = 0b00011100;
	MOVLW      28
	MOVWF      PORTC+0
;College project.c,49 :: 		for(i = 15;i > 0;i--){
	MOVLW      15
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_automatic18:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic48
	MOVF       _i+0, 0
	SUBLW      0
L__automatic48:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic19
;College project.c,50 :: 		if(fl%2==0) {return;}
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_automatic21
	GOTO       L_end_automatic
L_automatic21:
;College project.c,51 :: 		if(i == 3){
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic49
	MOVLW      3
	XORWF      _i+0, 0
L__automatic49:
	BTFSS      STATUS+0, 2
	GOTO       L_automatic22
;College project.c,52 :: 		porta = 0b000010;}
	MOVLW      2
	MOVWF      PORTA+0
L_automatic22:
;College project.c,53 :: 		portd = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;College project.c,54 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic23:
	DECFSZ     R13+0, 1
	GOTO       L_automatic23
	DECFSZ     R12+0, 1
	GOTO       L_automatic23
	DECFSZ     R11+0, 1
	GOTO       L_automatic23
	NOP
	NOP
;College project.c,49 :: 		for(i = 15;i > 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;College project.c,55 :: 		}
	GOTO       L_automatic18
L_automatic19:
;College project.c,56 :: 		porta = 0;
	CLRF       PORTA+0
;College project.c,57 :: 		}
	GOTO       L_automatic6
;College project.c,58 :: 		}
L_end_automatic:
	RETURN
; end of _automatic

_manual:

;College project.c,59 :: 		void manual(){
;College project.c,60 :: 		trisb.b1 = 1;
	BSF        TRISB+0, 1
;College project.c,61 :: 		portc = 0b10101100;
	MOVLW      172
	MOVWF      PORTC+0
;College project.c,62 :: 		porta = 0b110000;
	MOVLW      48
	MOVWF      PORTA+0
;College project.c,63 :: 		while(1){
L_manual24:
;College project.c,64 :: 		for(i = 3;i > 0;i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_manual26:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual51
	MOVF       _i+0, 0
	SUBLW      0
L__manual51:
	BTFSC      STATUS+0, 0
	GOTO       L_manual27
;College project.c,65 :: 		{if(fl%2==1)
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual29
;College project.c,66 :: 		{return;}
	GOTO       L_end_manual
L_manual29:
;College project.c,67 :: 		portd = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;College project.c,68 :: 		delay_ms(1000);}}
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual30:
	DECFSZ     R13+0, 1
	GOTO       L_manual30
	DECFSZ     R12+0, 1
	GOTO       L_manual30
	DECFSZ     R11+0, 1
	GOTO       L_manual30
	NOP
	NOP
;College project.c,64 :: 		for(i = 3;i > 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;College project.c,68 :: 		delay_ms(1000);}}
	GOTO       L_manual26
L_manual27:
;College project.c,69 :: 		portc = 0b11000000;
	MOVLW      192
	MOVWF      PORTC+0
;College project.c,70 :: 		porta = 0b111001;
	MOVLW      57
	MOVWF      PORTA+0
;College project.c,71 :: 		while(portb.b1!=1){if(fl%2==1) return;}
L_manual31:
	BTFSC      PORTB+0, 1
	GOTO       L_manual32
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual33
	GOTO       L_end_manual
L_manual33:
	GOTO       L_manual31
L_manual32:
;College project.c,72 :: 		portc = 0b00011100;
	MOVLW      28
	MOVWF      PORTC+0
;College project.c,73 :: 		porta = 0b000010;
	MOVLW      2
	MOVWF      PORTA+0
;College project.c,74 :: 		for(i = 3;i > 0;i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_manual34:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual52
	MOVF       _i+0, 0
	SUBLW      0
L__manual52:
	BTFSC      STATUS+0, 0
	GOTO       L_manual35
;College project.c,75 :: 		{if(fl%2==1)
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual37
;College project.c,76 :: 		{return;}
	GOTO       L_end_manual
L_manual37:
;College project.c,77 :: 		portd = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;College project.c,78 :: 		delay_ms(1000);}}
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual38:
	DECFSZ     R13+0, 1
	GOTO       L_manual38
	DECFSZ     R12+0, 1
	GOTO       L_manual38
	DECFSZ     R11+0, 1
	GOTO       L_manual38
	NOP
	NOP
;College project.c,74 :: 		for(i = 3;i > 0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;College project.c,78 :: 		delay_ms(1000);}}
	GOTO       L_manual34
L_manual35:
;College project.c,79 :: 		portc =0b00010000;
	MOVLW      16
	MOVWF      PORTC+0
;College project.c,80 :: 		porta = 0b000100;
	MOVLW      4
	MOVWF      PORTA+0
;College project.c,81 :: 		while(portb.b1!=1){if(fl%2==1) return;};
L_manual39:
	BTFSC      PORTB+0, 1
	GOTO       L_manual40
	MOVLW      1
	ANDWF      _fl+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual41
	GOTO       L_end_manual
L_manual41:
	GOTO       L_manual39
L_manual40:
;College project.c,82 :: 		portc = 0b10101100;
	MOVLW      172
	MOVWF      PORTC+0
;College project.c,83 :: 		porta = 0b000000;
	CLRF       PORTA+0
;College project.c,84 :: 		}}
	GOTO       L_manual24
L_end_manual:
	RETURN
; end of _manual
