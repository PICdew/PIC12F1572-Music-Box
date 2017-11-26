
_timer1interrupt:

;main.c,20 :: 		void timer1interrupt() iv 0x0004 ics ICS_AUTO {
;main.c,21 :: 		if(time_play_count > time_play) {
	MOVF       _time_play_count+1, 0
	SUBWF      _time_play+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__timer1interrupt32
	MOVF       _time_play_count+0, 0
	SUBWF      _time_play+0, 0
L__timer1interrupt32:
	BTFSC      STATUS+0, 0
	GOTO       L_timer1interrupt0
;main.c,22 :: 		time_play_count = 0;
	CLRF       _time_play_count+0
	CLRF       _time_play_count+1
;main.c,23 :: 		isUpdateNote = 1;
	MOVLW      1
	MOVWF      _isUpdateNote+0
;main.c,24 :: 		}
	GOTO       L_timer1interrupt1
L_timer1interrupt0:
;main.c,26 :: 		time_play_count++;
	INCF       _time_play_count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _time_play_count+1, 1
L_timer1interrupt1:
;main.c,29 :: 		TMR1 = 64536;
	MOVLW      24
	MOVWF      TMR1+0
	MOVLW      252
	MOVWF      TMR1+1
;main.c,30 :: 		PIR1.TMR1IF = 0;
	BCF        PIR1+0, 0
;main.c,31 :: 		}
L_end_timer1interrupt:
L__timer1interrupt31:
	RETFIE     %s
; end of _timer1interrupt

_init:

;main.c,33 :: 		void init() {
;main.c,40 :: 		OSCCON.SPLLEN = 0; // disable Software PLL.
	BCF        OSCCON+0, 7
;main.c,41 :: 		OSCCON.IRCF3 = 1;  // 8mhz -> 32mhz if PLLx4 set.
	BSF        OSCCON+0, 6
;main.c,42 :: 		OSCCON.IRCF2 = 1;
	BSF        OSCCON+0, 5
;main.c,43 :: 		OSCCON.IRCF1 = 1;
	BSF        OSCCON+0, 4
;main.c,44 :: 		OSCCON.IRCF0 = 0;
	BCF        OSCCON+0, 3
;main.c,45 :: 		OSCCON.SCS1  = 0;  // system clock select: internal osc.
	BCF        OSCCON+0, 1
;main.c,46 :: 		OSCCON.SCS0  = 0;
	BCF        OSCCON+0, 0
;main.c,48 :: 		APFCON.P1SEL = 0;
	BCF        APFCON+0, 0
;main.c,49 :: 		ANSELA = 0x00;
	CLRF       ANSELA+0
;main.c,50 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;main.c,51 :: 		LATA = 0x00;
	CLRF       LATA+0
;main.c,53 :: 		INTCON = 0x00;
	CLRF       INTCON+0
;main.c,55 :: 		}
L_end_init:
	RETURN
; end of _init

_init_timer1:

;main.c,57 :: 		void init_timer1() {
;main.c,59 :: 		T1CON = 0x00;
	CLRF       T1CON+0
;main.c,60 :: 		T1CON.T1CKPS0 = 1;     // 1:8 prescale value.
	BSF        T1CON+0, 4
;main.c,61 :: 		T1CON.T1CKPS1 = 1;
	BSF        T1CON+0, 5
;main.c,62 :: 		TMR1 = 64536;
	MOVLW      24
	MOVWF      TMR1+0
	MOVLW      252
	MOVWF      TMR1+1
;main.c,63 :: 		T1GCON = 0x00;
	CLRF       T1GCON+0
;main.c,64 :: 		T1CON.TMR1ON = 1;
	BSF        T1CON+0, 0
;main.c,69 :: 		}
L_end_init_timer1:
	RETURN
; end of _init_timer1

_init_intr:

;main.c,71 :: 		void init_intr() {
;main.c,73 :: 		PIR1 = 0x00;
	CLRF       PIR1+0
;main.c,74 :: 		PIE3 = 0x00;
	CLRF       PIE3+0
;main.c,75 :: 		PIE1.TMR1IE = 1;
	BSF        PIE1+0, 0
;main.c,76 :: 		INTCON.PEIE = 1;
	BSF        INTCON+0, 6
;main.c,77 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;main.c,78 :: 		}
L_end_init_intr:
	RETURN
; end of _init_intr

_init_pwm1:

;main.c,80 :: 		void init_pwm1() {
;main.c,82 :: 		PWM1CON = 0x00;
	CLRF       PWM1CON+0
;main.c,83 :: 		PWM1CON.PWM1POL = 0;
	BCF        PWM1CON+0, 4
;main.c,84 :: 		PWM1CON.PWM1OE = 1;
	BSF        PWM1CON+0, 6
;main.c,85 :: 		PWM1CON.PWM1EN = 0;
	BCF        PWM1CON+0, 7
;main.c,88 :: 		PWM1INTE = 0x00;
	CLRF       PWM1INTE+0
;main.c,91 :: 		PWM1CLKCON = 0x00;
	CLRF       PWM1CLKCON+0
;main.c,94 :: 		PWM1CLKCON.PWM1PS0 = 1;
	BSF        PWM1CLKCON+0, 4
;main.c,95 :: 		PWM1CLKCON.PWM1PS1 = 1;
	BSF        PWM1CLKCON+0, 5
;main.c,96 :: 		PWM1CLKCON.PWM1PS2 = 0;
	BCF        PWM1CLKCON+0, 6
;main.c,97 :: 		PWM1CLKCON.PWM1CS0 = 0;
	BCF        PWM1CLKCON+0, 0
;main.c,98 :: 		PWM1CLKCON.PWM1CS1 = 0;
	BCF        PWM1CLKCON+0, 1
;main.c,101 :: 		PWM1TMR = 0;
	CLRF       PWM1TMR+0
	CLRF       PWM1TMR+1
;main.c,104 :: 		PWM1PH = 0;
	CLRF       PWM1PH+0
	CLRF       PWM1PH+1
;main.c,107 :: 		PWM1PR = 5000;
	MOVLW      136
	MOVWF      PWM1PR+0
	MOVLW      19
	MOVWF      PWM1PR+1
;main.c,113 :: 		PWM1DC = 2500;
	MOVLW      196
	MOVWF      PWM1DC+0
	MOVLW      9
	MOVWF      PWM1DC+1
;main.c,115 :: 		PWM1LDCON.PWM1LD = 1;     // Load Buffer.
	BSF        PWM1LDCON+0, 7
;main.c,117 :: 		}
L_end_init_pwm1:
	RETURN
; end of _init_pwm1

_init_pwm2:

;main.c,119 :: 		void init_pwm2() {
;main.c,121 :: 		PWM2CON = 0x00;
	CLRF       PWM2CON+0
;main.c,122 :: 		PWM2CON.PWM2POL = 0;
	BCF        PWM2CON+0, 4
;main.c,123 :: 		PWM2CON.PWM2OE = 1;
	BSF        PWM2CON+0, 6
;main.c,124 :: 		PWM2CON.PWM2EN = 0;
	BCF        PWM2CON+0, 7
;main.c,127 :: 		PWM2INTE = 0x00;
	CLRF       PWM2INTE+0
;main.c,130 :: 		PWM2CLKCON = 0x00;
	CLRF       PWM2CLKCON+0
;main.c,133 :: 		PWM2CLKCON.PWM2PS0 = 1;
	BSF        PWM2CLKCON+0, 4
;main.c,134 :: 		PWM2CLKCON.PWM2PS1 = 1;
	BSF        PWM2CLKCON+0, 5
;main.c,135 :: 		PWM2CLKCON.PWM2PS2 = 0;
	BCF        PWM2CLKCON+0, 6
;main.c,136 :: 		PWM2CLKCON.PWM2CS0 = 0;
	BCF        PWM2CLKCON+0, 0
;main.c,137 :: 		PWM2CLKCON.PWM2CS1 = 0;
	BCF        PWM2CLKCON+0, 1
;main.c,140 :: 		PWM2TMR = 0;
	CLRF       PWM2TMR+0
	CLRF       PWM2TMR+1
;main.c,143 :: 		PWM2PH = 0;
	CLRF       PWM2PH+0
	CLRF       PWM2PH+1
;main.c,146 :: 		PWM2PR = 8000;
	MOVLW      64
	MOVWF      PWM2PR+0
	MOVLW      31
	MOVWF      PWM2PR+1
;main.c,152 :: 		PWM2DC = 4000;
	MOVLW      160
	MOVWF      PWM2DC+0
	MOVLW      15
	MOVWF      PWM2DC+1
;main.c,154 :: 		PWM2LDCON.PWM2LD = 1;     // Load Buffer.
	BSF        PWM2LDCON+0, 7
;main.c,156 :: 		}
L_end_init_pwm2:
	RETURN
; end of _init_pwm2

_init_pwm3:

;main.c,158 :: 		void init_pwm3() {
;main.c,160 :: 		PWM3CON = 0x00;
	CLRF       PWM3CON+0
;main.c,161 :: 		PWM3CON.PWM3POL = 0;
	BCF        PWM3CON+0, 4
;main.c,162 :: 		PWM3CON.PWM3OE = 1;
	BSF        PWM3CON+0, 6
;main.c,163 :: 		PWM3CON.PWM3EN = 0;
	BCF        PWM3CON+0, 7
;main.c,166 :: 		PWM3INTE = 0x00;
	CLRF       PWM3INTE+0
;main.c,169 :: 		PWM3CLKCON = 0x00;
	CLRF       PWM3CLKCON+0
;main.c,172 :: 		PWM3CLKCON.PWM3PS0 = 1;
	BSF        PWM3CLKCON+0, 4
;main.c,173 :: 		PWM3CLKCON.PWM3PS1 = 1;
	BSF        PWM3CLKCON+0, 5
;main.c,174 :: 		PWM3CLKCON.PWM3PS2 = 0;
	BCF        PWM3CLKCON+0, 6
;main.c,175 :: 		PWM3CLKCON.PWM3CS0 = 0;
	BCF        PWM3CLKCON+0, 0
;main.c,176 :: 		PWM3CLKCON.PWM3CS1 = 0;
	BCF        PWM3CLKCON+0, 1
;main.c,179 :: 		PWM3TMR = 0;
	CLRF       PWM3TMR+0
	CLRF       PWM3TMR+1
;main.c,182 :: 		PWM3PH = 0;
	CLRF       PWM3PH+0
	CLRF       PWM3PH+1
;main.c,185 :: 		PWM3PR = 2500;
	MOVLW      196
	MOVWF      PWM3PR+0
	MOVLW      9
	MOVWF      PWM3PR+1
;main.c,191 :: 		PWM3DC = 1250;
	MOVLW      226
	MOVWF      PWM3DC+0
	MOVLW      4
	MOVWF      PWM3DC+1
;main.c,193 :: 		PWM3LDCON.PWM3LD = 1;     // Load Buffer.
	BSF        PWM3LDCON+0, 7
;main.c,195 :: 		}
L_end_init_pwm3:
	RETURN
; end of _init_pwm3

_updateNote:

;main.c,199 :: 		void updateNote() {
;main.c,200 :: 		while(1) {
L_updateNote2:
;main.c,201 :: 		cmd = songData1[songIndex];
	MOVLW      _songData1+0
	ADDWF      _songIndex+0, 0
	MOVWF      FSR0L
	MOVLW      hi_addr(_songData1+0)
	ADDWFC     _songIndex+1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       R1, 0
	MOVWF      _cmd+0
;main.c,203 :: 		if(cmd < 0x80) {
	MOVLW      128
	SUBWF      R1, 0
	BTFSC      STATUS+0, 0
	GOTO       L_updateNote4
;main.c,204 :: 		time_play = ( (songData1[songIndex] << 8) | songData1[songIndex+1] );
	MOVLW      _songData1+0
	ADDWF      _songIndex+0, 0
	MOVWF      FSR0L
	MOVLW      hi_addr(_songData1+0)
	ADDWFC     _songIndex+1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R1
	MOVF       R1, 0
	MOVWF      _time_play+1
	CLRF       _time_play+0
	MOVLW      1
	ADDWF      _songIndex+0, 0
	MOVWF      R0
	MOVLW      0
	ADDWFC     _songIndex+1, 0
	MOVWF      R1
	MOVLW      _songData1+0
	ADDWF      R0, 0
	MOVWF      FSR0L
	MOVLW      hi_addr(_songData1+0)
	ADDWFC     R1, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R0
	MOVF       R0, 0
	IORWF       _time_play+0, 1
	MOVLW      0
	IORWF       _time_play+1, 1
;main.c,205 :: 		songIndex += 2;
	MOVLW      2
	ADDWF      _songIndex+0, 1
	MOVLW      0
	ADDWFC     _songIndex+1, 1
;main.c,206 :: 		break;
	GOTO       L_updateNote3
;main.c,207 :: 		}
L_updateNote4:
;main.c,209 :: 		opcode = cmd & 0xf0;
	MOVLW      240
	ANDWF      _cmd+0, 0
	MOVWF      R1
	MOVF       R1, 0
	MOVWF      _opcode+0
;main.c,210 :: 		chan   = cmd & 0x0f;
	MOVLW      15
	ANDWF      _cmd+0, 0
	MOVWF      _chan+0
;main.c,212 :: 		if(opcode == 0x80) {// stop note here!
	MOVF       R1, 0
	XORLW      128
	BTFSS      STATUS+0, 2
	GOTO       L_updateNote5
;main.c,213 :: 		switch(chan) {
	GOTO       L_updateNote6
;main.c,215 :: 		case 0: PWM1CON.PWM1EN = 0;
L_updateNote8:
	BCF        PWM1CON+0, 7
;main.c,216 :: 		break;
	GOTO       L_updateNote7
;main.c,217 :: 		case 1: PWM2CON.PWM2EN = 0;
L_updateNote9:
	BCF        PWM2CON+0, 7
;main.c,218 :: 		break;
	GOTO       L_updateNote7
;main.c,219 :: 		case 2: PWM3CON.PWM3EN = 0;
L_updateNote10:
	BCF        PWM3CON+0, 7
;main.c,220 :: 		break;
	GOTO       L_updateNote7
;main.c,221 :: 		default:
L_updateNote11:
;main.c,222 :: 		break;
	GOTO       L_updateNote7
;main.c,223 :: 		}
L_updateNote6:
	MOVF       _chan+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_updateNote8
	MOVF       _chan+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_updateNote9
	MOVF       _chan+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_updateNote10
	GOTO       L_updateNote11
L_updateNote7:
;main.c,224 :: 		songIndex += 1;
	INCF       _songIndex+0, 1
	BTFSC      STATUS+0, 2
	INCF       _songIndex+1, 1
;main.c,226 :: 		}
	GOTO       L_updateNote12
L_updateNote5:
;main.c,227 :: 		else if(opcode == 0x90) { // play note here!
	MOVF       _opcode+0, 0
	XORLW      144
	BTFSS      STATUS+0, 2
	GOTO       L_updateNote13
;main.c,228 :: 		isUpdateNote = 1;
	MOVLW      1
	MOVWF      _isUpdateNote+0
;main.c,229 :: 		switch(chan) {
	GOTO       L_updateNote14
;main.c,231 :: 		case 0: PWM1PR = tuningWords[songData1[songIndex+1]];
L_updateNote16:
	MOVLW      1
	ADDWF      _songIndex+0, 0
	MOVWF      R0
	MOVLW      0
	ADDWFC     _songIndex+1, 0
	MOVWF      R1
	MOVLW      _songData1+0
	ADDWF      R0, 0
	MOVWF      R6
	MOVLW      hi_addr(_songData1+0)
	ADDWFC     R1, 0
	MOVWF      R7
	MOVF       R6, 0
	MOVWF      FSR0L
	MOVF       R7, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	MOVLW      _tuningWords+0
	MOVWF      R4
	MOVLW      hi_addr(_tuningWords+0)
	MOVWF      R5
	MOVF       R3, 0
	MOVWF      R0
	CLRF       R1
	LSLF       R0, 1
	RLF        R1, 1
	MOVF       R0, 0
	ADDWF      R4, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	ADDWFC     R5, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      PWM1PR+0
	ADDFSR     0, 1
	MOVF       INDF0+0, 0
	MOVWF      PWM1PR+1
;main.c,232 :: 		PWM1DC = tuningWords[songData1[songIndex+1]] >> 1;
	MOVF       R6, 0
	MOVWF      FSR0L
	MOVF       R7, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      R0
	CLRF       R1
	LSLF       R0, 1
	RLF        R1, 1
	MOVF       R0, 0
	ADDWF      R4, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	ADDWFC     R5, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	ADDFSR     0, 1
	MOVF       INDF0+0, 0
	MOVWF      R4
	MOVF       R3, 0
	MOVWF      R0
	MOVF       R4, 0
	MOVWF      R1
	LSRF       R1, 1
	RRF        R0, 1
	MOVF       R0, 0
	MOVWF      PWM1DC+0
	MOVF       R1, 0
	MOVWF      PWM1DC+1
;main.c,233 :: 		PWM1LDCON.PWM1LD = 1;     // Load Buffer.
	BSF        PWM1LDCON+0, 7
;main.c,234 :: 		PWM1CON.PWM1EN = 1;
	BSF        PWM1CON+0, 7
;main.c,235 :: 		break;
	GOTO       L_updateNote15
;main.c,236 :: 		case 1: PWM2PR = tuningWords[songData1[songIndex+1]];
L_updateNote17:
	MOVLW      1
	ADDWF      _songIndex+0, 0
	MOVWF      R0
	MOVLW      0
	ADDWFC     _songIndex+1, 0
	MOVWF      R1
	MOVLW      _songData1+0
	ADDWF      R0, 0
	MOVWF      R6
	MOVLW      hi_addr(_songData1+0)
	ADDWFC     R1, 0
	MOVWF      R7
	MOVF       R6, 0
	MOVWF      FSR0L
	MOVF       R7, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	MOVLW      _tuningWords+0
	MOVWF      R4
	MOVLW      hi_addr(_tuningWords+0)
	MOVWF      R5
	MOVF       R3, 0
	MOVWF      R0
	CLRF       R1
	LSLF       R0, 1
	RLF        R1, 1
	MOVF       R0, 0
	ADDWF      R4, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	ADDWFC     R5, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      PWM2PR+0
	ADDFSR     0, 1
	MOVF       INDF0+0, 0
	MOVWF      PWM2PR+1
;main.c,237 :: 		PWM2DC = tuningWords[songData1[songIndex+1]] >> 1;
	MOVF       R6, 0
	MOVWF      FSR0L
	MOVF       R7, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      R0
	CLRF       R1
	LSLF       R0, 1
	RLF        R1, 1
	MOVF       R0, 0
	ADDWF      R4, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	ADDWFC     R5, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	ADDFSR     0, 1
	MOVF       INDF0+0, 0
	MOVWF      R4
	MOVF       R3, 0
	MOVWF      R0
	MOVF       R4, 0
	MOVWF      R1
	LSRF       R1, 1
	RRF        R0, 1
	MOVF       R0, 0
	MOVWF      PWM2DC+0
	MOVF       R1, 0
	MOVWF      PWM2DC+1
;main.c,238 :: 		PWM2LDCON.PWM2LD = 1;     // Load Buffer.
	BSF        PWM2LDCON+0, 7
;main.c,239 :: 		PWM2CON.PWM2EN = 1;
	BSF        PWM2CON+0, 7
;main.c,240 :: 		break;
	GOTO       L_updateNote15
;main.c,241 :: 		case 2: PWM3PR = tuningWords[songData1[songIndex+1]];
L_updateNote18:
	MOVLW      1
	ADDWF      _songIndex+0, 0
	MOVWF      R0
	MOVLW      0
	ADDWFC     _songIndex+1, 0
	MOVWF      R1
	MOVLW      _songData1+0
	ADDWF      R0, 0
	MOVWF      R6
	MOVLW      hi_addr(_songData1+0)
	ADDWFC     R1, 0
	MOVWF      R7
	MOVF       R6, 0
	MOVWF      FSR0L
	MOVF       R7, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	MOVLW      _tuningWords+0
	MOVWF      R4
	MOVLW      hi_addr(_tuningWords+0)
	MOVWF      R5
	MOVF       R3, 0
	MOVWF      R0
	CLRF       R1
	LSLF       R0, 1
	RLF        R1, 1
	MOVF       R0, 0
	ADDWF      R4, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	ADDWFC     R5, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      PWM3PR+0
	ADDFSR     0, 1
	MOVF       INDF0+0, 0
	MOVWF      PWM3PR+1
;main.c,242 :: 		PWM3DC = tuningWords[songData1[songIndex+1]] >> 1;
	MOVF       R6, 0
	MOVWF      FSR0L
	MOVF       R7, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      R0
	CLRF       R1
	LSLF       R0, 1
	RLF        R1, 1
	MOVF       R0, 0
	ADDWF      R4, 0
	MOVWF      FSR0L
	MOVF       R1, 0
	ADDWFC     R5, 0
	MOVWF      FSR0H
	MOVF       INDF0+0, 0
	MOVWF      R3
	ADDFSR     0, 1
	MOVF       INDF0+0, 0
	MOVWF      R4
	MOVF       R3, 0
	MOVWF      R0
	MOVF       R4, 0
	MOVWF      R1
	LSRF       R1, 1
	RRF        R0, 1
	MOVF       R0, 0
	MOVWF      PWM3DC+0
	MOVF       R1, 0
	MOVWF      PWM3DC+1
;main.c,243 :: 		PWM3LDCON.PWM3LD = 1;     // Load Buffer.
	BSF        PWM3LDCON+0, 7
;main.c,244 :: 		PWM3CON.PWM3EN = 1;
	BSF        PWM3CON+0, 7
;main.c,245 :: 		break;
	GOTO       L_updateNote15
;main.c,246 :: 		default:
L_updateNote19:
;main.c,247 :: 		break;
	GOTO       L_updateNote15
;main.c,248 :: 		}
L_updateNote14:
	MOVF       _chan+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_updateNote16
	MOVF       _chan+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_updateNote17
	MOVF       _chan+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_updateNote18
	GOTO       L_updateNote19
L_updateNote15:
;main.c,249 :: 		songIndex += 2;
	MOVLW      2
	ADDWF      _songIndex+0, 1
	MOVLW      0
	ADDWFC     _songIndex+1, 1
;main.c,251 :: 		}
	GOTO       L_updateNote20
L_updateNote13:
;main.c,253 :: 		else if(opcode == 0xf0) {  // stop playing score!
	MOVF       _opcode+0, 0
	XORLW      240
	BTFSS      STATUS+0, 2
	GOTO       L_updateNote21
;main.c,254 :: 		isPlaying = 0;
	CLRF       _isPlaying+0
;main.c,255 :: 		break;
	GOTO       L_updateNote3
;main.c,256 :: 		}
L_updateNote21:
;main.c,258 :: 		else if(opcode == 0xe0) {  // start playing from beginning!
	MOVF       _opcode+0, 0
	XORLW      224
	BTFSS      STATUS+0, 2
	GOTO       L_updateNote23
;main.c,259 :: 		songIndex = 0;
	CLRF       _songIndex+0
	CLRF       _songIndex+1
;main.c,260 :: 		time_play_count = 0;
	CLRF       _time_play_count+0
	CLRF       _time_play_count+1
;main.c,261 :: 		time_play = 0;
	CLRF       _time_play+0
	CLRF       _time_play+1
;main.c,262 :: 		break;
	GOTO       L_updateNote3
;main.c,263 :: 		}
L_updateNote23:
L_updateNote20:
L_updateNote12:
;main.c,264 :: 		}
	GOTO       L_updateNote2
L_updateNote3:
;main.c,265 :: 		}
L_end_updateNote:
	RETURN
; end of _updateNote

_main:

;main.c,267 :: 		void main() {
;main.c,269 :: 		init();
	CALL       _init+0
;main.c,271 :: 		delay_ms(50);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_main24:
	DECFSZ     R13, 1
	GOTO       L_main24
	DECFSZ     R12, 1
	GOTO       L_main24
	DECFSZ     R11, 1
	GOTO       L_main24
;main.c,273 :: 		init_pwm1();
	CALL       _init_pwm1+0
;main.c,274 :: 		init_pwm2();
	CALL       _init_pwm2+0
;main.c,275 :: 		init_pwm3();
	CALL       _init_pwm3+0
;main.c,277 :: 		init_intr();
	CALL       _init_intr+0
;main.c,279 :: 		isPlaying = 1;
	MOVLW      1
	MOVWF      _isPlaying+0
;main.c,281 :: 		init_timer1();
	CALL       _init_timer1+0
;main.c,283 :: 		while(1) {
L_main25:
;main.c,286 :: 		if (isPlaying == 1)
	MOVF       _isPlaying+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;main.c,288 :: 		if (isUpdateNote)
	MOVF       _isUpdateNote+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main28
;main.c,290 :: 		updateNote();
	CALL       _updateNote+0
;main.c,291 :: 		isUpdateNote = 0;
	CLRF       _isUpdateNote+0
;main.c,292 :: 		}
L_main28:
;main.c,293 :: 		}
	GOTO       L_main29
L_main27:
;main.c,296 :: 		PWM1CON.PWM1EN = 0;
	BCF        PWM1CON+0, 7
;main.c,297 :: 		PWM2CON.PWM2EN = 0;
	BCF        PWM2CON+0, 7
;main.c,298 :: 		PWM3CON.PWM3EN = 0;
	BCF        PWM3CON+0, 7
;main.c,299 :: 		}
L_main29:
;main.c,300 :: 		}
	GOTO       L_main25
;main.c,301 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
