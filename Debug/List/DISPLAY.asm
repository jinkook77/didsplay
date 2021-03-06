
;CodeVisionAVR C Compiler V3.35 Advanced
;(C) Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega2560
;Program type           : Application
;Clock frequency        : 11.059200 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 2048 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega2560
	#pragma AVRPART MEMORY PROG_FLASH 262144
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0200
	.EQU __SRAM_END=0x21FF
	.EQU __DSTACK_SIZE=0x0800
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _command=R4
	.DEF _fnd_data=R3
	.DEF _count_temp=R5
	.DEF _count_temp_msb=R6
	.DEF _send_process_count=R7
	.DEF _send_process_count_msb=R8
	.DEF _digit_num=R9
	.DEF _digit_num_msb=R10
	.DEF _digit=R11
	.DEF _digit_msb=R12
	.DEF _temp_a=R13
	.DEF _temp_a_msb=R14

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart1_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart2_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x3:
	.DB  0xFF
_0x4:
	.DB  0xFF
_0x5:
	.DB  0x1

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x01
	.DW  _temp_control_1_old
	.DW  _0x3*2

	.DW  0x01
	.DW  _temp_control_2_old
	.DW  _0x4*2

	.DW  0x01
	.DW  _ge_data_kind
	.DW  _0x5*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

	OUT  EIND,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0xA00

	.CSEG
;//*******************************************************
;//This program was created by the CodeWizardAVR V3.35
;//Automatic Program Generator
;//Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
;//http://www.hpinfotech.com
;//
;//Project :
;//Version :
;//Date    : 2019-08-15                                                3Author  :
;//Company :
;//Comments:
;//
;//
;//Chip type               : ATmega2560
;//Program type            : Application
;//AVR Core Clock frequency: 11.059200 MHz
;//Memory model            : Small
;//External RAM size       : 0
;//Data Stack size         : 2048
;//*******************************************************/
;
;#include <mega2560.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <delay.h>
;
; // Bit-Banged I2C Bus functions
;#include <i2c.h>
;
;// DS1307 Real Time Clock functions
;#include <ds1307.h>
;
;
;//PORT DEFINE
;#define DT_NORMAL PORTA.4
;#define DT_ERR PORTA.5
;#define GE_NORMAL PORTA.6
;#define GE_ERR PORTA.7
;#define BAT_RUN_1 PORTE.4
;#define BAT_RUN_2 PORTE.5
;#define BAT_ERR_1 PORTE.6
;#define BAT_ERR_2 PORTE.7
;
;//TEST LED
;#define TEST_LED_1 PORTC.5
;#define TEST_LED_2 PORTC.6
;
;//BUZZER
;#define BUZZER_HIGH PORTB.5
;#define BUZZER_STOP PINB.4
;
;
;// BUZZER STOP KEY
;#define BUZZER_STOP_KEY PINB.4
;
;//ADDRESS
;#define ADDRESS_0 (PINJ & 0X08) == 0X08
;#define ADDRESS_1 (PINJ & 0X04) == 0X04
;#define ADDRESS_2 (PINJ & 0X02) == 0X02
;#define ADDRESS_3 (PINJ & 0X01) == 0X01
;
;//FND
;#define LED_DIN PORTC.4
;#define LED_CLK PORTC.3
;#define LED_LOAD PORTC.2
;#define LED_LOAD_A PORTC.1
;#define LED_LOAD_B PORTC.0
;
;//RE_DE
;#define RE_DE0 PORTE.2
;#define RE_DE1 PORTE.3
;
;//LAN
;#define LAN_RESET PORTD.0
;#define LAN_STS PIND.1
;#define LAN_CTS PIND.5
;#define LAN_ISP PORTD.4
;#define LAN_RTS PIND.6
;#define LAN_TSP PIND.7
;
;// HOT SWAP
;#define DIS_HOT_SWAP PINB.0
;
;
;//VALUE DEFIEN
;#define ON 1
;#define OFF 0
;
;#define ERR 1
;#define NOR 0
;
;
;#define buzzer_err_delay 3000 //부저 울리는 딜레이 시간 처리
;
;// Declare your global variables here
;char command;
;char fnd_data;
;int count_temp;
;int send_process_count;
;int digit_num;
;int digit;
;
;//timer
;int temp_a;
;int temp_b;
;int temp_c;
;int temp_out_to_pc_count;
;int temp_out_pbit_count;
;// 데이터 변수
;int bat_volt_1;
;int bat_volt_2;
;
;// rtc변수
;//unsigned char week_day,day,month,year;
;unsigned char year;
;unsigned char month;
;unsigned char week;
;unsigned char day;
;unsigned char hour;
;unsigned char minute;
;unsigned char sec;
;
;//time
;eeprom unsigned char keep_year @0x02;
;eeprom unsigned char keep_month @0x04;
;eeprom unsigned char keep_day @0x06;
;eeprom unsigned char keep_hour @0x07;
;eeprom unsigned char keep_minute @0x09;
;eeprom unsigned char keep_sec @0x0b;
;
;
;
;//버퍼
;unsigned int voltage_1;
;unsigned int currunt_1;
;unsigned int voltage_2;
;unsigned int currunt_2;
;
;
;//전압
;unsigned int voltage_ch1_1;
;unsigned int voltage_ch2_1;
;unsigned int voltage_ch3_1;
;unsigned int voltage_ch4_1;
;unsigned int voltage_ch5_1;
;unsigned int voltage_ch6_1;
;unsigned int voltage_ch7_1;
;
;unsigned int voltage_m48_1;
;unsigned int voltage_fan_1;
;
;//전류
;unsigned int currunt_ch1_1;
;unsigned int currunt_ch2_1;
;unsigned int currunt_ch3_1;
;unsigned int currunt_ch4_1;
;unsigned int currunt_ch5_1;
;unsigned int currunt_ch6_1;
;unsigned int currunt_ch7_1;
;
;unsigned int voltage_m24_1;
;unsigned int currunt_fan_1;
;
;//전압
;unsigned int voltage_ch1_2;
;unsigned int voltage_ch2_2;
;unsigned int voltage_ch3_2;
;unsigned int voltage_ch4_2;
;unsigned int voltage_ch5_2;
;unsigned int voltage_ch6_2;
;unsigned int voltage_ch7_2;
;
;unsigned int voltage_m48_2;
;unsigned int voltage_fan_2;
;
;//전류
;unsigned int currunt_ch1_2;
;unsigned int currunt_ch2_2;
;unsigned int currunt_ch3_2;
;unsigned int currunt_ch4_2;
;unsigned int currunt_ch5_2;
;unsigned int currunt_ch6_2;
;unsigned int currunt_ch7_2;
;
;unsigned int voltage_m24_2;
;unsigned int currunt_fan_2;
;
;//div  48v
;unsigned int div_48v;
;unsigned char ac48_ovp = 0;
;unsigned char ac48_lvp = 0;
;unsigned char dc48_ovp = 0;
;unsigned char dc48_lvp = 0;
;unsigned char deiver_48_err = 0;
;
;
;// buzzer
;bit buzzer_on;
;unsigned int buzzer_count = 0;
;unsigned char data_buffer1_temp[92] = "";
;unsigned char data_buffer2_temp[92] = "";
;unsigned char data_buffer_ge_temp[10] = "";
;//battery 1
;unsigned char batt_level_1 = 0;
;unsigned char err_main_1 = 0;
;unsigned char err1_1 = 0;
;unsigned char err2_1 = 0;
;unsigned char status_1 = 0;
;
;//battery 2
;unsigned char batt_level_2 = 0;
;unsigned char err_main_2 = 0;
;unsigned char err1_2 = 0;
;unsigned char err2_2 = 0;
;unsigned char status_2 = 0;
;
;//battery data
;//unsigned char batt_record_data = 0;
;
;//GENERATOR
;unsigned char CRC_H = 0;
;unsigned char CRC_L = 0;
;unsigned char ge_voltage_h  = 0;
;unsigned char ge_voltage_l = 0;
;unsigned char ge_currunt_h  = 0;
;unsigned char ge_currunt_l = 0;
;unsigned char ge_err_data  = 0;
;unsigned int voltage_ge = 0;
;unsigned int currunt_ge = 0;
;unsigned char ge_err_act = 0;
;unsigned char ge_err_latch = 0;
;
;//pc transmmit confirm
;bit send_to_pc_active;
;
;
;//BIT RESULT
;unsigned char pobit_result = 0;
;unsigned char pbit_result = 0;
;
;//
;unsigned char batt_charge_1 = 0;
;unsigned char batt_charge_2 = 0;
;unsigned char batt_discharge_1 = 0;
;unsigned char batt_discharge_2 = 0;
;unsigned char err_fan_1 = 0;
;unsigned char err_fan_2 = 0;
;
;//battery
;bit batt_link_err_act_1 = 0;
;bit batt_link_err_act_2 = 0;
;bit batt_run_act_1 = 0;
;bit batt_run_act_2 = 0;
;
;//시간 기록 한번만 처리
;unsigned char time_data_get_act = 0;
;
;//hot swap
;bit dt_err_act;
;unsigned char led_flash = 0;
;// 시간명령 입력
;unsigned char time_data_get = 0;
;
;//control temp
;unsigned char temp_control_1 = 0;
;unsigned char temp_control_2 = 0;
;unsigned char temp_control_1_ = 0;
;unsigned char temp_control_2_ = 0;
;
;unsigned char temp_control_1_old = 0xff;

	.DSEG
;unsigned char temp_control_2_old = 0xff;
;
;unsigned char temp_control_sel = 0;
;
;//send to div 데이터 전송 실시
;unsigned char send_to_div_act = 0;
;unsigned char send_to_div_info_act = 0;
;
;//부저 한번만 울림
;unsigned char dt_err_act_buzzer = 0;
;unsigned char ge_err_act_buzzer = 0;
;unsigned char batt_err_1_act = 0;
;unsigned char batt_err_2_act = 0;
;unsigned char batt_err_1_act_buzzer = 0;
;unsigned char batt_err_2_act_buzzer = 0;
;unsigned char power_link1_err_act_buzzer = 0;
;unsigned char power_link2_err_act_buzzer = 0;
;
;// switch _status
;unsigned char sw_status = 0;
;
;//power_link for div
;unsigned char power_link_1 = 0;;
;unsigned char power_link_2 = 0;
;unsigned char power_link1_err = 0;
;unsigned char power_link2_err = 0;
;
;// 통신단절 카운트
;unsigned int loss_count_a, loss_count_ge = 0;
;bit comm_err = 0;
;bit comm_ge_err = 0;
;const int loss_active_delay_time = 40;//40 //30; //10
;const int loss_ge_active_delay_time = 20;//발전기 링크 에러 처리
;//unsigned char comm_err_temp = 0;
;//unsigned int comm_err_count = 0;
;//unsigned char error_item = 0;
;
;//detail error
;unsigned int link_err_detail;
;unsigned char div_err_detail = 0;
;unsigned char power_1_err_detail = 0;
;unsigned char power_2_err_detail = 0;
;unsigned char bat_1_err_detail = 0;
;unsigned char bat_2_err_detail = 0;
;unsigned char gen_err_detail = 0;
;
;unsigned char power_1_err = 0;
;unsigned char power_2_err = 0;
;
;unsigned char err_bat1_temp = 0;
;unsigned char err_bat2_temp = 0;
;unsigned char err_bat1_volt = 0;
;unsigned char err_bat2_volt = 0;
;unsigned char err_bat1_curr = 0;
;unsigned char err_bat2_curr = 0;
;
;// message_count
;unsigned char Common_CheckLink_number = 0;
;unsigned char Distributor_ShutdownErroResponse_number = 0;
;//unsigned char Distributor_PoBITResponse_number = 0;
;unsigned char Distributor_BITBetailResponse_number = 0;
;unsigned char Distributor_PBIT_number = 0;
;unsigned char Distributor_TimeSyncAck_number = 0;
;unsigned char Distributor_ShutdownResponse_number = 0;
;//unsigned char Distributor_PoBITResponse = 0;
;unsigned char PoBITResult_number = 0;
;unsigned char PoBITResult_number_ack = 0;
;unsigned char Distributor_devicestatus_number = 0;
;
;unsigned char Common_CHeckLink_act = 0;
;unsigned char Distributor_PBIT_act = 0;
;unsigned char Distributor_ShutdownResponse_act = 0;
;unsigned char Distributor_ShutdownErroResponse_act = 0;
;unsigned char Distributor_TimeSyncAck_act = 0;
;//unsigned char Distributor_PoBITResponse_act_pre = 0;
;unsigned char Distributor_BITDetailResponse_act = 0;
;unsigned char Distributor_PoBIT_act = 0;
;unsigned char Distributor_PoBIT_act_pre = 0;
;unsigned char send_to_ge_active = 0;//485 발전기와 통신
;unsigned char po_bit_recive_data_detail = 0; //수신데이터
;//unsigned char po_bit_set_recive_data = 0;
;
;unsigned char ge_data_kind = 1;
;
;//초기 부저 안울리게 처리
;#define mode_change_count_max 80    //10
;unsigned char mode_change_and_init = 0;
;unsigned char mode_change_count = 0;
;unsigned char buzzer_out_wait = 0;
;unsigned char init_mod_switch = 0;
;#define DATA_REGISTER_EMPTY (1<<UDRE0)
;#define RX_COMPLETE (1<<RXC0)
;#define FRAMING_ERROR (1<<FE0)
;#define PARITY_ERROR (1<<UPE0)
;#define DATA_OVERRUN (1<<DOR0)
;
;// USART0 Receiver buffer
;#define RX_BUFFER_SIZE0 8
;char rx_buffer0[RX_BUFFER_SIZE0];
;
;#if RX_BUFFER_SIZE0 <= 256
;volatile unsigned char rx_wr_index0=0,rx_rd_index0=0;
;#else
;volatile unsigned int rx_wr_index0=0,rx_rd_index0=0;
;#endif
;
;#if RX_BUFFER_SIZE0 < 256
;volatile unsigned char rx_counter0=0;
;#else
;volatile unsigned int rx_counter0=0;
;#endif
;
;// This flag is set on USART0 Receiver buffer overflow
;bit rx_buffer_overflow0;
;
;void buzzer_clear_all(void)
; 0000 0181 {

	.CSEG
_buzzer_clear_all:
; .FSTART _buzzer_clear_all
; 0000 0182     dt_err_act_buzzer = OFF;
	LDI  R30,LOW(0)
	STS  _dt_err_act_buzzer,R30
; 0000 0183     ge_err_act_buzzer = OFF;
	STS  _ge_err_act_buzzer,R30
; 0000 0184     batt_err_1_act_buzzer = OFF;
	STS  _batt_err_1_act_buzzer,R30
; 0000 0185     batt_err_2_act_buzzer = OFF;
	STS  _batt_err_2_act_buzzer,R30
; 0000 0186     power_link1_err_act_buzzer = OFF;
	STS  _power_link1_err_act_buzzer,R30
; 0000 0187     power_link2_err_act_buzzer = OFF;
	STS  _power_link2_err_act_buzzer,R30
; 0000 0188     buzzer_on = OFF;
	CBI  0x1E,0
; 0000 0189 }
	RET
; .FEND
;
;
;void data_clear()
; 0000 018D {
; 0000 018E          voltage_ch1_2 = 0;
; 0000 018F          currunt_ch1_2 = 0;
; 0000 0190          voltage_ch2_2 = 0;
; 0000 0191          currunt_ch2_2 = 0;
; 0000 0192          voltage_ch3_2 = 0;
; 0000 0193          currunt_ch3_2 = 0;
; 0000 0194          voltage_ch4_2 = 0;
; 0000 0195          currunt_ch4_2 = 0;
; 0000 0196          voltage_ch5_2 = 0;
; 0000 0197          currunt_ch5_2 = 0;
; 0000 0198          voltage_ch6_2 = 0;
; 0000 0199          currunt_ch6_2 = 0;
; 0000 019A          voltage_ch7_2 = 0;
; 0000 019B          currunt_ch7_2 = 0;
; 0000 019C 
; 0000 019D          voltage_m48_2 = 0;
; 0000 019E          voltage_m24_2 = 0;
; 0000 019F 
; 0000 01A0          voltage_fan_2 = 0;
; 0000 01A1          currunt_fan_2 = 0;
; 0000 01A2 
; 0000 01A3          batt_level_2 = 0;
; 0000 01A4          err_main_2 = 0;
; 0000 01A5          err1_2 = 0;
; 0000 01A6          err2_2 = 0;
; 0000 01A7          status_2 = 0;
; 0000 01A8 
; 0000 01A9          voltage_ch1_1 = 0;
; 0000 01AA          currunt_ch1_1 = 0;
; 0000 01AB          voltage_ch2_1 = 0;
; 0000 01AC          currunt_ch2_1 = 0;
; 0000 01AD          voltage_ch3_1 = 0;
; 0000 01AE          currunt_ch3_1 = 0;
; 0000 01AF          voltage_ch4_1 = 0;
; 0000 01B0          currunt_ch4_1 = 0;
; 0000 01B1          voltage_ch5_1 = 0;
; 0000 01B2          currunt_ch5_1 = 0;
; 0000 01B3          voltage_ch6_1 = 0;
; 0000 01B4          currunt_ch6_1 = 0;
; 0000 01B5          voltage_ch7_1 = 0;
; 0000 01B6          currunt_ch7_1 = 0;
; 0000 01B7 
; 0000 01B8          voltage_m48_1 = 0;
; 0000 01B9          voltage_m24_1 = 0;
; 0000 01BA 
; 0000 01BB          voltage_fan_1 = 0;
; 0000 01BC          currunt_fan_1 = 0;
; 0000 01BD 
; 0000 01BE          batt_level_1 = 0;
; 0000 01BF          err_main_1 = 0;
; 0000 01C0          err1_1 = 0;
; 0000 01C1          err2_1 = 0;
; 0000 01C2          status_1 = 0;
; 0000 01C3 }
;
;
;
;
;// USART0 Receiver interrupt service routine
;interrupt [USART0_RXC] void usart0_rx_isr(void)
; 0000 01CA {
_usart0_rx_isr:
; .FSTART _usart0_rx_isr
	CALL SUBOPT_0x0
; 0000 01CB unsigned char status;
; 0000 01CC char data;
; 0000 01CD status=UCSR0A;
;	status -> R17
;	data -> R16
	LDS  R17,192
; 0000 01CE data=UDR0;
	LDS  R16,198
; 0000 01CF if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x8
; 0000 01D0    {
; 0000 01D1    rx_buffer0[rx_wr_index0++]=data;
	LDS  R30,_rx_wr_index0
	SUBI R30,-LOW(1)
	STS  _rx_wr_index0,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 01D2 #if RX_BUFFER_SIZE0 == 256
; 0000 01D3    // special case for receiver buffer size=256
; 0000 01D4    if (++rx_counter0 == 0) rx_buffer_overflow0=1;
; 0000 01D5 #else
; 0000 01D6    if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDS  R26,_rx_wr_index0
	CPI  R26,LOW(0x8)
	BRNE _0x9
	LDI  R30,LOW(0)
	STS  _rx_wr_index0,R30
; 0000 01D7    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x9:
	LDS  R26,_rx_counter0
	SUBI R26,-LOW(1)
	STS  _rx_counter0,R26
	CPI  R26,LOW(0x8)
	BRNE _0xA
; 0000 01D8       {
; 0000 01D9       rx_counter0=0;
	LDI  R30,LOW(0)
	STS  _rx_counter0,R30
; 0000 01DA       rx_buffer_overflow0=1;
	SET
	BLD  R2,1
; 0000 01DB       }
; 0000 01DC #endif
; 0000 01DD    }
_0xA:
; 0000 01DE 
; 0000 01DF 
; 0000 01E0 
; 0000 01E1   if(data == 0x0a )
_0x8:
	CPI  R16,10
	BREQ PC+2
	RJMP _0xB
; 0000 01E2    {
; 0000 01E3        //시험용 삭제요망
; 0000 01E4 //       if(data_buffer2_temp[5] == 0x7f && data_buffer2_temp[4] == 0x77 && data_buffer2_temp[0] == 0x0d)
; 0000 01E5 //       {
; 0000 01E6 //        voltage_1 = data_buffer2_temp[3];
; 0000 01E7 //        voltage_2 = data_buffer2_temp[2];
; 0000 01E8 //
; 0000 01E9 //       }
; 0000 01EA 
; 0000 01EB 
; 0000 01EC        //채널상태 및 에러정보 요청
; 0000 01ED      if(data_buffer2_temp[91] == 0x7f && data_buffer2_temp[90] == 0xfe && data_buffer2_temp[0] == 0x0d)      // data_buf ...
	__GETB2MN _data_buffer2_temp,91
	CPI  R26,LOW(0x7F)
	BRNE _0xD
	__GETB2MN _data_buffer2_temp,90
	CPI  R26,LOW(0xFE)
	BRNE _0xD
	LDS  R26,_data_buffer2_temp
	CPI  R26,LOW(0xD)
	BREQ _0xE
_0xD:
	RJMP _0xC
_0xE:
; 0000 01EE       {
; 0000 01EF          //전원반 #2
; 0000 01F0          voltage_ch1_2 = (data_buffer2_temp[89] * 256) + data_buffer2_temp[88];   //v ch1
	__GETB2MN _data_buffer2_temp,89
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,88
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch1_2,R30
	STS  _voltage_ch1_2+1,R31
; 0000 01F1          currunt_ch1_2 = (data_buffer2_temp[87] * 256) + data_buffer2_temp[86];
	__GETB2MN _data_buffer2_temp,87
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,86
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch1_2,R30
	STS  _currunt_ch1_2+1,R31
; 0000 01F2          voltage_ch2_2 = (data_buffer2_temp[85] * 256) + data_buffer2_temp[84];   //v ch2
	__GETB2MN _data_buffer2_temp,85
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,84
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch2_2,R30
	STS  _voltage_ch2_2+1,R31
; 0000 01F3          currunt_ch2_2 = (data_buffer2_temp[83] * 256) + data_buffer2_temp[82];
	__GETB2MN _data_buffer2_temp,83
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,82
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch2_2,R30
	STS  _currunt_ch2_2+1,R31
; 0000 01F4          voltage_ch3_2 = (data_buffer2_temp[81] * 256) + data_buffer2_temp[80];   //v ch3
	__GETB2MN _data_buffer2_temp,81
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,80
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch3_2,R30
	STS  _voltage_ch3_2+1,R31
; 0000 01F5          currunt_ch3_2 = (data_buffer2_temp[79] * 256) + data_buffer2_temp[78];
	__GETB2MN _data_buffer2_temp,79
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,78
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch3_2,R30
	STS  _currunt_ch3_2+1,R31
; 0000 01F6          voltage_ch4_2 = (data_buffer2_temp[77] * 256) + data_buffer2_temp[76];   //v ch4
	__GETB2MN _data_buffer2_temp,77
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,76
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch4_2,R30
	STS  _voltage_ch4_2+1,R31
; 0000 01F7          currunt_ch4_2 = (data_buffer2_temp[75] * 256) + data_buffer2_temp[74];
	__GETB2MN _data_buffer2_temp,75
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,74
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch4_2,R30
	STS  _currunt_ch4_2+1,R31
; 0000 01F8          voltage_ch5_2 = (data_buffer2_temp[73] * 256) + data_buffer2_temp[72];   //v ch5
	__GETB2MN _data_buffer2_temp,73
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,72
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch5_2,R30
	STS  _voltage_ch5_2+1,R31
; 0000 01F9          currunt_ch5_2 = (data_buffer2_temp[71] * 256) + data_buffer2_temp[70];
	__GETB2MN _data_buffer2_temp,71
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,70
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch5_2,R30
	STS  _currunt_ch5_2+1,R31
; 0000 01FA          voltage_ch6_2 = (data_buffer2_temp[69] * 256) + data_buffer2_temp[68];   //v ch6
	__GETB2MN _data_buffer2_temp,69
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,68
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch6_2,R30
	STS  _voltage_ch6_2+1,R31
; 0000 01FB          currunt_ch6_2 = (data_buffer2_temp[67] * 256) + data_buffer2_temp[66];
	__GETB2MN _data_buffer2_temp,67
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,66
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch6_2,R30
	STS  _currunt_ch6_2+1,R31
; 0000 01FC          voltage_ch7_2 = (data_buffer2_temp[65] * 256) + data_buffer2_temp[64];   //v ch7
	__GETB2MN _data_buffer2_temp,65
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,64
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch7_2,R30
	STS  _voltage_ch7_2+1,R31
; 0000 01FD          currunt_ch7_2 = (data_buffer2_temp[63] * 256) + data_buffer2_temp[62];
	__GETB2MN _data_buffer2_temp,63
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,62
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch7_2,R30
	STS  _currunt_ch7_2+1,R31
; 0000 01FE          voltage_m48_2 = (data_buffer2_temp[61] * 256) + data_buffer2_temp[60];
	__GETB2MN _data_buffer2_temp,61
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,60
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_m48_2,R30
	STS  _voltage_m48_2+1,R31
; 0000 01FF          voltage_m24_2 = (data_buffer2_temp[59] * 256) + data_buffer2_temp[58];
	__GETB2MN _data_buffer2_temp,59
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,58
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_m24_2,R30
	STS  _voltage_m24_2+1,R31
; 0000 0200          voltage_fan_2 = (data_buffer2_temp[57] * 256) + data_buffer2_temp[56];
	__GETB2MN _data_buffer2_temp,57
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,56
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_fan_2,R30
	STS  _voltage_fan_2+1,R31
; 0000 0201          currunt_fan_2 = (data_buffer2_temp[55] * 256) + data_buffer2_temp[54];
	__GETB2MN _data_buffer2_temp,55
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,54
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_fan_2,R30
	STS  _currunt_fan_2+1,R31
; 0000 0202 
; 0000 0203          batt_level_2 = data_buffer2_temp[53];
	__GETB1MN _data_buffer2_temp,53
	STS  _batt_level_2,R30
; 0000 0204          err_main_2 = data_buffer2_temp[52];
	__GETB1MN _data_buffer2_temp,52
	STS  _err_main_2,R30
; 0000 0205          if((err_main_2 & 0x20)==0x20){err_bat2_temp = ERR;}else{err_bat2_temp = NOR;}
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0xF
	LDI  R30,LOW(1)
	RJMP _0x3C1
_0xF:
	LDI  R30,LOW(0)
_0x3C1:
	STS  _err_bat2_temp,R30
; 0000 0206          if((err_main_2 & 0x10)==0x10){err_bat2_volt = ERR;}else{err_bat2_volt = NOR;}
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x11
	LDI  R30,LOW(1)
	RJMP _0x3C2
_0x11:
	LDI  R30,LOW(0)
_0x3C2:
	STS  _err_bat2_volt,R30
; 0000 0207          if((err_main_2 & 0x08)==0x08){err_bat2_curr = ERR;}else{err_bat2_curr = NOR;}
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x13
	LDI  R30,LOW(1)
	RJMP _0x3C3
_0x13:
	LDI  R30,LOW(0)
_0x3C3:
	STS  _err_bat2_curr,R30
; 0000 0208          if((err_main_2 & 0x40)==0x40){batt_link_err_act_2 = ON;}else{batt_link_err_act_2 = OFF;}
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0x15
	SBI  0x1E,3
	RJMP _0x18
_0x15:
	CBI  0x1E,3
_0x18:
; 0000 0209          if((err_main_2 & 0x04)==0x04){batt_charge_2 = ON;}else{batt_charge_2 = OFF;}
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x1B
	LDI  R30,LOW(1)
	RJMP _0x3C4
_0x1B:
	LDI  R30,LOW(0)
_0x3C4:
	STS  _batt_charge_2,R30
; 0000 020A          if((err_main_2 & 0x02)==0x02){batt_discharge_2 = ON;}else{batt_discharge_2 = OFF;}
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x1D
	LDI  R30,LOW(1)
	RJMP _0x3C5
_0x1D:
	LDI  R30,LOW(0)
_0x3C5:
	STS  _batt_discharge_2,R30
; 0000 020B          if((batt_discharge_2 == ON)&&(batt_charge_2 == OFF)){batt_run_act_2 = ON;}else{batt_run_act_2 = OFF;}
	LDS  R26,_batt_discharge_2
	CPI  R26,LOW(0x1)
	BRNE _0x20
	LDS  R26,_batt_charge_2
	CPI  R26,LOW(0x0)
	BREQ _0x21
_0x20:
	RJMP _0x1F
_0x21:
	SBI  0x1E,5
	RJMP _0x24
_0x1F:
	CBI  0x1E,5
_0x24:
; 0000 020C 
; 0000 020D          //******************************
; 0000 020E          //
; 0000 020F          if(batt_link_err_act_2 == ON){batt_level_2 = 0;}
	SBIS 0x1E,3
	RJMP _0x27
	LDI  R30,LOW(0)
	STS  _batt_level_2,R30
; 0000 0210          //
; 0000 0211          //******************************
; 0000 0212 
; 0000 0213 
; 0000 0214          if((err_main_2 & 0x01)==0x01){err_fan_2 = ON;}else{err_fan_2 = OFF;}
_0x27:
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x28
	LDI  R30,LOW(1)
	RJMP _0x3C6
_0x28:
	LDI  R30,LOW(0)
_0x3C6:
	STS  _err_fan_2,R30
; 0000 0215 
; 0000 0216          err1_2 = data_buffer2_temp[51];
	__GETB1MN _data_buffer2_temp,51
	STS  _err1_2,R30
; 0000 0217          err2_2 = data_buffer2_temp[50];
	__GETB1MN _data_buffer2_temp,50
	STS  _err2_2,R30
; 0000 0218          if((err1_2 != 0x00)||(err2_2 != 0x00)){power_2_err = 0x01;}else{power_2_err = 0x00;}
	LDS  R26,_err1_2
	CPI  R26,LOW(0x0)
	BRNE _0x2B
	LDS  R26,_err2_2
	CPI  R26,LOW(0x0)
	BREQ _0x2A
_0x2B:
	LDI  R30,LOW(1)
	RJMP _0x3C7
_0x2A:
	LDI  R30,LOW(0)
_0x3C7:
	STS  _power_2_err,R30
; 0000 0219          status_2 = data_buffer2_temp[49];
	__GETB1MN _data_buffer2_temp,49
	STS  _status_2,R30
; 0000 021A 
; 0000 021B          power_link_2 = data_buffer2_temp[48];
	__GETB1MN _data_buffer2_temp,48
	STS  _power_link_2,R30
; 0000 021C          if((power_link_2 & 0x80) == 0x80)
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x2E
; 0000 021D          {
; 0000 021E           power_link2_err = 0;
	LDI  R30,LOW(0)
	STS  _power_link2_err,R30
; 0000 021F           power_link2_err_act_buzzer = OFF;
	STS  _power_link2_err_act_buzzer,R30
; 0000 0220          }
; 0000 0221          else
	RJMP _0x2F
_0x2E:
; 0000 0222          {
; 0000 0223           if((power_link2_err == 0)&&(power_link2_err_act_buzzer == OFF)) {power_link2_err_act_buzzer = ON;}
	LDS  R26,_power_link2_err
	CPI  R26,LOW(0x0)
	BRNE _0x31
	LDS  R26,_power_link2_err_act_buzzer
	CPI  R26,LOW(0x0)
	BREQ _0x32
_0x31:
	RJMP _0x30
_0x32:
	LDI  R30,LOW(1)
	STS  _power_link2_err_act_buzzer,R30
; 0000 0224           power_link2_err = 1;
_0x30:
	LDI  R30,LOW(1)
	STS  _power_link2_err,R30
; 0000 0225          }
_0x2F:
; 0000 0226 //         if(ADDRESS_0)
; 0000 0227 //         {
; 0000 0228 //             voltage_1  = voltage_m24_2;
; 0000 0229 //             currunt_1  = currunt_ch1_2 + currunt_ch2_2 + currunt_ch3_2 + currunt_ch4_2 + currunt_ch5_2 + currunt_ch6_ ...
; 0000 022A //             bat_volt_1 = batt_level_2;
; 0000 022B //         }
; 0000 022C //         else
; 0000 022D //         {
; 0000 022E //             rtc_get_time(&hour,&minute,&sec);
; 0000 022F //             //rtc_get_date(&week,&day,&month,&year);
; 0000 0230 //             voltage_1  = hour;
; 0000 0231 //             currunt_1  = minute;
; 0000 0232 //             bat_volt_1 = sec;
; 0000 0233 //         }
; 0000 0234 
; 0000 0235 
; 0000 0236          //전원반 #1
; 0000 0237          voltage_ch1_1 = (data_buffer2_temp[47] * 256) + data_buffer2_temp[46];   //v ch1
	__GETB2MN _data_buffer2_temp,47
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,46
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch1_1,R30
	STS  _voltage_ch1_1+1,R31
; 0000 0238          currunt_ch1_1 = (data_buffer2_temp[45] * 256) + data_buffer2_temp[44];
	__GETB2MN _data_buffer2_temp,45
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,44
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch1_1,R30
	STS  _currunt_ch1_1+1,R31
; 0000 0239          voltage_ch2_1 = (data_buffer2_temp[43] * 256) + data_buffer2_temp[42];   //v ch2
	__GETB2MN _data_buffer2_temp,43
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,42
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch2_1,R30
	STS  _voltage_ch2_1+1,R31
; 0000 023A          currunt_ch2_1 = (data_buffer2_temp[41] * 256) + data_buffer2_temp[40];
	__GETB2MN _data_buffer2_temp,41
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,40
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch2_1,R30
	STS  _currunt_ch2_1+1,R31
; 0000 023B          voltage_ch3_1 = (data_buffer2_temp[39] * 256) + data_buffer2_temp[38];   //v ch3
	__GETB2MN _data_buffer2_temp,39
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,38
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch3_1,R30
	STS  _voltage_ch3_1+1,R31
; 0000 023C          currunt_ch3_1 = (data_buffer2_temp[37] * 256) + data_buffer2_temp[36];
	__GETB2MN _data_buffer2_temp,37
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,36
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch3_1,R30
	STS  _currunt_ch3_1+1,R31
; 0000 023D          voltage_ch4_1 = (data_buffer2_temp[35] * 256) + data_buffer2_temp[34];   //v ch4
	__GETB2MN _data_buffer2_temp,35
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,34
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch4_1,R30
	STS  _voltage_ch4_1+1,R31
; 0000 023E          currunt_ch4_1 = (data_buffer2_temp[33] * 256) + data_buffer2_temp[32];
	__GETB2MN _data_buffer2_temp,33
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,32
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch4_1,R30
	STS  _currunt_ch4_1+1,R31
; 0000 023F          voltage_ch5_1 = (data_buffer2_temp[31] * 256) + data_buffer2_temp[30];   //v ch5
	__GETB2MN _data_buffer2_temp,31
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,30
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch5_1,R30
	STS  _voltage_ch5_1+1,R31
; 0000 0240          currunt_ch5_1 = (data_buffer2_temp[29] * 256) + data_buffer2_temp[28];
	__GETB2MN _data_buffer2_temp,29
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,28
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch5_1,R30
	STS  _currunt_ch5_1+1,R31
; 0000 0241          voltage_ch6_1 = (data_buffer2_temp[27] * 256) + data_buffer2_temp[26];   //v ch6
	__GETB2MN _data_buffer2_temp,27
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,26
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch6_1,R30
	STS  _voltage_ch6_1+1,R31
; 0000 0242          currunt_ch6_1 = (data_buffer2_temp[25] * 256) + data_buffer2_temp[24];
	__GETB2MN _data_buffer2_temp,25
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,24
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch6_1,R30
	STS  _currunt_ch6_1+1,R31
; 0000 0243          voltage_ch7_1 = (data_buffer2_temp[23] * 256) + data_buffer2_temp[22];   //v ch7
	__GETB2MN _data_buffer2_temp,23
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,22
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ch7_1,R30
	STS  _voltage_ch7_1+1,R31
; 0000 0244          currunt_ch7_1 = (data_buffer2_temp[21] * 256) + data_buffer2_temp[20];
	__GETB2MN _data_buffer2_temp,21
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,20
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_ch7_1,R30
	STS  _currunt_ch7_1+1,R31
; 0000 0245          voltage_m48_1 = (data_buffer2_temp[19] * 256) + data_buffer2_temp[18];
	__GETB2MN _data_buffer2_temp,19
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_m48_1,R30
	STS  _voltage_m48_1+1,R31
; 0000 0246          voltage_m24_1 = (data_buffer2_temp[17] * 256) + data_buffer2_temp[16];
	__GETB2MN _data_buffer2_temp,17
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,16
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_m24_1,R30
	STS  _voltage_m24_1+1,R31
; 0000 0247          voltage_fan_1 = (data_buffer2_temp[15] * 256) + data_buffer2_temp[14];
	__GETB2MN _data_buffer2_temp,15
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,14
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_fan_1,R30
	STS  _voltage_fan_1+1,R31
; 0000 0248          currunt_fan_1 = (data_buffer2_temp[13] * 256) + data_buffer2_temp[12];
	__GETB2MN _data_buffer2_temp,13
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,12
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _currunt_fan_1,R30
	STS  _currunt_fan_1+1,R31
; 0000 0249 
; 0000 024A          batt_level_1 = data_buffer2_temp[11];
	__GETB1MN _data_buffer2_temp,11
	STS  _batt_level_1,R30
; 0000 024B          err_main_1 = data_buffer2_temp[10];
	__GETB1MN _data_buffer2_temp,10
	STS  _err_main_1,R30
; 0000 024C 
; 0000 024D          if((err_main_1 & 0x40)==0x40){batt_link_err_act_1 = ERR;}else{batt_link_err_act_1 = NOR;}
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0x33
	SBI  0x1E,2
	RJMP _0x36
_0x33:
	CBI  0x1E,2
_0x36:
; 0000 024E          if((err_main_1 & 0x20)==0x20){err_bat1_temp = ERR;}else{err_bat1_temp = NOR;}
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0x39
	LDI  R30,LOW(1)
	RJMP _0x3C8
_0x39:
	LDI  R30,LOW(0)
_0x3C8:
	STS  _err_bat1_temp,R30
; 0000 024F          if((err_main_1 & 0x10)==0x10){err_bat1_volt = ERR;}else{err_bat1_volt = NOR;}
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x3B
	LDI  R30,LOW(1)
	RJMP _0x3C9
_0x3B:
	LDI  R30,LOW(0)
_0x3C9:
	STS  _err_bat1_volt,R30
; 0000 0250          if((err_main_1 & 0x08)==0x08){err_bat1_curr = ERR;}else{err_bat1_curr = NOR;}
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x3D
	LDI  R30,LOW(1)
	RJMP _0x3CA
_0x3D:
	LDI  R30,LOW(0)
_0x3CA:
	STS  _err_bat1_curr,R30
; 0000 0251          if((err_main_1 & 0x04)==0x04){batt_charge_1 = ON;}else{batt_charge_1 = OFF;}
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x3F
	LDI  R30,LOW(1)
	RJMP _0x3CB
_0x3F:
	LDI  R30,LOW(0)
_0x3CB:
	STS  _batt_charge_1,R30
; 0000 0252          if((err_main_1 & 0x02)==0x02){batt_discharge_1 = ON;}else{batt_discharge_1 = OFF;}
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x41
	LDI  R30,LOW(1)
	RJMP _0x3CC
_0x41:
	LDI  R30,LOW(0)
_0x3CC:
	STS  _batt_discharge_1,R30
; 0000 0253 
; 0000 0254          //******************************
; 0000 0255          //
; 0000 0256          if(batt_link_err_act_1 == ERR){batt_level_1 = 0;}
	SBIS 0x1E,2
	RJMP _0x43
	LDI  R30,LOW(0)
	STS  _batt_level_1,R30
; 0000 0257          //
; 0000 0258          //****
; 0000 0259 
; 0000 025A 
; 0000 025B 
; 0000 025C          if((batt_discharge_1 == ON)&&(batt_charge_1 == OFF)){batt_run_act_1 = ON;}else{batt_run_act_1 = OFF;}
_0x43:
	LDS  R26,_batt_discharge_1
	CPI  R26,LOW(0x1)
	BRNE _0x45
	LDS  R26,_batt_charge_1
	CPI  R26,LOW(0x0)
	BREQ _0x46
_0x45:
	RJMP _0x44
_0x46:
	SBI  0x1E,4
	RJMP _0x49
_0x44:
	CBI  0x1E,4
_0x49:
; 0000 025D 
; 0000 025E          if((err_main_1 & 0x01)==0x01){err_fan_1 = ON;}else{err_fan_1 = OFF;}
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x4C
	LDI  R30,LOW(1)
	RJMP _0x3CD
_0x4C:
	LDI  R30,LOW(0)
_0x3CD:
	STS  _err_fan_1,R30
; 0000 025F 
; 0000 0260          err1_1 = data_buffer2_temp[9];
	__GETB1MN _data_buffer2_temp,9
	STS  _err1_1,R30
; 0000 0261          err2_1 = data_buffer2_temp[8];
	__GETB1MN _data_buffer2_temp,8
	STS  _err2_1,R30
; 0000 0262          if((err1_1 != 0x00)||(err2_1 != 0x00)){power_1_err = 0x01;}else{power_1_err = 0x00;}
	LDS  R26,_err1_1
	CPI  R26,LOW(0x0)
	BRNE _0x4F
	LDS  R26,_err2_1
	CPI  R26,LOW(0x0)
	BREQ _0x4E
_0x4F:
	LDI  R30,LOW(1)
	RJMP _0x3CE
_0x4E:
	LDI  R30,LOW(0)
_0x3CE:
	STS  _power_1_err,R30
; 0000 0263          status_1 = data_buffer2_temp[7];
	__GETB1MN _data_buffer2_temp,7
	STS  _status_1,R30
; 0000 0264 
; 0000 0265          power_link_1 = data_buffer2_temp[6];
	__GETB1MN _data_buffer2_temp,6
	STS  _power_link_1,R30
; 0000 0266 
; 0000 0267          if((power_link_1 & 0x80) == 0x80)
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x52
; 0000 0268          {
; 0000 0269           power_link1_err_act_buzzer = OFF;
	LDI  R30,LOW(0)
	STS  _power_link1_err_act_buzzer,R30
; 0000 026A           power_link1_err = 0;
	RJMP _0x3CF
; 0000 026B          }
; 0000 026C          else
_0x52:
; 0000 026D          {
; 0000 026E           if((power_link1_err == 0)&&(power_link1_err_act_buzzer == OFF)) {power_link1_err_act_buzzer = ON;}
	LDS  R26,_power_link1_err
	CPI  R26,LOW(0x0)
	BRNE _0x55
	LDS  R26,_power_link1_err_act_buzzer
	CPI  R26,LOW(0x0)
	BREQ _0x56
_0x55:
	RJMP _0x54
_0x56:
	LDI  R30,LOW(1)
	STS  _power_link1_err_act_buzzer,R30
; 0000 026F           power_link1_err = 1;
_0x54:
	LDI  R30,LOW(1)
_0x3CF:
	STS  _power_link1_err,R30
; 0000 0270          }
; 0000 0271         //devive info
; 0000 0272         if((data_buffer2_temp[5] & 0x80) == 0x80){ac48_ovp = ERR;}else{ac48_ovp = NOR;}
	__GETB1MN _data_buffer2_temp,5
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x57
	LDI  R30,LOW(1)
	RJMP _0x3D0
_0x57:
	LDI  R30,LOW(0)
_0x3D0:
	STS  _ac48_ovp,R30
; 0000 0273         if((data_buffer2_temp[5] & 0x40) == 0x40){ac48_lvp = ERR;}else{ac48_lvp = NOR;}
	__GETB1MN _data_buffer2_temp,5
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0x59
	LDI  R30,LOW(1)
	RJMP _0x3D1
_0x59:
	LDI  R30,LOW(0)
_0x3D1:
	STS  _ac48_lvp,R30
; 0000 0274         if((data_buffer2_temp[5] & 0x20) == 0x20){dc48_ovp = ERR;}else{dc48_ovp = NOR;}
	__GETB1MN _data_buffer2_temp,5
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0x5B
	LDI  R30,LOW(1)
	RJMP _0x3D2
_0x5B:
	LDI  R30,LOW(0)
_0x3D2:
	STS  _dc48_ovp,R30
; 0000 0275         if((data_buffer2_temp[5] & 0x10) == 0x10){dc48_lvp = ERR;}else{dc48_lvp = NOR;}
	__GETB1MN _data_buffer2_temp,5
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x5D
	LDI  R30,LOW(1)
	RJMP _0x3D3
_0x5D:
	LDI  R30,LOW(0)
_0x3D3:
	STS  _dc48_lvp,R30
; 0000 0276 
; 0000 0277        if((ac48_ovp == ERR)||(ac48_lvp == ERR)||(dc48_ovp == ERR)||(dc48_lvp == ERR)){deiver_48_err = ERR;}else{deiver_4 ...
	LDS  R26,_ac48_ovp
	CPI  R26,LOW(0x1)
	BREQ _0x60
	LDS  R26,_ac48_lvp
	CPI  R26,LOW(0x1)
	BREQ _0x60
	LDS  R26,_dc48_ovp
	CPI  R26,LOW(0x1)
	BREQ _0x60
	LDS  R26,_dc48_lvp
	CPI  R26,LOW(0x1)
	BRNE _0x5F
_0x60:
	LDI  R30,LOW(1)
	RJMP _0x3D4
_0x5F:
	LDI  R30,LOW(0)
_0x3D4:
	STS  _deiver_48_err,R30
; 0000 0278 
; 0000 0279         if((data_buffer2_temp[5] & 0x08) == 0x08)
	__GETB1MN _data_buffer2_temp,5
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x63
; 0000 027A         {
; 0000 027B          if(time_data_get_act == 0){time_data_get = 1;}
	LDS  R30,_time_data_get_act
	CPI  R30,0
	BRNE _0x64
	LDI  R30,LOW(1)
	STS  _time_data_get,R30
; 0000 027C          time_data_get_act = 1;
_0x64:
	LDI  R30,LOW(1)
	RJMP _0x3D5
; 0000 027D         }
; 0000 027E         else
_0x63:
; 0000 027F         {
; 0000 0280           time_data_get = 0;
	LDI  R30,LOW(0)
	STS  _time_data_get,R30
; 0000 0281           time_data_get_act = 0;
_0x3D5:
	STS  _time_data_get_act,R30
; 0000 0282         }
; 0000 0283 
; 0000 0284          //switch
; 0000 0285          sw_status = data_buffer2_temp[4];
	__GETB1MN _data_buffer2_temp,4
	STS  _sw_status,R30
; 0000 0286 
; 0000 0287          //분배반 48V
; 0000 0288          div_48v = (data_buffer2_temp[3] * 256) + data_buffer2_temp[2];
	__GETB2MN _data_buffer2_temp,3
	CALL SUBOPT_0x1
	__GETB1MN _data_buffer2_temp,2
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _div_48v,R30
	STS  _div_48v+1,R31
; 0000 0289 
; 0000 028A           if(ADDRESS_0)
	LDS  R30,259
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BREQ PC+2
	RJMP _0x66
; 0000 028B          {
; 0000 028C             if(DT_ERR == ERR)
	SBIS 0x2,5
	RJMP _0x67
; 0000 028D             {
; 0000 028E                 voltage_1 = 0;
	CALL SUBOPT_0x2
; 0000 028F                 currunt_1 = 0;
; 0000 0290                 bat_volt_1 = 0;
; 0000 0291             }
; 0000 0292             else
	RJMP _0x68
_0x67:
; 0000 0293             {
; 0000 0294              voltage_1  = voltage_m24_2;//(ge_rx_data_h*256)+ge_rx_data_l;//
	LDS  R30,_voltage_m24_2
	LDS  R31,_voltage_m24_2+1
	STS  _voltage_1,R30
	STS  _voltage_1+1,R31
; 0000 0295              //currunt_1  = currunt_ch1_1 + currunt_ch2_1 + currunt_ch3_1 + currunt_ch4_1 + currunt_ch3_2 + currunt_ch4_ ...
; 0000 0296              //currunt_1  =  (currunt_ch1_2 + currunt_ch2_2+ currunt_ch3_2 + currunt_ch4_2+currunt_ch5_2 + currunt_ch6_2 ...
; 0000 0297              currunt_1  =  (currunt_ch1_2 + currunt_ch2_2+ currunt_ch3_2 + currunt_ch4_2+currunt_ch5_2 + currunt_ch6_2+  ...
	LDS  R30,_currunt_ch2_2
	LDS  R31,_currunt_ch2_2+1
	LDS  R26,_currunt_ch1_2
	LDS  R27,_currunt_ch1_2+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch3_2
	LDS  R27,_currunt_ch3_2+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch4_2
	LDS  R27,_currunt_ch4_2+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch5_2
	LDS  R27,_currunt_ch5_2+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch6_2
	LDS  R27,_currunt_ch6_2+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch7_2
	LDS  R27,_currunt_ch7_2+1
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x3
; 0000 0298              bat_volt_1 = batt_level_2;
	LDS  R30,_batt_level_2
	LDI  R31,0
	STS  _bat_volt_1,R30
	STS  _bat_volt_1+1,R31
; 0000 0299             }
_0x68:
; 0000 029A          }
; 0000 029B          else
	RJMP _0x69
_0x66:
; 0000 029C          {
; 0000 029D              rtc_get_time(&hour,&minute,&sec);
	CALL SUBOPT_0x4
; 0000 029E              //rtc_get_date(&week,&day,&month,&year);
; 0000 029F              voltage_1  = hour;
	LDS  R30,_hour
	LDI  R31,0
	STS  _voltage_1,R30
	STS  _voltage_1+1,R31
; 0000 02A0              currunt_1  = minute;
	LDS  R30,_minute
	LDI  R31,0
	CALL SUBOPT_0x3
; 0000 02A1              bat_volt_1 = sec;
	LDS  R30,_sec
	LDI  R31,0
	STS  _bat_volt_1,R30
	STS  _bat_volt_1+1,R31
; 0000 02A2          }
_0x69:
; 0000 02A3 
; 0000 02A4 
; 0000 02A5          if(ADDRESS_0)
	LDS  R30,259
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BREQ PC+2
	RJMP _0x6A
; 0000 02A6          {
; 0000 02A7             if(DT_ERR == ERR)
	SBIS 0x2,5
	RJMP _0x6B
; 0000 02A8             {
; 0000 02A9                 voltage_2 = 0;
	CALL SUBOPT_0x5
; 0000 02AA                 currunt_2 = 0;
; 0000 02AB                 bat_volt_2 = 0;
; 0000 02AC             }
; 0000 02AD             else
	RJMP _0x6C
_0x6B:
; 0000 02AE             {
; 0000 02AF                 voltage_2  = voltage_m24_1;//(ge_rx_data_err1 * 256)+ge_rx_data_err2; //sw_status;
	LDS  R30,_voltage_m24_1
	LDS  R31,_voltage_m24_1+1
	STS  _voltage_2,R30
	STS  _voltage_2+1,R31
; 0000 02B0                 //currunt_2  = currunt_ch1_2 + currunt_ch2_2+ currunt_ch5_2 + currunt_ch6_2+ currunt_ch5_1 + currunt_ch6 ...
; 0000 02B1                 //currunt_2  = (currunt_ch1_1 + currunt_ch2_1 + currunt_ch3_1 + currunt_ch4_1  +currunt_ch5_1 + currunt_ ...
; 0000 02B2                 currunt_2  = (currunt_ch1_1 + currunt_ch2_1 + currunt_ch3_1 + currunt_ch4_1  +currunt_ch5_1 + currunt_ch ...
	LDS  R30,_currunt_ch2_1
	LDS  R31,_currunt_ch2_1+1
	LDS  R26,_currunt_ch1_1
	LDS  R27,_currunt_ch1_1+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch3_1
	LDS  R27,_currunt_ch3_1+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch4_1
	LDS  R27,_currunt_ch4_1+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch5_1
	LDS  R27,_currunt_ch5_1+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch6_1
	LDS  R27,_currunt_ch6_1+1
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_currunt_ch7_1
	LDS  R27,_currunt_ch7_1+1
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x6
; 0000 02B3                 bat_volt_2 = batt_level_1;
	LDS  R30,_batt_level_1
	LDI  R31,0
	STS  _bat_volt_2,R30
	STS  _bat_volt_2+1,R31
; 0000 02B4             }
_0x6C:
; 0000 02B5          }
; 0000 02B6          else
	RJMP _0x6D
_0x6A:
; 0000 02B7          {
; 0000 02B8             //rtc_get_time(&hour,&minute,&sec);
; 0000 02B9             rtc_get_date(&week,&day,&month,&year);
	CALL SUBOPT_0x7
; 0000 02BA             voltage_2  = year;
	LDS  R30,_year
	LDI  R31,0
	STS  _voltage_2,R30
	STS  _voltage_2+1,R31
; 0000 02BB             currunt_2  = month;
	LDS  R30,_month
	LDI  R31,0
	CALL SUBOPT_0x6
; 0000 02BC             bat_volt_2 = day;
	LDS  R30,_day
	LDI  R31,0
	STS  _bat_volt_2,R30
	STS  _bat_volt_2+1,R31
; 0000 02BD          }
_0x6D:
; 0000 02BE 
; 0000 02BF 
; 0000 02C0          data_buffer2_temp[91] = '';
	LDI  R30,LOW(0)
	__PUTB1MN _data_buffer2_temp,91
; 0000 02C1          data_buffer2_temp[90] = '';
	__PUTB1MN _data_buffer2_temp,90
; 0000 02C2          data_buffer2_temp[89] = '';
	__PUTB1MN _data_buffer2_temp,89
; 0000 02C3          data_buffer2_temp[88] = '';
	__PUTB1MN _data_buffer2_temp,88
; 0000 02C4          data_buffer2_temp[87] = '';
	__PUTB1MN _data_buffer2_temp,87
; 0000 02C5          data_buffer2_temp[86] = '';
	__PUTB1MN _data_buffer2_temp,86
; 0000 02C6          data_buffer2_temp[85] = '';
	__PUTB1MN _data_buffer2_temp,85
; 0000 02C7          data_buffer2_temp[84] = '';
	__PUTB1MN _data_buffer2_temp,84
; 0000 02C8          data_buffer2_temp[83] = '';
	__PUTB1MN _data_buffer2_temp,83
; 0000 02C9          data_buffer2_temp[82] = '';
	__PUTB1MN _data_buffer2_temp,82
; 0000 02CA          data_buffer2_temp[81] = '';
	__PUTB1MN _data_buffer2_temp,81
; 0000 02CB          data_buffer2_temp[80] = '';
	__PUTB1MN _data_buffer2_temp,80
; 0000 02CC          data_buffer2_temp[79] = '';
	__PUTB1MN _data_buffer2_temp,79
; 0000 02CD          data_buffer2_temp[78] = '';
	__PUTB1MN _data_buffer2_temp,78
; 0000 02CE          data_buffer2_temp[77] = '';
	__PUTB1MN _data_buffer2_temp,77
; 0000 02CF          data_buffer2_temp[76] = '';
	__PUTB1MN _data_buffer2_temp,76
; 0000 02D0          data_buffer2_temp[75] = '';
	__PUTB1MN _data_buffer2_temp,75
; 0000 02D1          data_buffer2_temp[74] = '';
	__PUTB1MN _data_buffer2_temp,74
; 0000 02D2          data_buffer2_temp[73] = '';
	__PUTB1MN _data_buffer2_temp,73
; 0000 02D3          data_buffer2_temp[72] = '';
	__PUTB1MN _data_buffer2_temp,72
; 0000 02D4          data_buffer2_temp[71] = '';
	__PUTB1MN _data_buffer2_temp,71
; 0000 02D5          data_buffer2_temp[70] = '';
	__PUTB1MN _data_buffer2_temp,70
; 0000 02D6          data_buffer2_temp[69] = '';
	__PUTB1MN _data_buffer2_temp,69
; 0000 02D7          data_buffer2_temp[68] = '';
	__PUTB1MN _data_buffer2_temp,68
; 0000 02D8          data_buffer2_temp[67] = '';
	__PUTB1MN _data_buffer2_temp,67
; 0000 02D9          data_buffer2_temp[66] = '';
	__PUTB1MN _data_buffer2_temp,66
; 0000 02DA          data_buffer2_temp[65] = '';
	__PUTB1MN _data_buffer2_temp,65
; 0000 02DB          data_buffer2_temp[64] = '';
	__PUTB1MN _data_buffer2_temp,64
; 0000 02DC          data_buffer2_temp[63] = '';
	__PUTB1MN _data_buffer2_temp,63
; 0000 02DD          data_buffer2_temp[62] = '';
	__PUTB1MN _data_buffer2_temp,62
; 0000 02DE          data_buffer2_temp[61] = '';
	__PUTB1MN _data_buffer2_temp,61
; 0000 02DF          data_buffer2_temp[60] = '';
	__PUTB1MN _data_buffer2_temp,60
; 0000 02E0          data_buffer2_temp[59] = '';
	__PUTB1MN _data_buffer2_temp,59
; 0000 02E1          data_buffer2_temp[58] = '';
	__PUTB1MN _data_buffer2_temp,58
; 0000 02E2          data_buffer2_temp[57] = '';
	__PUTB1MN _data_buffer2_temp,57
; 0000 02E3          data_buffer2_temp[56] = '';
	__PUTB1MN _data_buffer2_temp,56
; 0000 02E4          data_buffer2_temp[55] = '';
	__PUTB1MN _data_buffer2_temp,55
; 0000 02E5          data_buffer2_temp[54] = '';
	__PUTB1MN _data_buffer2_temp,54
; 0000 02E6          data_buffer2_temp[53] = '';
	__PUTB1MN _data_buffer2_temp,53
; 0000 02E7          data_buffer2_temp[52] = '';
	__PUTB1MN _data_buffer2_temp,52
; 0000 02E8          data_buffer2_temp[51] = '';
	__PUTB1MN _data_buffer2_temp,51
; 0000 02E9          data_buffer2_temp[50] = '';
	__PUTB1MN _data_buffer2_temp,50
; 0000 02EA          data_buffer2_temp[49] = '';
	__PUTB1MN _data_buffer2_temp,49
; 0000 02EB          data_buffer2_temp[48] = '';
	__PUTB1MN _data_buffer2_temp,48
; 0000 02EC          data_buffer2_temp[47] = '';
	__PUTB1MN _data_buffer2_temp,47
; 0000 02ED          data_buffer2_temp[46] = '';
	__PUTB1MN _data_buffer2_temp,46
; 0000 02EE          data_buffer2_temp[45] = '';
	__PUTB1MN _data_buffer2_temp,45
; 0000 02EF          data_buffer2_temp[44] = '';
	__PUTB1MN _data_buffer2_temp,44
; 0000 02F0          data_buffer2_temp[43] = '';
	__PUTB1MN _data_buffer2_temp,43
; 0000 02F1          data_buffer2_temp[42] = '';
	__PUTB1MN _data_buffer2_temp,42
; 0000 02F2          data_buffer2_temp[41] = '';
	__PUTB1MN _data_buffer2_temp,41
; 0000 02F3          data_buffer2_temp[40] = '';
	__PUTB1MN _data_buffer2_temp,40
; 0000 02F4          data_buffer2_temp[39] = '';
	__PUTB1MN _data_buffer2_temp,39
; 0000 02F5          data_buffer2_temp[38] = '';
	__PUTB1MN _data_buffer2_temp,38
; 0000 02F6          data_buffer2_temp[37] = '';
	__PUTB1MN _data_buffer2_temp,37
; 0000 02F7          data_buffer2_temp[36] = '';
	__PUTB1MN _data_buffer2_temp,36
; 0000 02F8          data_buffer2_temp[35] = '';
	__PUTB1MN _data_buffer2_temp,35
; 0000 02F9          data_buffer2_temp[34] = '';
	__PUTB1MN _data_buffer2_temp,34
; 0000 02FA          data_buffer2_temp[33] = '';
	__PUTB1MN _data_buffer2_temp,33
; 0000 02FB          data_buffer2_temp[32] = '';
	__PUTB1MN _data_buffer2_temp,32
; 0000 02FC          data_buffer2_temp[31] = '';
	__PUTB1MN _data_buffer2_temp,31
; 0000 02FD          data_buffer2_temp[30] = '';
	__PUTB1MN _data_buffer2_temp,30
; 0000 02FE          data_buffer2_temp[29] = '';
	__PUTB1MN _data_buffer2_temp,29
; 0000 02FF          data_buffer2_temp[28] = '';
	__PUTB1MN _data_buffer2_temp,28
; 0000 0300          data_buffer2_temp[27] = '';
	__PUTB1MN _data_buffer2_temp,27
; 0000 0301          data_buffer2_temp[26] = '';
	__PUTB1MN _data_buffer2_temp,26
; 0000 0302          data_buffer2_temp[25] = '';
	__PUTB1MN _data_buffer2_temp,25
; 0000 0303          data_buffer2_temp[24] = '';
	__PUTB1MN _data_buffer2_temp,24
; 0000 0304          data_buffer2_temp[23] = '';
	__PUTB1MN _data_buffer2_temp,23
; 0000 0305          data_buffer2_temp[22] = '';
	__PUTB1MN _data_buffer2_temp,22
; 0000 0306          data_buffer2_temp[21] = '';
	__PUTB1MN _data_buffer2_temp,21
; 0000 0307          data_buffer2_temp[20] = '';
	__PUTB1MN _data_buffer2_temp,20
; 0000 0308          data_buffer2_temp[19] = '';
	__PUTB1MN _data_buffer2_temp,19
; 0000 0309          data_buffer2_temp[18] = '';
	__PUTB1MN _data_buffer2_temp,18
; 0000 030A          data_buffer2_temp[17] = '';
	__PUTB1MN _data_buffer2_temp,17
; 0000 030B          data_buffer2_temp[16] = '';
	__PUTB1MN _data_buffer2_temp,16
; 0000 030C          data_buffer2_temp[15] = '';
	__PUTB1MN _data_buffer2_temp,15
; 0000 030D          data_buffer2_temp[14] = '';
	__PUTB1MN _data_buffer2_temp,14
; 0000 030E          data_buffer2_temp[13] = '';
	CALL SUBOPT_0x8
; 0000 030F          data_buffer2_temp[12] = '';
; 0000 0310          data_buffer2_temp[11] = '';
; 0000 0311          data_buffer2_temp[10] = '';
; 0000 0312          data_buffer2_temp[9] = '';
; 0000 0313          data_buffer2_temp[8] = '';
; 0000 0314          data_buffer2_temp[7] = '';
; 0000 0315          data_buffer2_temp[6] = '';
; 0000 0316          data_buffer2_temp[5] = '';
; 0000 0317          data_buffer2_temp[4] = '';
; 0000 0318          data_buffer2_temp[3] = '';
; 0000 0319          data_buffer2_temp[2] = '';
; 0000 031A          data_buffer2_temp[1] = '';
; 0000 031B          data_buffer2_temp[0] = '';
; 0000 031C         loss_count_a=0;
	LDI  R30,LOW(0)
	STS  _loss_count_a,R30
	STS  _loss_count_a+1,R30
; 0000 031D        }
; 0000 031E        // loss_count_a=0;
; 0000 031F    }
_0xC:
; 0000 0320    else
	RJMP _0x6E
_0xB:
; 0000 0321    {
; 0000 0322          data_buffer2_temp[91] = data_buffer2_temp[90];
	__GETB1MN _data_buffer2_temp,90
	__PUTB1MN _data_buffer2_temp,91
; 0000 0323          data_buffer2_temp[90] = data_buffer2_temp[89];
	__GETB1MN _data_buffer2_temp,89
	__PUTB1MN _data_buffer2_temp,90
; 0000 0324          data_buffer2_temp[89] = data_buffer2_temp[88];
	__GETB1MN _data_buffer2_temp,88
	__PUTB1MN _data_buffer2_temp,89
; 0000 0325          data_buffer2_temp[88] = data_buffer2_temp[87];
	__GETB1MN _data_buffer2_temp,87
	__PUTB1MN _data_buffer2_temp,88
; 0000 0326          data_buffer2_temp[87] = data_buffer2_temp[86];
	__GETB1MN _data_buffer2_temp,86
	__PUTB1MN _data_buffer2_temp,87
; 0000 0327          data_buffer2_temp[86] = data_buffer2_temp[85];
	__GETB1MN _data_buffer2_temp,85
	__PUTB1MN _data_buffer2_temp,86
; 0000 0328          data_buffer2_temp[85] = data_buffer2_temp[84];
	__GETB1MN _data_buffer2_temp,84
	__PUTB1MN _data_buffer2_temp,85
; 0000 0329          data_buffer2_temp[84] = data_buffer2_temp[83];
	__GETB1MN _data_buffer2_temp,83
	__PUTB1MN _data_buffer2_temp,84
; 0000 032A          data_buffer2_temp[83] = data_buffer2_temp[82];
	__GETB1MN _data_buffer2_temp,82
	__PUTB1MN _data_buffer2_temp,83
; 0000 032B          data_buffer2_temp[82] = data_buffer2_temp[81];
	__GETB1MN _data_buffer2_temp,81
	__PUTB1MN _data_buffer2_temp,82
; 0000 032C          data_buffer2_temp[81] = data_buffer2_temp[80];
	__GETB1MN _data_buffer2_temp,80
	__PUTB1MN _data_buffer2_temp,81
; 0000 032D          data_buffer2_temp[80] = data_buffer2_temp[79];
	__GETB1MN _data_buffer2_temp,79
	__PUTB1MN _data_buffer2_temp,80
; 0000 032E          data_buffer2_temp[79] = data_buffer2_temp[78];
	__GETB1MN _data_buffer2_temp,78
	__PUTB1MN _data_buffer2_temp,79
; 0000 032F          data_buffer2_temp[78] = data_buffer2_temp[77];
	__GETB1MN _data_buffer2_temp,77
	__PUTB1MN _data_buffer2_temp,78
; 0000 0330          data_buffer2_temp[77] = data_buffer2_temp[76];
	__GETB1MN _data_buffer2_temp,76
	__PUTB1MN _data_buffer2_temp,77
; 0000 0331          data_buffer2_temp[76] = data_buffer2_temp[75];
	__GETB1MN _data_buffer2_temp,75
	__PUTB1MN _data_buffer2_temp,76
; 0000 0332          data_buffer2_temp[75] = data_buffer2_temp[74];
	__GETB1MN _data_buffer2_temp,74
	__PUTB1MN _data_buffer2_temp,75
; 0000 0333          data_buffer2_temp[74] = data_buffer2_temp[73];
	__GETB1MN _data_buffer2_temp,73
	__PUTB1MN _data_buffer2_temp,74
; 0000 0334          data_buffer2_temp[73] = data_buffer2_temp[72];
	__GETB1MN _data_buffer2_temp,72
	__PUTB1MN _data_buffer2_temp,73
; 0000 0335          data_buffer2_temp[72] = data_buffer2_temp[71];
	__GETB1MN _data_buffer2_temp,71
	__PUTB1MN _data_buffer2_temp,72
; 0000 0336          data_buffer2_temp[71] = data_buffer2_temp[70];
	__GETB1MN _data_buffer2_temp,70
	__PUTB1MN _data_buffer2_temp,71
; 0000 0337          data_buffer2_temp[70] = data_buffer2_temp[69];
	__GETB1MN _data_buffer2_temp,69
	__PUTB1MN _data_buffer2_temp,70
; 0000 0338          data_buffer2_temp[69] = data_buffer2_temp[68];
	__GETB1MN _data_buffer2_temp,68
	__PUTB1MN _data_buffer2_temp,69
; 0000 0339          data_buffer2_temp[68] = data_buffer2_temp[67];
	__GETB1MN _data_buffer2_temp,67
	__PUTB1MN _data_buffer2_temp,68
; 0000 033A          data_buffer2_temp[67] = data_buffer2_temp[66];
	__GETB1MN _data_buffer2_temp,66
	__PUTB1MN _data_buffer2_temp,67
; 0000 033B          data_buffer2_temp[66] = data_buffer2_temp[65];
	__GETB1MN _data_buffer2_temp,65
	__PUTB1MN _data_buffer2_temp,66
; 0000 033C          data_buffer2_temp[65] = data_buffer2_temp[64];
	__GETB1MN _data_buffer2_temp,64
	__PUTB1MN _data_buffer2_temp,65
; 0000 033D          data_buffer2_temp[64] = data_buffer2_temp[63];
	__GETB1MN _data_buffer2_temp,63
	__PUTB1MN _data_buffer2_temp,64
; 0000 033E          data_buffer2_temp[63] = data_buffer2_temp[62];
	__GETB1MN _data_buffer2_temp,62
	__PUTB1MN _data_buffer2_temp,63
; 0000 033F          data_buffer2_temp[62] = data_buffer2_temp[61];
	__GETB1MN _data_buffer2_temp,61
	__PUTB1MN _data_buffer2_temp,62
; 0000 0340          data_buffer2_temp[61] = data_buffer2_temp[60];
	__GETB1MN _data_buffer2_temp,60
	__PUTB1MN _data_buffer2_temp,61
; 0000 0341          data_buffer2_temp[60] = data_buffer2_temp[59];
	__GETB1MN _data_buffer2_temp,59
	__PUTB1MN _data_buffer2_temp,60
; 0000 0342          data_buffer2_temp[59] = data_buffer2_temp[58];
	__GETB1MN _data_buffer2_temp,58
	__PUTB1MN _data_buffer2_temp,59
; 0000 0343          data_buffer2_temp[58] = data_buffer2_temp[57];
	__GETB1MN _data_buffer2_temp,57
	__PUTB1MN _data_buffer2_temp,58
; 0000 0344          data_buffer2_temp[57] = data_buffer2_temp[56];
	__GETB1MN _data_buffer2_temp,56
	__PUTB1MN _data_buffer2_temp,57
; 0000 0345          data_buffer2_temp[56] = data_buffer2_temp[55];
	__GETB1MN _data_buffer2_temp,55
	__PUTB1MN _data_buffer2_temp,56
; 0000 0346          data_buffer2_temp[55] = data_buffer2_temp[54];
	__GETB1MN _data_buffer2_temp,54
	__PUTB1MN _data_buffer2_temp,55
; 0000 0347          data_buffer2_temp[54] = data_buffer2_temp[53];
	__GETB1MN _data_buffer2_temp,53
	__PUTB1MN _data_buffer2_temp,54
; 0000 0348          data_buffer2_temp[53] = data_buffer2_temp[52];
	__GETB1MN _data_buffer2_temp,52
	__PUTB1MN _data_buffer2_temp,53
; 0000 0349          data_buffer2_temp[52] = data_buffer2_temp[51];
	__GETB1MN _data_buffer2_temp,51
	__PUTB1MN _data_buffer2_temp,52
; 0000 034A          data_buffer2_temp[51] = data_buffer2_temp[50];
	__GETB1MN _data_buffer2_temp,50
	__PUTB1MN _data_buffer2_temp,51
; 0000 034B          data_buffer2_temp[50] = data_buffer2_temp[49];
	__GETB1MN _data_buffer2_temp,49
	__PUTB1MN _data_buffer2_temp,50
; 0000 034C          data_buffer2_temp[49] = data_buffer2_temp[48];
	__GETB1MN _data_buffer2_temp,48
	__PUTB1MN _data_buffer2_temp,49
; 0000 034D          data_buffer2_temp[48] = data_buffer2_temp[47];
	__GETB1MN _data_buffer2_temp,47
	__PUTB1MN _data_buffer2_temp,48
; 0000 034E          data_buffer2_temp[47] = data_buffer2_temp[46];
	__GETB1MN _data_buffer2_temp,46
	__PUTB1MN _data_buffer2_temp,47
; 0000 034F          data_buffer2_temp[46] = data_buffer2_temp[45];
	__GETB1MN _data_buffer2_temp,45
	__PUTB1MN _data_buffer2_temp,46
; 0000 0350          data_buffer2_temp[45] = data_buffer2_temp[44];
	__GETB1MN _data_buffer2_temp,44
	__PUTB1MN _data_buffer2_temp,45
; 0000 0351          data_buffer2_temp[44] = data_buffer2_temp[43];
	__GETB1MN _data_buffer2_temp,43
	__PUTB1MN _data_buffer2_temp,44
; 0000 0352          data_buffer2_temp[43] = data_buffer2_temp[42];
	__GETB1MN _data_buffer2_temp,42
	__PUTB1MN _data_buffer2_temp,43
; 0000 0353          data_buffer2_temp[42] = data_buffer2_temp[41];
	__GETB1MN _data_buffer2_temp,41
	__PUTB1MN _data_buffer2_temp,42
; 0000 0354          data_buffer2_temp[41] = data_buffer2_temp[40];
	__GETB1MN _data_buffer2_temp,40
	__PUTB1MN _data_buffer2_temp,41
; 0000 0355          data_buffer2_temp[40] = data_buffer2_temp[39];
	__GETB1MN _data_buffer2_temp,39
	__PUTB1MN _data_buffer2_temp,40
; 0000 0356          data_buffer2_temp[39] = data_buffer2_temp[38];
	__GETB1MN _data_buffer2_temp,38
	__PUTB1MN _data_buffer2_temp,39
; 0000 0357          data_buffer2_temp[38] = data_buffer2_temp[37];
	__GETB1MN _data_buffer2_temp,37
	__PUTB1MN _data_buffer2_temp,38
; 0000 0358          data_buffer2_temp[37] = data_buffer2_temp[36];
	__GETB1MN _data_buffer2_temp,36
	__PUTB1MN _data_buffer2_temp,37
; 0000 0359          data_buffer2_temp[36] = data_buffer2_temp[35];
	__GETB1MN _data_buffer2_temp,35
	__PUTB1MN _data_buffer2_temp,36
; 0000 035A          data_buffer2_temp[35] = data_buffer2_temp[34];
	__GETB1MN _data_buffer2_temp,34
	__PUTB1MN _data_buffer2_temp,35
; 0000 035B          data_buffer2_temp[34] = data_buffer2_temp[33];
	__GETB1MN _data_buffer2_temp,33
	__PUTB1MN _data_buffer2_temp,34
; 0000 035C          data_buffer2_temp[33] = data_buffer2_temp[32];
	__GETB1MN _data_buffer2_temp,32
	__PUTB1MN _data_buffer2_temp,33
; 0000 035D          data_buffer2_temp[32] = data_buffer2_temp[31];
	__GETB1MN _data_buffer2_temp,31
	__PUTB1MN _data_buffer2_temp,32
; 0000 035E          data_buffer2_temp[31] = data_buffer2_temp[30];
	__GETB1MN _data_buffer2_temp,30
	__PUTB1MN _data_buffer2_temp,31
; 0000 035F          data_buffer2_temp[30] = data_buffer2_temp[29];
	__GETB1MN _data_buffer2_temp,29
	__PUTB1MN _data_buffer2_temp,30
; 0000 0360          data_buffer2_temp[29] = data_buffer2_temp[28];
	__GETB1MN _data_buffer2_temp,28
	__PUTB1MN _data_buffer2_temp,29
; 0000 0361          data_buffer2_temp[28] = data_buffer2_temp[27];
	__GETB1MN _data_buffer2_temp,27
	__PUTB1MN _data_buffer2_temp,28
; 0000 0362          data_buffer2_temp[27] = data_buffer2_temp[26];
	__GETB1MN _data_buffer2_temp,26
	__PUTB1MN _data_buffer2_temp,27
; 0000 0363          data_buffer2_temp[26] = data_buffer2_temp[25];
	__GETB1MN _data_buffer2_temp,25
	__PUTB1MN _data_buffer2_temp,26
; 0000 0364          data_buffer2_temp[25] = data_buffer2_temp[24];
	__GETB1MN _data_buffer2_temp,24
	__PUTB1MN _data_buffer2_temp,25
; 0000 0365          data_buffer2_temp[24] = data_buffer2_temp[23];
	__GETB1MN _data_buffer2_temp,23
	__PUTB1MN _data_buffer2_temp,24
; 0000 0366          data_buffer2_temp[23] = data_buffer2_temp[22];
	__GETB1MN _data_buffer2_temp,22
	__PUTB1MN _data_buffer2_temp,23
; 0000 0367          data_buffer2_temp[22] = data_buffer2_temp[21];
	__GETB1MN _data_buffer2_temp,21
	__PUTB1MN _data_buffer2_temp,22
; 0000 0368          data_buffer2_temp[21] = data_buffer2_temp[20];
	__GETB1MN _data_buffer2_temp,20
	__PUTB1MN _data_buffer2_temp,21
; 0000 0369          data_buffer2_temp[20] = data_buffer2_temp[19];
	__GETB1MN _data_buffer2_temp,19
	__PUTB1MN _data_buffer2_temp,20
; 0000 036A          data_buffer2_temp[19] = data_buffer2_temp[18];
	__GETB1MN _data_buffer2_temp,18
	__PUTB1MN _data_buffer2_temp,19
; 0000 036B          data_buffer2_temp[18] = data_buffer2_temp[17];
	__GETB1MN _data_buffer2_temp,17
	__PUTB1MN _data_buffer2_temp,18
; 0000 036C          data_buffer2_temp[17] = data_buffer2_temp[16];
	__GETB1MN _data_buffer2_temp,16
	__PUTB1MN _data_buffer2_temp,17
; 0000 036D          data_buffer2_temp[16] = data_buffer2_temp[15];
	__GETB1MN _data_buffer2_temp,15
	__PUTB1MN _data_buffer2_temp,16
; 0000 036E          data_buffer2_temp[15] = data_buffer2_temp[14];
	__GETB1MN _data_buffer2_temp,14
	__PUTB1MN _data_buffer2_temp,15
; 0000 036F          data_buffer2_temp[14] = data_buffer2_temp[13];
	__GETB1MN _data_buffer2_temp,13
	__PUTB1MN _data_buffer2_temp,14
; 0000 0370          data_buffer2_temp[13] = data_buffer2_temp[12];
	__GETB1MN _data_buffer2_temp,12
	__PUTB1MN _data_buffer2_temp,13
; 0000 0371          data_buffer2_temp[12] = data_buffer2_temp[11];
	__GETB1MN _data_buffer2_temp,11
	__PUTB1MN _data_buffer2_temp,12
; 0000 0372          data_buffer2_temp[11] = data_buffer2_temp[10];
	__GETB1MN _data_buffer2_temp,10
	__PUTB1MN _data_buffer2_temp,11
; 0000 0373          data_buffer2_temp[10] = data_buffer2_temp[9];
	__GETB1MN _data_buffer2_temp,9
	__PUTB1MN _data_buffer2_temp,10
; 0000 0374          data_buffer2_temp[9] = data_buffer2_temp[8];
	__GETB1MN _data_buffer2_temp,8
	__PUTB1MN _data_buffer2_temp,9
; 0000 0375          data_buffer2_temp[8] = data_buffer2_temp[7];
	__GETB1MN _data_buffer2_temp,7
	__PUTB1MN _data_buffer2_temp,8
; 0000 0376          data_buffer2_temp[7] = data_buffer2_temp[6];
	__GETB1MN _data_buffer2_temp,6
	__PUTB1MN _data_buffer2_temp,7
; 0000 0377          data_buffer2_temp[6] = data_buffer2_temp[5];
	__GETB1MN _data_buffer2_temp,5
	__PUTB1MN _data_buffer2_temp,6
; 0000 0378          data_buffer2_temp[5] = data_buffer2_temp[4];
	__GETB1MN _data_buffer2_temp,4
	__PUTB1MN _data_buffer2_temp,5
; 0000 0379          data_buffer2_temp[4] = data_buffer2_temp[3];
	__GETB1MN _data_buffer2_temp,3
	__PUTB1MN _data_buffer2_temp,4
; 0000 037A          data_buffer2_temp[3] = data_buffer2_temp[2];
	__GETB1MN _data_buffer2_temp,2
	__PUTB1MN _data_buffer2_temp,3
; 0000 037B          data_buffer2_temp[2] = data_buffer2_temp[1];
	__GETB1MN _data_buffer2_temp,1
	__PUTB1MN _data_buffer2_temp,2
; 0000 037C          data_buffer2_temp[1] = data_buffer2_temp[0];
	LDS  R30,_data_buffer2_temp
	__PUTB1MN _data_buffer2_temp,1
; 0000 037D          data_buffer2_temp[0] = data;
	STS  _data_buffer2_temp,R16
; 0000 037E    }
_0x6E:
; 0000 037F }
	RJMP _0x450
; .FEND
;
;// Get a character from the USART0 Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0385 {
; 0000 0386 char data;
; 0000 0387 while (rx_counter0==0);
;	data -> R17
; 0000 0388 data=rx_buffer0[rx_rd_index0++];
; 0000 0389 #if RX_BUFFER_SIZE0 != 256
; 0000 038A if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
; 0000 038B #endif
; 0000 038C #asm("cli")
; 0000 038D --rx_counter0;
; 0000 038E #asm("sei")
; 0000 038F return data;
; 0000 0390 }
;#pragma used-
;
;// USART1 Receiver buffer
;#define RX_BUFFER_SIZE1 8
;char rx_buffer1[RX_BUFFER_SIZE1];
;
;#if RX_BUFFER_SIZE1 <= 256
;unsigned char rx_wr_index1=0,rx_rd_index1=0;
;#else
;unsigned int rx_wr_index1=0,rx_rd_index1=0;
;#endif
;
;#if RX_BUFFER_SIZE1 < 256
;unsigned char rx_counter1=0;
;#else
;unsigned int rx_counter1=0;
;#endif
;
;// This flag is set on USART1 Receiver buffer overflow
;bit rx_buffer_overflow1;
;
;// USART1 Receiver interrupt service routine
;interrupt [USART1_RXC] void usart1_rx_isr(void)
; 0000 03A8 {
_usart1_rx_isr:
; .FSTART _usart1_rx_isr
	CALL SUBOPT_0x0
; 0000 03A9 unsigned char status;
; 0000 03AA char data;
; 0000 03AB status=UCSR1A;
;	status -> R17
;	data -> R16
	LDS  R17,200
; 0000 03AC data=UDR1;
	LDS  R16,206
; 0000 03AD if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x73
; 0000 03AE    {
; 0000 03AF    rx_buffer1[rx_wr_index1++]=data;
	LDS  R30,_rx_wr_index1
	SUBI R30,-LOW(1)
	STS  _rx_wr_index1,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer1)
	SBCI R31,HIGH(-_rx_buffer1)
	ST   Z,R16
; 0000 03B0 #if RX_BUFFER_SIZE1 == 256
; 0000 03B1    // special case for receiver buffer size=256
; 0000 03B2    if (++rx_counter1 == 0) rx_buffer_overflow1=1;
; 0000 03B3 #else
; 0000 03B4    if (rx_wr_index1 == RX_BUFFER_SIZE1) rx_wr_index1=0;
	LDS  R26,_rx_wr_index1
	CPI  R26,LOW(0x8)
	BRNE _0x74
	LDI  R30,LOW(0)
	STS  _rx_wr_index1,R30
; 0000 03B5    if (++rx_counter1 == RX_BUFFER_SIZE1)
_0x74:
	LDS  R26,_rx_counter1
	SUBI R26,-LOW(1)
	STS  _rx_counter1,R26
	CPI  R26,LOW(0x8)
	BRNE _0x75
; 0000 03B6       {
; 0000 03B7       rx_counter1=0;
	LDI  R30,LOW(0)
	STS  _rx_counter1,R30
; 0000 03B8       rx_buffer_overflow1=1;
	SET
	BLD  R2,2
; 0000 03B9       }
; 0000 03BA #endif
; 0000 03BB    }
_0x75:
; 0000 03BC          data_buffer1_temp[91] = data_buffer1_temp[90];
_0x73:
	__GETB1MN _data_buffer1_temp,90
	__PUTB1MN _data_buffer1_temp,91
; 0000 03BD          data_buffer1_temp[90] = data_buffer1_temp[89];
	__GETB1MN _data_buffer1_temp,89
	__PUTB1MN _data_buffer1_temp,90
; 0000 03BE          data_buffer1_temp[89] = data_buffer1_temp[88];
	__GETB1MN _data_buffer1_temp,88
	__PUTB1MN _data_buffer1_temp,89
; 0000 03BF          data_buffer1_temp[88] = data_buffer1_temp[87];
	__GETB1MN _data_buffer1_temp,87
	__PUTB1MN _data_buffer1_temp,88
; 0000 03C0          data_buffer1_temp[87] = data_buffer1_temp[86];
	__GETB1MN _data_buffer1_temp,86
	__PUTB1MN _data_buffer1_temp,87
; 0000 03C1          data_buffer1_temp[86] = data_buffer1_temp[85];
	__GETB1MN _data_buffer1_temp,85
	__PUTB1MN _data_buffer1_temp,86
; 0000 03C2          data_buffer1_temp[85] = data_buffer1_temp[84];
	__GETB1MN _data_buffer1_temp,84
	__PUTB1MN _data_buffer1_temp,85
; 0000 03C3          data_buffer1_temp[84] = data_buffer1_temp[83];
	__GETB1MN _data_buffer1_temp,83
	__PUTB1MN _data_buffer1_temp,84
; 0000 03C4          data_buffer1_temp[83] = data_buffer1_temp[82];
	__GETB1MN _data_buffer1_temp,82
	__PUTB1MN _data_buffer1_temp,83
; 0000 03C5          data_buffer1_temp[82] = data_buffer1_temp[81];
	__GETB1MN _data_buffer1_temp,81
	__PUTB1MN _data_buffer1_temp,82
; 0000 03C6          data_buffer1_temp[81] = data_buffer1_temp[80];
	__GETB1MN _data_buffer1_temp,80
	__PUTB1MN _data_buffer1_temp,81
; 0000 03C7          data_buffer1_temp[80] = data_buffer1_temp[79];
	__GETB1MN _data_buffer1_temp,79
	__PUTB1MN _data_buffer1_temp,80
; 0000 03C8          data_buffer1_temp[79] = data_buffer1_temp[78];
	__GETB1MN _data_buffer1_temp,78
	__PUTB1MN _data_buffer1_temp,79
; 0000 03C9          data_buffer1_temp[78] = data_buffer1_temp[77];
	__GETB1MN _data_buffer1_temp,77
	__PUTB1MN _data_buffer1_temp,78
; 0000 03CA          data_buffer1_temp[77] = data_buffer1_temp[76];
	__GETB1MN _data_buffer1_temp,76
	__PUTB1MN _data_buffer1_temp,77
; 0000 03CB          data_buffer1_temp[76] = data_buffer1_temp[75];
	__GETB1MN _data_buffer1_temp,75
	__PUTB1MN _data_buffer1_temp,76
; 0000 03CC          data_buffer1_temp[75] = data_buffer1_temp[74];
	__GETB1MN _data_buffer1_temp,74
	__PUTB1MN _data_buffer1_temp,75
; 0000 03CD          data_buffer1_temp[74] = data_buffer1_temp[73];
	__GETB1MN _data_buffer1_temp,73
	__PUTB1MN _data_buffer1_temp,74
; 0000 03CE          data_buffer1_temp[73] = data_buffer1_temp[72];
	__GETB1MN _data_buffer1_temp,72
	__PUTB1MN _data_buffer1_temp,73
; 0000 03CF          data_buffer1_temp[72] = data_buffer1_temp[71];
	__GETB1MN _data_buffer1_temp,71
	__PUTB1MN _data_buffer1_temp,72
; 0000 03D0          data_buffer1_temp[71] = data_buffer1_temp[70];
	__GETB1MN _data_buffer1_temp,70
	__PUTB1MN _data_buffer1_temp,71
; 0000 03D1          data_buffer1_temp[70] = data_buffer1_temp[69];
	__GETB1MN _data_buffer1_temp,69
	__PUTB1MN _data_buffer1_temp,70
; 0000 03D2          data_buffer1_temp[69] = data_buffer1_temp[68];
	__GETB1MN _data_buffer1_temp,68
	__PUTB1MN _data_buffer1_temp,69
; 0000 03D3          data_buffer1_temp[68] = data_buffer1_temp[67];
	__GETB1MN _data_buffer1_temp,67
	__PUTB1MN _data_buffer1_temp,68
; 0000 03D4          data_buffer1_temp[67] = data_buffer1_temp[66];
	__GETB1MN _data_buffer1_temp,66
	__PUTB1MN _data_buffer1_temp,67
; 0000 03D5          data_buffer1_temp[66] = data_buffer1_temp[65];
	__GETB1MN _data_buffer1_temp,65
	__PUTB1MN _data_buffer1_temp,66
; 0000 03D6          data_buffer1_temp[65] = data_buffer1_temp[64];
	__GETB1MN _data_buffer1_temp,64
	__PUTB1MN _data_buffer1_temp,65
; 0000 03D7          data_buffer1_temp[64] = data_buffer1_temp[63];
	__GETB1MN _data_buffer1_temp,63
	__PUTB1MN _data_buffer1_temp,64
; 0000 03D8          data_buffer1_temp[63] = data_buffer1_temp[62];
	__GETB1MN _data_buffer1_temp,62
	__PUTB1MN _data_buffer1_temp,63
; 0000 03D9          data_buffer1_temp[62] = data_buffer1_temp[61];
	__GETB1MN _data_buffer1_temp,61
	__PUTB1MN _data_buffer1_temp,62
; 0000 03DA          data_buffer1_temp[61] = data_buffer1_temp[60];
	__GETB1MN _data_buffer1_temp,60
	__PUTB1MN _data_buffer1_temp,61
; 0000 03DB          data_buffer1_temp[60] = data_buffer1_temp[59];
	__GETB1MN _data_buffer1_temp,59
	__PUTB1MN _data_buffer1_temp,60
; 0000 03DC          data_buffer1_temp[59] = data_buffer1_temp[58];
	__GETB1MN _data_buffer1_temp,58
	__PUTB1MN _data_buffer1_temp,59
; 0000 03DD          data_buffer1_temp[58] = data_buffer1_temp[57];
	__GETB1MN _data_buffer1_temp,57
	__PUTB1MN _data_buffer1_temp,58
; 0000 03DE          data_buffer1_temp[57] = data_buffer1_temp[56];
	__GETB1MN _data_buffer1_temp,56
	__PUTB1MN _data_buffer1_temp,57
; 0000 03DF          data_buffer1_temp[56] = data_buffer1_temp[55];
	__GETB1MN _data_buffer1_temp,55
	__PUTB1MN _data_buffer1_temp,56
; 0000 03E0          data_buffer1_temp[55] = data_buffer1_temp[54];
	__GETB1MN _data_buffer1_temp,54
	__PUTB1MN _data_buffer1_temp,55
; 0000 03E1          data_buffer1_temp[54] = data_buffer1_temp[53];
	__GETB1MN _data_buffer1_temp,53
	__PUTB1MN _data_buffer1_temp,54
; 0000 03E2          data_buffer1_temp[53] = data_buffer1_temp[52];
	__GETB1MN _data_buffer1_temp,52
	__PUTB1MN _data_buffer1_temp,53
; 0000 03E3          data_buffer1_temp[52] = data_buffer1_temp[51];
	__GETB1MN _data_buffer1_temp,51
	__PUTB1MN _data_buffer1_temp,52
; 0000 03E4          data_buffer1_temp[51] = data_buffer1_temp[50];
	__GETB1MN _data_buffer1_temp,50
	__PUTB1MN _data_buffer1_temp,51
; 0000 03E5          data_buffer1_temp[50] = data_buffer1_temp[49];
	__GETB1MN _data_buffer1_temp,49
	__PUTB1MN _data_buffer1_temp,50
; 0000 03E6          data_buffer1_temp[49] = data_buffer1_temp[48];
	__GETB1MN _data_buffer1_temp,48
	__PUTB1MN _data_buffer1_temp,49
; 0000 03E7          data_buffer1_temp[48] = data_buffer1_temp[47];
	__GETB1MN _data_buffer1_temp,47
	__PUTB1MN _data_buffer1_temp,48
; 0000 03E8          data_buffer1_temp[47] = data_buffer1_temp[46];
	__GETB1MN _data_buffer1_temp,46
	__PUTB1MN _data_buffer1_temp,47
; 0000 03E9          data_buffer1_temp[46] = data_buffer1_temp[45];
	__GETB1MN _data_buffer1_temp,45
	__PUTB1MN _data_buffer1_temp,46
; 0000 03EA          data_buffer1_temp[45] = data_buffer1_temp[44];
	__GETB1MN _data_buffer1_temp,44
	__PUTB1MN _data_buffer1_temp,45
; 0000 03EB          data_buffer1_temp[44] = data_buffer1_temp[43];
	__GETB1MN _data_buffer1_temp,43
	__PUTB1MN _data_buffer1_temp,44
; 0000 03EC          data_buffer1_temp[43] = data_buffer1_temp[42];
	__GETB1MN _data_buffer1_temp,42
	__PUTB1MN _data_buffer1_temp,43
; 0000 03ED          data_buffer1_temp[42] = data_buffer1_temp[41];
	__GETB1MN _data_buffer1_temp,41
	__PUTB1MN _data_buffer1_temp,42
; 0000 03EE          data_buffer1_temp[41] = data_buffer1_temp[40];
	__GETB1MN _data_buffer1_temp,40
	__PUTB1MN _data_buffer1_temp,41
; 0000 03EF          data_buffer1_temp[40] = data_buffer1_temp[39];
	__GETB1MN _data_buffer1_temp,39
	__PUTB1MN _data_buffer1_temp,40
; 0000 03F0          data_buffer1_temp[39] = data_buffer1_temp[38];
	__GETB1MN _data_buffer1_temp,38
	__PUTB1MN _data_buffer1_temp,39
; 0000 03F1          data_buffer1_temp[38] = data_buffer1_temp[37];
	__GETB1MN _data_buffer1_temp,37
	__PUTB1MN _data_buffer1_temp,38
; 0000 03F2          data_buffer1_temp[37] = data_buffer1_temp[36];
	__GETB1MN _data_buffer1_temp,36
	__PUTB1MN _data_buffer1_temp,37
; 0000 03F3          data_buffer1_temp[36] = data_buffer1_temp[35];
	__GETB1MN _data_buffer1_temp,35
	__PUTB1MN _data_buffer1_temp,36
; 0000 03F4          data_buffer1_temp[35] = data_buffer1_temp[34];
	__GETB1MN _data_buffer1_temp,34
	__PUTB1MN _data_buffer1_temp,35
; 0000 03F5          data_buffer1_temp[34] = data_buffer1_temp[33];
	__GETB1MN _data_buffer1_temp,33
	__PUTB1MN _data_buffer1_temp,34
; 0000 03F6          data_buffer1_temp[33] = data_buffer1_temp[32];
	__GETB1MN _data_buffer1_temp,32
	__PUTB1MN _data_buffer1_temp,33
; 0000 03F7          data_buffer1_temp[32] = data_buffer1_temp[31];
	__GETB1MN _data_buffer1_temp,31
	__PUTB1MN _data_buffer1_temp,32
; 0000 03F8          data_buffer1_temp[31] = data_buffer1_temp[30];
	__GETB1MN _data_buffer1_temp,30
	__PUTB1MN _data_buffer1_temp,31
; 0000 03F9          data_buffer1_temp[30] = data_buffer1_temp[29];
	__GETB1MN _data_buffer1_temp,29
	__PUTB1MN _data_buffer1_temp,30
; 0000 03FA          data_buffer1_temp[29] = data_buffer1_temp[28];
	__GETB1MN _data_buffer1_temp,28
	__PUTB1MN _data_buffer1_temp,29
; 0000 03FB          data_buffer1_temp[28] = data_buffer1_temp[27];
	__GETB1MN _data_buffer1_temp,27
	__PUTB1MN _data_buffer1_temp,28
; 0000 03FC          data_buffer1_temp[27] = data_buffer1_temp[26];
	__GETB1MN _data_buffer1_temp,26
	__PUTB1MN _data_buffer1_temp,27
; 0000 03FD          data_buffer1_temp[26] = data_buffer1_temp[25];
	__GETB1MN _data_buffer1_temp,25
	__PUTB1MN _data_buffer1_temp,26
; 0000 03FE          data_buffer1_temp[25] = data_buffer1_temp[24];
	__GETB1MN _data_buffer1_temp,24
	__PUTB1MN _data_buffer1_temp,25
; 0000 03FF          data_buffer1_temp[24] = data_buffer1_temp[23];
	__GETB1MN _data_buffer1_temp,23
	__PUTB1MN _data_buffer1_temp,24
; 0000 0400          data_buffer1_temp[23] = data_buffer1_temp[22];
	__GETB1MN _data_buffer1_temp,22
	__PUTB1MN _data_buffer1_temp,23
; 0000 0401          data_buffer1_temp[22] = data_buffer1_temp[21];
	__GETB1MN _data_buffer1_temp,21
	__PUTB1MN _data_buffer1_temp,22
; 0000 0402          data_buffer1_temp[21] = data_buffer1_temp[20];
	__GETB1MN _data_buffer1_temp,20
	__PUTB1MN _data_buffer1_temp,21
; 0000 0403          data_buffer1_temp[20] = data_buffer1_temp[19];
	__GETB1MN _data_buffer1_temp,19
	__PUTB1MN _data_buffer1_temp,20
; 0000 0404          data_buffer1_temp[19] = data_buffer1_temp[18];
	__GETB1MN _data_buffer1_temp,18
	__PUTB1MN _data_buffer1_temp,19
; 0000 0405          data_buffer1_temp[18] = data_buffer1_temp[17];
	__GETB1MN _data_buffer1_temp,17
	__PUTB1MN _data_buffer1_temp,18
; 0000 0406          data_buffer1_temp[17] = data_buffer1_temp[16];
	__GETB1MN _data_buffer1_temp,16
	__PUTB1MN _data_buffer1_temp,17
; 0000 0407          data_buffer1_temp[16] = data_buffer1_temp[15];
	__GETB1MN _data_buffer1_temp,15
	__PUTB1MN _data_buffer1_temp,16
; 0000 0408          data_buffer1_temp[15] = data_buffer1_temp[14];
	__GETB1MN _data_buffer1_temp,14
	__PUTB1MN _data_buffer1_temp,15
; 0000 0409          data_buffer1_temp[14] = data_buffer1_temp[13];
	__GETB1MN _data_buffer1_temp,13
	__PUTB1MN _data_buffer1_temp,14
; 0000 040A          data_buffer1_temp[13] = data_buffer1_temp[12];
	__GETB1MN _data_buffer1_temp,12
	__PUTB1MN _data_buffer1_temp,13
; 0000 040B          data_buffer1_temp[12] = data_buffer1_temp[11];
	__GETB1MN _data_buffer1_temp,11
	__PUTB1MN _data_buffer1_temp,12
; 0000 040C          data_buffer1_temp[11] = data_buffer1_temp[10];
	__GETB1MN _data_buffer1_temp,10
	__PUTB1MN _data_buffer1_temp,11
; 0000 040D          data_buffer1_temp[10] = data_buffer1_temp[9];
	__GETB1MN _data_buffer1_temp,9
	__PUTB1MN _data_buffer1_temp,10
; 0000 040E          data_buffer1_temp[9] = data_buffer1_temp[8];
	__GETB1MN _data_buffer1_temp,8
	__PUTB1MN _data_buffer1_temp,9
; 0000 040F          data_buffer1_temp[8] = data_buffer1_temp[7];
	__GETB1MN _data_buffer1_temp,7
	__PUTB1MN _data_buffer1_temp,8
; 0000 0410          data_buffer1_temp[7] = data_buffer1_temp[6];
	__GETB1MN _data_buffer1_temp,6
	__PUTB1MN _data_buffer1_temp,7
; 0000 0411          data_buffer1_temp[6] = data_buffer1_temp[5];
	__GETB1MN _data_buffer1_temp,5
	__PUTB1MN _data_buffer1_temp,6
; 0000 0412          data_buffer1_temp[5] = data_buffer1_temp[4];
	__GETB1MN _data_buffer1_temp,4
	__PUTB1MN _data_buffer1_temp,5
; 0000 0413          data_buffer1_temp[4] = data_buffer1_temp[3];
	__GETB1MN _data_buffer1_temp,3
	__PUTB1MN _data_buffer1_temp,4
; 0000 0414          data_buffer1_temp[3] = data_buffer1_temp[2];
	__GETB1MN _data_buffer1_temp,2
	__PUTB1MN _data_buffer1_temp,3
; 0000 0415          data_buffer1_temp[2] = data_buffer1_temp[1];
	__GETB1MN _data_buffer1_temp,1
	__PUTB1MN _data_buffer1_temp,2
; 0000 0416          data_buffer1_temp[1] = data_buffer1_temp[0];
	LDS  R30,_data_buffer1_temp
	__PUTB1MN _data_buffer1_temp,1
; 0000 0417          data_buffer1_temp[0] = data;
	STS  _data_buffer1_temp,R16
; 0000 0418 
; 0000 0419    //링크 확인
; 0000 041A    if((data_buffer1_temp[7] == 0x00)&&(data_buffer1_temp[6] == 0xf1)&&(data_buffer1_temp[5] == 0x20)&&(data_buffer1_temp ...
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x0)
	BRNE _0x77
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0xF1)
	BRNE _0x77
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x20)
	BRNE _0x77
	__GETB2MN _data_buffer1_temp,4
	CPI  R26,LOW(0xCB)
	BRNE _0x77
	__GETB2MN _data_buffer1_temp,2
	CPI  R26,LOW(0x24)
	BRNE _0x77
	__GETB2MN _data_buffer1_temp,1
	CPI  R26,LOW(0x0)
	BRNE _0x77
	LDS  R26,_data_buffer1_temp
	CPI  R26,LOW(0x0)
	BREQ _0x78
_0x77:
	RJMP _0x76
_0x78:
; 0000 041B    {
; 0000 041C       Common_CHeckLink_act = 1;
	LDI  R30,LOW(1)
	STS  _Common_CHeckLink_act,R30
; 0000 041D       data_buffer2_temp[7] = '';
	CALL SUBOPT_0x9
; 0000 041E       data_buffer2_temp[6] = '';
; 0000 041F       data_buffer2_temp[5] = '';
; 0000 0420       data_buffer2_temp[4] = '';
; 0000 0421       data_buffer2_temp[3] = '';
; 0000 0422       data_buffer2_temp[2] = '';
; 0000 0423       data_buffer2_temp[1] = '';
; 0000 0424       data_buffer2_temp[0] = '';
; 0000 0425    }
; 0000 0426 
; 0000 0427 
; 0000 0428    //배전기 셧다운 요청
; 0000 0429    if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x60)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp ...
_0x76:
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x0)
	BRNE _0x7A
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x60)
	BRNE _0x7A
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0x20)
	BRNE _0x7A
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x28)
	BRNE _0x7A
	__GETB2MN _data_buffer1_temp,3
	CPI  R26,LOW(0x24)
	BRNE _0x7A
	__GETB2MN _data_buffer1_temp,2
	CPI  R26,LOW(0x1)
	BRNE _0x7A
	__GETB2MN _data_buffer1_temp,1
	CPI  R26,LOW(0x0)
	BRNE _0x7A
	LDS  R26,_data_buffer1_temp
	CPI  R26,LOW(0x0)
	BREQ _0x7B
_0x7A:
	RJMP _0x79
_0x7B:
; 0000 042A    {
; 0000 042B       Distributor_ShutdownResponse_act = 1;
	LDI  R30,LOW(1)
	STS  _Distributor_ShutdownResponse_act,R30
; 0000 042C      //   11/08 한화요청에 의거 삭제 셧다운은 메인에서 주변장치 off후 차단
; 0000 042D      // temp_control_1 = 0x00;
; 0000 042E      // temp_control_2 = 0x00;
; 0000 042F 
; 0000 0430          //***************************
; 0000 0431      // send_to_div_act = 1;
; 0000 0432       data_buffer2_temp[8] = '';
	CALL SUBOPT_0xA
; 0000 0433       data_buffer2_temp[7] = '';
; 0000 0434       data_buffer2_temp[6] = '';
; 0000 0435       data_buffer2_temp[5] = '';
; 0000 0436       data_buffer2_temp[4] = '';
; 0000 0437       data_buffer2_temp[3] = '';
; 0000 0438       data_buffer2_temp[2] = '';
; 0000 0439       data_buffer2_temp[1] = '';
; 0000 043A       data_buffer2_temp[0] = '';
; 0000 043B    }
; 0000 043C 
; 0000 043D    //배전기 PO-BIT 초기설정
; 0000 043E    if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x61)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp ...
_0x79:
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x0)
	BRNE _0x7D
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x61)
	BRNE _0x7D
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0x20)
	BRNE _0x7D
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x28)
	BRNE _0x7D
	__GETB2MN _data_buffer1_temp,3
	CPI  R26,LOW(0x24)
	BRNE _0x7D
	__GETB2MN _data_buffer1_temp,2
	CPI  R26,LOW(0x1)
	BRNE _0x7D
	__GETB2MN _data_buffer1_temp,1
	CPI  R26,LOW(0x0)
	BRNE _0x7D
	LDS  R26,_data_buffer1_temp
	CPI  R26,LOW(0x0)
	BREQ _0x7E
_0x7D:
	RJMP _0x7C
_0x7E:
; 0000 043F    {
; 0000 0440       //po_bit_set_recive_data = data_buffer1_temp[0];
; 0000 0441       Distributor_PoBIT_act_pre = 1;
	LDI  R30,LOW(1)
	STS  _Distributor_PoBIT_act_pre,R30
; 0000 0442       data_buffer2_temp[8] = '';
	CALL SUBOPT_0xA
; 0000 0443       data_buffer2_temp[7] = '';
; 0000 0444       data_buffer2_temp[6] = '';
; 0000 0445       data_buffer2_temp[5] = '';
; 0000 0446       data_buffer2_temp[4] = '';
; 0000 0447       data_buffer2_temp[3] = '';
; 0000 0448       data_buffer2_temp[2] = '';
; 0000 0449       data_buffer2_temp[1] = '';
; 0000 044A       data_buffer2_temp[0] = '';
; 0000 044B    }
; 0000 044C 
; 0000 044D    //배전기 PO-BIT설정
; 0000 044E    if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x61)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp ...
_0x7C:
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x0)
	BRNE _0x80
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x61)
	BRNE _0x80
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0x20)
	BRNE _0x80
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x28)
	BRNE _0x80
	__GETB2MN _data_buffer1_temp,3
	CPI  R26,LOW(0x24)
	BRNE _0x80
	__GETB2MN _data_buffer1_temp,2
	CPI  R26,LOW(0x1)
	BRNE _0x80
	__GETB2MN _data_buffer1_temp,1
	CPI  R26,LOW(0x0)
	BRNE _0x80
	LDS  R26,_data_buffer1_temp
	CPI  R26,LOW(0x4)
	BREQ _0x81
_0x80:
	RJMP _0x7F
_0x81:
; 0000 044F    {
; 0000 0450      // po_bit_set_recive_data = data_buffer1_temp[0];
; 0000 0451       Distributor_PoBIT_act = 1;
	LDI  R30,LOW(1)
	STS  _Distributor_PoBIT_act,R30
; 0000 0452       data_buffer2_temp[8] = '';
	CALL SUBOPT_0xA
; 0000 0453       data_buffer2_temp[7] = '';
; 0000 0454       data_buffer2_temp[6] = '';
; 0000 0455       data_buffer2_temp[5] = '';
; 0000 0456       data_buffer2_temp[4] = '';
; 0000 0457       data_buffer2_temp[3] = '';
; 0000 0458       data_buffer2_temp[2] = '';
; 0000 0459       data_buffer2_temp[1] = '';
; 0000 045A       data_buffer2_temp[0] = '';
; 0000 045B    }
; 0000 045C //
; 0000 045D //   //부저 울림 원격 중지 191226
; 0000 045E //   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x61)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_te ...
; 0000 045F //   {
; 0000 0460 //      buzzer_clear_all();
; 0000 0461 //      data_buffer2_temp[8] = '';
; 0000 0462 //      data_buffer2_temp[7] = '';
; 0000 0463 //      data_buffer2_temp[6] = '';
; 0000 0464 //      data_buffer2_temp[5] = '';
; 0000 0465 //      data_buffer2_temp[4] = '';
; 0000 0466 //      data_buffer2_temp[3] = '';
; 0000 0467 //      data_buffer2_temp[2] = '';
; 0000 0468 //      data_buffer2_temp[1] = '';
; 0000 0469 //      data_buffer2_temp[0] = '';
; 0000 046A //   }
; 0000 046B 
; 0000 046C    //배전기 PO-BIT 결과  상세정보 요구
; 0000 046D    if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x62)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp ...
_0x7F:
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x0)
	BRNE _0x83
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x62)
	BRNE _0x83
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0x20)
	BRNE _0x83
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x28)
	BRNE _0x83
	__GETB2MN _data_buffer1_temp,3
	CPI  R26,LOW(0x24)
	BRNE _0x83
	__GETB2MN _data_buffer1_temp,2
	CPI  R26,LOW(0x1)
	BRNE _0x83
	__GETB2MN _data_buffer1_temp,1
	CPI  R26,LOW(0x0)
	BREQ _0x84
_0x83:
	RJMP _0x82
_0x84:
; 0000 046E    {
; 0000 046F       po_bit_recive_data_detail = data_buffer1_temp[0];
	LDS  R30,_data_buffer1_temp
	STS  _po_bit_recive_data_detail,R30
; 0000 0470       Distributor_BITDetailResponse_act = 1;
	LDI  R30,LOW(1)
	STS  _Distributor_BITDetailResponse_act,R30
; 0000 0471       data_buffer2_temp[8] = '';
	CALL SUBOPT_0xA
; 0000 0472       data_buffer2_temp[7] = '';
; 0000 0473       data_buffer2_temp[6] = '';
; 0000 0474       data_buffer2_temp[5] = '';
; 0000 0475       data_buffer2_temp[4] = '';
; 0000 0476       data_buffer2_temp[3] = '';
; 0000 0477       data_buffer2_temp[2] = '';
; 0000 0478       data_buffer2_temp[1] = '';
; 0000 0479       data_buffer2_temp[0] = '';
; 0000 047A    }
; 0000 047B 
; 0000 047C    //배전기 장치설정
; 0000 047D    if((data_buffer1_temp[10] == 0x00)&&(data_buffer1_temp[9] == 0x63)&&(data_buffer1_temp[8] == 0x20)&&(data_buffer1_tem ...
_0x82:
	__GETB2MN _data_buffer1_temp,10
	CPI  R26,LOW(0x0)
	BRNE _0x86
	__GETB2MN _data_buffer1_temp,9
	CPI  R26,LOW(0x63)
	BRNE _0x86
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x20)
	BRNE _0x86
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x28)
	BRNE _0x86
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x24)
	BRNE _0x86
	__GETB2MN _data_buffer1_temp,4
	CPI  R26,LOW(0x3)
	BRNE _0x86
	__GETB2MN _data_buffer1_temp,3
	CPI  R26,LOW(0x0)
	BREQ _0x87
_0x86:
	RJMP _0x85
_0x87:
; 0000 047E    {
; 0000 047F       temp_control_sel = data_buffer1_temp[2];
	__GETB1MN _data_buffer1_temp,2
	STS  _temp_control_sel,R30
; 0000 0480       if(temp_control_sel == 0x20)
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x20)
	BRNE _0x88
; 0000 0481       {
; 0000 0482         buzzer_clear_all();
	CALL _buzzer_clear_all
; 0000 0483       }
; 0000 0484       else
	RJMP _0x89
_0x88:
; 0000 0485       {
; 0000 0486         temp_control_1 = data_buffer1_temp[1];
	__GETB1MN _data_buffer1_temp,1
	STS  _temp_control_1,R30
; 0000 0487         temp_control_2 = data_buffer1_temp[0];
	LDS  R30,_data_buffer1_temp
	STS  _temp_control_2,R30
; 0000 0488         //***************************
; 0000 0489         send_to_div_act = 1;
	LDI  R30,LOW(1)
	STS  _send_to_div_act,R30
; 0000 048A         //**************************
; 0000 048B       }
_0x89:
; 0000 048C 
; 0000 048D       // Distributor_DeviceRequest = 1;
; 0000 048E       data_buffer2_temp[10] = '';
	LDI  R30,LOW(0)
	__PUTB1MN _data_buffer2_temp,10
; 0000 048F       data_buffer2_temp[9] = '';
	__PUTB1MN _data_buffer2_temp,9
; 0000 0490       data_buffer2_temp[8] = '';
	CALL SUBOPT_0xA
; 0000 0491       data_buffer2_temp[7] = '';
; 0000 0492       data_buffer2_temp[6] = '';
; 0000 0493       data_buffer2_temp[5] = '';
; 0000 0494       data_buffer2_temp[4] = '';
; 0000 0495       data_buffer2_temp[3] = '';
; 0000 0496       data_buffer2_temp[2] = '';
; 0000 0497       data_buffer2_temp[1] = '';
; 0000 0498       data_buffer2_temp[0] = '';
; 0000 0499     }
; 0000 049A 
; 0000 049B    //임무처리기 셧다운 오류 요청
; 0000 049C    if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x64)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp ...
_0x85:
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x0)
	BRNE _0x8B
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x64)
	BRNE _0x8B
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0x20)
	BRNE _0x8B
	__GETB2MN _data_buffer1_temp,5
	CPI  R26,LOW(0x28)
	BRNE _0x8B
	__GETB2MN _data_buffer1_temp,3
	CPI  R26,LOW(0x24)
	BRNE _0x8B
	__GETB2MN _data_buffer1_temp,2
	CPI  R26,LOW(0x1)
	BRNE _0x8B
	__GETB2MN _data_buffer1_temp,1
	CPI  R26,LOW(0x0)
	BRNE _0x8B
	LDS  R26,_data_buffer1_temp
	CPI  R26,LOW(0x1)
	BREQ _0x8C
_0x8B:
	RJMP _0x8A
_0x8C:
; 0000 049D    {
; 0000 049E      //shoutdown_request_recive_data = data_buffer1_temp[0];
; 0000 049F 
; 0000 04A0       Distributor_ShutdownErroResponse_act = 1;
	LDI  R30,LOW(1)
	STS  _Distributor_ShutdownErroResponse_act,R30
; 0000 04A1       data_buffer2_temp[8] = '';
	CALL SUBOPT_0xA
; 0000 04A2       data_buffer2_temp[7] = '';
; 0000 04A3       data_buffer2_temp[6] = '';
; 0000 04A4       data_buffer2_temp[5] = '';
; 0000 04A5       data_buffer2_temp[4] = '';
; 0000 04A6       data_buffer2_temp[3] = '';
; 0000 04A7       data_buffer2_temp[2] = '';
; 0000 04A8       data_buffer2_temp[1] = '';
; 0000 04A9       data_buffer2_temp[0] = '';
; 0000 04AA     }
; 0000 04AB 
; 0000 04AC 
; 0000 04AD    //시간 설정
; 0000 04AE    if((data_buffer1_temp[13] == 0x00)&&(data_buffer1_temp[12] == 0x65)&&(data_buffer1_temp[11] == 0x20)&&(data_buffer1_t ...
_0x8A:
	__GETB2MN _data_buffer1_temp,13
	CPI  R26,LOW(0x0)
	BRNE _0x8E
	__GETB2MN _data_buffer1_temp,12
	CPI  R26,LOW(0x65)
	BRNE _0x8E
	__GETB2MN _data_buffer1_temp,11
	CPI  R26,LOW(0x20)
	BRNE _0x8E
	__GETB2MN _data_buffer1_temp,10
	CPI  R26,LOW(0x28)
	BRNE _0x8E
	__GETB2MN _data_buffer1_temp,8
	CPI  R26,LOW(0x24)
	BRNE _0x8E
	__GETB2MN _data_buffer1_temp,7
	CPI  R26,LOW(0x6)
	BRNE _0x8E
	__GETB2MN _data_buffer1_temp,6
	CPI  R26,LOW(0x0)
	BREQ _0x8F
_0x8E:
	RJMP _0x8D
_0x8F:
; 0000 04AF    {
; 0000 04B0      year = data_buffer1_temp[5];
	__GETB1MN _data_buffer1_temp,5
	STS  _year,R30
; 0000 04B1      month = data_buffer1_temp[4];
	__GETB1MN _data_buffer1_temp,4
	STS  _month,R30
; 0000 04B2      day = data_buffer1_temp[3];
	__GETB1MN _data_buffer1_temp,3
	STS  _day,R30
; 0000 04B3      hour = data_buffer1_temp[2];
	__GETB1MN _data_buffer1_temp,2
	STS  _hour,R30
; 0000 04B4      minute = data_buffer1_temp[1];
	__GETB1MN _data_buffer1_temp,1
	STS  _minute,R30
; 0000 04B5      sec = data_buffer1_temp[0];
	LDS  R30,_data_buffer1_temp
	STS  _sec,R30
; 0000 04B6 //
; 0000 04B7    rtc_set_time(hour,minute,sec);
	LDS  R30,_hour
	ST   -Y,R30
	LDS  R30,_minute
	ST   -Y,R30
	LDS  R26,_sec
	CALL _rtc_set_time
; 0000 04B8 //   if(year > 12)
; 0000 04B9 //   {
; 0000 04BA //   year = (year - 12);
; 0000 04BB //   year = 0x1f | (year & 0x0f);
; 0000 04BC //   }
; 0000 04BD //   else
; 0000 04BE //   {
; 0000 04BF //   year = year & 0x0f;
; 0000 04C0 //   }
; 0000 04C1 //     year = 0x1f & year;
; 0000 04C2      rtc_set_date(0x05,day,month,year);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDS  R30,_day
	ST   -Y,R30
	LDS  R30,_month
	ST   -Y,R30
	LDS  R26,_year
	CALL _rtc_set_date
; 0000 04C3 
; 0000 04C4      Distributor_TimeSyncAck_act = 1;
	LDI  R30,LOW(1)
	STS  _Distributor_TimeSyncAck_act,R30
; 0000 04C5 
; 0000 04C6      //time_data_get = 1;
; 0000 04C7      //buffer clear
; 0000 04C8      data_buffer2_temp[13] = '';
	CALL SUBOPT_0x8
; 0000 04C9      data_buffer2_temp[12] = '';
; 0000 04CA      data_buffer2_temp[11] = '';
; 0000 04CB      data_buffer2_temp[10] = '';
; 0000 04CC      data_buffer2_temp[9] = '';
; 0000 04CD      data_buffer2_temp[8] = '';
; 0000 04CE      data_buffer2_temp[7] = '';
; 0000 04CF      data_buffer2_temp[6] = '';
; 0000 04D0      data_buffer2_temp[5] = '';
; 0000 04D1      data_buffer2_temp[4] = '';
; 0000 04D2      data_buffer2_temp[3] = '';
; 0000 04D3      data_buffer2_temp[2] = '';
; 0000 04D4      data_buffer2_temp[1] = '';
; 0000 04D5      data_buffer2_temp[0] = '';
; 0000 04D6    }
; 0000 04D7 
; 0000 04D8 
; 0000 04D9  /*
; 0000 04DA 
; 0000 04DB   if(data == 0x0a )
; 0000 04DC    {
; 0000 04DD        //채널상태 및 에러정보 요청
; 0000 04DE      if(data_buffer2_temp[91] == 0x7f && data_buffer2_temp[90] == 0xfe && data_buffer2_temp[0] == 0x0d)
; 0000 04DF       {
; 0000 04E0 
; 0000 04E1 
; 0000 04E2          data_buffer2_temp[91] = '';
; 0000 04E3          data_buffer2_temp[90] = '';
; 0000 04E4          data_buffer2_temp[89] = '';
; 0000 04E5          data_buffer2_temp[88] = '';
; 0000 04E6          data_buffer2_temp[87] = '';
; 0000 04E7          data_buffer2_temp[86] = '';
; 0000 04E8          data_buffer2_temp[85] = '';
; 0000 04E9          data_buffer2_temp[84] = '';
; 0000 04EA          data_buffer2_temp[83] = '';
; 0000 04EB          data_buffer2_temp[82] = '';
; 0000 04EC          data_buffer2_temp[81] = '';
; 0000 04ED          data_buffer2_temp[80] = '';
; 0000 04EE          data_buffer2_temp[79] = '';
; 0000 04EF          data_buffer2_temp[78] = '';
; 0000 04F0          data_buffer2_temp[77] = '';
; 0000 04F1          data_buffer2_temp[76] = '';
; 0000 04F2          data_buffer2_temp[75] = '';
; 0000 04F3          data_buffer2_temp[74] = '';
; 0000 04F4          data_buffer2_temp[73] = '';
; 0000 04F5          data_buffer2_temp[72] = '';
; 0000 04F6          data_buffer2_temp[71] = '';
; 0000 04F7          data_buffer2_temp[70] = '';
; 0000 04F8          data_buffer2_temp[69] = '';
; 0000 04F9          data_buffer2_temp[68] = '';
; 0000 04FA          data_buffer2_temp[67] = '';
; 0000 04FB          data_buffer2_temp[66] = '';
; 0000 04FC          data_buffer2_temp[65] = '';
; 0000 04FD          data_buffer2_temp[64] = '';
; 0000 04FE          data_buffer2_temp[63] = '';
; 0000 04FF          data_buffer2_temp[62] = '';
; 0000 0500          data_buffer2_temp[61] = '';
; 0000 0501          data_buffer2_temp[60] = '';
; 0000 0502          data_buffer2_temp[59] = '';
; 0000 0503          data_buffer2_temp[58] = '';
; 0000 0504          data_buffer2_temp[57] = '';
; 0000 0505          data_buffer2_temp[56] = '';
; 0000 0506          data_buffer2_temp[55] = '';
; 0000 0507          data_buffer2_temp[54] = '';
; 0000 0508          data_buffer2_temp[53] = '';
; 0000 0509          data_buffer2_temp[52] = '';
; 0000 050A          data_buffer2_temp[51] = '';
; 0000 050B          data_buffer2_temp[50] = '';
; 0000 050C          data_buffer2_temp[49] = '';
; 0000 050D          data_buffer2_temp[48] = '';
; 0000 050E          data_buffer2_temp[47] = '';
; 0000 050F          data_buffer2_temp[46] = '';
; 0000 0510          data_buffer2_temp[45] = '';
; 0000 0511          data_buffer2_temp[44] = '';
; 0000 0512          data_buffer2_temp[43] = '';
; 0000 0513          data_buffer2_temp[42] = '';
; 0000 0514          data_buffer2_temp[41] = '';
; 0000 0515          data_buffer2_temp[40] = '';
; 0000 0516          data_buffer2_temp[39] = '';
; 0000 0517          data_buffer2_temp[38] = '';
; 0000 0518          data_buffer2_temp[37] = '';
; 0000 0519          data_buffer2_temp[36] = '';
; 0000 051A          data_buffer2_temp[35] = '';
; 0000 051B          data_buffer2_temp[34] = '';
; 0000 051C          data_buffer2_temp[33] = '';
; 0000 051D          data_buffer2_temp[32] = '';
; 0000 051E          data_buffer2_temp[31] = '';
; 0000 051F          data_buffer2_temp[30] = '';
; 0000 0520          data_buffer2_temp[29] = '';
; 0000 0521          data_buffer2_temp[28] = '';
; 0000 0522          data_buffer2_temp[27] = '';
; 0000 0523          data_buffer2_temp[26] = '';
; 0000 0524          data_buffer2_temp[25] = '';
; 0000 0525          data_buffer2_temp[24] = '';
; 0000 0526          data_buffer2_temp[23] = '';
; 0000 0527          data_buffer2_temp[22] = '';
; 0000 0528          data_buffer2_temp[21] = '';
; 0000 0529          data_buffer2_temp[20] = '';
; 0000 052A          data_buffer2_temp[19] = '';
; 0000 052B          data_buffer2_temp[18] = '';
; 0000 052C          data_buffer2_temp[17] = '';
; 0000 052D          data_buffer2_temp[16] = '';
; 0000 052E          data_buffer2_temp[15] = '';
; 0000 052F          data_buffer2_temp[14] = '';
; 0000 0530          data_buffer2_temp[13] = '';
; 0000 0531          data_buffer2_temp[12] = '';
; 0000 0532          data_buffer2_temp[11] = '';
; 0000 0533          data_buffer2_temp[10] = '';
; 0000 0534          data_buffer2_temp[9] = '';
; 0000 0535          data_buffer2_temp[8] = '';
; 0000 0536          data_buffer2_temp[7] = '';
; 0000 0537          data_buffer2_temp[6] = '';
; 0000 0538          data_buffer2_temp[5] = '';
; 0000 0539          data_buffer2_temp[4] = '';
; 0000 053A          data_buffer2_temp[3] = '';
; 0000 053B          data_buffer2_temp[2] = '';
; 0000 053C          data_buffer2_temp[1] = '';
; 0000 053D          data_buffer2_temp[0] = '';
; 0000 053E        }
; 0000 053F    }
; 0000 0540    else
; 0000 0541    {
; 0000 0542 
; 0000 0543    }
; 0000 0544 */
; 0000 0545 
; 0000 0546 }
_0x8D:
_0x450:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;// Get a character from the USART1 Receiver buffer
;#pragma used+
;char getchar1(void)
; 0000 054B {
; 0000 054C char data;
; 0000 054D while (rx_counter1==0);
;	data -> R17
; 0000 054E data=rx_buffer1[rx_rd_index1++];
; 0000 054F #if RX_BUFFER_SIZE1 != 256
; 0000 0550 if (rx_rd_index1 == RX_BUFFER_SIZE1) rx_rd_index1=0;
; 0000 0551 #endif
; 0000 0552 #asm("cli")
; 0000 0553 --rx_counter1;
; 0000 0554 #asm("sei")
; 0000 0555 return data;
; 0000 0556 }
;#pragma used-
;// Write a character to the USART1 Transmitter
;#pragma used+
;void putchar1(char c)
; 0000 055B {
_putchar1:
; .FSTART _putchar1
; 0000 055C while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
	ST   -Y,R17
	MOV  R17,R26
;	c -> R17
_0x94:
	LDS  R30,200
	ANDI R30,LOW(0x20)
	BREQ _0x94
; 0000 055D UDR1=c;
	STS  206,R17
; 0000 055E }
	RJMP _0x20A0004
; .FEND
;#pragma used-
;
;// USART2 Receiver buffer
;#define RX_BUFFER_SIZE2 8
;char rx_buffer2[RX_BUFFER_SIZE2];
;
;#if RX_BUFFER_SIZE2 <= 256
;unsigned char rx_wr_index2=0,rx_rd_index2=0;
;#else
;unsigned int rx_wr_index2=0,rx_rd_index2=0;
;#endif
;
;#if RX_BUFFER_SIZE2 < 256
;unsigned char rx_counter2=0;
;#else
;unsigned int rx_counter2=0;
;#endif
;
;// This flag is set on USART2 Receiver buffer overflow
;bit rx_buffer_overflow2;
;
;// USART2 Receiver interrupt service routine
;interrupt [USART2_RXC] void usart2_rx_isr(void)
; 0000 0576 {
_usart2_rx_isr:
; .FSTART _usart2_rx_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0577 unsigned char status;
; 0000 0578 char data;
; 0000 0579 status=UCSR2A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,208
; 0000 057A data=UDR2;
	LDS  R16,214
; 0000 057B if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x97
; 0000 057C    {
; 0000 057D    rx_buffer2[rx_wr_index2++]=data;
	LDS  R30,_rx_wr_index2
	SUBI R30,-LOW(1)
	STS  _rx_wr_index2,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer2)
	SBCI R31,HIGH(-_rx_buffer2)
	ST   Z,R16
; 0000 057E #if RX_BUFFER_SIZE2 == 256
; 0000 057F    // special case for receiver buffer size=256
; 0000 0580    if (++rx_counter2 == 0) rx_buffer_overflow2=1;
; 0000 0581 #else
; 0000 0582    if (rx_wr_index2 == RX_BUFFER_SIZE2) rx_wr_index2=0;
	LDS  R26,_rx_wr_index2
	CPI  R26,LOW(0x8)
	BRNE _0x98
	LDI  R30,LOW(0)
	STS  _rx_wr_index2,R30
; 0000 0583    if (++rx_counter2 == RX_BUFFER_SIZE2)
_0x98:
	LDS  R26,_rx_counter2
	SUBI R26,-LOW(1)
	STS  _rx_counter2,R26
	CPI  R26,LOW(0x8)
	BRNE _0x99
; 0000 0584       {
; 0000 0585       rx_counter2=0;
	LDI  R30,LOW(0)
	STS  _rx_counter2,R30
; 0000 0586       rx_buffer_overflow2=1;
	SET
	BLD  R2,3
; 0000 0587       }
; 0000 0588 #endif
; 0000 0589    }
_0x99:
; 0000 058A          data_buffer_ge_temp[9] = data_buffer_ge_temp[8];
_0x97:
	__GETB1MN _data_buffer_ge_temp,8
	__PUTB1MN _data_buffer_ge_temp,9
; 0000 058B          data_buffer_ge_temp[8] = data_buffer_ge_temp[7];
	__GETB1MN _data_buffer_ge_temp,7
	__PUTB1MN _data_buffer_ge_temp,8
; 0000 058C          data_buffer_ge_temp[7] = data_buffer_ge_temp[6];
	__GETB1MN _data_buffer_ge_temp,6
	__PUTB1MN _data_buffer_ge_temp,7
; 0000 058D          data_buffer_ge_temp[6] = data_buffer_ge_temp[5];
	__GETB1MN _data_buffer_ge_temp,5
	__PUTB1MN _data_buffer_ge_temp,6
; 0000 058E          data_buffer_ge_temp[5] = data_buffer_ge_temp[4];
	__GETB1MN _data_buffer_ge_temp,4
	__PUTB1MN _data_buffer_ge_temp,5
; 0000 058F          data_buffer_ge_temp[4] = data_buffer_ge_temp[3];
	__GETB1MN _data_buffer_ge_temp,3
	__PUTB1MN _data_buffer_ge_temp,4
; 0000 0590          data_buffer_ge_temp[3] = data_buffer_ge_temp[2];
	__GETB1MN _data_buffer_ge_temp,2
	__PUTB1MN _data_buffer_ge_temp,3
; 0000 0591          data_buffer_ge_temp[2] = data_buffer_ge_temp[1];
	__GETB1MN _data_buffer_ge_temp,1
	__PUTB1MN _data_buffer_ge_temp,2
; 0000 0592          data_buffer_ge_temp[1] = data_buffer_ge_temp[0];
	LDS  R30,_data_buffer_ge_temp
	__PUTB1MN _data_buffer_ge_temp,1
; 0000 0593          data_buffer_ge_temp[0] = data;
	STS  _data_buffer_ge_temp,R16
; 0000 0594 
; 0000 0595    //발전기 전압
; 0000 0596    if((data_buffer_ge_temp[6] == 0x01)&&(data_buffer_ge_temp[5] == 0x03)&&(data_buffer_ge_temp[4] == 0x02)&&(ge_data_kin ...
	__GETB2MN _data_buffer_ge_temp,6
	CPI  R26,LOW(0x1)
	BRNE _0x9B
	__GETB2MN _data_buffer_ge_temp,5
	CPI  R26,LOW(0x3)
	BRNE _0x9B
	__GETB2MN _data_buffer_ge_temp,4
	CPI  R26,LOW(0x2)
	BRNE _0x9B
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x1)
	BREQ _0x9C
_0x9B:
	RJMP _0x9A
_0x9C:
; 0000 0597    {
; 0000 0598       ge_voltage_h = data_buffer_ge_temp[3];
	__GETB1MN _data_buffer_ge_temp,3
	STS  _ge_voltage_h,R30
; 0000 0599       ge_voltage_l = data_buffer_ge_temp[2];
	__GETB1MN _data_buffer_ge_temp,2
	STS  _ge_voltage_l,R30
; 0000 059A       voltage_ge = (ge_voltage_h * 256) + ge_voltage_l;
	LDS  R26,_ge_voltage_h
	CALL SUBOPT_0x1
	LDS  R30,_ge_voltage_l
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _voltage_ge,R30
	STS  _voltage_ge+1,R31
; 0000 059B       CRC_H = data_buffer_ge_temp[1];
	CALL SUBOPT_0xB
; 0000 059C       CRC_L = data_buffer_ge_temp[0];
; 0000 059D       loss_count_ge = 0;
; 0000 059E 
; 0000 059F    }
; 0000 05A0    //발전기 전류
; 0000 05A1    if((data_buffer_ge_temp[6] == 0x01)&&(data_buffer_ge_temp[5] == 0x03)&&(data_buffer_ge_temp[4] == 0x02)&&(ge_data_kin ...
_0x9A:
	__GETB2MN _data_buffer_ge_temp,6
	CPI  R26,LOW(0x1)
	BRNE _0x9E
	__GETB2MN _data_buffer_ge_temp,5
	CPI  R26,LOW(0x3)
	BRNE _0x9E
	__GETB2MN _data_buffer_ge_temp,4
	CPI  R26,LOW(0x2)
	BRNE _0x9E
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x2)
	BREQ _0x9F
_0x9E:
	RJMP _0x9D
_0x9F:
; 0000 05A2    {
; 0000 05A3       ge_currunt_h = data_buffer_ge_temp[3];
	__GETB1MN _data_buffer_ge_temp,3
	STS  _ge_currunt_h,R30
; 0000 05A4       ge_currunt_l = data_buffer_ge_temp[2];
	__GETB1MN _data_buffer_ge_temp,2
	STS  _ge_currunt_l,R30
; 0000 05A5       currunt_ge = ((ge_currunt_h * 256) + ge_currunt_l)*10;
	LDS  R26,_ge_currunt_h
	CALL SUBOPT_0x1
	LDS  R30,_ge_currunt_l
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MULW12
	STS  _currunt_ge,R30
	STS  _currunt_ge+1,R31
; 0000 05A6       CRC_H = data_buffer_ge_temp[1];
	CALL SUBOPT_0xB
; 0000 05A7       CRC_L = data_buffer_ge_temp[0];
; 0000 05A8       loss_count_ge = 0;
; 0000 05A9    }
; 0000 05AA 
; 0000 05AB    //발전기 에러상태 표시
; 0000 05AC    if((data_buffer_ge_temp[6] == 0x01)&&(data_buffer_ge_temp[5] == 0x03)&&(data_buffer_ge_temp[4] == 0x02)&&(data_buffer ...
_0x9D:
	__GETB2MN _data_buffer_ge_temp,6
	CPI  R26,LOW(0x1)
	BRNE _0xA1
	__GETB2MN _data_buffer_ge_temp,5
	CPI  R26,LOW(0x3)
	BRNE _0xA1
	__GETB2MN _data_buffer_ge_temp,4
	CPI  R26,LOW(0x2)
	BRNE _0xA1
	__GETB2MN _data_buffer_ge_temp,3
	CPI  R26,LOW(0x0)
	BRNE _0xA1
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x3)
	BREQ _0xA2
_0xA1:
	RJMP _0xA0
_0xA2:
; 0000 05AD    {
; 0000 05AE       ge_err_data = data_buffer_ge_temp[2];
	__GETB1MN _data_buffer_ge_temp,2
	STS  _ge_err_data,R30
; 0000 05AF 
; 0000 05B0       if((ge_err_data & 0x1f) == 0x00){ge_err_act = NOR;}else{ge_err_act = ERR;}
	ANDI R30,LOW(0x1F)
	BRNE _0xA3
	LDI  R30,LOW(0)
	RJMP _0x3D6
_0xA3:
	LDI  R30,LOW(1)
_0x3D6:
	STS  _ge_err_act,R30
; 0000 05B1 
; 0000 05B2       CRC_H = data_buffer_ge_temp[1];
	CALL SUBOPT_0xB
; 0000 05B3       CRC_L = data_buffer_ge_temp[0];
; 0000 05B4       loss_count_ge = 0;
; 0000 05B5    }
; 0000 05B6 
; 0000 05B7 
; 0000 05B8 }
_0xA0:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;// Get a character from the USART2 Receiver buffer
;#pragma used+
;char getchar2(void)
; 0000 05BD {
; 0000 05BE char data;
; 0000 05BF while (rx_counter2==0);
;	data -> R17
; 0000 05C0 data=rx_buffer2[rx_rd_index2++];
; 0000 05C1 #if RX_BUFFER_SIZE2 != 256
; 0000 05C2 if (rx_rd_index2 == RX_BUFFER_SIZE2) rx_rd_index2=0;
; 0000 05C3 #endif
; 0000 05C4 #asm("cli")
; 0000 05C5 --rx_counter2;
; 0000 05C6 #asm("sei")
; 0000 05C7 return data;
; 0000 05C8 }
;#pragma used-
;
;// Write a character to the USART2 Transmitter
;#pragma used+
;void putchar2(char c)
; 0000 05CE {
_putchar2:
; .FSTART _putchar2
; 0000 05CF while ((UCSR2A & DATA_REGISTER_EMPTY)==0);
	ST   -Y,R17
	MOV  R17,R26
;	c -> R17
_0xA9:
	LDS  R30,208
	ANDI R30,LOW(0x20)
	BREQ _0xA9
; 0000 05D0 UDR2=c;
	STS  214,R17
; 0000 05D1 }
	RJMP _0x20A0004
; .FEND
;#pragma used-
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 05D9 {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 05DA  temp_a++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 13,14,30,31
; 0000 05DB  if(temp_a >= 722)
	LDI  R30,LOW(722)
	LDI  R31,HIGH(722)
	CP   R13,R30
	CPC  R14,R31
	BRLT _0xAC
; 0000 05DC     {
; 0000 05DD      temp_b++;
	LDI  R26,LOW(_temp_b)
	LDI  R27,HIGH(_temp_b)
	CALL SUBOPT_0xC
; 0000 05DE      temp_a = 0;
	CLR  R13
	CLR  R14
; 0000 05DF      temp_out_to_pc_count++;
	LDI  R26,LOW(_temp_out_to_pc_count)
	LDI  R27,HIGH(_temp_out_to_pc_count)
	CALL SUBOPT_0xC
; 0000 05E0 
; 0000 05E1     }
; 0000 05E2 
; 0000 05E3   if(temp_b > 9)//60
_0xAC:
	LDS  R26,_temp_b
	LDS  R27,_temp_b+1
	SBIW R26,10
	BRLT _0xAD
; 0000 05E4   {
; 0000 05E5     temp_b = 0;
	LDI  R30,LOW(0)
	STS  _temp_b,R30
	STS  _temp_b+1,R30
; 0000 05E6     temp_out_pbit_count++;
	LDI  R26,LOW(_temp_out_pbit_count)
	LDI  R27,HIGH(_temp_out_pbit_count)
	CALL SUBOPT_0xC
; 0000 05E7     if(loss_count_a >= loss_active_delay_time){loss_count_a = loss_active_delay_time;comm_err = 1;}else{loss_count_a++;c ...
	LDS  R26,_loss_count_a
	LDS  R27,_loss_count_a+1
	SBIW R26,40
	BRLO _0xAE
	LDI  R30,LOW(40)
	LDI  R31,HIGH(40)
	STS  _loss_count_a,R30
	STS  _loss_count_a+1,R31
	SBI  0x1E,7
	RJMP _0xB1
_0xAE:
	LDI  R26,LOW(_loss_count_a)
	LDI  R27,HIGH(_loss_count_a)
	CALL SUBOPT_0xC
	CBI  0x1E,7
_0xB1:
; 0000 05E8 
; 0000 05E9 //    if(loss_count_a >= loss_active_delay_time){loss_count_a = loss_active_delay_time;comm_err_temp = 1;}else{loss_coun ...
; 0000 05EA //
; 0000 05EB ////    if(comm_err_count >= 10)
; 0000 05EC //    {
; 0000 05ED //        comm_err = 1;
; 0000 05EE //        comm_err_count = 10;
; 0000 05EF //    }
; 0000 05F0 //    else
; 0000 05F1 //    {
; 0000 05F2 //        comm_err = 0;
; 0000 05F3 //        if(comm_err_temp == 1){comm_err_count++;}else{comm_err_temp = 0; comm_err_count = 0;}
; 0000 05F4 //    }
; 0000 05F5 //
; 0000 05F6     //if(loss_count_ge >= loss_active_delay_time){loss_count_ge = loss_active_delay_time;comm_ge_err = 1;}else{loss_coun ...
; 0000 05F7    if(loss_count_ge >= loss_ge_active_delay_time){loss_count_ge = loss_ge_active_delay_time;comm_ge_err = 1;}else{loss_c ...
	LDS  R26,_loss_count_ge
	LDS  R27,_loss_count_ge+1
	SBIW R26,20
	BRLO _0xB4
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	STS  _loss_count_ge,R30
	STS  _loss_count_ge+1,R31
	SET
	RJMP _0x3D7
_0xB4:
	LDI  R26,LOW(_loss_count_ge)
	LDI  R27,HIGH(_loss_count_ge)
	CALL SUBOPT_0xC
	CLT
_0x3D7:
	BLD  R2,0
; 0000 05F8    if(led_flash == 0){led_flash = 1;}else{led_flash = 0;}
	LDS  R30,_led_flash
	CPI  R30,0
	BRNE _0xB6
	LDI  R30,LOW(1)
	RJMP _0x3D8
_0xB6:
	LDI  R30,LOW(0)
_0x3D8:
	STS  _led_flash,R30
; 0000 05F9    // send_to_div_act = 1;
; 0000 05FA   }
; 0000 05FB 
; 0000 05FC   if(temp_out_pbit_count > 5) //   distributo_pbit 10hz
_0xAD:
	LDS  R26,_temp_out_pbit_count
	LDS  R27,_temp_out_pbit_count+1
	SBIW R26,6
	BRLT _0xB8
; 0000 05FD   {
; 0000 05FE     temp_out_pbit_count = 0;
	LDI  R30,LOW(0)
	STS  _temp_out_pbit_count,R30
	STS  _temp_out_pbit_count+1,R30
; 0000 05FF     TEST_LED_1 = ~TEST_LED_1;
	SBIS 0x8,5
	RJMP _0xB9
	CBI  0x8,5
	RJMP _0xBA
_0xB9:
	SBI  0x8,5
_0xBA:
; 0000 0600     send_to_div_info_act = 1;
	LDI  R30,LOW(1)
	STS  _send_to_div_info_act,R30
; 0000 0601 
; 0000 0602     //send to pc pbit정보
; 0000 0603     Distributor_PBIT_act = 1;
	STS  _Distributor_PBIT_act,R30
; 0000 0604 
; 0000 0605     send_to_pc_active = 1;
	SBI  0x1E,1
; 0000 0606   }
; 0000 0607   else
	RJMP _0xBD
_0xB8:
; 0000 0608   {
; 0000 0609        if(send_process_count > 8)
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R30,R7
	CPC  R31,R8
	BRGE _0xBE
; 0000 060A        {
; 0000 060B         send_process_count = 0;
	CLR  R7
	CLR  R8
; 0000 060C        }
; 0000 060D        else
	RJMP _0xBF
_0xBE:
; 0000 060E        {
; 0000 060F         send_process_count++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 7,8,30,31
; 0000 0610        }
_0xBF:
; 0000 0611   }
_0xBD:
; 0000 0612 
; 0000 0613 
; 0000 0614 
; 0000 0615   if(temp_out_to_pc_count > 5)//60  //  distributo_device_status 1hz
	LDS  R26,_temp_out_to_pc_count
	LDS  R27,_temp_out_to_pc_count+1
	SBIW R26,6
	BRLT _0xC0
; 0000 0616   {
; 0000 0617     //send to pc
; 0000 0618   TEST_LED_2 = ~TEST_LED_2;
	SBIS 0x8,6
	RJMP _0xC1
	CBI  0x8,6
	RJMP _0xC2
_0xC1:
	SBI  0x8,6
_0xC2:
; 0000 0619     temp_out_to_pc_count = 0;
	LDI  R30,LOW(0)
	STS  _temp_out_to_pc_count,R30
	STS  _temp_out_to_pc_count+1,R30
; 0000 061A 
; 0000 061B     send_to_ge_active = 1;
	LDI  R30,LOW(1)
	STS  _send_to_ge_active,R30
; 0000 061C 
; 0000 061D 
; 0000 061E     if(mode_change_and_init == 1)
	LDS  R26,_mode_change_and_init
	CPI  R26,LOW(0x1)
	BRNE _0xC3
; 0000 061F     {
; 0000 0620       if(mode_change_count >= mode_change_count_max)
	LDS  R26,_mode_change_count
	CPI  R26,LOW(0x50)
	BRLO _0xC4
; 0000 0621       {
; 0000 0622         buzzer_out_wait = 1;
	STS  _buzzer_out_wait,R30
; 0000 0623         mode_change_count = mode_change_count_max;
	LDI  R30,LOW(80)
	STS  _mode_change_count,R30
; 0000 0624         mode_change_and_init = 0;
	LDI  R30,LOW(0)
	STS  _mode_change_and_init,R30
; 0000 0625       }
; 0000 0626       else
	RJMP _0xC5
_0xC4:
; 0000 0627       {
; 0000 0628         mode_change_count++;
	LDS  R30,_mode_change_count
	SUBI R30,-LOW(1)
	STS  _mode_change_count,R30
; 0000 0629       }
_0xC5:
; 0000 062A     }
; 0000 062B     else
	RJMP _0xC6
_0xC3:
; 0000 062C     {
; 0000 062D       mode_change_count = 0;
	LDI  R30,LOW(0)
	STS  _mode_change_count,R30
; 0000 062E     }
_0xC6:
; 0000 062F   }
; 0000 0630 }
_0xC0:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;void pulse(void)
; 0000 0633 {
_pulse:
; .FSTART _pulse
; 0000 0634     delay_us(1);
	__DELAY_USB 4
; 0000 0635     LED_CLK = 1;
	SBI  0x8,3
; 0000 0636     delay_us(1);
	__DELAY_USB 4
; 0000 0637     LED_CLK = 0;
	CBI  0x8,3
; 0000 0638 }
	RET
; .FEND
;
;
;void send_to_ge(void)
; 0000 063C {
_send_to_ge:
; .FSTART _send_to_ge
; 0000 063D  RE_DE1 = 1;
	SBI  0xE,3
; 0000 063E  delay_us(30);
	__DELAY_USB 111
; 0000 063F 
; 0000 0640  if(ge_data_kind > 3){ge_data_kind = 1;}else{ge_data_kind++;}
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x4)
	BRLO _0xCD
	LDI  R30,LOW(1)
	RJMP _0x3D9
_0xCD:
	LDS  R30,_ge_data_kind
	SUBI R30,-LOW(1)
_0x3D9:
	STS  _ge_data_kind,R30
; 0000 0641 
; 0000 0642  // ge_data_kind = 3;
; 0000 0643 
; 0000 0644 
; 0000 0645  if(ge_data_kind == 1)  //발전기 전압
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x1)
	BRNE _0xCF
; 0000 0646  {
; 0000 0647  putchar2(0x01);  //control address
	CALL SUBOPT_0xD
; 0000 0648  putchar2(0x03);  //modebus function number
; 0000 0649  putchar2(0x23);  //object number
; 0000 064A  putchar2(0xc8);  //object number
	LDI  R26,LOW(200)
	CALL SUBOPT_0xE
; 0000 064B  putchar2(0x00);  //length
; 0000 064C  putchar2(0x01);  //length
; 0000 064D  putchar2(0x0e);  //under of crc
	LDI  R26,LOW(14)
	RCALL _putchar2
; 0000 064E  putchar2(0x70);  //upper of crc
	LDI  R26,LOW(112)
	RCALL _putchar2
; 0000 064F  }
; 0000 0650 
; 0000 0651 
; 0000 0652  if(ge_data_kind == 2) //발전기 전류
_0xCF:
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x2)
	BRNE _0xD0
; 0000 0653  {
; 0000 0654  putchar2(0x01);  //control address
	CALL SUBOPT_0xD
; 0000 0655  putchar2(0x03);  //modebus function number
; 0000 0656  putchar2(0x23);  //object number
; 0000 0657  putchar2(0xc4);  //object number
	LDI  R26,LOW(196)
	CALL SUBOPT_0xE
; 0000 0658  putchar2(0x00);  //length
; 0000 0659  putchar2(0x01);  //length
; 0000 065A  putchar2(0xce);  //under of crc
	LDI  R26,LOW(206)
	RCALL _putchar2
; 0000 065B  putchar2(0x73);  //upper of crc
	LDI  R26,LOW(115)
	RCALL _putchar2
; 0000 065C  }
; 0000 065D 
; 0000 065E  if(ge_data_kind == 3) //발전기 에러
_0xD0:
	LDS  R26,_ge_data_kind
	CPI  R26,LOW(0x3)
	BRNE _0xD1
; 0000 065F  {
; 0000 0660  putchar2(0x01);  //control address
	LDI  R26,LOW(1)
	RCALL _putchar2
; 0000 0661  putchar2(0x03);  //modebus function number
	LDI  R26,LOW(3)
	RCALL _putchar2
; 0000 0662  putchar2(0x2d);  //object number
	LDI  R26,LOW(45)
	RCALL _putchar2
; 0000 0663  putchar2(0x73);  //object number
	LDI  R26,LOW(115)
	CALL SUBOPT_0xE
; 0000 0664  putchar2(0x00);  //length
; 0000 0665  putchar2(0x01);  //length
; 0000 0666  putchar2(0x7c);  //under of crc
	LDI  R26,LOW(124)
	RCALL _putchar2
; 0000 0667  putchar2(0xbd);  //upper of crc
	LDI  R26,LOW(189)
	RCALL _putchar2
; 0000 0668  }
; 0000 0669 
; 0000 066A // if(ge_data_kind == 3) // 엔진 과속도 보호
; 0000 066B // {
; 0000 066C // putchar2(0x01);  //control address
; 0000 066D // putchar2(0x03);  //modebus function number
; 0000 066E // putchar2(0x20);  //object number
; 0000 066F // putchar2(0x47);  //object number
; 0000 0670 // putchar2(0x00);  //length
; 0000 0671 // putchar2(0x01);  //length
; 0000 0672 // putchar2(0x3f);  //under of crc
; 0000 0673 // putchar2(0xdf);  //upper of crc
; 0000 0674 // }
; 0000 0675 //
; 0000 0676 // if(ge_data_kind == 4)  // 엔진 오일압력 보호/경고
; 0000 0677 // {
; 0000 0678 // putchar2(0x01);  //control address
; 0000 0679 // putchar2(0x03);  //modebus function number
; 0000 067A // putchar2(0x09);  //object number
; 0000 067B // putchar2(0x41);  //object number
; 0000 067C // putchar2(0x00);  //length
; 0000 067D // putchar2(0x01);  //length
; 0000 067E // putchar2(0xd7);  //under of crc
; 0000 067F // putchar2(0x82);  //upper of crc
; 0000 0680 // }
; 0000 0681 //
; 0000 0682 // if(ge_data_kind == 5) //과전압 bit
; 0000 0683 // {
; 0000 0684 // putchar2(0x01);  //control address
; 0000 0685 // putchar2(0x03);  //modebus function number
; 0000 0686 // putchar2(0x2c);  //object number
; 0000 0687 // putchar2(0x5f);  //object number
; 0000 0688 // putchar2(0x00);  //length
; 0000 0689 // putchar2(0x01);  //length
; 0000 068A // putchar2(0xbc);  //under of crc
; 0000 068B // putchar2(0x88);  //upper of crc
; 0000 068C // }
; 0000 068D //
; 0000 068E // if(ge_data_kind == 6)//저전압 bit
; 0000 068F // {
; 0000 0690 // putchar2(0x01);  //control address
; 0000 0691 // putchar2(0x03);  //modebus function number
; 0000 0692 // putchar2(0x2c);  //object number
; 0000 0693 // putchar2(0x63);  //object number
; 0000 0694 // putchar2(0x00);  //length
; 0000 0695 // putchar2(0x01);  //length
; 0000 0696 // putchar2(0x7c);  //under of crc
; 0000 0697 // putchar2(0x84);  //upper of crc
; 0000 0698 // }
; 0000 0699 //
; 0000 069A // if(ge_data_kind == 7) // 과전류 bit
; 0000 069B // {
; 0000 069C // putchar2(0x01);  //control address
; 0000 069D // putchar2(0x03);  //modebus function number
; 0000 069E // putchar2(0x36);  //object number
; 0000 069F // putchar2(0x5c);  //object number
; 0000 06A0 // putchar2(0x00);  //length
; 0000 06A1 // putchar2(0x01);  //length
; 0000 06A2 // putchar2(0x4b);  //under of crc
; 0000 06A3 // putchar2(0x90);  //upper of crc
; 0000 06A4 // }
; 0000 06A5 //
; 0000 06A6 //  if(ge_data_kind == 8) //발전기 전압 voltage
; 0000 06A7 // {
; 0000 06A8 // putchar2(0x01);  //control address
; 0000 06A9 // putchar2(0x03);  //modebus function number
; 0000 06AA // putchar2(0x20);  //object number
; 0000 06AB // putchar2(0x15);  //object number
; 0000 06AC // putchar2(0x00);  //length
; 0000 06AD // putchar2(0x01);  //length
; 0000 06AE // putchar2(0x9e);  //under of crc
; 0000 06AF // putchar2(0x0e);  //upper of crc
; 0000 06B0 // }
; 0000 06B1 
; 0000 06B2  delay_us(350);
_0xD1:
	__DELAY_USW 968
; 0000 06B3 
; 0000 06B4   RE_DE1 = 0;
	CBI  0xE,3
; 0000 06B5  send_to_ge_active = 0;
	LDI  R30,LOW(0)
	STS  _send_to_ge_active,R30
; 0000 06B6 }
	RET
; .FEND
;
;void send_to_div(void)
; 0000 06B9 {
_send_to_div:
; .FSTART _send_to_div
; 0000 06BA    RE_DE0 = 1;
	SBI  0xE,2
; 0000 06BB    delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	CALL _delay_ms
; 0000 06BC 
; 0000 06BD     putchar(0x7f);  //9
	CALL SUBOPT_0xF
; 0000 06BE     putchar(0xfe);  //8
; 0000 06BF     putchar(0x00);  //7
	LDI  R26,LOW(0)
	CALL _putchar
; 0000 06C0 
; 0000 06C1 //
; 0000 06C2 //    if(!ADDRESS_3)
; 0000 06C3 //    {
; 0000 06C4 //    if(ADDRESS_1){temp_control_2 = temp_control_2 | 0x80;}else{temp_control_2 = temp_control_2 & ~0x80;}
; 0000 06C5 //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x40;}else{temp_control_2 = temp_control_2 & ~0x40;}
; 0000 06C6 //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x20;}else{temp_control_2 = temp_control_2 & ~0x20;}
; 0000 06C7 //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x10;}else{temp_control_2 = temp_control_2 & ~0x10;}
; 0000 06C8 //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x08;}else{temp_control_2 = temp_control_2 & ~0x08;}
; 0000 06C9 //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x04;}else{temp_control_2 = temp_control_2 & ~0x04;}
; 0000 06CA //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x02;}else{temp_control_2 = temp_control_2 & ~0x02;}
; 0000 06CB //    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x01;}else{temp_control_2 = temp_control_2 & ~0x01;}
; 0000 06CC //
; 0000 06CD //    if(ADDRESS_1){temp_control_1 = temp_control_1 | 0x80;}else{temp_control_1 = temp_control_1 & ~0x80;}
; 0000 06CE //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x40;}else{temp_control_1 = temp_control_1 & ~0x40;}
; 0000 06CF //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x20;}else{temp_control_1 = temp_control_1 & ~0x20;}
; 0000 06D0 //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x10;}else{temp_control_1 = temp_control_1 & ~0x10;}
; 0000 06D1 //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x08;}else{temp_control_1 = temp_control_1 & ~0x08;}
; 0000 06D2 //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x04;}else{temp_control_1 = temp_control_1 & ~0x04;}
; 0000 06D3 //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x02;}else{temp_control_1 = temp_control_1 & ~0x02;}
; 0000 06D4 //    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x01;}else{temp_control_1 = temp_control_1 & ~0x01;}
; 0000 06D5 //    }
; 0000 06D6 
; 0000 06D7 //    if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x10;} //13
; 0000 06D8 //    if((temp_control_2 & 0x10) == 0x10){temp_control_2_ |= 0x40;} //12
; 0000 06D9 //    if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x20;} //11
; 0000 06DA //    if((temp_control_2 & 0x04) == 0x04){temp_control_2_ |= 0x08;} //10
; 0000 06DB //    if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x40;} //09
; 0000 06DC //    if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x08;} //08
; 0000 06DD //
; 0000 06DE //    if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x04;} //07
; 0000 06DF //    if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x10;} //06
; 0000 06E0 //    if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x04;} //05
; 0000 06E1 //    if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x20;} //04
; 0000 06E2 //    if((temp_control_1 & 0x08) == 0x08){temp_control_1_ |= 0x02;} //03
; 0000 06E3 //    if((temp_control_1 & 0x04) == 0x04){temp_control_1_ |= 0x01;} //02
; 0000 06E4 //    if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x02;} //01
; 0000 06E5 //    if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x01;} //00
; 0000 06E6 //
; 0000 06E7 //    if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x10;} //13
; 0000 06E8 //    if((temp_control_2 & 0x10) == 0x10){temp_control_2_ |= 0x40;} //12
; 0000 06E9 //    if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x20;} //11
; 0000 06EA //    if((temp_control_2 & 0x04) == 0x04){temp_control_2_ |= 0x08;} //10
; 0000 06EB //    if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x40;} //09
; 0000 06EC //    if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x08;} //08
; 0000 06ED //
; 0000 06EE //    if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x04;} //07
; 0000 06EF //    if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x10;} //06
; 0000 06F0 //    if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x04;} //05 //////
; 0000 06F1 //    if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x20;} //04
; 0000 06F2 //    if((temp_control_1 & 0x08) == 0x08){temp_control_1_ |= 0x02;} //03
; 0000 06F3 //    if((temp_control_1 & 0x04) == 0x04){temp_control_1_ |= 0x01;} //02
; 0000 06F4 //    if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x02;} //01  운용처리기2 전시기2
; 0000 06F5 //    if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x01;} //00  임무처리기 조정기 2
; 0000 06F6 
; 0000 06F7     if(temp_control_sel == 0xff)  //전체 셧다운 또는 전체 켜기 명령
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0xFF)
	BRNE _0xD6
; 0000 06F8     {
; 0000 06F9 //       temp_control_1_ = temp_control_1_old;
; 0000 06FA //       temp_control_2_ = temp_control_2_old;
; 0000 06FB         if((temp_control_1 == 0xff)&&(temp_control_2 == 0xff))
	LDS  R26,_temp_control_1
	CPI  R26,LOW(0xFF)
	BRNE _0xD8
	LDS  R26,_temp_control_2
	CPI  R26,LOW(0xFF)
	BREQ _0xD9
_0xD8:
	RJMP _0xD7
_0xD9:
; 0000 06FC         {
; 0000 06FD           temp_control_1_ = 0xff;
	LDI  R30,LOW(255)
	STS  _temp_control_1_,R30
; 0000 06FE           temp_control_2_ = 0xff;
	STS  _temp_control_2_,R30
; 0000 06FF         }
; 0000 0700 
; 0000 0701         if((temp_control_1 == 0x00)&&(temp_control_2 == 0x00))
_0xD7:
	LDS  R26,_temp_control_1
	CPI  R26,LOW(0x0)
	BRNE _0xDB
	LDS  R26,_temp_control_2
	CPI  R26,LOW(0x0)
	BREQ _0xDC
_0xDB:
	RJMP _0xDA
_0xDC:
; 0000 0702         {
; 0000 0703           temp_control_1_ = 0x00;
	LDI  R30,LOW(0)
	STS  _temp_control_1_,R30
; 0000 0704           temp_control_2_ = 0x00;
	STS  _temp_control_2_,R30
; 0000 0705         }
; 0000 0706     }
_0xDA:
; 0000 0707     else
	RJMP _0xDD
_0xD6:
; 0000 0708     {
; 0000 0709 //    if(temp_control_1_ != 0x00){temp_control_1_ = temp_control_1_old;} //10/12/26
; 0000 070A //    if(temp_control_2_ != 0x00){temp_control_2_ = temp_control_2_old;}
; 0000 070B     temp_control_1_ = temp_control_1_old;
	LDS  R30,_temp_control_1_old
	STS  _temp_control_1_,R30
; 0000 070C     temp_control_2_ = temp_control_2_old;
	LDS  R30,_temp_control_2_old
	STS  _temp_control_2_,R30
; 0000 070D     if(temp_control_sel == 14){if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x10;}else{temp_control_1_ &= ~0x1 ...
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0xE)
	BRNE _0xDE
	LDS  R30,_temp_control_2
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0xDF
	LDS  R30,_temp_control_1_
	ORI  R30,0x10
	RJMP _0x3DA
_0xDF:
	LDS  R30,_temp_control_1_
	ANDI R30,0xEF
_0x3DA:
	STS  _temp_control_1_,R30
; 0000 070E     if(temp_control_sel == 13){if((temp_control_2 & 0x10) == 0x10){temp_control_2_ |= 0x40;}else{temp_control_2_ &= ~0x4 ...
_0xDE:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0xD)
	BRNE _0xE1
	LDS  R30,_temp_control_2
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0xE2
	LDS  R30,_temp_control_2_
	ORI  R30,0x40
	RJMP _0x3DB
_0xE2:
	LDS  R30,_temp_control_2_
	ANDI R30,0xBF
_0x3DB:
	STS  _temp_control_2_,R30
; 0000 070F     if(temp_control_sel == 12){if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x20;}else{temp_control_1_ &= ~0x2 ...
_0xE1:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0xC)
	BRNE _0xE4
	LDS  R30,_temp_control_2
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0xE5
	LDS  R30,_temp_control_1_
	ORI  R30,0x20
	RJMP _0x3DC
_0xE5:
	LDS  R30,_temp_control_1_
	ANDI R30,0xDF
_0x3DC:
	STS  _temp_control_1_,R30
; 0000 0710     if(temp_control_sel == 11){if((temp_control_2 & 0x04) == 0x04){temp_control_2_ |= 0x08;}else{temp_control_2_ &= ~0x0 ...
_0xE4:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0xB)
	BRNE _0xE7
	LDS  R30,_temp_control_2
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0xE8
	LDS  R30,_temp_control_2_
	ORI  R30,8
	RJMP _0x3DD
_0xE8:
	LDS  R30,_temp_control_2_
	ANDI R30,0XF7
_0x3DD:
	STS  _temp_control_2_,R30
; 0000 0711     if(temp_control_sel == 10){if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x40;}else{temp_control_1_ &= ~0x4 ...
_0xE7:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0xA)
	BRNE _0xEA
	LDS  R30,_temp_control_2
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0xEB
	LDS  R30,_temp_control_1_
	ORI  R30,0x40
	RJMP _0x3DE
_0xEB:
	LDS  R30,_temp_control_1_
	ANDI R30,0xBF
_0x3DE:
	STS  _temp_control_1_,R30
; 0000 0712     if(temp_control_sel == 9){if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x08;}else{temp_control_1_ &= ~0x08 ...
_0xEA:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x9)
	BRNE _0xED
	LDS  R30,_temp_control_2
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0xEE
	LDS  R30,_temp_control_1_
	ORI  R30,8
	RJMP _0x3DF
_0xEE:
	LDS  R30,_temp_control_1_
	ANDI R30,0XF7
_0x3DF:
	STS  _temp_control_1_,R30
; 0000 0713 
; 0000 0714     if(temp_control_sel == 8){if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x04;}else{temp_control_1_ &= ~0x04 ...
_0xED:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x8)
	BRNE _0xF0
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0xF1
	LDS  R30,_temp_control_1_
	ORI  R30,4
	RJMP _0x3E0
_0xF1:
	LDS  R30,_temp_control_1_
	ANDI R30,0xFB
_0x3E0:
	STS  _temp_control_1_,R30
; 0000 0715     if(temp_control_sel == 7){if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x10;}else{temp_control_2_ &= ~0x10 ...
_0xF0:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x7)
	BRNE _0xF3
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0xF4
	LDS  R30,_temp_control_2_
	ORI  R30,0x10
	RJMP _0x3E1
_0xF4:
	LDS  R30,_temp_control_2_
	ANDI R30,0xEF
_0x3E1:
	STS  _temp_control_2_,R30
; 0000 0716     if(temp_control_sel == 6){if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x04;}else{temp_control_2_ &= ~0x04 ...
_0xF3:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x6)
	BRNE _0xF6
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0xF7
	LDS  R30,_temp_control_2_
	ORI  R30,4
	RJMP _0x3E2
_0xF7:
	LDS  R30,_temp_control_2_
	ANDI R30,0xFB
_0x3E2:
	STS  _temp_control_2_,R30
; 0000 0717     if(temp_control_sel == 5){if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x20;}else{temp_control_2_ &= ~0x20 ...
_0xF6:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x5)
	BRNE _0xF9
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0xFA
	LDS  R30,_temp_control_2_
	ORI  R30,0x20
	RJMP _0x3E3
_0xFA:
	LDS  R30,_temp_control_2_
	ANDI R30,0xDF
_0x3E3:
	STS  _temp_control_2_,R30
; 0000 0718     if(temp_control_sel == 4){if((temp_control_1 & 0x08) == 0x08){temp_control_1_ |= 0x02;}else{temp_control_1_ &= ~0x02 ...
_0xF9:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x4)
	BRNE _0xFC
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0xFD
	LDS  R30,_temp_control_1_
	ORI  R30,2
	RJMP _0x3E4
_0xFD:
	LDS  R30,_temp_control_1_
	ANDI R30,0xFD
_0x3E4:
	STS  _temp_control_1_,R30
; 0000 0719     if(temp_control_sel == 3){if((temp_control_1 & 0x04) == 0x04){temp_control_1_ |= 0x01;}else{temp_control_1_ &= ~0x01 ...
_0xFC:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x3)
	BRNE _0xFF
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x100
	LDS  R30,_temp_control_1_
	ORI  R30,1
	RJMP _0x3E5
_0x100:
	LDS  R30,_temp_control_1_
	ANDI R30,0xFE
_0x3E5:
	STS  _temp_control_1_,R30
; 0000 071A     if(temp_control_sel == 2){if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x02;}else{temp_control_2_ &= ~0x02 ...
_0xFF:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x2)
	BRNE _0x102
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x103
	LDS  R30,_temp_control_2_
	ORI  R30,2
	RJMP _0x3E6
_0x103:
	LDS  R30,_temp_control_2_
	ANDI R30,0xFD
_0x3E6:
	STS  _temp_control_2_,R30
; 0000 071B     if(temp_control_sel == 1){if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x01;}else{temp_control_2_ &= ~0x01 ...
_0x102:
	LDS  R26,_temp_control_sel
	CPI  R26,LOW(0x1)
	BRNE _0x105
	LDS  R30,_temp_control_1
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x106
	LDS  R30,_temp_control_2_
	ORI  R30,1
	RJMP _0x3E7
_0x106:
	LDS  R30,_temp_control_2_
	ANDI R30,0xFE
_0x3E7:
	STS  _temp_control_2_,R30
; 0000 071C     }
_0x105:
_0xDD:
; 0000 071D     temp_control_1_old = temp_control_1_;
	LDS  R30,_temp_control_1_
	STS  _temp_control_1_old,R30
; 0000 071E     temp_control_2_old = temp_control_2_;
	LDS  R30,_temp_control_2_
	STS  _temp_control_2_old,R30
; 0000 071F 
; 0000 0720 
; 0000 0721 
; 0000 0722 //   한화시험 최종
; 0000 0723 //    if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x01;} //13  40
; 0000 0724 //    if((temp_control_2 & 0x10) == 0x10){temp_control_1_ |= 0x02;} //12  20
; 0000 0725 //    if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x04;} //11  10
; 0000 0726 //    if((temp_control_2 & 0x04) == 0x04){temp_control_1_ |= 0x08;} //10  08
; 0000 0727 //    if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x10;} //09  04
; 0000 0728 //    if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x20;} //08  02
; 0000 0729 //
; 0000 072A //    if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x40;} //07   01
; 0000 072B //    if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x01;} //06   40
; 0000 072C //    if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x02;} //05  20
; 0000 072D //    if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x04;} //04    10
; 0000 072E //    if((temp_control_1 & 0x08) == 0x08){temp_control_2_ |= 0x08;} //03
; 0000 072F //    if((temp_control_1 & 0x04) == 0x04){temp_control_2_ |= 0x10;} //02   04
; 0000 0730 //    if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x20;} //01 02 운용처리기2 전시기2
; 0000 0731 //    if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x40;} //00  01 임무처리기 조정기 2
; 0000 0732 
; 0000 0733 
; 0000 0734     putchar(temp_control_1_);  //6   temp_control_2
	LDS  R26,_temp_control_1_
	CALL _putchar
; 0000 0735     putchar(temp_control_2_);  //5
	LDS  R26,_temp_control_2_
	CALL _putchar
; 0000 0736 
; 0000 0737     temp_control_2_ = 0x00;
	LDI  R30,LOW(0)
	STS  _temp_control_2_,R30
; 0000 0738     temp_control_1_ = 0x00;
	STS  _temp_control_1_,R30
; 0000 0739 
; 0000 073A     temp_control_2 = 0x00;
	STS  _temp_control_2,R30
; 0000 073B     temp_control_1 = 0x00;
	STS  _temp_control_1,R30
; 0000 073C 
; 0000 073D     putchar(0x00);  //4
	CALL SUBOPT_0x10
; 0000 073E     putchar(0x00);  //3
; 0000 073F     putchar(0x00);  //2
; 0000 0740     putchar(0x0d);  //1
	CALL SUBOPT_0x11
; 0000 0741     putchar(0x0a);  //0
; 0000 0742 
; 0000 0743     delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	CALL _delay_ms
; 0000 0744     RE_DE0 = 0;
	CBI  0xE,2
; 0000 0745 
; 0000 0746     send_to_div_act = 0;
	LDI  R30,LOW(0)
	STS  _send_to_div_act,R30
; 0000 0747 }
	RET
; .FEND
;
;void Request_div_info(void)
; 0000 074A {
_Request_div_info:
; .FSTART _Request_div_info
; 0000 074B //send to div
; 0000 074C   RE_DE0 = 1;
	SBI  0xE,2
; 0000 074D   delay_us(100);
	__DELAY_USW 276
; 0000 074E   putchar(0x7f);  //9
	CALL SUBOPT_0xF
; 0000 074F   putchar(0xfe);  //8
; 0000 0750   putchar(0x55);  //7
	LDI  R26,LOW(85)
	CALL _putchar
; 0000 0751   putchar(0xaa);  //6
	LDI  R26,LOW(170)
	CALL _putchar
; 0000 0752   putchar(0x00);  //5
	CALL SUBOPT_0x10
; 0000 0753   putchar(0x00);  //4
; 0000 0754   putchar(0x00);  //3
; 0000 0755   putchar(0x00);  //2
	LDI  R26,LOW(0)
	CALL _putchar
; 0000 0756   putchar(0x0d);  //1
	CALL SUBOPT_0x11
; 0000 0757   putchar(0x0a);  //0
; 0000 0758   delay_us(200);
	__DELAY_USW 553
; 0000 0759   RE_DE0 = 0;
	CBI  0xE,2
; 0000 075A   send_to_div_info_act = 0;
	LDI  R30,LOW(0)
	STS  _send_to_div_info_act,R30
; 0000 075B }
	RET
; .FEND
;
;
;void fnd_out(int digit_num)
; 0000 075F {
_fnd_out:
; .FSTART _fnd_out
; 0000 0760        switch(digit_num)
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	digit_num -> R16,R17
	MOVW R30,R16
; 0000 0761        {
; 0000 0762        case 0:
	SBIW R30,0
	BREQ _0x3E8
; 0000 0763        LED_LOAD = 0;
; 0000 0764        LED_LOAD_A = 1;
; 0000 0765        LED_LOAD_B = 1;
; 0000 0766        break;
; 0000 0767 
; 0000 0768        case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x118
; 0000 0769        LED_LOAD = 1;
	SBI  0x8,2
; 0000 076A        LED_LOAD_A = 0;
	CBI  0x8,1
; 0000 076B        LED_LOAD_B = 1;
	RJMP _0x3E9
; 0000 076C        break;
; 0000 076D 
; 0000 076E        case 2:
_0x118:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x11F
; 0000 076F        LED_LOAD = 1;
	SBI  0x8,2
; 0000 0770        LED_LOAD_A = 1;
	SBI  0x8,1
; 0000 0771        LED_LOAD_B = 0;
	CBI  0x8,0
; 0000 0772        break;
	RJMP _0x110
; 0000 0773 
; 0000 0774        case 3:
_0x11F:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x12D
; 0000 0775        LED_LOAD = 0;
	CBI  0x8,2
; 0000 0776        LED_LOAD_A = 0;
	CBI  0x8,1
; 0000 0777        LED_LOAD_B = 0;
	CBI  0x8,0
; 0000 0778        break;
	RJMP _0x110
; 0000 0779 
; 0000 077A        default:
_0x12D:
; 0000 077B        LED_LOAD = 0;
_0x3E8:
	CBI  0x8,2
; 0000 077C        LED_LOAD_A = 1;
	SBI  0x8,1
; 0000 077D        LED_LOAD_B = 1;
_0x3E9:
	SBI  0x8,0
; 0000 077E        break;
; 0000 077F        }
_0x110:
; 0000 0780 
; 0000 0781 
; 0000 0782        delay_us(1);
	__DELAY_USB 4
; 0000 0783 
; 0000 0784        LED_DIN = 1;
	SBI  0x8,4
; 0000 0785        for(count_temp = 0; count_temp <4; count_temp++)
	CLR  R5
	CLR  R6
_0x137:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R5,R30
	CPC  R6,R31
	BRGE _0x138
; 0000 0786         {
; 0000 0787          pulse();
	RCALL _pulse
; 0000 0788         }
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 5,6,30,31
	RJMP _0x137
_0x138:
; 0000 0789 
; 0000 078A         //command digit 3
; 0000 078B         if((command & 0x08) == 0x08){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R4
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x139
	SBI  0x8,4
	RJMP _0x13C
_0x139:
	CBI  0x8,4
_0x13C:
; 0000 078C         pulse();
	RCALL _pulse
; 0000 078D 
; 0000 078E         //command digit 2
; 0000 078F         if((command & 0x04) == 0x04){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R4
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x13F
	SBI  0x8,4
	RJMP _0x142
_0x13F:
	CBI  0x8,4
_0x142:
; 0000 0790         pulse();
	RCALL _pulse
; 0000 0791 
; 0000 0792         //command digit 1
; 0000 0793         if((command & 0x02) == 0x02){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R4
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x145
	SBI  0x8,4
	RJMP _0x148
_0x145:
	CBI  0x8,4
_0x148:
; 0000 0794         pulse();
	RCALL _pulse
; 0000 0795 
; 0000 0796         //command digit 0
; 0000 0797         if((command & 0x01) == 0x01){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R4
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x14B
	SBI  0x8,4
	RJMP _0x14E
_0x14B:
	CBI  0x8,4
_0x14E:
; 0000 0798         pulse();
	RCALL _pulse
; 0000 0799 
; 0000 079A 
; 0000 079B          //data digit 7
; 0000 079C         if((fnd_data & 0x80) == 0x80){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x151
	SBI  0x8,4
	RJMP _0x154
_0x151:
	CBI  0x8,4
_0x154:
; 0000 079D         pulse();
	RCALL _pulse
; 0000 079E 
; 0000 079F         //data digit 6
; 0000 07A0         if((fnd_data & 0x40) == 0x40){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x40)
	CPI  R30,LOW(0x40)
	BRNE _0x157
	SBI  0x8,4
	RJMP _0x15A
_0x157:
	CBI  0x8,4
_0x15A:
; 0000 07A1         pulse();
	RCALL _pulse
; 0000 07A2 
; 0000 07A3         //data digit 5
; 0000 07A4         if((fnd_data & 0x20) == 0x20){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0x15D
	SBI  0x8,4
	RJMP _0x160
_0x15D:
	CBI  0x8,4
_0x160:
; 0000 07A5         pulse();
	RCALL _pulse
; 0000 07A6 
; 0000 07A7         //data digit 4
; 0000 07A8         if((fnd_data & 0x10) == 0x10){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x163
	SBI  0x8,4
	RJMP _0x166
_0x163:
	CBI  0x8,4
_0x166:
; 0000 07A9         pulse();
	RCALL _pulse
; 0000 07AA 
; 0000 07AB         //data digit 3
; 0000 07AC         if((fnd_data & 0x08) == 0x08){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x169
	SBI  0x8,4
	RJMP _0x16C
_0x169:
	CBI  0x8,4
_0x16C:
; 0000 07AD         pulse();
	RCALL _pulse
; 0000 07AE 
; 0000 07AF         //data digit 2
; 0000 07B0         if((fnd_data & 0x04) == 0x04){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x16F
	SBI  0x8,4
	RJMP _0x172
_0x16F:
	CBI  0x8,4
_0x172:
; 0000 07B1         pulse();
	RCALL _pulse
; 0000 07B2 
; 0000 07B3         //data digit 1
; 0000 07B4         if((fnd_data & 0x02) == 0x02){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x175
	SBI  0x8,4
	RJMP _0x178
_0x175:
	CBI  0x8,4
_0x178:
; 0000 07B5         pulse();
	RCALL _pulse
; 0000 07B6 
; 0000 07B7         //data digit 0
; 0000 07B8         if((fnd_data & 0x01) == 0x01){LED_DIN = 1;} else{LED_DIN = 0;}
	MOV  R30,R3
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x17B
	SBI  0x8,4
	RJMP _0x17E
_0x17B:
	CBI  0x8,4
_0x17E:
; 0000 07B9         pulse();
	RCALL _pulse
; 0000 07BA 
; 0000 07BB 
; 0000 07BC          delay_us(1);
	__DELAY_USB 4
; 0000 07BD        LED_LOAD = 1;
	SBI  0x8,2
; 0000 07BE        LED_LOAD_A = 1;
	SBI  0x8,1
; 0000 07BF        LED_LOAD_B = 1;
	SBI  0x8,0
; 0000 07C0        delay_us(1);
	__DELAY_USB 4
; 0000 07C1 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;void num_convert(char num)
; 0000 07C4 {
_num_convert:
; .FSTART _num_convert
; 0000 07C5       switch(num)
	ST   -Y,R17
	MOV  R17,R26
;	num -> R17
	MOV  R30,R17
	LDI  R31,0
; 0000 07C6       {
; 0000 07C7        case 0:
	SBIW R30,0
	BRNE _0x18A
; 0000 07C8          fnd_data = 0x7e;
	LDI  R30,LOW(126)
	MOV  R3,R30
; 0000 07C9        break;
	RJMP _0x189
; 0000 07CA 
; 0000 07CB        case 1:
_0x18A:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x18B
; 0000 07CC          fnd_data = 0x30;
	LDI  R30,LOW(48)
	MOV  R3,R30
; 0000 07CD        break;
	RJMP _0x189
; 0000 07CE 
; 0000 07CF        case 2:
_0x18B:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x18C
; 0000 07D0          fnd_data = 0x6d;
	LDI  R30,LOW(109)
	MOV  R3,R30
; 0000 07D1        break;
	RJMP _0x189
; 0000 07D2 
; 0000 07D3        case 3:
_0x18C:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x18D
; 0000 07D4          fnd_data = 0x79;
	LDI  R30,LOW(121)
	MOV  R3,R30
; 0000 07D5        break;
	RJMP _0x189
; 0000 07D6 
; 0000 07D7        case 4:
_0x18D:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x18E
; 0000 07D8          fnd_data = 0x33;
	LDI  R30,LOW(51)
	MOV  R3,R30
; 0000 07D9        break;
	RJMP _0x189
; 0000 07DA 
; 0000 07DB        case 5:
_0x18E:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x18F
; 0000 07DC          fnd_data = 0x5b;
	LDI  R30,LOW(91)
	MOV  R3,R30
; 0000 07DD        break;
	RJMP _0x189
; 0000 07DE 
; 0000 07DF        case 6:
_0x18F:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x190
; 0000 07E0          fnd_data = 0x5f;
	LDI  R30,LOW(95)
	MOV  R3,R30
; 0000 07E1        break;
	RJMP _0x189
; 0000 07E2 
; 0000 07E3        case 7:
_0x190:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x191
; 0000 07E4          fnd_data = 0x70;
	LDI  R30,LOW(112)
	MOV  R3,R30
; 0000 07E5        break;
	RJMP _0x189
; 0000 07E6 
; 0000 07E7        case 8:
_0x191:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x192
; 0000 07E8          fnd_data = 0x7f;
	LDI  R30,LOW(127)
	MOV  R3,R30
; 0000 07E9        break;
	RJMP _0x189
; 0000 07EA 
; 0000 07EB        case 9:
_0x192:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x194
; 0000 07EC          fnd_data = 0x7b;
	LDI  R30,LOW(123)
	MOV  R3,R30
; 0000 07ED        break;
	RJMP _0x189
; 0000 07EE 
; 0000 07EF        default:
_0x194:
; 0000 07F0          fnd_data = 0x00;
	CLR  R3
; 0000 07F1        break;
; 0000 07F2       }
_0x189:
; 0000 07F3 }
_0x20A0004:
	LD   R17,Y+
	RET
; .FEND
;
;
;
;
;void digit1(char temp,char num)
; 0000 07F9 {
_digit1:
; .FSTART _digit1
; 0000 07FA        command = 0x03;
	CALL SUBOPT_0x12
;	temp -> R16
;	num -> R17
	LDI  R30,LOW(3)
	RJMP _0x20A0003
; 0000 07FB        num_convert(temp);
; 0000 07FC        digit_num = num;
; 0000 07FD        fnd_out(digit_num);
; 0000 07FE }
; .FEND
;
;
;void digit2(char temp,char num)
; 0000 0802 {
_digit2:
; .FSTART _digit2
; 0000 0803        command = 0x02;
	CALL SUBOPT_0x12
;	temp -> R16
;	num -> R17
	LDI  R30,LOW(2)
	CALL SUBOPT_0x13
; 0000 0804        num_convert(temp);
; 0000 0805        if(digit == 0 || digit == 1){fnd_data = fnd_data | 0x80;} //전류 소수점 표시
	BREQ _0x196
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R11
	CPC  R31,R12
	BRNE _0x195
_0x196:
	LDI  R30,LOW(128)
	OR   R3,R30
; 0000 0806        if(digit == 0){fnd_data = fnd_data | 0x80;}
_0x195:
	MOV  R0,R11
	OR   R0,R12
	BRNE _0x198
	LDI  R30,LOW(128)
	OR   R3,R30
; 0000 0807        digit_num = num;
_0x198:
	RJMP _0x20A0002
; 0000 0808        fnd_out(digit_num);
; 0000 0809 }
; .FEND
;
;
;void digit3(char temp,char num)
; 0000 080D {
_digit3:
; .FSTART _digit3
; 0000 080E        command = 0x01;
	CALL SUBOPT_0x12
;	temp -> R16
;	num -> R17
	LDI  R30,LOW(1)
	RJMP _0x20A0003
; 0000 080F        num_convert(temp);
; 0000 0810        digit_num = num;
; 0000 0811        fnd_out(digit_num);
; 0000 0812 
; 0000 0813 }
; .FEND
;
;
;void digit4(char temp,char num)
; 0000 0817 {
_digit4:
; .FSTART _digit4
; 0000 0818        command = 0x06;
	CALL SUBOPT_0x12
;	temp -> R16
;	num -> R17
	LDI  R30,LOW(6)
	RJMP _0x20A0003
; 0000 0819        num_convert(temp);
; 0000 081A        digit_num = num;
; 0000 081B        fnd_out(digit_num);
; 0000 081C }
; .FEND
;
;void digit5(char temp,char num)
; 0000 081F {
_digit5:
; .FSTART _digit5
; 0000 0820        command = 0x05;
	CALL SUBOPT_0x12
;	temp -> R16
;	num -> R17
	LDI  R30,LOW(5)
	CALL SUBOPT_0x13
; 0000 0821        num_convert(temp);
; 0000 0822        if(digit == 0 || digit == 1){fnd_data = fnd_data | 0x80;}
	BREQ _0x19A
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R11
	CPC  R31,R12
	BRNE _0x199
_0x19A:
	LDI  R30,LOW(128)
	OR   R3,R30
; 0000 0823        if(digit == 0){fnd_data = fnd_data | 0x80;}
_0x199:
	MOV  R0,R11
	OR   R0,R12
	BRNE _0x19C
	LDI  R30,LOW(128)
	OR   R3,R30
; 0000 0824        digit_num = num;
_0x19C:
	RJMP _0x20A0002
; 0000 0825        fnd_out(digit_num);
; 0000 0826 }
; .FEND
;
;void digit6(char temp,char num)
; 0000 0829 {
_digit6:
; .FSTART _digit6
; 0000 082A        command = 0x04;
	CALL SUBOPT_0x12
;	temp -> R16
;	num -> R17
	LDI  R30,LOW(4)
_0x20A0003:
	MOV  R4,R30
; 0000 082B        num_convert(temp);
	MOV  R26,R16
	RCALL _num_convert
; 0000 082C        digit_num = num;
_0x20A0002:
	MOV  R9,R17
	CLR  R10
; 0000 082D        fnd_out(digit_num);
	__GETW2R 9,10
	RCALL _fnd_out
; 0000 082E }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
;
;
;void fnd_init(void)
; 0000 0832 {
_fnd_init:
; .FSTART _fnd_init
; 0000 0833    LED_LOAD = 1;
	SBI  0x8,2
; 0000 0834         LED_LOAD_A = 1;
	SBI  0x8,1
; 0000 0835         LED_LOAD_B = 1;
	SBI  0x8,0
; 0000 0836 //// fnd test
; 0000 0837 //       command = 0x0f;
; 0000 0838 //       fnd_data = 0x01;
; 0000 0839 //       fnd_out(3);
; 0000 083A 
; 0000 083B 
; 0000 083C // scan limit
; 0000 083D        command = 0x0b;
	CALL SUBOPT_0x14
; 0000 083E        fnd_data = 0x05;
; 0000 083F        fnd_out(3);
; 0000 0840 
; 0000 0841 // intensity
; 0000 0842        command = 0x0a;
; 0000 0843        fnd_data = 0x03; //0x07
; 0000 0844        fnd_out(3);
; 0000 0845 
; 0000 0846 // decode mode
; 0000 0847        command = 0x09;
; 0000 0848        //fnd_data = 0xff;
; 0000 0849       fnd_data = 0x00;
; 0000 084A        fnd_out(3);
; 0000 084B 
; 0000 084C //  // shut down
; 0000 084D //       command = 0x0c;
; 0000 084E //       fnd_data = 0x01;
; 0000 084F //       fnd_out(3);
; 0000 0850 
; 0000 0851 //// fnd test normar
; 0000 0852 //       command = 0x0f;
; 0000 0853 //       fnd_data = 0x00;
; 0000 0854 //       fnd_out(3);
; 0000 0855 //
; 0000 0856 //       digit = 3;
; 0000 0857 //       digit1(8,digit);
; 0000 0858 //       digit2(8,digit);
; 0000 0859 //       digit3(8,digit);
; 0000 085A //       digit4(8,digit);
; 0000 085B //       digit5(8,digit);
; 0000 085C //       digit6(8,digit);
; 0000 085D }
	RET
; .FEND
;
;void init(void)
; 0000 0860 {
_init:
; .FSTART _init
; 0000 0861 //led_bit test
; 0000 0862         LAN_RESET = 1;
	SBI  0xB,0
; 0000 0863         LAN_ISP = 1;
	SBI  0xB,4
; 0000 0864 
; 0000 0865 
; 0000 0866         LED_LOAD = 1;
	SBI  0x8,2
; 0000 0867         LED_LOAD_A = 1;
	SBI  0x8,1
; 0000 0868         LED_LOAD_B = 1;
	SBI  0x8,0
; 0000 0869 // fnd test
; 0000 086A        command = 0x0f;
	LDI  R30,LOW(15)
	CALL SUBOPT_0x15
; 0000 086B        fnd_data = 0x01;
; 0000 086C        fnd_out(3);
; 0000 086D 
; 0000 086E 
; 0000 086F // scan limit
; 0000 0870        command = 0x0b;
	CALL SUBOPT_0x14
; 0000 0871        fnd_data = 0x05;
; 0000 0872        fnd_out(3);
; 0000 0873 
; 0000 0874 // intensity
; 0000 0875        command = 0x0a;
; 0000 0876        fnd_data = 0x03; //0x07
; 0000 0877        fnd_out(3);
; 0000 0878 
; 0000 0879 // decode mode
; 0000 087A        command = 0x09;
; 0000 087B        //fnd_data = 0xff;
; 0000 087C       fnd_data = 0x00;
; 0000 087D        fnd_out(3);
; 0000 087E 
; 0000 087F   // shut down
; 0000 0880        command = 0x0c;
	LDI  R30,LOW(12)
	CALL SUBOPT_0x15
; 0000 0881        fnd_data = 0x01;
; 0000 0882        fnd_out(3);
; 0000 0883 
; 0000 0884 // fnd test normar
; 0000 0885        command = 0x0f;
	LDI  R30,LOW(15)
	MOV  R4,R30
; 0000 0886        fnd_data = 0x00;
	CLR  R3
; 0000 0887        fnd_out(3);
	LDI  R26,LOW(3)
	LDI  R27,0
	RCALL _fnd_out
; 0000 0888 
; 0000 0889        digit = 3;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	__PUTW1R 11,12
; 0000 088A        digit1(8,digit);
	LDI  R30,LOW(8)
	CALL SUBOPT_0x16
; 0000 088B        digit2(8,digit);
	LDI  R30,LOW(8)
	CALL SUBOPT_0x17
; 0000 088C        digit3(8,digit);
	LDI  R30,LOW(8)
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit3
; 0000 088D        digit4(8,digit);
	LDI  R30,LOW(8)
	CALL SUBOPT_0x18
; 0000 088E        digit5(8,digit);
	LDI  R30,LOW(8)
	CALL SUBOPT_0x19
; 0000 088F        digit6(8,digit);
	LDI  R30,LOW(8)
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit6
; 0000 0890 
; 0000 0891         BUZZER_HIGH = 1;
	SBI  0x5,5
; 0000 0892         DT_NORMAL  = OFF;
	CBI  0x2,4
; 0000 0893         DT_ERR = ON;
	SBI  0x2,5
; 0000 0894         GE_NORMAL  = OFF;
	CBI  0x2,6
; 0000 0895         GE_ERR = ON;
	SBI  0x2,7
; 0000 0896         BAT_RUN_1  = OFF;
	CBI  0xE,4
; 0000 0897         BAT_RUN_2  = OFF;
	CBI  0xE,5
; 0000 0898         BAT_ERR_1  = ON;
	SBI  0xE,6
; 0000 0899         BAT_ERR_2  = ON;
	SBI  0xE,7
; 0000 089A         TEST_LED_1 = ON;
	SBI  0x8,5
; 0000 089B         TEST_LED_2 = ON;
	SBI  0x8,6
; 0000 089C 
; 0000 089D         delay_ms(250);
	LDI  R26,LOW(250)
	LDI  R27,0
	CALL _delay_ms
; 0000 089E         BUZZER_HIGH = 0; //LAN RESET
	CBI  0x5,5
; 0000 089F         delay_ms(750);
	LDI  R26,LOW(750)
	LDI  R27,HIGH(750)
	CALL _delay_ms
; 0000 08A0         DT_NORMAL  = ON;
	SBI  0x2,4
; 0000 08A1         DT_ERR = OFF;
	CBI  0x2,5
; 0000 08A2         GE_NORMAL  = ON;
	SBI  0x2,6
; 0000 08A3         GE_ERR = OFF;
	CBI  0x2,7
; 0000 08A4         BAT_RUN_1  = ON;
	SBI  0xE,4
; 0000 08A5         BAT_RUN_2  = ON;
	SBI  0xE,5
; 0000 08A6         BAT_ERR_1  = OFF;
	CBI  0xE,6
; 0000 08A7         BAT_ERR_2  = OFF;
	CBI  0xE,7
; 0000 08A8 
; 0000 08A9         LAN_RESET = 0;
	CBI  0xB,0
; 0000 08AA        // delay_ms(500);
; 0000 08AB        delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 08AC         DT_NORMAL  = OFF;
	CBI  0x2,4
; 0000 08AD         DT_ERR = OFF;
	CBI  0x2,5
; 0000 08AE         GE_NORMAL  = OFF;
	CBI  0x2,6
; 0000 08AF         GE_ERR = OFF;
	CBI  0x2,7
; 0000 08B0         BAT_ERR_1  = OFF;
	CBI  0xE,6
; 0000 08B1         BAT_ERR_2  = OFF;
	CBI  0xE,7
; 0000 08B2         BAT_RUN_1  = OFF;
	CBI  0xE,4
; 0000 08B3         BAT_RUN_2  = OFF;
	CBI  0xE,5
; 0000 08B4 
; 0000 08B5         LAN_RESET = 1;  //LAN RESET
	SBI  0xB,0
; 0000 08B6 
; 0000 08B7         RE_DE0 = 0;
	CBI  0xE,2
; 0000 08B8         RE_DE1 = 0;
	CBI  0xE,3
; 0000 08B9 
; 0000 08BA         buzzer_on = 1;
	SBI  0x1E,0
; 0000 08BB         mode_change_and_init = 1; //초기 경보 대기
	LDI  R30,LOW(1)
	STS  _mode_change_and_init,R30
; 0000 08BC 
; 0000 08BD         temp_control_1_old = 0xff;
	LDI  R30,LOW(255)
	STS  _temp_control_1_old,R30
; 0000 08BE         temp_control_2_old = 0xff;
	STS  _temp_control_2_old,R30
; 0000 08BF }
	RET
; .FEND
;
;void display_out()
; 0000 08C2 {
_display_out:
; .FSTART _display_out
; 0000 08C3         if(DT_ERR == ERR)
	SBIS 0x2,5
	RJMP _0x1EF
; 0000 08C4         {
; 0000 08C5          voltage_1 = 0;
	CALL SUBOPT_0x2
; 0000 08C6          currunt_1 = 0;
; 0000 08C7          bat_volt_1 = 0;
; 0000 08C8          voltage_2 = 0;
	CALL SUBOPT_0x5
; 0000 08C9          currunt_2 = 0;
; 0000 08CA          bat_volt_2 = 0;
; 0000 08CB         }
; 0000 08CC         digit = 0;
_0x1EF:
	CLR  R11
	CLR  R12
; 0000 08CD             if(voltage_1 < 100)
	CALL SUBOPT_0x1A
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0x1F0
; 0000 08CE             {
; 0000 08CF               digit1(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x16
; 0000 08D0                if(voltage_1<10)
	CALL SUBOPT_0x1A
	SBIW R26,10
	BRSH _0x1F1
; 0000 08D1                 {
; 0000 08D2                    digit2(0,digit);
	LDI  R30,LOW(0)
	RJMP _0x3EA
; 0000 08D3                 }
; 0000 08D4                 else
_0x1F1:
; 0000 08D5                 {
; 0000 08D6                    digit2(voltage_1/10,digit);
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1B
_0x3EA:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit2
; 0000 08D7                 }
; 0000 08D8             }
; 0000 08D9             else
	RJMP _0x1F3
_0x1F0:
; 0000 08DA             {
; 0000 08DB               if( voltage_1/100 < 10)
	CALL SUBOPT_0x1C
	SBIW R30,10
	BRSH _0x1F4
; 0000 08DC               {
; 0000 08DD                 digit1(voltage_1/100,digit);
	CALL SUBOPT_0x1C
	RJMP _0x3EB
; 0000 08DE               }
; 0000 08DF               else
_0x1F4:
; 0000 08E0               {
; 0000 08E1                 digit1(0,digit);
	LDI  R30,LOW(0)
_0x3EB:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit1
; 0000 08E2               }
; 0000 08E3               digit2((voltage_1 - ((voltage_1/100)*100))/10,digit);
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x17
; 0000 08E4             }
_0x1F3:
; 0000 08E5             if(voltage_1 == 0){ digit3(0,digit);}else{digit3(voltage_1%10,digit);}
	LDS  R30,_voltage_1
	LDS  R31,_voltage_1+1
	SBIW R30,0
	BRNE _0x1F6
	LDI  R30,LOW(0)
	RJMP _0x3EC
_0x1F6:
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1F
_0x3EC:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit3
; 0000 08E6 
; 0000 08E7 
; 0000 08E8             if(voltage_2 < 100)
	CALL SUBOPT_0x20
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0x1F8
; 0000 08E9             {
; 0000 08EA               digit4(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x18
; 0000 08EB                if(voltage_2<10)
	CALL SUBOPT_0x20
	SBIW R26,10
	BRSH _0x1F9
; 0000 08EC                 {
; 0000 08ED                    digit5(0,digit);
	LDI  R30,LOW(0)
	RJMP _0x3ED
; 0000 08EE                 }
; 0000 08EF                 else
_0x1F9:
; 0000 08F0                 {
; 0000 08F1                    digit5(voltage_2/10,digit);
	CALL SUBOPT_0x20
	CALL SUBOPT_0x1B
_0x3ED:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit5
; 0000 08F2                 }
; 0000 08F3             }
; 0000 08F4             else
	RJMP _0x1FB
_0x1F8:
; 0000 08F5             {
; 0000 08F6               if( voltage_2/100 < 10)
	CALL SUBOPT_0x21
	SBIW R30,10
	BRSH _0x1FC
; 0000 08F7               {
; 0000 08F8                 digit4(voltage_2/100,digit);
	CALL SUBOPT_0x21
	RJMP _0x3EE
; 0000 08F9               }
; 0000 08FA               else
_0x1FC:
; 0000 08FB               {
; 0000 08FC                 digit4(0,digit);
	LDI  R30,LOW(0)
_0x3EE:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit4
; 0000 08FD               }
; 0000 08FE               digit5((voltage_2 - ((voltage_2/100)*100))/10,digit);
	CALL SUBOPT_0x21
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x20
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x19
; 0000 08FF             }
_0x1FB:
; 0000 0900             if(voltage_2 == 0){ digit6(0,digit);}else{digit6(voltage_2%10,digit);}
	LDS  R30,_voltage_2
	LDS  R31,_voltage_2+1
	SBIW R30,0
	BRNE _0x1FE
	LDI  R30,LOW(0)
	RJMP _0x3EF
_0x1FE:
	CALL SUBOPT_0x20
	CALL SUBOPT_0x1F
_0x3EF:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit6
; 0000 0901 
; 0000 0902 
; 0000 0903             digit = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__PUTW1R 11,12
; 0000 0904 
; 0000 0905             if(currunt_1 < 100)
	CALL SUBOPT_0x22
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0x200
; 0000 0906             {
; 0000 0907               digit1(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x16
; 0000 0908                if(currunt_1<10)
	CALL SUBOPT_0x22
	SBIW R26,10
	BRSH _0x201
; 0000 0909                 {
; 0000 090A                    digit2(0,digit);
	LDI  R30,LOW(0)
	RJMP _0x3F0
; 0000 090B                 }
; 0000 090C                 else
_0x201:
; 0000 090D                 {
; 0000 090E                    digit2(currunt_1/10,digit);
	CALL SUBOPT_0x22
	CALL SUBOPT_0x1B
_0x3F0:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit2
; 0000 090F                 }
; 0000 0910             }
; 0000 0911             else
	RJMP _0x203
_0x200:
; 0000 0912             {
; 0000 0913 
; 0000 0914               if( currunt_1/100 < 10)
	CALL SUBOPT_0x23
	SBIW R30,10
	BRSH _0x204
; 0000 0915               {
; 0000 0916                 digit1(currunt_1/100,digit);        //입력 값이 1000 넘을 경우  처리
	CALL SUBOPT_0x23
	RJMP _0x3F1
; 0000 0917               }
; 0000 0918               else
_0x204:
; 0000 0919               {
; 0000 091A                 digit1(0,digit);
	LDI  R30,LOW(0)
_0x3F1:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit1
; 0000 091B               }
; 0000 091C               digit2((currunt_1- ((currunt_1/100)*100))/10,digit);
	CALL SUBOPT_0x23
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x22
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x17
; 0000 091D             }
_0x203:
; 0000 091E             if(currunt_1 == 0){ digit3(0,digit);}else{digit3(currunt_1%10,digit);}
	LDS  R30,_currunt_1
	LDS  R31,_currunt_1+1
	SBIW R30,0
	BRNE _0x206
	LDI  R30,LOW(0)
	RJMP _0x3F2
_0x206:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x1F
_0x3F2:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit3
; 0000 091F 
; 0000 0920             if(currunt_2 < 100)
	CALL SUBOPT_0x24
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0x208
; 0000 0921             {
; 0000 0922               digit4(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x18
; 0000 0923                if(currunt_2<10)
	CALL SUBOPT_0x24
	SBIW R26,10
	BRSH _0x209
; 0000 0924                 {
; 0000 0925                    digit5(0,digit);
	LDI  R30,LOW(0)
	RJMP _0x3F3
; 0000 0926                 }
; 0000 0927                 else
_0x209:
; 0000 0928                 {
; 0000 0929                    digit5(currunt_2/10,digit);
	CALL SUBOPT_0x24
	CALL SUBOPT_0x1B
_0x3F3:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit5
; 0000 092A                 }
; 0000 092B             }
; 0000 092C             else
	RJMP _0x20B
_0x208:
; 0000 092D             {
; 0000 092E                 if( currunt_2/100 < 10)
	CALL SUBOPT_0x25
	SBIW R30,10
	BRSH _0x20C
; 0000 092F                 {
; 0000 0930                 digit4(currunt_2/100,digit);
	CALL SUBOPT_0x25
	RJMP _0x3F4
; 0000 0931                 }
; 0000 0932                 else
_0x20C:
; 0000 0933                 {
; 0000 0934                 digit4(0,digit);
	LDI  R30,LOW(0)
_0x3F4:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit4
; 0000 0935                 }
; 0000 0936                 digit5((currunt_2 - ((currunt_2/100)*100))/10,digit);
	CALL SUBOPT_0x25
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x24
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x19
; 0000 0937             }
_0x20B:
; 0000 0938             if(currunt_2 == 0){ digit6(0,digit);}else{digit6(currunt_2%10,digit);}
	LDS  R30,_currunt_2
	LDS  R31,_currunt_2+1
	SBIW R30,0
	BRNE _0x20E
	LDI  R30,LOW(0)
	RJMP _0x3F5
_0x20E:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x1F
_0x3F5:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit6
; 0000 0939 
; 0000 093A 
; 0000 093B             digit = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	__PUTW1R 11,12
; 0000 093C             if(bat_volt_1 < 100)
	CALL SUBOPT_0x26
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRGE _0x210
; 0000 093D             {
; 0000 093E               digit1(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x16
; 0000 093F                if(bat_volt_1<10)
	CALL SUBOPT_0x26
	SBIW R26,10
	BRGE _0x211
; 0000 0940                 {
; 0000 0941                    digit2(0,digit);
	LDI  R30,LOW(0)
	RJMP _0x3F6
; 0000 0942                 }
; 0000 0943                 else
_0x211:
; 0000 0944                 {
; 0000 0945                    digit2(bat_volt_1/10,digit);
	CALL SUBOPT_0x26
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
_0x3F6:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit2
; 0000 0946                 }
; 0000 0947             if(bat_volt_1 == 0){ digit3(0,digit);}else{digit3(bat_volt_1%10,digit);}
	LDS  R30,_bat_volt_1
	LDS  R31,_bat_volt_1+1
	SBIW R30,0
	BRNE _0x213
	LDI  R30,LOW(0)
	RJMP _0x3F7
_0x213:
	CALL SUBOPT_0x26
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
_0x3F7:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit3
; 0000 0948             }
; 0000 0949             else
	RJMP _0x215
_0x210:
; 0000 094A             {
; 0000 094B                 digit1(1,digit);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x16
; 0000 094C                 digit2(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x17
; 0000 094D                 digit3(0,digit);
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit3
; 0000 094E             }
_0x215:
; 0000 094F 
; 0000 0950             if(bat_volt_2 < 100)
	CALL SUBOPT_0x27
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRGE _0x216
; 0000 0951             {
; 0000 0952               digit4(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x18
; 0000 0953                if(bat_volt_2<10)
	CALL SUBOPT_0x27
	SBIW R26,10
	BRGE _0x217
; 0000 0954                 {
; 0000 0955                    digit5(0,digit);
	LDI  R30,LOW(0)
	RJMP _0x3F8
; 0000 0956                 }
; 0000 0957                 else
_0x217:
; 0000 0958                 {
; 0000 0959                    digit5(bat_volt_2/10,digit);
	CALL SUBOPT_0x27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
_0x3F8:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit5
; 0000 095A                 }
; 0000 095B             if(bat_volt_2 == 0){ digit6(0,digit);}else{digit6(bat_volt_2%10,digit);}
	LDS  R30,_bat_volt_2
	LDS  R31,_bat_volt_2+1
	SBIW R30,0
	BRNE _0x219
	LDI  R30,LOW(0)
	RJMP _0x3F9
_0x219:
	CALL SUBOPT_0x27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
_0x3F9:
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit6
; 0000 095C             }
; 0000 095D             else
	RJMP _0x21B
_0x216:
; 0000 095E             {
; 0000 095F                 digit4(1,digit);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x18
; 0000 0960                 digit5(0,digit);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x19
; 0000 0961                 digit6(0,digit);
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R11
	RCALL _digit6
; 0000 0962             }
_0x21B:
; 0000 0963 
; 0000 0964 
; 0000 0965 }
	RET
; .FEND
;
;void Response_Common_CHeckLink(void)
; 0000 0968 {
_Response_Common_CHeckLink:
; .FSTART _Response_Common_CHeckLink
; 0000 0969  putchar1(0x38);//type
	LDI  R26,LOW(56)
	RCALL _putchar1
; 0000 096A  putchar1(0xf1);//id
	LDI  R26,LOW(241)
	CALL SUBOPT_0x28
; 0000 096B  putchar1(0x28); //sol_data
; 0000 096C  putchar1(0x20); //dest_data
; 0000 096D  putchar1(Common_CheckLink_number);//number
	LDS  R26,_Common_CheckLink_number
	CALL SUBOPT_0x29
; 0000 096E  putchar1(0x24);//style
; 0000 096F  putchar1(0x00);//length
	CALL SUBOPT_0x2A
; 0000 0970  putchar1(0x00);//length
; 0000 0971  if(Common_CheckLink_number >= 0xff){Common_CheckLink_number = 0;}else{Common_CheckLink_number++;}
	LDS  R26,_Common_CheckLink_number
	CPI  R26,LOW(0xFF)
	BRLO _0x21C
	LDI  R30,LOW(0)
	RJMP _0x3FA
_0x21C:
	LDS  R30,_Common_CheckLink_number
	SUBI R30,-LOW(1)
_0x3FA:
	STS  _Common_CheckLink_number,R30
; 0000 0972  Common_CHeckLink_act = 0;
	LDI  R30,LOW(0)
	STS  _Common_CHeckLink_act,R30
; 0000 0973 }
	RET
; .FEND
;
;//void Response_PoBITResult(void)
;//{
;// putchar1(0x38); //type
;// putchar1(0x01); //id
;// putchar1(0x28); //sol_data
;// putchar1(0x20); //dest_data
;// putchar1(PoBITResult_number);
;// putchar1(0x25); //tm
;// putchar1(0x00);//length_1
;// putchar1(0x02);//length_2
;// putchar1(0x05);//po bit상태
;//
;// if(gen_err == 1){pobit_result |= 0x40;}else{pobit_result &= ~0x40;}
;// if(batt_link_err_act_1 == 1){pobit_result |= 0x20;}else{pobit_result &= ~0x20;}
;// if(batt_link_err_act_1 == 1){pobit_result |= 0x10;}else{pobit_result &= ~0x10;}
;// if(batt_link_err_act_2 == 1){pobit_result |= 0x08;}else{pobit_result &= ~0x08;}
;// if(power_link_1 & 0x80 != 0x80){pobit_result |= 0x04;}else{pobit_result &= ~0x04;}
;// if(power_link_2 & 0x80 != 0x80){pobit_result |= 0x02;}else{pobit_result &= ~0x02;}
;// if(DT_ERR == 1){pobit_result |= 0x01;}else{pobit_result &= ~0x01;}
;// if(PoBITResult_number >= 0xff){PoBITResult_number = 0;}else{PoBITResult_number++;}
;//
;// PoBITResult_act = 0;
;//}
;
;//배전기 PBIT응답
;void Response_Distributor_PBIT(void)
; 0000 098F {
_Response_Distributor_PBIT:
; .FSTART _Response_Distributor_PBIT
; 0000 0990  putchar1(0x38); //type
	LDI  R26,LOW(56)
	RCALL _putchar1
; 0000 0991  putchar1(0xf3); //id
	LDI  R26,LOW(243)
	CALL SUBOPT_0x28
; 0000 0992  putchar1(0x28); //sol_data
; 0000 0993  putchar1(0x20); //dest_data
; 0000 0994  putchar1(Distributor_PBIT_number);
	LDS  R26,_Distributor_PBIT_number
	CALL SUBOPT_0x29
; 0000 0995  putchar1(0x24); //tm
; 0000 0996  putchar1(0x01);//length_1
	CALL SUBOPT_0x2B
; 0000 0997  putchar1(0x00);//length_2
; 0000 0998  pbit_result = 0x00;//초기
	LDI  R30,LOW(0)
	STS  _pbit_result,R30
; 0000 0999 
; 0000 099A  //통신상태
; 0000 099B  //bit 5 reserve
; 0000 099C  if((comm_ge_err == ERR)||(power_link1_err == 1)||(power_link2_err == 1)||(batt_link_err_act_1 == 1)||
; 0000 099D  (batt_link_err_act_2 == 1)||(DT_ERR == 1)){pbit_result |= 0x80;}else{pbit_result &= ~0x80;}//batt 온도 불량///batt 전류 ...
	SBRC R2,0
	RJMP _0x21F
	LDS  R26,_power_link1_err
	CPI  R26,LOW(0x1)
	BREQ _0x21F
	LDS  R26,_power_link2_err
	CPI  R26,LOW(0x1)
	BREQ _0x21F
	SBIC 0x1E,2
	RJMP _0x21F
	SBIC 0x1E,3
	RJMP _0x21F
	SBIS 0x2,5
	RJMP _0x21E
_0x21F:
	LDS  R30,_pbit_result
	ORI  R30,0x80
	RJMP _0x3FB
_0x21E:
	LDS  R30,_pbit_result
	ANDI R30,0x7F
_0x3FB:
	STS  _pbit_result,R30
; 0000 099E 
; 0000 099F  if((ge_err_act == ERR)&&(comm_ge_err == NOR)){pbit_result |= 0x20;}else{pbit_result &= ~0x20;}//통신단절시 에러표시 0으 ...
	LDS  R26,_ge_err_act
	CPI  R26,LOW(0x1)
	BRNE _0x223
	SBRS R2,0
	RJMP _0x224
_0x223:
	RJMP _0x222
_0x224:
	LDS  R30,_pbit_result
	ORI  R30,0x20
	RJMP _0x3FC
_0x222:
	LDS  R30,_pbit_result
	ANDI R30,0xDF
_0x3FC:
	STS  _pbit_result,R30
; 0000 09A0  if((err_bat2_volt == 1)||(err_bat2_temp == 1)||(err_bat2_curr == 1)){pbit_result |= 0x10;}else{pbit_result &= ~0x10;}
	LDS  R26,_err_bat2_volt
	CPI  R26,LOW(0x1)
	BREQ _0x227
	LDS  R26,_err_bat2_temp
	CPI  R26,LOW(0x1)
	BREQ _0x227
	LDS  R26,_err_bat2_curr
	CPI  R26,LOW(0x1)
	BRNE _0x226
_0x227:
	LDS  R30,_pbit_result
	ORI  R30,0x10
	RJMP _0x3FD
_0x226:
	LDS  R30,_pbit_result
	ANDI R30,0xEF
_0x3FD:
	STS  _pbit_result,R30
; 0000 09A1  if((err_bat1_volt == 1)||(err_bat1_temp == 1)||(err_bat1_curr == 1)){pbit_result |= 0x08;}else{pbit_result &= ~0x08;}
	LDS  R26,_err_bat1_volt
	CPI  R26,LOW(0x1)
	BREQ _0x22B
	LDS  R26,_err_bat1_temp
	CPI  R26,LOW(0x1)
	BREQ _0x22B
	LDS  R26,_err_bat1_curr
	CPI  R26,LOW(0x1)
	BRNE _0x22A
_0x22B:
	LDS  R30,_pbit_result
	ORI  R30,8
	RJMP _0x3FE
_0x22A:
	LDS  R30,_pbit_result
	ANDI R30,0XF7
_0x3FE:
	STS  _pbit_result,R30
; 0000 09A2  if(power_2_err == 1){pbit_result |= 0x04;}else{pbit_result &= ~0x04;}
	LDS  R26,_power_2_err
	CPI  R26,LOW(0x1)
	BRNE _0x22E
	ORI  R30,4
	RJMP _0x3FF
_0x22E:
	LDS  R30,_pbit_result
	ANDI R30,0xFB
_0x3FF:
	STS  _pbit_result,R30
; 0000 09A3  if(power_1_err == 1){pbit_result |= 0x02;}else{pbit_result &= ~0x02;}
	LDS  R26,_power_1_err
	CPI  R26,LOW(0x1)
	BRNE _0x230
	ORI  R30,2
	RJMP _0x400
_0x230:
	LDS  R30,_pbit_result
	ANDI R30,0xFD
_0x400:
	STS  _pbit_result,R30
; 0000 09A4  if(deiver_48_err == ERR){pbit_result |= 0x01;}else{pbit_result &= ~0x01;}
	LDS  R26,_deiver_48_err
	CPI  R26,LOW(0x1)
	BRNE _0x232
	ORI  R30,1
	RJMP _0x401
_0x232:
	LDS  R30,_pbit_result
	ANDI R30,0xFE
_0x401:
	STS  _pbit_result,R30
; 0000 09A5 
; 0000 09A6  putchar1(pbit_result);//pobit결과
	LDS  R26,_pbit_result
	RCALL _putchar1
; 0000 09A7  if(Distributor_PBIT_number >= 0xff){Distributor_PBIT_number = 0;}else{Distributor_PBIT_number++;}
	LDS  R26,_Distributor_PBIT_number
	CPI  R26,LOW(0xFF)
	BRLO _0x234
	LDI  R30,LOW(0)
	RJMP _0x402
_0x234:
	LDS  R30,_Distributor_PBIT_number
	SUBI R30,-LOW(1)
_0x402:
	STS  _Distributor_PBIT_number,R30
; 0000 09A8  Distributor_PBIT_act = 0;
	LDI  R30,LOW(0)
	STS  _Distributor_PBIT_act,R30
; 0000 09A9 }
	RET
; .FEND
;
;void Response_Distributor_ShutdownResponse(void)
; 0000 09AC {
_Response_Distributor_ShutdownResponse:
; .FSTART _Response_Distributor_ShutdownResponse
; 0000 09AD  putchar1(0x38); //type
	LDI  R26,LOW(56)
	RCALL _putchar1
; 0000 09AE  putchar1(0x00); //id
	LDI  R26,LOW(0)
	CALL SUBOPT_0x28
; 0000 09AF  putchar1(0x28); //sol_data
; 0000 09B0  putchar1(0x20); //dest_data
; 0000 09B1  putchar1(Distributor_ShutdownResponse_number);
	LDS  R26,_Distributor_ShutdownResponse_number
	CALL SUBOPT_0x29
; 0000 09B2  putchar1(0x24); //tm
; 0000 09B3  putchar1(0x01);//length_1
	LDI  R26,LOW(1)
	RCALL _putchar1
; 0000 09B4  putchar1(0x00);//length_2
	CALL SUBOPT_0x2A
; 0000 09B5  putchar1(0x00);//pobit결과
; 0000 09B6  if(Distributor_ShutdownResponse_number >= 0xff){Distributor_ShutdownResponse_number = 0;}else{Distributor_ShutdownRespo ...
	LDS  R26,_Distributor_ShutdownResponse_number
	CPI  R26,LOW(0xFF)
	BRLO _0x236
	LDI  R30,LOW(0)
	RJMP _0x403
_0x236:
	LDS  R30,_Distributor_ShutdownResponse_number
	SUBI R30,-LOW(1)
_0x403:
	STS  _Distributor_ShutdownResponse_number,R30
; 0000 09B7  Distributor_ShutdownResponse_act = 0;
	LDI  R30,LOW(0)
	STS  _Distributor_ShutdownResponse_act,R30
; 0000 09B8 }
	RET
; .FEND
;
;void Response_Distributor_ShutdownErroResponse(void)
; 0000 09BB {
_Response_Distributor_ShutdownErroResponse:
; .FSTART _Response_Distributor_ShutdownErroResponse
; 0000 09BC  putchar1(0x38); //type
	LDI  R26,LOW(56)
	RCALL _putchar1
; 0000 09BD  putchar1(0x03); //id
	LDI  R26,LOW(3)
	CALL SUBOPT_0x28
; 0000 09BE  putchar1(0x28); //sol_data
; 0000 09BF  putchar1(0x20); //dest_data
; 0000 09C0  putchar1(Distributor_ShutdownErroResponse_number);
	LDS  R26,_Distributor_ShutdownErroResponse_number
	CALL SUBOPT_0x29
; 0000 09C1  putchar1(0x24); //tm
; 0000 09C2  putchar1(0x07); //length 1
	LDI  R26,LOW(7)
	CALL SUBOPT_0x2C
; 0000 09C3  putchar1(0x00); //length 2
; 0000 09C4  putchar1(keep_year);//year
	LDI  R26,LOW(_keep_year)
	LDI  R27,HIGH(_keep_year)
	CALL SUBOPT_0x2D
; 0000 09C5  putchar1(keep_month);//month
	LDI  R26,LOW(_keep_month)
	LDI  R27,HIGH(_keep_month)
	CALL SUBOPT_0x2D
; 0000 09C6  putchar1(keep_day);//day
	LDI  R26,LOW(_keep_day)
	LDI  R27,HIGH(_keep_day)
	CALL SUBOPT_0x2D
; 0000 09C7  putchar1(keep_hour);//hour
	LDI  R26,LOW(_keep_hour)
	LDI  R27,HIGH(_keep_hour)
	CALL SUBOPT_0x2D
; 0000 09C8  putchar1(keep_minute);//minute
	LDI  R26,LOW(_keep_minute)
	LDI  R27,HIGH(_keep_minute)
	CALL SUBOPT_0x2D
; 0000 09C9  putchar1(keep_sec);//sec
	LDI  R26,LOW(_keep_sec)
	LDI  R27,HIGH(_keep_sec)
	CALL SUBOPT_0x2D
; 0000 09CA  putchar1(0x01);//error device
	LDI  R26,LOW(1)
	RCALL _putchar1
; 0000 09CB  if(Distributor_ShutdownErroResponse_number >= 0xff){Distributor_ShutdownErroResponse_number = 0;}else{Distributor_Shutd ...
	LDS  R26,_Distributor_ShutdownErroResponse_number
	CPI  R26,LOW(0xFF)
	BRLO _0x238
	LDI  R30,LOW(0)
	RJMP _0x404
_0x238:
	LDS  R30,_Distributor_ShutdownErroResponse_number
	SUBI R30,-LOW(1)
_0x404:
	STS  _Distributor_ShutdownErroResponse_number,R30
; 0000 09CC  Distributor_ShutdownErroResponse_act = 0;
	LDI  R30,LOW(0)
	STS  _Distributor_ShutdownErroResponse_act,R30
; 0000 09CD }
	RET
; .FEND
;
;void Response_Distributor_TimeSyncAck(void)
; 0000 09D0 {
_Response_Distributor_TimeSyncAck:
; .FSTART _Response_Distributor_TimeSyncAck
; 0000 09D1  putchar1(0x38); //type
	LDI  R26,LOW(56)
	RCALL _putchar1
; 0000 09D2  putchar1(0x04); //id
	LDI  R26,LOW(4)
	CALL SUBOPT_0x28
; 0000 09D3  putchar1(0x28); //sol_data
; 0000 09D4  putchar1(0x20); //dest_data
; 0000 09D5  putchar1(Distributor_TimeSyncAck_number);
	LDS  R26,_Distributor_TimeSyncAck_number
	CALL SUBOPT_0x29
; 0000 09D6  putchar1(0x24); //tm
; 0000 09D7  putchar1(0x01); //length 1
	CALL SUBOPT_0x2B
; 0000 09D8  putchar1(0x00); //length 2
; 0000 09D9  putchar1(0x01); //설정 완료 응답
	LDI  R26,LOW(1)
	RCALL _putchar1
; 0000 09DA  if(Distributor_TimeSyncAck_number >= 0xff){Distributor_TimeSyncAck_number = 0;}else{Distributor_TimeSyncAck_number++;}
	LDS  R26,_Distributor_TimeSyncAck_number
	CPI  R26,LOW(0xFF)
	BRLO _0x23A
	LDI  R30,LOW(0)
	RJMP _0x405
_0x23A:
	LDS  R30,_Distributor_TimeSyncAck_number
	SUBI R30,-LOW(1)
_0x405:
	STS  _Distributor_TimeSyncAck_number,R30
; 0000 09DB  Distributor_TimeSyncAck_act = 0;
	LDI  R30,LOW(0)
	STS  _Distributor_TimeSyncAck_act,R30
; 0000 09DC }
	RET
; .FEND
;
;
;void Response_Distributor_PoBITResponse_pre(void)
; 0000 09E0 {
_Response_Distributor_PoBITResponse_pre:
; .FSTART _Response_Distributor_PoBITResponse_pre
; 0000 09E1  //ack처리
; 0000 09E2  putchar1(0x38); //type
	CALL SUBOPT_0x2E
; 0000 09E3  putchar1(0x01); //id
; 0000 09E4  putchar1(0x28); //sol_data
; 0000 09E5  putchar1(0x20); //dest_data
; 0000 09E6  putchar1(PoBITResult_number_ack);
	LDS  R26,_PoBITResult_number_ack
	CALL SUBOPT_0x29
; 0000 09E7  putchar1(0x24); //tm
; 0000 09E8  putchar1(0x02);//length_1
	LDI  R26,LOW(2)
	CALL SUBOPT_0x2C
; 0000 09E9  putchar1(0x00);//length_2
; 0000 09EA  putchar1(0x01);//ack
	CALL SUBOPT_0x2B
; 0000 09EB  putchar1(0x00);//데이터 없음
; 0000 09EC  if(PoBITResult_number_ack >= 0xff){PoBITResult_number_ack = 0;}else{PoBITResult_number_ack++;}
	LDS  R26,_PoBITResult_number_ack
	CPI  R26,LOW(0xFF)
	BRLO _0x23C
	LDI  R30,LOW(0)
	RJMP _0x406
_0x23C:
	LDS  R30,_PoBITResult_number_ack
	SUBI R30,-LOW(1)
_0x406:
	STS  _PoBITResult_number_ack,R30
; 0000 09ED  Distributor_PoBIT_act_pre= 0;
	LDI  R30,LOW(0)
	STS  _Distributor_PoBIT_act_pre,R30
; 0000 09EE }
	RET
; .FEND
;
;void Response_Distributor_PoBITResponse(void)
; 0000 09F1 {
_Response_Distributor_PoBITResponse:
; .FSTART _Response_Distributor_PoBITResponse
; 0000 09F2  putchar1(0x38); //type
	CALL SUBOPT_0x2E
; 0000 09F3  putchar1(0x01); //id
; 0000 09F4  putchar1(0x28); //sol_data
; 0000 09F5  putchar1(0x20); //dest_data
; 0000 09F6  putchar1(PoBITResult_number);
	LDS  R26,_PoBITResult_number
	CALL SUBOPT_0x29
; 0000 09F7  putchar1(0x24); //tm
; 0000 09F8  putchar1(0x02);//length_1
	LDI  R26,LOW(2)
	CALL SUBOPT_0x2C
; 0000 09F9  putchar1(0x00);//length_2
; 0000 09FA  putchar1(0x05);//po bit상태
	LDI  R26,LOW(5)
	RCALL _putchar1
; 0000 09FB  if(PoBITResult_number >= 0xff){PoBITResult_number = 0;}else{PoBITResult_number++;}
	LDS  R26,_PoBITResult_number
	CPI  R26,LOW(0xFF)
	BRLO _0x23E
	LDI  R30,LOW(0)
	RJMP _0x407
_0x23E:
	LDS  R30,_PoBITResult_number
	SUBI R30,-LOW(1)
_0x407:
	STS  _PoBITResult_number,R30
; 0000 09FC  //통신상태
; 0000 09FD  //bit 5 reserve
; 0000 09FE  if((comm_ge_err == ERR)||(power_link1_err == 1)||(power_link2_err == 1)||(batt_link_err_act_1 == 1)||(batt_link_err_act ...
	SBRC R2,0
	RJMP _0x241
	LDS  R26,_power_link1_err
	CPI  R26,LOW(0x1)
	BREQ _0x241
	LDS  R26,_power_link2_err
	CPI  R26,LOW(0x1)
	BREQ _0x241
	SBIC 0x1E,2
	RJMP _0x241
	SBIC 0x1E,3
	RJMP _0x241
	SBIS 0x2,5
	RJMP _0x240
_0x241:
	LDS  R30,_pbit_result
	ORI  R30,0x80
	RJMP _0x408
_0x240:
	LDS  R30,_pbit_result
	ANDI R30,0x7F
_0x408:
	STS  _pbit_result,R30
; 0000 09FF  if(ge_err_act == ERR){pbit_result |= 0x20;}else{pbit_result &= ~0x20;}
	LDS  R26,_ge_err_act
	CPI  R26,LOW(0x1)
	BRNE _0x244
	ORI  R30,0x20
	RJMP _0x409
_0x244:
	LDS  R30,_pbit_result
	ANDI R30,0xDF
_0x409:
	STS  _pbit_result,R30
; 0000 0A00  if((err_bat2_volt == 1)||(err_bat2_temp == 1)||(err_bat2_curr == 1)){pbit_result |= 0x10;}else{pbit_result &= ~0x10;}
	LDS  R26,_err_bat2_volt
	CPI  R26,LOW(0x1)
	BREQ _0x247
	LDS  R26,_err_bat2_temp
	CPI  R26,LOW(0x1)
	BREQ _0x247
	LDS  R26,_err_bat2_curr
	CPI  R26,LOW(0x1)
	BRNE _0x246
_0x247:
	LDS  R30,_pbit_result
	ORI  R30,0x10
	RJMP _0x40A
_0x246:
	LDS  R30,_pbit_result
	ANDI R30,0xEF
_0x40A:
	STS  _pbit_result,R30
; 0000 0A01  if((err_bat1_volt == 1)||(err_bat1_temp == 1)||(err_bat1_curr == 1)){pbit_result |= 0x08;}else{pbit_result &= ~0x08;}
	LDS  R26,_err_bat1_volt
	CPI  R26,LOW(0x1)
	BREQ _0x24B
	LDS  R26,_err_bat1_temp
	CPI  R26,LOW(0x1)
	BREQ _0x24B
	LDS  R26,_err_bat1_curr
	CPI  R26,LOW(0x1)
	BRNE _0x24A
_0x24B:
	LDS  R30,_pbit_result
	ORI  R30,8
	RJMP _0x40B
_0x24A:
	LDS  R30,_pbit_result
	ANDI R30,0XF7
_0x40B:
	STS  _pbit_result,R30
; 0000 0A02  if(power_2_err == 1){pbit_result |= 0x04;}else{pbit_result &= ~0x04;}
	LDS  R26,_power_2_err
	CPI  R26,LOW(0x1)
	BRNE _0x24E
	ORI  R30,4
	RJMP _0x40C
_0x24E:
	LDS  R30,_pbit_result
	ANDI R30,0xFB
_0x40C:
	STS  _pbit_result,R30
; 0000 0A03  if(power_1_err == 1){pbit_result |= 0x02;}else{pbit_result &= ~0x02;}
	LDS  R26,_power_1_err
	CPI  R26,LOW(0x1)
	BRNE _0x250
	ORI  R30,2
	RJMP _0x40D
_0x250:
	LDS  R30,_pbit_result
	ANDI R30,0xFD
_0x40D:
	STS  _pbit_result,R30
; 0000 0A04  if(deiver_48_err == ERR){pbit_result |= 0x01;}else{pbit_result &= ~0x01;}
	LDS  R26,_deiver_48_err
	CPI  R26,LOW(0x1)
	BRNE _0x252
	ORI  R30,1
	RJMP _0x40E
_0x252:
	LDS  R30,_pbit_result
	ANDI R30,0xFE
_0x40E:
	STS  _pbit_result,R30
; 0000 0A05 
; 0000 0A06  putchar1(pobit_result);//pobit결과
	LDS  R26,_pobit_result
	CALL _putchar1
; 0000 0A07  if(PoBITResult_number >= 0xff){PoBITResult_number = 0;}else{PoBITResult_number++;}
	LDS  R26,_PoBITResult_number
	CPI  R26,LOW(0xFF)
	BRLO _0x254
	LDI  R30,LOW(0)
	RJMP _0x40F
_0x254:
	LDS  R30,_PoBITResult_number
	SUBI R30,-LOW(1)
_0x40F:
	STS  _PoBITResult_number,R30
; 0000 0A08  Distributor_PoBIT_act= 0;
	LDI  R30,LOW(0)
	STS  _Distributor_PoBIT_act,R30
; 0000 0A09 }
	RET
; .FEND
;
;void Response_Distributor_BITDetailResponse(void)
; 0000 0A0C {
_Response_Distributor_BITDetailResponse:
; .FSTART _Response_Distributor_BITDetailResponse
; 0000 0A0D  putchar1(0x38); //type
	LDI  R26,LOW(56)
	CALL _putchar1
; 0000 0A0E  putchar1(0x02); //id
	LDI  R26,LOW(2)
	CALL SUBOPT_0x28
; 0000 0A0F  putchar1(0x28); //sol_data
; 0000 0A10  putchar1(0x20); //dest_data
; 0000 0A11  putchar1(Distributor_BITBetailResponse_number);
	LDS  R26,_Distributor_BITBetailResponse_number
	CALL SUBOPT_0x29
; 0000 0A12  putchar1(0x24); //tm
; 0000 0A13  putchar1(0x02); //length 1
	LDI  R26,LOW(2)
	CALL SUBOPT_0x2C
; 0000 0A14  putchar1(0x00); //length 2
; 0000 0A15  //통신상태
; 0000 0A16  //bit 5 reserve
; 0000 0A17 // if(gen_err  == 1){pbit_result |= 0x20;}else{pbit_result &= ~0x20;}//5
; 0000 0A18 // if(batt_link_err_act_2 == 1){pbit_result |= 0x10;}else{pbit_result &= ~0x10;}
; 0000 0A19 // if(batt_link_err_act_1 == 1){pbit_result |= 0x08;}else{pbit_result &= ~0x08;}
; 0000 0A1A // if(power_link2_err == 1){pbit_result |= 0x04;}else{pbit_result &= ~0x04;}
; 0000 0A1B // if(power_link1_err == 1){pbit_result |= 0x02;}else{pbit_result &= ~0x02;}
; 0000 0A1C // if(DT_ERR == 1){pbit_result |= 0x01;}else{pbit_result &= ~0x01;}
; 0000 0A1D  putchar1(po_bit_recive_data_detail);//pobit결과
	LDS  R26,_po_bit_recive_data_detail
	CALL _putchar1
; 0000 0A1E 
; 0000 0A1F // //데이터 초기화
; 0000 0A20 // link_err_detail = 0x00;
; 0000 0A21 // div_err_detail = 0x00;
; 0000 0A22 // power_1_err_detail = 0x00;
; 0000 0A23 // power_2_err_detail = 0x00;
; 0000 0A24 // bat_1_err_detail = 0x00;
; 0000 0A25 // bat_2_err_detail = 0x00;
; 0000 0A26 // gen_err_detail = 0x00;
; 0000 0A27 
; 0000 0A28  //*****************
; 0000 0A29  //에러 데이터 정렬
; 0000 0A2A  //*****************
; 0000 0A2B 
; 0000 0A2C  //링크에러
; 0000 0A2D // link_err_detail = 0x00;
; 0000 0A2E 
; 0000 0A2F  if(comm_ge_err == ERR){link_err_detail |= 0x20;}else{link_err_detail &= ~0x20;} //발전기 링크 에러
	SBRS R2,0
	RJMP _0x256
	CALL SUBOPT_0x2F
	ORI  R30,0x20
	RJMP _0x410
_0x256:
	CALL SUBOPT_0x2F
	ANDI R30,LOW(0xFFDF)
_0x410:
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A30  if(batt_link_err_act_2 == ERR){link_err_detail |= 0x10;}else{link_err_detail &= ~0x10;} //배터리1 링크 에러
	SBIS 0x1E,3
	RJMP _0x258
	CALL SUBOPT_0x2F
	ORI  R30,0x10
	RJMP _0x411
_0x258:
	CALL SUBOPT_0x2F
	ANDI R30,LOW(0xFFEF)
_0x411:
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A31  if(batt_link_err_act_1 == ERR){link_err_detail |= 0x08;}else{link_err_detail &= ~0x08;} //배터리2 링크 에러
	SBIS 0x1E,2
	RJMP _0x25A
	CALL SUBOPT_0x2F
	ORI  R30,8
	RJMP _0x412
_0x25A:
	CALL SUBOPT_0x2F
	ANDI R30,LOW(0xFFF7)
_0x412:
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A32  if((power_link_2 & 0x80) != 0x80){link_err_detail |= 0x04;}else{link_err_detail &= ~0x04;} //전원반1 링크 에러
	LDS  R30,_power_link_2
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BREQ _0x25C
	CALL SUBOPT_0x2F
	ORI  R30,4
	RJMP _0x413
_0x25C:
	CALL SUBOPT_0x2F
	ANDI R30,LOW(0xFFFB)
_0x413:
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A33  if((power_link_1 & 0x80) != 0x80){link_err_detail |= 0x02;}else{link_err_detail &= ~0x02;} //전원반2 링크 에러
	LDS  R30,_power_link_1
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BREQ _0x25E
	CALL SUBOPT_0x2F
	ORI  R30,2
	RJMP _0x414
_0x25E:
	CALL SUBOPT_0x2F
	ANDI R30,LOW(0xFFFD)
_0x414:
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A34  if((comm_err == 1)||(dt_err_act == 1)){link_err_detail |= 0x01;}else{link_err_detail &= ~0x01;} //분배기 링크 에러
	SBIC 0x1E,7
	RJMP _0x261
	SBIS 0x1E,6
	RJMP _0x260
_0x261:
	CALL SUBOPT_0x2F
	ORI  R30,1
	RJMP _0x415
_0x260:
	CALL SUBOPT_0x2F
	ANDI R30,LOW(0xFFFE)
_0x415:
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A35 
; 0000 0A36  //발전기
; 0000 0A37  if(comm_ge_err == ERR)
	SBRS R2,0
	RJMP _0x264
; 0000 0A38  {
; 0000 0A39   gen_err_detail = 0x00;
	LDI  R30,LOW(0)
	RJMP _0x416
; 0000 0A3A  }
; 0000 0A3B  else
_0x264:
; 0000 0A3C  {
; 0000 0A3D  if((ge_err_data & 0x10) == 0x10){gen_err_detail |= 0x10;}else{gen_err_detail &= ~0x10;} //발전기 오일 압력
	LDS  R30,_ge_err_data
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x266
	LDS  R30,_gen_err_detail
	ORI  R30,0x10
	RJMP _0x417
_0x266:
	LDS  R30,_gen_err_detail
	ANDI R30,0xEF
_0x417:
	STS  _gen_err_detail,R30
; 0000 0A3E  if((ge_err_data & 0x08) == 0x08){gen_err_detail |= 0x08;}else{gen_err_detail &= ~0x08;} //발전기 과속도
	LDS  R30,_ge_err_data
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x268
	LDS  R30,_gen_err_detail
	ORI  R30,8
	RJMP _0x418
_0x268:
	LDS  R30,_gen_err_detail
	ANDI R30,0XF7
_0x418:
	STS  _gen_err_detail,R30
; 0000 0A3F  if((ge_err_data & 0x04) == 0x04){gen_err_detail |= 0x04;}else{gen_err_detail &= ~0x04;} //발전기 엔진과온도
	LDS  R30,_ge_err_data
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x26A
	LDS  R30,_gen_err_detail
	ORI  R30,4
	RJMP _0x419
_0x26A:
	LDS  R30,_gen_err_detail
	ANDI R30,0xFB
_0x419:
	STS  _gen_err_detail,R30
; 0000 0A40  if((ge_err_data & 0x02) == 0x02){gen_err_detail |= 0x02;}else{gen_err_detail &= ~0x02;} //발전기 전압이상
	LDS  R30,_ge_err_data
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x26C
	LDS  R30,_gen_err_detail
	ORI  R30,2
	RJMP _0x41A
_0x26C:
	LDS  R30,_gen_err_detail
	ANDI R30,0xFD
_0x41A:
	STS  _gen_err_detail,R30
; 0000 0A41  if((ge_err_data & 0x01) == 0x01){gen_err_detail |= 0x01;}else{gen_err_detail &= ~0x01;} //발전기 과전류
	LDS  R30,_ge_err_data
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x26E
	LDS  R30,_gen_err_detail
	ORI  R30,1
	RJMP _0x416
_0x26E:
	LDS  R30,_gen_err_detail
	ANDI R30,0xFE
_0x416:
	STS  _gen_err_detail,R30
; 0000 0A42  }
; 0000 0A43 
; 0000 0A44   //배터리2
; 0000 0A45  if(err_bat2_temp == 1){bat_2_err_detail |= 0x04;}else{bat_2_err_detail &= ~0x04;} //batt 온도 불량
	LDS  R26,_err_bat2_temp
	CPI  R26,LOW(0x1)
	BRNE _0x270
	LDS  R30,_bat_2_err_detail
	ORI  R30,4
	RJMP _0x41B
_0x270:
	LDS  R30,_bat_2_err_detail
	ANDI R30,0xFB
_0x41B:
	STS  _bat_2_err_detail,R30
; 0000 0A46  if(err_bat2_curr == 1){bat_2_err_detail |= 0x02;}else{bat_2_err_detail &= ~0x02;} //batt 전류 불량
	LDS  R26,_err_bat2_curr
	CPI  R26,LOW(0x1)
	BRNE _0x272
	ORI  R30,2
	RJMP _0x41C
_0x272:
	LDS  R30,_bat_2_err_detail
	ANDI R30,0xFD
_0x41C:
	STS  _bat_2_err_detail,R30
; 0000 0A47  if(err_bat2_volt == 1){bat_2_err_detail |= 0x01;}else{bat_2_err_detail &= ~0x01;} //batt 전압 불량
	LDS  R26,_err_bat2_volt
	CPI  R26,LOW(0x1)
	BRNE _0x274
	ORI  R30,1
	RJMP _0x41D
_0x274:
	LDS  R30,_bat_2_err_detail
	ANDI R30,0xFE
_0x41D:
	STS  _bat_2_err_detail,R30
; 0000 0A48 
; 0000 0A49 // if((err_main_2 & 0x40) == 0x40){bat_2_err_detail |= 0x04;}else{bat_1_err_detail &= ~0x04;} //batt 온도 불량
; 0000 0A4A // if((err_main_2 & 0x08) == 0x08){bat_2_err_detail |= 0x02;}else{bat_1_err_detail &= ~0x02;} //batt 전류 불량
; 0000 0A4B // if((err_main_2 & 0x10) == 0x10){bat_2_err_detail |= 0x01;}else{bat_1_err_detail &= ~0x01;} //batt 전압 불량
; 0000 0A4C 
; 0000 0A4D  //배터리1
; 0000 0A4E  if(err_bat1_temp == 1){bat_1_err_detail |= 0x04;}else{bat_1_err_detail &= ~0x04;} //batt 온도 불량
	LDS  R26,_err_bat1_temp
	CPI  R26,LOW(0x1)
	BRNE _0x276
	LDS  R30,_bat_1_err_detail
	ORI  R30,4
	RJMP _0x41E
_0x276:
	LDS  R30,_bat_1_err_detail
	ANDI R30,0xFB
_0x41E:
	STS  _bat_1_err_detail,R30
; 0000 0A4F  if(err_bat1_curr == 1){bat_1_err_detail |= 0x02;}else{bat_1_err_detail &= ~0x02;} //batt 전류 불량
	LDS  R26,_err_bat1_curr
	CPI  R26,LOW(0x1)
	BRNE _0x278
	ORI  R30,2
	RJMP _0x41F
_0x278:
	LDS  R30,_bat_1_err_detail
	ANDI R30,0xFD
_0x41F:
	STS  _bat_1_err_detail,R30
; 0000 0A50  if(err_bat1_volt == 1){bat_1_err_detail |= 0x01;}else{bat_1_err_detail &= ~0x01;} //batt 전압 불량
	LDS  R26,_err_bat1_volt
	CPI  R26,LOW(0x1)
	BRNE _0x27A
	ORI  R30,1
	RJMP _0x420
_0x27A:
	LDS  R30,_bat_1_err_detail
	ANDI R30,0xFE
_0x420:
	STS  _bat_1_err_detail,R30
; 0000 0A51 
; 0000 0A52 
; 0000 0A53 // if((err_main_1 & 0x40) == 0x40){bat_1_err_detail |= 0x04;}else{bat_1_err_detail &= ~0x04;} //batt 온도 불량
; 0000 0A54 // if((err_main_1 & 0x08) == 0x08){bat_1_err_detail |= 0x02;}else{bat_1_err_detail &= ~0x02;} //batt 전류 불량
; 0000 0A55 // if((err_main_1 & 0x10) == 0x10){bat_1_err_detail |= 0x01;}else{bat_1_err_detail &= ~0x01;} //batt 전압 불량
; 0000 0A56 
; 0000 0A57  //전원반 2 에러
; 0000 0A58   if((err_main_2 & 0x80)==0x80){power_2_err_detail = 0x01;}else{power_2_err_detail = 0x00;}  //전원반2이 하나라도 에러만 ...
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x27C
	LDI  R30,LOW(1)
	RJMP _0x421
_0x27C:
	LDI  R30,LOW(0)
_0x421:
	STS  _power_2_err_detail,R30
; 0000 0A59 // if((power_link_2 & 0x80) != 0x80){power_2_err_detail = 0x01;}else{power_2_err_detail = 0x00;}
; 0000 0A5A 
; 0000 0A5B  //전원반 1 에러
; 0000 0A5C    if((err_main_1 & 0x80)==0x80){power_1_err_detail = 0x01;}else{power_1_err_detail = 0x00;}  //전원반1이 하나라도 에러� ...
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x27E
	LDI  R30,LOW(1)
	RJMP _0x422
_0x27E:
	LDI  R30,LOW(0)
_0x422:
	STS  _power_1_err_detail,R30
; 0000 0A5D //  if((power_link_1 & 0x80)!=0x80){power_1_err_detail = 0x01;}else{power_1_err_detail = 0x00;}  //전원반1이 하나라도 에 ...
; 0000 0A5E 
; 0000 0A5F  //분배기 에러
; 0000 0A60  if(deiver_48_err == ERR){div_err_detail = 0x01;}else{div_err_detail = 0x00;}
	LDS  R26,_deiver_48_err
	CPI  R26,LOW(0x1)
	BRNE _0x280
	LDI  R30,LOW(1)
	RJMP _0x423
_0x280:
	LDI  R30,LOW(0)
_0x423:
	STS  _div_err_detail,R30
; 0000 0A61 
; 0000 0A62  //*****************
; 0000 0A63  //시험용 데이터 출력
; 0000 0A64  //****************
; 0000 0A65  if(ADDRESS_2 == 0)
	LDS  R30,259
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BREQ _0x282
; 0000 0A66  {
; 0000 0A67      link_err_detail = 0x80;
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	STS  _link_err_detail,R30
	STS  _link_err_detail+1,R31
; 0000 0A68      gen_err_detail = 0x20;
	LDI  R30,LOW(32)
	STS  _gen_err_detail,R30
; 0000 0A69      bat_2_err_detail = 0x10;
	LDI  R30,LOW(16)
	STS  _bat_2_err_detail,R30
; 0000 0A6A      bat_1_err_detail = 0x08;
	LDI  R30,LOW(8)
	STS  _bat_1_err_detail,R30
; 0000 0A6B      power_2_err_detail = 0x04;
	LDI  R30,LOW(4)
	STS  _power_2_err_detail,R30
; 0000 0A6C      power_1_err_detail = 0x02;
	LDI  R30,LOW(2)
	STS  _power_1_err_detail,R30
; 0000 0A6D      div_err_detail = 0x01;
	LDI  R30,LOW(1)
	STS  _div_err_detail,R30
; 0000 0A6E  }
; 0000 0A6F 
; 0000 0A70 
; 0000 0A71  //reserve
; 0000 0A72  if((po_bit_recive_data_detail & 0x80) == 0x80){putchar1(link_err_detail);} //link connection    임무처리기 고장(1)
_0x282:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x283
	LDS  R26,_link_err_detail
	CALL _putchar1
; 0000 0A73  if((po_bit_recive_data_detail & 0x20) == 0x20){putchar1(gen_err_detail);} //general device 발전기 오일압력(4) 엔진 과속 ...
_0x283:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x20)
	CPI  R30,LOW(0x20)
	BRNE _0x284
	LDS  R26,_gen_err_detail
	CALL _putchar1
; 0000 0A74  if((po_bit_recive_data_detail & 0x10) == 0x10){putchar1(bat_2_err_detail);} //nattery device #2 배터리2 온도(2) 전류(1) ...
_0x284:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x285
	LDS  R26,_bat_2_err_detail
	CALL _putchar1
; 0000 0A75  if((po_bit_recive_data_detail & 0x08) == 0x08){putchar1(bat_1_err_detail);} //battery device #1 배터리1 온도(2) 전류(1) ...
_0x285:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE _0x286
	LDS  R26,_bat_1_err_detail
	CALL _putchar1
; 0000 0A76  if((po_bit_recive_data_detail & 0x04) == 0x04){putchar1(power_2_err_detail);} //power device#2  전원공급기2 고장(1)
_0x286:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE _0x287
	LDS  R26,_power_2_err_detail
	CALL _putchar1
; 0000 0A77  if((po_bit_recive_data_detail & 0x02) == 0x02){putchar1(power_1_err_detail);} //power device#1  전원공급기1 고장(1)
_0x287:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE _0x288
	LDS  R26,_power_1_err_detail
	CALL _putchar1
; 0000 0A78  if((po_bit_recive_data_detail & 0x01) == 0x01){putchar1(div_err_detail);} //배전기 상태   배전기 상태 고장(1)
_0x288:
	LDS  R30,_po_bit_recive_data_detail
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x289
	LDS  R26,_div_err_detail
	CALL _putchar1
; 0000 0A79 
; 0000 0A7A  if(Distributor_BITBetailResponse_number >= 0xff){Distributor_BITBetailResponse_number = 0;}else{Distributor_BITBetailRe ...
_0x289:
	LDS  R26,_Distributor_BITBetailResponse_number
	CPI  R26,LOW(0xFF)
	BRLO _0x28A
	LDI  R30,LOW(0)
	RJMP _0x424
_0x28A:
	LDS  R30,_Distributor_BITBetailResponse_number
	SUBI R30,-LOW(1)
_0x424:
	STS  _Distributor_BITBetailResponse_number,R30
; 0000 0A7B  Distributor_BITDetailResponse_act = 0;
	LDI  R30,LOW(0)
	STS  _Distributor_BITDetailResponse_act,R30
; 0000 0A7C }
	RET
; .FEND
;
;void Report_Distributor_DeviceStatus(void) //장치 상태 출력 10hz 주기적
; 0000 0A7F {
_Report_Distributor_DeviceStatus:
; .FSTART _Report_Distributor_DeviceStatus
; 0000 0A80  putchar1(0x38); //type
	LDI  R26,LOW(56)
	CALL _putchar1
; 0000 0A81  putchar1(0xf6); //id
	LDI  R26,LOW(246)
	CALL SUBOPT_0x28
; 0000 0A82  putchar1(0x28); //sol_data
; 0000 0A83  putchar1(0x20); //dest_data
; 0000 0A84  putchar1(Distributor_devicestatus_number);
	LDS  R26,_Distributor_devicestatus_number
	CALL SUBOPT_0x29
; 0000 0A85  putchar1(0x24); //tm
; 0000 0A86  putchar1(0x2a); //length 1
	LDI  R26,LOW(42)
	CALL SUBOPT_0x2C
; 0000 0A87  putchar1(0x00); //length 2 //39바이트
; 0000 0A88 
; 0000 0A89  //switch_상태 사용 전원 구분
; 0000 0A8A  if((batt_run_act_1 == ON)||(batt_run_act_2 == ON))
	SBIC 0x1E,4
	RJMP _0x28D
	SBIS 0x1E,5
	RJMP _0x28C
_0x28D:
; 0000 0A8B  {
; 0000 0A8C   putchar1(0x04);
	LDI  R26,LOW(4)
	RJMP _0x425
; 0000 0A8D  }
; 0000 0A8E  else
_0x28C:
; 0000 0A8F  {
; 0000 0A90   putchar1(sw_status);//배터리(2) 외부전원(1) 발전기(0)
	LDS  R26,_sw_status
_0x425:
	CALL _putchar1
; 0000 0A91  }
; 0000 0A92  //****************
; 0000 0A93  //시험용 데이터 출력
; 0000 0A94  //****************
; 0000 0A95  if(ADDRESS_1 == 0)
	LDS  R30,259
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE PC+2
	RJMP _0x290
; 0000 0A96  {
; 0000 0A97   voltage_ge = 450;
	LDI  R30,LOW(450)
	LDI  R31,HIGH(450)
	STS  _voltage_ge,R30
	STS  _voltage_ge+1,R31
; 0000 0A98   currunt_ge = 100;
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _currunt_ge,R30
	STS  _currunt_ge+1,R31
; 0000 0A99 
; 0000 0A9A   voltage_m24_1 = 280;
	LDI  R30,LOW(280)
	LDI  R31,HIGH(280)
	STS  _voltage_m24_1,R30
	STS  _voltage_m24_1+1,R31
; 0000 0A9B   currunt_1 = 101;
	LDI  R30,LOW(101)
	LDI  R31,HIGH(101)
	CALL SUBOPT_0x3
; 0000 0A9C 
; 0000 0A9D   voltage_m24_2 = 280;
	LDI  R30,LOW(280)
	LDI  R31,HIGH(280)
	STS  _voltage_m24_2,R30
	STS  _voltage_m24_2+1,R31
; 0000 0A9E   currunt_2 = 102;
	LDI  R30,LOW(102)
	LDI  R31,HIGH(102)
	CALL SUBOPT_0x6
; 0000 0A9F 
; 0000 0AA0   voltage_ch1_1 = 281;
	LDI  R30,LOW(281)
	LDI  R31,HIGH(281)
	STS  _voltage_ch1_1,R30
	STS  _voltage_ch1_1+1,R31
; 0000 0AA1   voltage_ch2_1 = 282;
	LDI  R30,LOW(282)
	LDI  R31,HIGH(282)
	STS  _voltage_ch2_1,R30
	STS  _voltage_ch2_1+1,R31
; 0000 0AA2   voltage_ch3_1 = 283;
	LDI  R30,LOW(283)
	LDI  R31,HIGH(283)
	STS  _voltage_ch3_1,R30
	STS  _voltage_ch3_1+1,R31
; 0000 0AA3   voltage_ch4_1 = 284;
	LDI  R30,LOW(284)
	LDI  R31,HIGH(284)
	STS  _voltage_ch4_1,R30
	STS  _voltage_ch4_1+1,R31
; 0000 0AA4   voltage_ch5_1 = 285;
	LDI  R30,LOW(285)
	LDI  R31,HIGH(285)
	STS  _voltage_ch5_1,R30
	STS  _voltage_ch5_1+1,R31
; 0000 0AA5   voltage_ch6_1 = 286;
	LDI  R30,LOW(286)
	LDI  R31,HIGH(286)
	STS  _voltage_ch6_1,R30
	STS  _voltage_ch6_1+1,R31
; 0000 0AA6   voltage_ch7_1 = 287;
	LDI  R30,LOW(287)
	LDI  R31,HIGH(287)
	STS  _voltage_ch7_1,R30
	STS  _voltage_ch7_1+1,R31
; 0000 0AA7 
; 0000 0AA8   voltage_ch1_2 = 281;
	LDI  R30,LOW(281)
	LDI  R31,HIGH(281)
	STS  _voltage_ch1_2,R30
	STS  _voltage_ch1_2+1,R31
; 0000 0AA9   voltage_ch2_2 = 282;
	LDI  R30,LOW(282)
	LDI  R31,HIGH(282)
	STS  _voltage_ch2_2,R30
	STS  _voltage_ch2_2+1,R31
; 0000 0AAA   voltage_ch3_2 = 283;
	LDI  R30,LOW(283)
	LDI  R31,HIGH(283)
	STS  _voltage_ch3_2,R30
	STS  _voltage_ch3_2+1,R31
; 0000 0AAB   voltage_ch4_2 = 284;
	LDI  R30,LOW(284)
	LDI  R31,HIGH(284)
	STS  _voltage_ch4_2,R30
	STS  _voltage_ch4_2+1,R31
; 0000 0AAC   voltage_ch5_2 = 285;
	LDI  R30,LOW(285)
	LDI  R31,HIGH(285)
	STS  _voltage_ch5_2,R30
	STS  _voltage_ch5_2+1,R31
; 0000 0AAD   voltage_ch6_2 = 286;
	LDI  R30,LOW(286)
	LDI  R31,HIGH(286)
	STS  _voltage_ch6_2,R30
	STS  _voltage_ch6_2+1,R31
; 0000 0AAE   voltage_ch7_2 = 287;
	LDI  R30,LOW(287)
	LDI  R31,HIGH(287)
	STS  _voltage_ch7_2,R30
	STS  _voltage_ch7_2+1,R31
; 0000 0AAF 
; 0000 0AB0   currunt_ch1_1 = 151;
	LDI  R30,LOW(151)
	LDI  R31,HIGH(151)
	STS  _currunt_ch1_1,R30
	STS  _currunt_ch1_1+1,R31
; 0000 0AB1   currunt_ch2_1 = 152;
	LDI  R30,LOW(152)
	LDI  R31,HIGH(152)
	STS  _currunt_ch2_1,R30
	STS  _currunt_ch2_1+1,R31
; 0000 0AB2   currunt_ch3_1 = 153;
	LDI  R30,LOW(153)
	LDI  R31,HIGH(153)
	STS  _currunt_ch3_1,R30
	STS  _currunt_ch3_1+1,R31
; 0000 0AB3   currunt_ch4_1 = 154;
	LDI  R30,LOW(154)
	LDI  R31,HIGH(154)
	STS  _currunt_ch4_1,R30
	STS  _currunt_ch4_1+1,R31
; 0000 0AB4   currunt_ch5_1 = 155;
	LDI  R30,LOW(155)
	LDI  R31,HIGH(155)
	STS  _currunt_ch5_1,R30
	STS  _currunt_ch5_1+1,R31
; 0000 0AB5   currunt_ch6_1 = 156;
	LDI  R30,LOW(156)
	LDI  R31,HIGH(156)
	STS  _currunt_ch6_1,R30
	STS  _currunt_ch6_1+1,R31
; 0000 0AB6   currunt_ch7_1 = 157;
	LDI  R30,LOW(157)
	LDI  R31,HIGH(157)
	STS  _currunt_ch7_1,R30
	STS  _currunt_ch7_1+1,R31
; 0000 0AB7 
; 0000 0AB8   currunt_ch1_2 = 151;
	LDI  R30,LOW(151)
	LDI  R31,HIGH(151)
	STS  _currunt_ch1_2,R30
	STS  _currunt_ch1_2+1,R31
; 0000 0AB9   currunt_ch2_2 = 152;
	LDI  R30,LOW(152)
	LDI  R31,HIGH(152)
	STS  _currunt_ch2_2,R30
	STS  _currunt_ch2_2+1,R31
; 0000 0ABA   currunt_ch3_2 = 153;
	LDI  R30,LOW(153)
	LDI  R31,HIGH(153)
	STS  _currunt_ch3_2,R30
	STS  _currunt_ch3_2+1,R31
; 0000 0ABB   currunt_ch4_2 = 154;
	LDI  R30,LOW(154)
	LDI  R31,HIGH(154)
	STS  _currunt_ch4_2,R30
	STS  _currunt_ch4_2+1,R31
; 0000 0ABC   currunt_ch5_2 = 155;
	LDI  R30,LOW(155)
	LDI  R31,HIGH(155)
	STS  _currunt_ch5_2,R30
	STS  _currunt_ch5_2+1,R31
; 0000 0ABD   currunt_ch6_2 = 156;
	LDI  R30,LOW(156)
	LDI  R31,HIGH(156)
	STS  _currunt_ch6_2,R30
	STS  _currunt_ch6_2+1,R31
; 0000 0ABE   currunt_ch7_2 = 157;
	LDI  R30,LOW(157)
	LDI  R31,HIGH(157)
	STS  _currunt_ch7_2,R30
	STS  _currunt_ch7_2+1,R31
; 0000 0ABF 
; 0000 0AC0   batt_level_1 = 40;
	LDI  R30,LOW(40)
	STS  _batt_level_1,R30
; 0000 0AC1   batt_level_2 = 80;
	LDI  R30,LOW(80)
	STS  _batt_level_2,R30
; 0000 0AC2  }
; 0000 0AC3 
; 0000 0AC4 
; 0000 0AC5 
; 0000 0AC6  //전원공급기 #1 전압 전류
; 0000 0AC7  if((voltage_m24_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_m24_1 - 150);}else{putchar1(0x00);}    // current1
_0x290:
	LDS  R26,_voltage_m24_1
	LDS  R27,_voltage_m24_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x292
	SBIS 0x2,5
	RJMP _0x293
_0x292:
	RJMP _0x291
_0x293:
	LDS  R26,_voltage_m24_1
	SUBI R26,LOW(150)
	RJMP _0x426
_0x291:
	LDI  R26,LOW(0)
_0x426:
	CALL _putchar1
; 0000 0AC8  if(DT_ERR == NOR)
	SBIC 0x2,5
	RJMP _0x295
; 0000 0AC9  {
; 0000 0ACA  putchar1(currunt_2%256);
	LDS  R30,_currunt_2
	MOV  R26,R30
	CALL _putchar1
; 0000 0ACB  putchar1(currunt_2/256);
	LDS  R30,_currunt_2+1
	MOV  R26,R30
	RJMP _0x427
; 0000 0ACC  }
; 0000 0ACD  else
_0x295:
; 0000 0ACE  {
; 0000 0ACF  putchar1(0x00);
	LDI  R26,LOW(0)
	CALL _putchar1
; 0000 0AD0  putchar1(0x00);
	LDI  R26,LOW(0)
_0x427:
	CALL _putchar1
; 0000 0AD1  }
; 0000 0AD2 
; 0000 0AD3 
; 0000 0AD4  //전원공급기 #2 전압 전류
; 0000 0AD5  if((voltage_m24_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_m24_2 - 150);}else{putchar1(0x00);}     // current2
	LDS  R26,_voltage_m24_2
	LDS  R27,_voltage_m24_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x298
	SBIS 0x2,5
	RJMP _0x299
_0x298:
	RJMP _0x297
_0x299:
	LDS  R26,_voltage_m24_2
	SUBI R26,LOW(150)
	RJMP _0x428
_0x297:
	LDI  R26,LOW(0)
_0x428:
	CALL _putchar1
; 0000 0AD6   if(DT_ERR == NOR)
	SBIC 0x2,5
	RJMP _0x29B
; 0000 0AD7   {
; 0000 0AD8   putchar1(currunt_1%256);
	LDS  R30,_currunt_1
	MOV  R26,R30
	CALL _putchar1
; 0000 0AD9   putchar1(currunt_1/256);
	LDS  R30,_currunt_1+1
	MOV  R26,R30
	RJMP _0x429
; 0000 0ADA   }
; 0000 0ADB   else
_0x29B:
; 0000 0ADC   {
; 0000 0ADD   putchar1(0x00);
	LDI  R26,LOW(0)
	CALL _putchar1
; 0000 0ADE   putchar1(0x00);
	LDI  R26,LOW(0)
_0x429:
	CALL _putchar1
; 0000 0ADF   }
; 0000 0AE0 
; 0000 0AE1  //MCU POWER
; 0000 0AE2  if((voltage_ch1_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch1_2 - 150);}else{putchar1(0x00);}   //1-2  7-1
	LDS  R26,_voltage_ch1_2
	LDS  R27,_voltage_ch1_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x29E
	SBIS 0x2,5
	RJMP _0x29F
_0x29E:
	RJMP _0x29D
_0x29F:
	LDS  R26,_voltage_ch1_2
	SUBI R26,LOW(150)
	RJMP _0x42A
_0x29D:
	LDI  R26,LOW(0)
_0x42A:
	CALL _putchar1
; 0000 0AE3 
; 0000 0AE4   if(DT_ERR == NOR){putchar1(currunt_ch1_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2A1
	LDS  R26,_currunt_ch1_2
	RJMP _0x42B
_0x2A1:
	LDI  R26,LOW(0)
_0x42B:
	CALL _putchar1
; 0000 0AE5 
; 0000 0AE6  //OPU1 POWER
; 0000 0AE7  if((voltage_ch2_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch2_2 - 150);}else{putchar1(0x00);}  //2-2 6-1
	LDS  R26,_voltage_ch2_2
	LDS  R27,_voltage_ch2_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2A4
	SBIS 0x2,5
	RJMP _0x2A5
_0x2A4:
	RJMP _0x2A3
_0x2A5:
	LDS  R26,_voltage_ch2_2
	SUBI R26,LOW(150)
	RJMP _0x42C
_0x2A3:
	LDI  R26,LOW(0)
_0x42C:
	CALL _putchar1
; 0000 0AE8   if(DT_ERR == NOR){putchar1(currunt_ch2_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2A7
	LDS  R26,_currunt_ch2_2
	RJMP _0x42D
_0x2A7:
	LDI  R26,LOW(0)
_0x42D:
	CALL _putchar1
; 0000 0AE9 
; 0000 0AEA  //ODU1 POWER
; 0000 0AEB  if((voltage_ch1_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch1_1 - 150);}else{putchar1(0x00);}  //1-1 7-2
	LDS  R26,_voltage_ch1_1
	LDS  R27,_voltage_ch1_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2AA
	SBIS 0x2,5
	RJMP _0x2AB
_0x2AA:
	RJMP _0x2A9
_0x2AB:
	LDS  R26,_voltage_ch1_1
	SUBI R26,LOW(150)
	RJMP _0x42E
_0x2A9:
	LDI  R26,LOW(0)
_0x42E:
	CALL _putchar1
; 0000 0AEC   if(DT_ERR == NOR){putchar1(currunt_ch1_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2AD
	LDS  R26,_currunt_ch1_1
	RJMP _0x42F
_0x2AD:
	LDI  R26,LOW(0)
_0x42F:
	CALL _putchar1
; 0000 0AED 
; 0000 0AEE  //OCU1 POWER
; 0000 0AEF  if((voltage_ch2_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch2_1 - 150);}else{putchar1(0x00);}  //2-1 6-2
	LDS  R26,_voltage_ch2_1
	LDS  R27,_voltage_ch2_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2B0
	SBIS 0x2,5
	RJMP _0x2B1
_0x2B0:
	RJMP _0x2AF
_0x2B1:
	LDS  R26,_voltage_ch2_1
	SUBI R26,LOW(150)
	RJMP _0x430
_0x2AF:
	LDI  R26,LOW(0)
_0x430:
	CALL _putchar1
; 0000 0AF0   if(DT_ERR == NOR){ putchar1(currunt_ch2_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2B3
	LDS  R26,_currunt_ch2_1
	RJMP _0x431
_0x2B3:
	LDI  R26,LOW(0)
_0x431:
	CALL _putchar1
; 0000 0AF1 
; 0000 0AF2  //OPU2 POWER
; 0000 0AF3  if((voltage_ch6_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch6_2 - 150);}else{putchar1(0x00);}  // 6-2 2-1
	LDS  R26,_voltage_ch6_2
	LDS  R27,_voltage_ch6_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2B6
	SBIS 0x2,5
	RJMP _0x2B7
_0x2B6:
	RJMP _0x2B5
_0x2B7:
	LDS  R26,_voltage_ch6_2
	SUBI R26,LOW(150)
	RJMP _0x432
_0x2B5:
	LDI  R26,LOW(0)
_0x432:
	CALL _putchar1
; 0000 0AF4   if(DT_ERR == NOR){ putchar1(currunt_ch6_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2B9
	LDS  R26,_currunt_ch6_2
	RJMP _0x433
_0x2B9:
	LDI  R26,LOW(0)
_0x433:
	CALL _putchar1
; 0000 0AF5 
; 0000 0AF6  //ODU2 POWER
; 0000 0AF7  if((voltage_ch3_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch3_2 - 150);}else{putchar1(0x00);}   //3-2 5-1
	LDS  R26,_voltage_ch3_2
	LDS  R27,_voltage_ch3_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2BC
	SBIS 0x2,5
	RJMP _0x2BD
_0x2BC:
	RJMP _0x2BB
_0x2BD:
	LDS  R26,_voltage_ch3_2
	SUBI R26,LOW(150)
	RJMP _0x434
_0x2BB:
	LDI  R26,LOW(0)
_0x434:
	CALL _putchar1
; 0000 0AF8    if(DT_ERR == NOR){putchar1(currunt_ch3_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2BF
	LDS  R26,_currunt_ch3_2
	RJMP _0x435
_0x2BF:
	LDI  R26,LOW(0)
_0x435:
	CALL _putchar1
; 0000 0AF9 
; 0000 0AFA  //OCU2
; 0000 0AFB  if((voltage_ch5_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch5_2 - 150);}else{putchar1(0x00);}   //5-2 3-1
	LDS  R26,_voltage_ch5_2
	LDS  R27,_voltage_ch5_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2C2
	SBIS 0x2,5
	RJMP _0x2C3
_0x2C2:
	RJMP _0x2C1
_0x2C3:
	LDS  R26,_voltage_ch5_2
	SUBI R26,LOW(150)
	RJMP _0x436
_0x2C1:
	LDI  R26,LOW(0)
_0x436:
	CALL _putchar1
; 0000 0AFC    if(DT_ERR == NOR){putchar1(currunt_ch5_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2C5
	LDS  R26,_currunt_ch5_2
	RJMP _0x437
_0x2C5:
	LDI  R26,LOW(0)
_0x437:
	CALL _putchar1
; 0000 0AFD 
; 0000 0AFE 
; 0000 0AFF 
; 0000 0B00  //MAIN LINK POWER
; 0000 0B01  if((voltage_ch3_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch3_1 - 150);}else{putchar1(0x00);}  //3- 1 5-2
	LDS  R26,_voltage_ch3_1
	LDS  R27,_voltage_ch3_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2C8
	SBIS 0x2,5
	RJMP _0x2C9
_0x2C8:
	RJMP _0x2C7
_0x2C9:
	LDS  R26,_voltage_ch3_1
	SUBI R26,LOW(150)
	RJMP _0x438
_0x2C7:
	LDI  R26,LOW(0)
_0x438:
	CALL _putchar1
; 0000 0B02  if(DT_ERR == NOR){putchar1(currunt_ch3_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2CB
	LDS  R26,_currunt_ch3_1
	RJMP _0x439
_0x2CB:
	LDI  R26,LOW(0)
_0x439:
	CALL _putchar1
; 0000 0B03 
; 0000 0B04  if(DT_ERR == NOR)
	SBIC 0x2,5
	RJMP _0x2CD
; 0000 0B05  {
; 0000 0B06  if(voltage_fan_1 <= 150){putchar1(0x00);}else{putchar1(voltage_fan_1 - 150);} //main fan 전압 전류 수정 191212
	LDS  R26,_voltage_fan_1
	LDS  R27,_voltage_fan_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRSH _0x2CE
	LDI  R26,LOW(0)
	RJMP _0x43A
_0x2CE:
	LDS  R26,_voltage_fan_1
	SUBI R26,LOW(150)
_0x43A:
	CALL _putchar1
; 0000 0B07  if(currunt_fan_1 >= 255){putchar1(0xff);}else{putchar1(currunt_fan_1);}
	LDS  R26,_currunt_fan_1
	LDS  R27,_currunt_fan_1+1
	CPI  R26,LOW(0xFF)
	LDI  R30,HIGH(0xFF)
	CPC  R27,R30
	BRLO _0x2D0
	LDI  R26,LOW(255)
	RJMP _0x43B
_0x2D0:
	LDS  R26,_currunt_fan_1
_0x43B:
	CALL _putchar1
; 0000 0B08  }
; 0000 0B09  else
	RJMP _0x2D2
_0x2CD:
; 0000 0B0A  {
; 0000 0B0B   putchar1(0x00);
	CALL SUBOPT_0x2A
; 0000 0B0C   putchar1(0x00);
; 0000 0B0D  }
_0x2D2:
; 0000 0B0E 
; 0000 0B0F 
; 0000 0B10  //SUB LINK POWER
; 0000 0B11  if((voltage_ch4_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch4_1 - 150);}else{putchar1(0x00);}  //4-1 4-2
	LDS  R26,_voltage_ch4_1
	LDS  R27,_voltage_ch4_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2D4
	SBIS 0x2,5
	RJMP _0x2D5
_0x2D4:
	RJMP _0x2D3
_0x2D5:
	LDS  R26,_voltage_ch4_1
	SUBI R26,LOW(150)
	RJMP _0x43C
_0x2D3:
	LDI  R26,LOW(0)
_0x43C:
	CALL _putchar1
; 0000 0B12    if(DT_ERR == NOR){ putchar1(currunt_ch4_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2D7
	LDS  R26,_currunt_ch4_1
	RJMP _0x43D
_0x2D7:
	LDI  R26,LOW(0)
_0x43D:
	CALL _putchar1
; 0000 0B13 
; 0000 0B14  //ANT MAST POWER
; 0000 0B15  if((voltage_ch7_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch7_1 - 150);}else{putchar1(0x00);}  //7-1 1-2
	LDS  R26,_voltage_ch7_1
	LDS  R27,_voltage_ch7_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2DA
	SBIS 0x2,5
	RJMP _0x2DB
_0x2DA:
	RJMP _0x2D9
_0x2DB:
	LDS  R26,_voltage_ch7_1
	SUBI R26,LOW(150)
	RJMP _0x43E
_0x2D9:
	LDI  R26,LOW(0)
_0x43E:
	CALL _putchar1
; 0000 0B16    if(DT_ERR == NOR){ putchar1(currunt_ch7_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2DD
	LDS  R26,_currunt_ch7_1
	RJMP _0x43F
_0x2DD:
	LDI  R26,LOW(0)
_0x43F:
	CALL _putchar1
; 0000 0B17 
; 0000 0B18  if(DT_ERR == NOR)
	SBIC 0x2,5
	RJMP _0x2DF
; 0000 0B19  {
; 0000 0B1A  if(voltage_fan_2 <= 150){putchar1(0x00);}else{putchar1(voltage_fan_2 - 150);}  //ant fan 전압 전류 수정 191212
	LDS  R26,_voltage_fan_2
	LDS  R27,_voltage_fan_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRSH _0x2E0
	LDI  R26,LOW(0)
	RJMP _0x440
_0x2E0:
	LDS  R26,_voltage_fan_2
	SUBI R26,LOW(150)
_0x440:
	CALL _putchar1
; 0000 0B1B  if(currunt_fan_2 >= 255){putchar1(0xff);}else{putchar1(currunt_fan_2);}
	LDS  R26,_currunt_fan_2
	LDS  R27,_currunt_fan_2+1
	CPI  R26,LOW(0xFF)
	LDI  R30,HIGH(0xFF)
	CPC  R27,R30
	BRLO _0x2E2
	LDI  R26,LOW(255)
	RJMP _0x441
_0x2E2:
	LDS  R26,_currunt_fan_2
_0x441:
	CALL _putchar1
; 0000 0B1C  }
; 0000 0B1D  else
	RJMP _0x2E4
_0x2DF:
; 0000 0B1E  {
; 0000 0B1F   putchar1(0x00);
	CALL SUBOPT_0x2A
; 0000 0B20   putchar1(0x00);
; 0000 0B21  }
_0x2E4:
; 0000 0B22 
; 0000 0B23 
; 0000 0B24  //INS POWER
; 0000 0B25  if((voltage_ch4_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch4_2 - 150);}else{putchar1(0x00);} //4-2 4-1
	LDS  R26,_voltage_ch4_2
	LDS  R27,_voltage_ch4_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2E6
	SBIS 0x2,5
	RJMP _0x2E7
_0x2E6:
	RJMP _0x2E5
_0x2E7:
	LDS  R26,_voltage_ch4_2
	SUBI R26,LOW(150)
	RJMP _0x442
_0x2E5:
	LDI  R26,LOW(0)
_0x442:
	CALL _putchar1
; 0000 0B26    if(DT_ERR == NOR){ putchar1(currunt_ch4_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2E9
	LDS  R26,_currunt_ch4_2
	RJMP _0x443
_0x2E9:
	LDI  R26,LOW(0)
_0x443:
	CALL _putchar1
; 0000 0B27 
; 0000 0B28  //C2VREC POWER
; 0000 0B29  if((voltage_ch6_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch6_1 - 150);}else{putchar1(0x00);}  //6-1 2-2
	LDS  R26,_voltage_ch6_1
	LDS  R27,_voltage_ch6_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2EC
	SBIS 0x2,5
	RJMP _0x2ED
_0x2EC:
	RJMP _0x2EB
_0x2ED:
	LDS  R26,_voltage_ch6_1
	SUBI R26,LOW(150)
	RJMP _0x444
_0x2EB:
	LDI  R26,LOW(0)
_0x444:
	CALL _putchar1
; 0000 0B2A    if(DT_ERR == NOR){ putchar1(currunt_ch6_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2EF
	LDS  R26,_currunt_ch6_1
	RJMP _0x445
_0x2EF:
	LDI  R26,LOW(0)
_0x445:
	CALL _putchar1
; 0000 0B2B 
; 0000 0B2C  //ROUTER POWER
; 0000 0B2D  if((voltage_ch7_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch7_2 - 150);}else{putchar1(0x00);}  //7-2 1-1
	LDS  R26,_voltage_ch7_2
	LDS  R27,_voltage_ch7_2+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2F2
	SBIS 0x2,5
	RJMP _0x2F3
_0x2F2:
	RJMP _0x2F1
_0x2F3:
	LDS  R26,_voltage_ch7_2
	SUBI R26,LOW(150)
	RJMP _0x446
_0x2F1:
	LDI  R26,LOW(0)
_0x446:
	CALL _putchar1
; 0000 0B2E   if(DT_ERR == NOR){ putchar1(currunt_ch7_2); }else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2F5
	LDS  R26,_currunt_ch7_2
	RJMP _0x447
_0x2F5:
	LDI  R26,LOW(0)
_0x447:
	CALL _putchar1
; 0000 0B2F 
; 0000 0B30  //SWITCH POWER
; 0000 0B31  if((voltage_ch5_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch5_1 - 150);}else{putchar1(0x00);} //5-1  3-2
	LDS  R26,_voltage_ch5_1
	LDS  R27,_voltage_ch5_1+1
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	BRLO _0x2F8
	SBIS 0x2,5
	RJMP _0x2F9
_0x2F8:
	RJMP _0x2F7
_0x2F9:
	LDS  R26,_voltage_ch5_1
	SUBI R26,LOW(150)
	RJMP _0x448
_0x2F7:
	LDI  R26,LOW(0)
_0x448:
	CALL _putchar1
; 0000 0B32    if(DT_ERR == NOR){ putchar1(currunt_ch5_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2FB
	LDS  R26,_currunt_ch5_1
	RJMP _0x449
_0x2FB:
	LDI  R26,LOW(0)
_0x449:
	CALL _putchar1
; 0000 0B33 
; 0000 0B34  //BTTERY 1 STATUS
; 0000 0B35   if(DT_ERR == NOR){putchar1(batt_level_1);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2FD
	LDS  R26,_batt_level_1
	RJMP _0x44A
_0x2FD:
	LDI  R26,LOW(0)
_0x44A:
	CALL _putchar1
; 0000 0B36 
; 0000 0B37  //BATTERY 2 STATUS
; 0000 0B38   if(DT_ERR == NOR){putchar1(batt_level_2);}else{putchar1(0x00);}
	SBIC 0x2,5
	RJMP _0x2FF
	LDS  R26,_batt_level_2
	RJMP _0x44B
_0x2FF:
	LDI  R26,LOW(0)
_0x44B:
	CALL _putchar1
; 0000 0B39 
; 0000 0B3A  //발전기 전압 및 전류
; 0000 0B3B if(comm_ge_err == ERR)
	SBRS R2,0
	RJMP _0x301
; 0000 0B3C {
; 0000 0B3D voltage_ge = 0;
	LDI  R30,LOW(0)
	STS  _voltage_ge,R30
	STS  _voltage_ge+1,R30
; 0000 0B3E putchar1(voltage_ge);
	LDS  R26,_voltage_ge
	CALL SUBOPT_0x2C
; 0000 0B3F putchar1(0x00);  //전류를 0으로 처리
; 0000 0B40 putchar1(0x00);  //전류를 0으로 처리
	LDI  R26,LOW(0)
	RJMP _0x44C
; 0000 0B41 }
; 0000 0B42 else
_0x301:
; 0000 0B43 {
; 0000 0B44 if(voltage_ge > 350){putchar1(voltage_ge - 350);}else{putchar1(0x00);}
	LDS  R26,_voltage_ge
	LDS  R27,_voltage_ge+1
	CPI  R26,LOW(0x15F)
	LDI  R30,HIGH(0x15F)
	CPC  R27,R30
	BRLO _0x303
	LDS  R26,_voltage_ge
	SUBI R26,LOW(94)
	RJMP _0x44D
_0x303:
	LDI  R26,LOW(0)
_0x44D:
	CALL _putchar1
; 0000 0B45  putchar1(currunt_ge % 256);   //리틀인디언 적용
	LDS  R30,_currunt_ge
	MOV  R26,R30
	CALL _putchar1
; 0000 0B46  putchar1(currunt_ge / 255);
	LDS  R26,_currunt_ge
	LDS  R27,_currunt_ge+1
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	CALL __DIVW21U
	MOV  R26,R30
_0x44C:
	CALL _putchar1
; 0000 0B47 }
; 0000 0B48   if(Distributor_devicestatus_number >= 0xff){Distributor_devicestatus_number = 0;}else{Distributor_devicestatus_number+ ...
	LDS  R26,_Distributor_devicestatus_number
	CPI  R26,LOW(0xFF)
	BRLO _0x305
	LDI  R30,LOW(0)
	RJMP _0x44E
_0x305:
	LDS  R30,_Distributor_devicestatus_number
	SUBI R30,-LOW(1)
_0x44E:
	STS  _Distributor_devicestatus_number,R30
; 0000 0B49 }
	RET
; .FEND
;
;void main(void)
; 0000 0B4C {
_main:
; .FSTART _main
; 0000 0B4D // Declare your local variables here
; 0000 0B4E 
; 0000 0B4F // Crystal Oscillator division factor: 1
; 0000 0B50 #pragma optsize-
; 0000 0B51 CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0B52 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0B53 #ifdef _OPTIMIZE_SIZE_
; 0000 0B54 #pragma optsize+
; 0000 0B55 #endif
; 0000 0B56 
; 0000 0B57 // Input/Output Ports initialization
; 0000 0B58 // Port A initialization
; 0000 0B59 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B5A DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(240)
	OUT  0x1,R30
; 0000 0B5B // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B5C PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(0)
	OUT  0x2,R30
; 0000 0B5D 
; 0000 0B5E // Port B initialization
; 0000 0B5F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B60 DDRB=(0<<DDB7) | (1<<DDB6) | (1<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(96)
	OUT  0x4,R30
; 0000 0B61 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B62 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (1<<PORTB0);
	LDI  R30,LOW(1)
	OUT  0x5,R30
; 0000 0B63 
; 0000 0B64 // Port C initialization
; 0000 0B65 // Function: Bit7=In Bit6=Out Bit5=Out Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B66 DDRC=(0<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(127)
	OUT  0x7,R30
; 0000 0B67 // State: Bit7=T Bit6=0 Bit5=0 Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B68 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x8,R30
; 0000 0B69 
; 0000 0B6A // Port D initialization
; 0000 0B6B // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B6C DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (1<<DDD4) | (0<<DDD3) | (0<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(19)
	OUT  0xA,R30
; 0000 0B6D // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B6E PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0B6F 
; 0000 0B70 // Port E initialization
; 0000 0B71 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B72 DDRE=(1<<DDE7) | (1<<DDE6) | (1<<DDE5) | (1<<DDE4) | (1<<DDE3) | (1<<DDE2) | (0<<DDE1) | (0<<DDE0);
	LDI  R30,LOW(252)
	OUT  0xD,R30
; 0000 0B73 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B74 PORTE=(0<<PORTE7) | (0<<PORTE6) | (0<<PORTE5) | (0<<PORTE4) | (0<<PORTE3) | (0<<PORTE2) | (0<<PORTE1) | (0<<PORTE0);
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0000 0B75 
; 0000 0B76 // Port F initialization
; 0000 0B77 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B78 DDRF=(0<<DDF7) | (0<<DDF6) | (0<<DDF5) | (0<<DDF4) | (0<<DDF3) | (0<<DDF2) | (0<<DDF1) | (0<<DDF0);
	OUT  0x10,R30
; 0000 0B79 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B7A PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF3) | (0<<PORTF2) | (0<<PORTF1) | (0<<PORTF0);
	OUT  0x11,R30
; 0000 0B7B 
; 0000 0B7C // Port G initialization
; 0000 0B7D // Function: Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B7E DDRG=(0<<DDG5) | (0<<DDG4) | (0<<DDG3) | (0<<DDG2) | (0<<DDG1) | (0<<DDG0);
	OUT  0x13,R30
; 0000 0B7F // State: Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B80 PORTG=(0<<PORTG5) | (0<<PORTG4) | (0<<PORTG3) | (0<<PORTG2) | (0<<PORTG1) | (0<<PORTG0);
	OUT  0x14,R30
; 0000 0B81 
; 0000 0B82 // Port H initialization
; 0000 0B83 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B84 DDRH=(0<<DDH7) | (0<<DDH6) | (0<<DDH5) | (0<<DDH4) | (0<<DDH3) | (0<<DDH2) | (0<<DDH1) | (0<<DDH0);
	STS  257,R30
; 0000 0B85 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B86 PORTH=(0<<PORTH7) | (0<<PORTH6) | (0<<PORTH5) | (0<<PORTH4) | (0<<PORTH3) | (0<<PORTH2) | (0<<PORTH1) | (0<<PORTH0);
	STS  258,R30
; 0000 0B87 
; 0000 0B88 // Port J initialization
; 0000 0B89 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B8A DDRJ=(0<<DDJ7) | (0<<DDJ6) | (0<<DDJ5) | (0<<DDJ4) | (0<<DDJ3) | (0<<DDJ2) | (0<<DDJ1) | (0<<DDJ0);
	STS  260,R30
; 0000 0B8B // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B8C PORTJ=(0<<PORTJ7) | (0<<PORTJ6) | (0<<PORTJ5) | (0<<PORTJ4) | (0<<PORTJ3) | (0<<PORTJ2) | (0<<PORTJ1) | (0<<PORTJ0);
	STS  261,R30
; 0000 0B8D 
; 0000 0B8E // Port K initialization
; 0000 0B8F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B90 DDRK=(0<<DDK7) | (0<<DDK6) | (0<<DDK5) | (0<<DDK4) | (0<<DDK3) | (0<<DDK2) | (0<<DDK1) | (0<<DDK0);
	STS  263,R30
; 0000 0B91 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B92 PORTK=(0<<PORTK7) | (0<<PORTK6) | (0<<PORTK5) | (0<<PORTK4) | (0<<PORTK3) | (0<<PORTK2) | (0<<PORTK1) | (0<<PORTK0);
	STS  264,R30
; 0000 0B93 
; 0000 0B94 // Port L initialization
; 0000 0B95 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0B96 DDRL=(0<<DDL7) | (0<<DDL6) | (0<<DDL5) | (0<<DDL4) | (0<<DDL3) | (0<<DDL2) | (0<<DDL1) | (0<<DDL0);
	STS  266,R30
; 0000 0B97 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0B98 PORTL=(0<<PORTL7) | (0<<PORTL6) | (0<<PORTL5) | (0<<PORTL4) | (0<<PORTL3) | (0<<PORTL2) | (0<<PORTL1) | (0<<PORTL0);
	STS  267,R30
; 0000 0B99 
; 0000 0B9A // Timer/Counter 0 initialization
; 0000 0B9B // Clock source: System Clock
; 0000 0B9C // Clock value: 11059.200 kHz
; 0000 0B9D // Mode: Normal top=0xFF
; 0000 0B9E // OC0A output: Disconnected
; 0000 0B9F // OC0B output: Disconnected
; 0000 0BA0 // Timer Period: 0.023148 ms
; 0000 0BA1 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	OUT  0x24,R30
; 0000 0BA2 TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (1<<CS00);
	LDI  R30,LOW(1)
	OUT  0x25,R30
; 0000 0BA3 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 0BA4 OCR0A=0x00;
	OUT  0x27,R30
; 0000 0BA5 OCR0B=0x00;
	OUT  0x28,R30
; 0000 0BA6 
; 0000 0BA7 // Timer/Counter 1 initialization
; 0000 0BA8 // Clock source: System Clock
; 0000 0BA9 // Clock value: 11059.200 kHz
; 0000 0BAA // Mode: Fast PWM top=OCR1A
; 0000 0BAB // OC1A output: Disconnected
; 0000 0BAC // OC1B output: Non-Inverted PWM
; 0000 0BAD // OC1C output: Disconnected
; 0000 0BAE // Noise Canceler: Off
; 0000 0BAF // Input Capture on Falling Edge
; 0000 0BB0 // Timer Period: 0.50004 ms
; 0000 0BB1 // Output Pulse(s):
; 0000 0BB2 // OC1B Period: 0.50004 ms Width: 0.24997 ms
; 0000 0BB3 // Timer1 Overflow Interrupt: Off
; 0000 0BB4 // Input Capture Interrupt: Off
; 0000 0BB5 // Compare A Match Interrupt: Off
; 0000 0BB6 // Compare B Match Interrupt: Off
; 0000 0BB7 // Compare C Match Interrupt: Off
; 0000 0BB8 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (1<<WGM11) | (1<<WGM10);
	LDI  R30,LOW(35)
	STS  128,R30
; 0000 0BB9 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (1<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
	LDI  R30,LOW(25)
	STS  129,R30
; 0000 0BBA TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 0BBB TCNT1L=0x00;
	STS  132,R30
; 0000 0BBC ICR1H=0x00;
	STS  135,R30
; 0000 0BBD ICR1L=0x00;
	STS  134,R30
; 0000 0BBE OCR1AH=0x15;
	LDI  R30,LOW(21)
	STS  137,R30
; 0000 0BBF OCR1AL=0x99;
	LDI  R30,LOW(153)
	STS  136,R30
; 0000 0BC0 OCR1BH=0x0A;
	LDI  R30,LOW(10)
	STS  139,R30
; 0000 0BC1 OCR1BL=0xCC;
	LDI  R30,LOW(204)
	STS  138,R30
; 0000 0BC2 OCR1CH=0x00;
	LDI  R30,LOW(0)
	STS  141,R30
; 0000 0BC3 OCR1CL=0x00;
	STS  140,R30
; 0000 0BC4 
; 0000 0BC5 // Timer/Counter 2 initialization
; 0000 0BC6 // Clock source: System Clock
; 0000 0BC7 // Clock value: Timer2 Stopped
; 0000 0BC8 // Mode: Normal top=0xFF
; 0000 0BC9 // OC2A output: Disconnected
; 0000 0BCA // OC2B output: Disconnected
; 0000 0BCB ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 0BCC TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
	STS  176,R30
; 0000 0BCD TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	STS  177,R30
; 0000 0BCE TCNT2=0x00;
	STS  178,R30
; 0000 0BCF OCR2A=0x00;
	STS  179,R30
; 0000 0BD0 OCR2B=0x00;
	STS  180,R30
; 0000 0BD1 
; 0000 0BD2 // Timer/Counter 3 initialization
; 0000 0BD3 // Clock source: System Clock
; 0000 0BD4 // Clock value: Timer3 Stopped
; 0000 0BD5 // Mode: Normal top=0xFFFF
; 0000 0BD6 // OC3A output: Disconnected
; 0000 0BD7 // OC3B output: Disconnected
; 0000 0BD8 // OC3C output: Disconnected
; 0000 0BD9 // Noise Canceler: Off
; 0000 0BDA // Input Capture on Falling Edge
; 0000 0BDB // Timer3 Overflow Interrupt: Off
; 0000 0BDC // Input Capture Interrupt: Off
; 0000 0BDD // Compare A Match Interrupt: Off
; 0000 0BDE // Compare B Match Interrupt: Off
; 0000 0BDF // Compare C Match Interrupt: Off
; 0000 0BE0 TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
	STS  144,R30
; 0000 0BE1 TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
	STS  145,R30
; 0000 0BE2 TCNT3H=0x00;
	STS  149,R30
; 0000 0BE3 TCNT3L=0x00;
	STS  148,R30
; 0000 0BE4 ICR3H=0x00;
	STS  151,R30
; 0000 0BE5 ICR3L=0x00;
	STS  150,R30
; 0000 0BE6 OCR3AH=0x00;
	STS  153,R30
; 0000 0BE7 OCR3AL=0x00;
	STS  152,R30
; 0000 0BE8 OCR3BH=0x00;
	STS  155,R30
; 0000 0BE9 OCR3BL=0x00;
	STS  154,R30
; 0000 0BEA OCR3CH=0x00;
	STS  157,R30
; 0000 0BEB OCR3CL=0x00;
	STS  156,R30
; 0000 0BEC 
; 0000 0BED // Timer/Counter 4 initialization
; 0000 0BEE // Clock source: System Clock
; 0000 0BEF // Clock value: Timer4 Stopped
; 0000 0BF0 // Mode: Normal top=0xFFFF
; 0000 0BF1 // OC4A output: Disconnected
; 0000 0BF2 // OC4B output: Disconnected
; 0000 0BF3 // OC4C output: Disconnected
; 0000 0BF4 // Noise Canceler: Off
; 0000 0BF5 // Input Capture on Falling Edge
; 0000 0BF6 // Timer4 Overflow Interrupt: Off
; 0000 0BF7 // Input Capture Interrupt: Off
; 0000 0BF8 // Compare A Match Interrupt: Off
; 0000 0BF9 // Compare B Match Interrupt: Off
; 0000 0BFA // Compare C Match Interrupt: Off
; 0000 0BFB TCCR4A=(0<<COM4A1) | (0<<COM4A0) | (0<<COM4B1) | (0<<COM4B0) | (0<<COM4C1) | (0<<COM4C0) | (0<<WGM41) | (0<<WGM40);
	STS  160,R30
; 0000 0BFC TCCR4B=(0<<ICNC4) | (0<<ICES4) | (0<<WGM43) | (0<<WGM42) | (0<<CS42) | (0<<CS41) | (0<<CS40);
	STS  161,R30
; 0000 0BFD TCNT4H=0x00;
	STS  165,R30
; 0000 0BFE TCNT4L=0x00;
	STS  164,R30
; 0000 0BFF ICR4H=0x00;
	STS  167,R30
; 0000 0C00 ICR4L=0x00;
	STS  166,R30
; 0000 0C01 OCR4AH=0x00;
	STS  169,R30
; 0000 0C02 OCR4AL=0x00;
	STS  168,R30
; 0000 0C03 OCR4BH=0x00;
	STS  171,R30
; 0000 0C04 OCR4BL=0x00;
	STS  170,R30
; 0000 0C05 OCR4CH=0x00;
	STS  173,R30
; 0000 0C06 OCR4CL=0x00;
	STS  172,R30
; 0000 0C07 
; 0000 0C08 // Timer/Counter 5 initialization
; 0000 0C09 // Clock source: System Clock
; 0000 0C0A // Clock value: Timer5 Stopped
; 0000 0C0B // Mode: Normal top=0xFFFF
; 0000 0C0C // OC5A output: Disconnected
; 0000 0C0D // OC5B output: Disconnected
; 0000 0C0E // OC5C output: Disconnected
; 0000 0C0F // Noise Canceler: Off
; 0000 0C10 // Input Capture on Falling Edge
; 0000 0C11 // Timer5 Overflow Interrupt: Off
; 0000 0C12 // Input Capture Interrupt: Off
; 0000 0C13 // Compare A Match Interrupt: Off
; 0000 0C14 // Compare B Match Interrupt: Off
; 0000 0C15 // Compare C Match Interrupt: Off
; 0000 0C16 TCCR5A=(0<<COM5A1) | (0<<COM5A0) | (0<<COM5B1) | (0<<COM5B0) | (0<<COM5C1) | (0<<COM5C0) | (0<<WGM51) | (0<<WGM50);
	STS  288,R30
; 0000 0C17 TCCR5B=(0<<ICNC5) | (0<<ICES5) | (0<<WGM53) | (0<<WGM52) | (0<<CS52) | (0<<CS51) | (0<<CS50);
	STS  289,R30
; 0000 0C18 TCNT5H=0x00;
	STS  293,R30
; 0000 0C19 TCNT5L=0x00;
	STS  292,R30
; 0000 0C1A ICR5H=0x00;
	STS  295,R30
; 0000 0C1B ICR5L=0x00;
	STS  294,R30
; 0000 0C1C OCR5AH=0x00;
	STS  297,R30
; 0000 0C1D OCR5AL=0x00;
	STS  296,R30
; 0000 0C1E OCR5BH=0x00;
	STS  299,R30
; 0000 0C1F OCR5BL=0x00;
	STS  298,R30
; 0000 0C20 OCR5CH=0x00;
	STS  301,R30
; 0000 0C21 OCR5CL=0x00;
	STS  300,R30
; 0000 0C22 
; 0000 0C23 // Timer/Counter 0 Interrupt(s) initialization
; 0000 0C24 TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (1<<TOIE0);
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 0C25 
; 0000 0C26 // Timer/Counter 1 Interrupt(s) initialization
; 0000 0C27 TIMSK1=(0<<ICIE1) | (0<<OCIE1C) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	LDI  R30,LOW(0)
	STS  111,R30
; 0000 0C28 
; 0000 0C29 // Timer/Counter 2 Interrupt(s) initialization
; 0000 0C2A TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);
	STS  112,R30
; 0000 0C2B 
; 0000 0C2C // Timer/Counter 3 Interrupt(s) initialization
; 0000 0C2D TIMSK3=(0<<ICIE3) | (0<<OCIE3C) | (0<<OCIE3B) | (0<<OCIE3A) | (0<<TOIE3);
	STS  113,R30
; 0000 0C2E 
; 0000 0C2F // Timer/Counter 4 Interrupt(s) initialization
; 0000 0C30 TIMSK4=(0<<ICIE4) | (0<<OCIE4C) | (0<<OCIE4B) | (0<<OCIE4A) | (0<<TOIE4);
	STS  114,R30
; 0000 0C31 
; 0000 0C32 // Timer/Counter 5 Interrupt(s) initialization
; 0000 0C33 TIMSK5=(0<<ICIE5) | (0<<OCIE5C) | (0<<OCIE5B) | (0<<OCIE5A) | (0<<TOIE5);
	STS  115,R30
; 0000 0C34 
; 0000 0C35 // External Interrupt(s) initialization
; 0000 0C36 // INT0: Off
; 0000 0C37 // INT1: Off
; 0000 0C38 // INT2: Off
; 0000 0C39 // INT3: Off
; 0000 0C3A // INT4: Off
; 0000 0C3B // INT5: Off
; 0000 0C3C // INT6: Off
; 0000 0C3D // INT7: Off
; 0000 0C3E EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 0C3F EICRB=(0<<ISC71) | (0<<ISC70) | (0<<ISC61) | (0<<ISC60) | (0<<ISC51) | (0<<ISC50) | (0<<ISC41) | (0<<ISC40);
	STS  106,R30
; 0000 0C40 EIMSK=(0<<INT7) | (0<<INT6) | (0<<INT5) | (0<<INT4) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 0C41 // PCINT0 interrupt: Off
; 0000 0C42 // PCINT1 interrupt: Off
; 0000 0C43 // PCINT2 interrupt: Off
; 0000 0C44 // PCINT3 interrupt: Off
; 0000 0C45 // PCINT4 interrupt: Off
; 0000 0C46 // PCINT5 interrupt: Off
; 0000 0C47 // PCINT6 interrupt: Off
; 0000 0C48 // PCINT7 interrupt: Off
; 0000 0C49 // PCINT8 interrupt: Off
; 0000 0C4A // PCINT9 interrupt: Off
; 0000 0C4B // PCINT10 interrupt: Off
; 0000 0C4C // PCINT11 interrupt: Off
; 0000 0C4D // PCINT12 interrupt: Off
; 0000 0C4E // PCINT13 interrupt: Off
; 0000 0C4F // PCINT14 interrupt: Off
; 0000 0C50 // PCINT15 interrupt: Off                                                                             y
; 0000 0C51 // PCINT16 interrupt: Off
; 0000 0C52 // PCINT17 interrupt: Off
; 0000 0C53 // PCINT18 interrupt: Off
; 0000 0C54 // PCINT19 interrupt: Off
; 0000 0C55 // PCINT20 interrupt: Off
; 0000 0C56 // PCINT21 interrupt: Off
; 0000 0C57 // PCINT22 interrupt: Off
; 0000 0C58 // PCINT23 interrupt: Off
; 0000 0C59 PCMSK0=(0<<PCINT7) | (0<<PCINT6) | (0<<PCINT5) | (0<<PCINT4) | (0<<PCINT3) | (0<<PCINT2) | (0<<PCINT1) | (0<<PCINT0);
	STS  107,R30
; 0000 0C5A PCMSK1=(0<<PCINT15) | (0<<PCINT14) | (0<<PCINT13) | (0<<PCINT12) | (0<<PCINT11) | (0<<PCINT10) | (0<<PCINT9) | (0<<PCINT ...
	STS  108,R30
; 0000 0C5B PCMSK2=(0<<PCINT23) | (0<<PCINT22) | (0<<PCINT21) | (0<<PCINT20) | (0<<PCINT19) | (0<<PCINT18) | (0<<PCINT17) | (0<<PCIN ...
	STS  109,R30
; 0000 0C5C PCICR=(0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);
	STS  104,R30
; 0000 0C5D 
; 0000 0C5E // USART0 initialization
; 0000 0C5F // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0C60 // USART0 Receiver: On
; 0000 0C61 // USART0 Transmitter: On
; 0000 0C62 // USART0 Mode: Asynchronous
; 0000 0C63 // USART0 Baud Rate: 115200
; 0000 0C64 UCSR0A=(0<<RXC0) | (0<<TXC0) | (0<<UDRE0) | (0<<FE0) | (0<<DOR0) | (0<<UPE0) | (0<<U2X0) | (0<<MPCM0);
	STS  192,R30
; 0000 0C65 UCSR0B=(1<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (1<<RXEN0) | (1<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	LDI  R30,LOW(152)
	STS  193,R30
; 0000 0C66 UCSR0C=(0<<UMSEL01) | (0<<UMSEL00) | (0<<UPM01) | (0<<UPM00) | (0<<USBS0) | (1<<UCSZ01) | (1<<UCSZ00) | (0<<UCPOL0);
	LDI  R30,LOW(6)
	STS  194,R30
; 0000 0C67 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0000 0C68 UBRR0L=0x05;
	LDI  R30,LOW(5)
	STS  196,R30
; 0000 0C69 
; 0000 0C6A // USART1 initialization
; 0000 0C6B // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0C6C // USART1 Receiver: On
; 0000 0C6D // USART1 Transmitter: On
; 0000 0C6E // USART1 Mode: Asynchronous
; 0000 0C6F // USART1 Baud Rate: 115200
; 0000 0C70 UCSR1A=(0<<RXC1) | (0<<TXC1) | (0<<UDRE1) | (0<<FE1) | (0<<DOR1) | (0<<UPE1) | (0<<U2X1) | (0<<MPCM1);
	LDI  R30,LOW(0)
	STS  200,R30
; 0000 0C71 UCSR1B=(1<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (1<<RXEN1) | (1<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	LDI  R30,LOW(152)
	STS  201,R30
; 0000 0C72 UCSR1C=(0<<UMSEL11) | (0<<UMSEL10) | (0<<UPM11) | (0<<UPM10) | (0<<USBS1) | (1<<UCSZ11) | (1<<UCSZ10) | (0<<UCPOL1);
	LDI  R30,LOW(6)
	STS  202,R30
; 0000 0C73 UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  205,R30
; 0000 0C74 UBRR1L=0x05;
	LDI  R30,LOW(5)
	STS  204,R30
; 0000 0C75 
; 0000 0C76 
; 0000 0C77 // USART2 initialization
; 0000 0C78 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0C79 // USART2 Receiver: On
; 0000 0C7A // USART2 Transmitter: On
; 0000 0C7B // USART2 Mode: Asynchronous
; 0000 0C7C // USART2 Baud Rate: 57600
; 0000 0C7D UCSR2A=(0<<RXC2) | (0<<TXC2) | (0<<UDRE2) | (0<<FE2) | (0<<DOR2) | (0<<UPE2) | (0<<U2X2) | (0<<MPCM2);
	LDI  R30,LOW(0)
	STS  208,R30
; 0000 0C7E UCSR2B=(1<<RXCIE2) | (0<<TXCIE2) | (0<<UDRIE2) | (1<<RXEN2) | (1<<TXEN2) | (0<<UCSZ22) | (0<<RXB82) | (0<<TXB82);
	LDI  R30,LOW(152)
	STS  209,R30
; 0000 0C7F UCSR2C=(0<<UMSEL21) | (0<<UMSEL20) | (0<<UPM21) | (0<<UPM20) | (0<<USBS2) | (1<<UCSZ21) | (1<<UCSZ20) | (0<<UCPOL2);
	LDI  R30,LOW(6)
	STS  210,R30
; 0000 0C80 UBRR2H=0x00;
	LDI  R30,LOW(0)
	STS  213,R30
; 0000 0C81 UBRR2L=0x0B;
	LDI  R30,LOW(11)
	STS  212,R30
; 0000 0C82 
; 0000 0C83 /*
; 0000 0C84 // USART2 initialization
; 0000 0C85 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0C86 // USART2 Receiver: On
; 0000 0C87 // USART2 Transmitter: On
; 0000 0C88 // USART2 Mode: Asynchronous
; 0000 0C89 // USART2 Baud Rate: 115200
; 0000 0C8A UCSR2A=(0<<RXC2) | (0<<TXC2) | (0<<UDRE2) | (0<<FE2) | (0<<DOR2) | (0<<UPE2) | (0<<U2X2) | (0<<MPCM2);
; 0000 0C8B UCSR2B=(1<<RXCIE2) | (0<<TXCIE2) | (0<<UDRIE2) | (1<<RXEN2) | (1<<TXEN2) | (0<<UCSZ22) | (0<<RXB82) | (0<<TXB82);
; 0000 0C8C UCSR2C=(0<<UMSEL21) | (0<<UMSEL20) | (0<<UPM21) | (0<<UPM20) | (0<<USBS2) | (1<<UCSZ21) | (1<<UCSZ20) | (0<<UCPOL2);
; 0000 0C8D UBRR2H=0x00;
; 0000 0C8E UBRR2L=0x05;
; 0000 0C8F */
; 0000 0C90 
; 0000 0C91 // USART3 initialization
; 0000 0C92 // USART3 disabled
; 0000 0C93 UCSR3B=(0<<RXCIE3) | (0<<TXCIE3) | (0<<UDRIE3) | (0<<RXEN3) | (0<<TXEN3) | (0<<UCSZ32) | (0<<RXB83) | (0<<TXB83);
	LDI  R30,LOW(0)
	STS  305,R30
; 0000 0C94 
; 0000 0C95 // Analog Comparator initialization
; 0000 0C96 // Analog Comparator: Off
; 0000 0C97 // The Analog Comparator's positive input is
; 0000 0C98 // connected to the AIN0 pin
; 0000 0C99 // The Analog Comparator's negative input is
; 0000 0C9A // connected to the AIN1 pin
; 0000 0C9B ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 0C9C ADCSRB=(0<<ACME);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 0C9D // Digital input buffer on AIN0: On
; 0000 0C9E // Digital input buffer on AIN1: On
; 0000 0C9F DIDR1=(0<<AIN0D) | (0<<AIN1D);
	STS  127,R30
; 0000 0CA0 
; 0000 0CA1 // ADC initialization
; 0000 0CA2 // ADC disabled
; 0000 0CA3 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	STS  122,R30
; 0000 0CA4 
; 0000 0CA5 // SPI initialization
; 0000 0CA6 // SPI disabled
; 0000 0CA7 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0x2C,R30
; 0000 0CA8 
; 0000 0CA9 // TWI initialization
; 0000 0CAA // TWI disabled
; 0000 0CAB TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  188,R30
; 0000 0CAC 
; 0000 0CAD // Globally enable interrupts
; 0000 0CAE #asm("sei")
	SEI
; 0000 0CAF 
; 0000 0CB0 // Bit-Banged I2C Bus initialization
; 0000 0CB1 // SDA signal: PORTF bit: 2
; 0000 0CB2 // SCL signal: PORTA bit: 1
; 0000 0CB3 // Bit Rate: 100 kHz
; 0000 0CB4 // Note: I2C settings are specified in the
; 0000 0CB5 // Project|Configure|C Compiler|Libraries|I2C menu.
; 0000 0CB6 i2c_init();
	CALL _i2c_init
; 0000 0CB7 
; 0000 0CB8 // DS1307 Real Time Clock initialization for Bit-Banged I2C
; 0000 0CB9 // Square wave output on pin SQW/OUT: On
; 0000 0CBA // Square wave frequency: 1 Hz
; 0000 0CBB rtc_init(0,1,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _rtc_init
; 0000 0CBC 
; 0000 0CBD //날짜초기 설정
; 0000 0CBE 
; 0000 0CBF /* Set time 00:00:00 */
; 0000 0CC0 rtc_set_time(0,0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _rtc_set_time
; 0000 0CC1 
; 0000 0CC2 /* Set date Monday 23/07/2018   week,day,month,yea*/
; 0000 0CC3 rtc_set_date(1,1,1,20);
	LDI  R30,LOW(1)
	ST   -Y,R30
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(20)
	RCALL _rtc_set_date
; 0000 0CC4 
; 0000 0CC5 
; 0000 0CC6 
; 0000 0CC7 init();
	CALL _init
; 0000 0CC8 
; 0000 0CC9 while (1)
_0x307:
; 0000 0CCA       {
; 0000 0CCB             temp_c++;
	LDI  R26,LOW(_temp_c)
	LDI  R27,HIGH(_temp_c)
	CALL SUBOPT_0xC
; 0000 0CCC             if(temp_c>2){temp_c = 0;display_out();}
	LDS  R26,_temp_c
	LDS  R27,_temp_c+1
	SBIW R26,3
	BRLT _0x30A
	LDI  R30,LOW(0)
	STS  _temp_c,R30
	STS  _temp_c+1,R30
	CALL _display_out
; 0000 0CCD 
; 0000 0CCE        //LED
; 0000 0CCF           if(((comm_err == 0) && (DIS_HOT_SWAP == 0))&&(power_link1_err == 0)&&(buzzer_out_wait == 1)&&((sw_status == 1) ...
_0x30A:
	SBIC 0x1E,7
	RJMP _0x30C
	SBIS 0x3,0
	RJMP _0x30D
_0x30C:
	RJMP _0x30E
_0x30D:
	LDS  R26,_power_link1_err
	CPI  R26,LOW(0x0)
	BRNE _0x30E
	LDS  R26,_buzzer_out_wait
	CPI  R26,LOW(0x1)
	BRNE _0x30E
	LDS  R26,_sw_status
	CPI  R26,LOW(0x1)
	BREQ _0x30F
	CPI  R26,LOW(0x2)
	BRNE _0x30E
_0x30F:
	RJMP _0x311
_0x30E:
	RJMP _0x30B
_0x311:
; 0000 0CD0           //if((power_link_1 & 0x80) == 0x80)
; 0000 0CD1            {
; 0000 0CD2                 if((batt_link_err_act_1 == 1)||((err_main_1 & 0x80)==0x80)||(err_bat1_temp == ERR)||(err_bat1_volt == ER ...
	SBIC 0x1E,2
	RJMP _0x313
	LDS  R30,_err_main_1
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BREQ _0x313
	LDS  R26,_err_bat1_temp
	CPI  R26,LOW(0x1)
	BREQ _0x313
	LDS  R26,_err_bat1_volt
	CPI  R26,LOW(0x1)
	BREQ _0x313
	LDS  R26,_err_bat1_curr
	CPI  R26,LOW(0x1)
	BRNE _0x312
_0x313:
; 0000 0CD3                 {
; 0000 0CD4                 BAT_ERR_1 = ON;
	SBI  0xE,6
; 0000 0CD5                 BAT_RUN_1 = OFF;
	CBI  0xE,4
; 0000 0CD6                 if((batt_err_1_act == OFF)&&(batt_err_1_act_buzzer == OFF)){batt_err_1_act_buzzer = ON;}
	LDS  R26,_batt_err_1_act
	CPI  R26,LOW(0x0)
	BRNE _0x31A
	LDS  R26,_batt_err_1_act_buzzer
	CPI  R26,LOW(0x0)
	BREQ _0x31B
_0x31A:
	RJMP _0x319
_0x31B:
	LDI  R30,LOW(1)
	STS  _batt_err_1_act_buzzer,R30
; 0000 0CD7                 batt_err_1_act = ON;
_0x319:
	LDI  R30,LOW(1)
	STS  _batt_err_1_act,R30
; 0000 0CD8                 }
; 0000 0CD9                 else
	RJMP _0x31C
_0x312:
; 0000 0CDA                 {
; 0000 0CDB                 BAT_ERR_1 = OFF;
	CBI  0xE,6
; 0000 0CDC                 if(batt_run_act_1 == 1){BAT_RUN_1 = ON;}else{if(led_flash == 1){BAT_RUN_1 = ON;}else{BAT_RUN_1 = OFF;}}
	SBIS 0x1E,4
	RJMP _0x31F
	SBI  0xE,4
	RJMP _0x322
_0x31F:
	LDS  R26,_led_flash
	CPI  R26,LOW(0x1)
	BRNE _0x323
	SBI  0xE,4
	RJMP _0x326
_0x323:
	CBI  0xE,4
_0x326:
_0x322:
; 0000 0CDD                 batt_err_1_act = OFF;
	LDI  R30,LOW(0)
	STS  _batt_err_1_act,R30
; 0000 0CDE                 batt_err_1_act_buzzer = OFF;
	STS  _batt_err_1_act_buzzer,R30
; 0000 0CDF                 }
_0x31C:
; 0000 0CE0            }
; 0000 0CE1            else
	RJMP _0x329
_0x30B:
; 0000 0CE2            {
; 0000 0CE3                 BAT_ERR_1 = OFF;
	CBI  0xE,6
; 0000 0CE4                 BAT_RUN_1 = OFF;
	CBI  0xE,4
; 0000 0CE5            }
_0x329:
; 0000 0CE6 
; 0000 0CE7           // if((power_link_2 & 0x80) == 0x80)// 전원반 1,2 핫스왑결과 1이면 정상 0이면 에러로 처리
; 0000 0CE8 
; 0000 0CE9 
; 0000 0CEA            if(((comm_err == 0) && (DIS_HOT_SWAP == 0))&&(power_link2_err == 0)&&(buzzer_out_wait == 1)&&((sw_status == 1 ...
	SBIC 0x1E,7
	RJMP _0x32F
	SBIS 0x3,0
	RJMP _0x330
_0x32F:
	RJMP _0x331
_0x330:
	LDS  R26,_power_link2_err
	CPI  R26,LOW(0x0)
	BRNE _0x331
	LDS  R26,_buzzer_out_wait
	CPI  R26,LOW(0x1)
	BRNE _0x331
	LDS  R26,_sw_status
	CPI  R26,LOW(0x1)
	BREQ _0x332
	CPI  R26,LOW(0x2)
	BRNE _0x331
_0x332:
	RJMP _0x334
_0x331:
	RJMP _0x32E
_0x334:
; 0000 0CEB            {
; 0000 0CEC                 if((batt_link_err_act_2 == 1)||((err_main_2 & 0x80)==0x80)||(err_bat2_temp == ERR)||(err_bat2_volt == ER ...
	SBIC 0x1E,3
	RJMP _0x336
	LDS  R30,_err_main_2
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BREQ _0x336
	LDS  R26,_err_bat2_temp
	CPI  R26,LOW(0x1)
	BREQ _0x336
	LDS  R26,_err_bat2_volt
	CPI  R26,LOW(0x1)
	BREQ _0x336
	LDS  R26,_err_bat2_curr
	CPI  R26,LOW(0x1)
	BRNE _0x335
_0x336:
; 0000 0CED                 {
; 0000 0CEE                 BAT_ERR_2 = ON;
	SBI  0xE,7
; 0000 0CEF                 BAT_RUN_2 = OFF;
	CBI  0xE,5
; 0000 0CF0                 if((batt_err_2_act == OFF)&&(batt_err_2_act_buzzer == OFF)){batt_err_2_act_buzzer = ON;}
	LDS  R26,_batt_err_2_act
	CPI  R26,LOW(0x0)
	BRNE _0x33D
	LDS  R26,_batt_err_2_act_buzzer
	CPI  R26,LOW(0x0)
	BREQ _0x33E
_0x33D:
	RJMP _0x33C
_0x33E:
	LDI  R30,LOW(1)
	STS  _batt_err_2_act_buzzer,R30
; 0000 0CF1                 batt_err_2_act = ON;
_0x33C:
	LDI  R30,LOW(1)
	STS  _batt_err_2_act,R30
; 0000 0CF2                 }
; 0000 0CF3                 else
	RJMP _0x33F
_0x335:
; 0000 0CF4                 {
; 0000 0CF5                 BAT_ERR_2 = OFF;
	CBI  0xE,7
; 0000 0CF6                 if(batt_run_act_2 == 1){BAT_RUN_2 = ON;}else{if(led_flash == 1){BAT_RUN_2 = ON;}else{BAT_RUN_2 = OFF;}}
	SBIS 0x1E,5
	RJMP _0x342
	SBI  0xE,5
	RJMP _0x345
_0x342:
	LDS  R26,_led_flash
	CPI  R26,LOW(0x1)
	BRNE _0x346
	SBI  0xE,5
	RJMP _0x349
_0x346:
	CBI  0xE,5
_0x349:
_0x345:
; 0000 0CF7                 batt_err_2_act = OFF;
	LDI  R30,LOW(0)
	STS  _batt_err_2_act,R30
; 0000 0CF8                 batt_err_2_act_buzzer = OFF;
	STS  _batt_err_2_act_buzzer,R30
; 0000 0CF9                 }
_0x33F:
; 0000 0CFA            }
; 0000 0CFB            else
	RJMP _0x34C
_0x32E:
; 0000 0CFC            {
; 0000 0CFD                 BAT_ERR_2 = OFF;
	CBI  0xE,7
; 0000 0CFE                 BAT_RUN_2 = OFF;
	CBI  0xE,5
; 0000 0CFF            }
_0x34C:
; 0000 0D00 
; 0000 0D01 
; 0000 0D02            //****************
; 0000 0D03            // comm_ge_err = 0; //임시처리 시험 및 납품시 삭제 필요
; 0000 0D04            //****************
; 0000 0D05 
; 0000 0D06             if((sw_status == 1)||(sw_status == 2))
	LDS  R26,_sw_status
	CPI  R26,LOW(0x1)
	BREQ _0x352
	CPI  R26,LOW(0x2)
	BREQ _0x352
	RJMP _0x351
_0x352:
; 0000 0D07             {
; 0000 0D08                 if((((comm_err == 1)||(deiver_48_err == ERR))&&(buzzer_out_wait == 1))||(DIS_HOT_SWAP == 1))
	SBIC 0x1E,7
	RJMP _0x355
	LDS  R26,_deiver_48_err
	CPI  R26,LOW(0x1)
	BRNE _0x357
_0x355:
	LDS  R26,_buzzer_out_wait
	CPI  R26,LOW(0x1)
	BREQ _0x359
_0x357:
	SBIS 0x3,0
	RJMP _0x354
_0x359:
; 0000 0D09                 {
; 0000 0D0A                 DT_NORMAL = 0;
	CBI  0x2,4
; 0000 0D0B                 DT_ERR = 1;
	SBI  0x2,5
; 0000 0D0C                 if((dt_err_act == OFF)&&(dt_err_act_buzzer == OFF)){dt_err_act_buzzer = ON;}
	SBIC 0x1E,6
	RJMP _0x360
	LDS  R26,_dt_err_act_buzzer
	CPI  R26,LOW(0x0)
	BREQ _0x361
_0x360:
	RJMP _0x35F
_0x361:
	LDI  R30,LOW(1)
	STS  _dt_err_act_buzzer,R30
; 0000 0D0D                 dt_err_act = ON;
_0x35F:
	SBI  0x1E,6
; 0000 0D0E                 }
; 0000 0D0F                 else
	RJMP _0x364
_0x354:
; 0000 0D10                 {
; 0000 0D11                 DT_NORMAL = 1;
	SBI  0x2,4
; 0000 0D12                 DT_ERR = 0;
	CBI  0x2,5
; 0000 0D13                 dt_err_act = OFF;
	CBI  0x1E,6
; 0000 0D14                 dt_err_act_buzzer = OFF;
	LDI  R30,LOW(0)
	STS  _dt_err_act_buzzer,R30
; 0000 0D15                 }
_0x364:
; 0000 0D16 
; 0000 0D17 
; 0000 0D18                 if(((comm_ge_err == ERR)||(ge_err_act == ERR))&&(buzzer_out_wait == 1))
	SBRC R2,0
	RJMP _0x36C
	LDS  R26,_ge_err_act
	CPI  R26,LOW(0x1)
	BRNE _0x36E
_0x36C:
	LDS  R26,_buzzer_out_wait
	CPI  R26,LOW(0x1)
	BREQ _0x36F
_0x36E:
	RJMP _0x36B
_0x36F:
; 0000 0D19                 {
; 0000 0D1A                  GE_ERR = 1;GE_NORMAL = 0;
	SBI  0x2,7
	CBI  0x2,6
; 0000 0D1B                  if((ge_err_latch == OFF)&&(ge_err_act_buzzer == OFF)){ge_err_act_buzzer = ON;}
	LDS  R26,_ge_err_latch
	CPI  R26,LOW(0x0)
	BRNE _0x375
	LDS  R26,_ge_err_act_buzzer
	CPI  R26,LOW(0x0)
	BREQ _0x376
_0x375:
	RJMP _0x374
_0x376:
	LDI  R30,LOW(1)
	STS  _ge_err_act_buzzer,R30
; 0000 0D1C                  ge_err_latch = ON;
_0x374:
	LDI  R30,LOW(1)
	RJMP _0x44F
; 0000 0D1D                 }
; 0000 0D1E                 else
_0x36B:
; 0000 0D1F                 {
; 0000 0D20                  GE_NORMAL = 1;GE_ERR = 0;
	SBI  0x2,6
	CBI  0x2,7
; 0000 0D21                  ge_err_act_buzzer = OFF;
	LDI  R30,LOW(0)
	STS  _ge_err_act_buzzer,R30
; 0000 0D22                  ge_err_latch = OFF;
_0x44F:
	STS  _ge_err_latch,R30
; 0000 0D23                 }
; 0000 0D24 
; 0000 0D25 
; 0000 0D26 
; 0000 0D27                if(init_mod_switch == 0)
	LDS  R30,_init_mod_switch
	CPI  R30,0
	BRNE _0x37C
; 0000 0D28                {
; 0000 0D29                 mode_change_and_init = 1; //초기 부저 경보 발생
	LDI  R30,LOW(1)
	STS  _mode_change_and_init,R30
; 0000 0D2A                 init_mod_switch = 1;
	STS  _init_mod_switch,R30
; 0000 0D2B                }
; 0000 0D2C             }
_0x37C:
; 0000 0D2D             else
	RJMP _0x37D
_0x351:
; 0000 0D2E             {
; 0000 0D2F               DT_NORMAL = 0;
	CBI  0x2,4
; 0000 0D30               DT_ERR = 0;
	CBI  0x2,5
; 0000 0D31               GE_ERR = 0;
	CBI  0x2,7
; 0000 0D32               GE_NORMAL = 0;
	CBI  0x2,6
; 0000 0D33               buzzer_clear_all();
	CALL _buzzer_clear_all
; 0000 0D34               init_mod_switch = 0;
	LDI  R30,LOW(0)
	STS  _init_mod_switch,R30
; 0000 0D35               mode_change_and_init = 0;
	STS  _mode_change_and_init,R30
; 0000 0D36               buzzer_out_wait = 0;
	STS  _buzzer_out_wait,R30
; 0000 0D37             }
_0x37D:
; 0000 0D38 
; 0000 0D39 
; 0000 0D3A 
; 0000 0D3B             //if(LAN_STS == 1){DT_NORMAL = 1;}else{DT_NORMAL = 0;}
; 0000 0D3C             //if(LAN_STS == 1){GE_NORMAL = 1;}else{GE_NORMAL = 0;}
; 0000 0D3D             //if(LAN_STS == 1){DT_ERR = 1;}else{DT_ERR = 0;}
; 0000 0D3E             //if(LAN_STS == 1){GE_ERR = 1;}else{GE_ERR = 0;}
; 0000 0D3F 
; 0000 0D40             //        //COMM ERROR PROCESS of dt
; 0000 0D41             //        if(comm_err == 1) //통신 loss시 검출
; 0000 0D42             //        {
; 0000 0D43             //         data_clear();
; 0000 0D44             //         if(ADDRESS_0){voltage_1 = 0;}
; 0000 0D45             //        if(ADDRESS_0){ voltage_2 = 0;}
; 0000 0D46             //
; 0000 0D47             //        if(ADDRESS_0){ currunt_1 = 0;}
; 0000 0D48             //        if(ADDRESS_0){ currunt_2 = 0;}
; 0000 0D49             //
; 0000 0D4A             //        if(ADDRESS_0){ bat_volt_1 = 0;}
; 0000 0D4B             //        if(ADDRESS_0){ bat_volt_2 = 0;}
; 0000 0D4C             //        }
; 0000 0D4D 
; 0000 0D4E 
; 0000 0D4F 
; 0000 0D50        if(send_to_div_act == 1){send_to_div();}
	LDS  R26,_send_to_div_act
	CPI  R26,LOW(0x1)
	BRNE _0x386
	CALL _send_to_div
; 0000 0D51 
; 0000 0D52         //셧다운 시간 기록
; 0000 0D53        if(time_data_get == 1)
_0x386:
	LDS  R26,_time_data_get
	CPI  R26,LOW(0x1)
	BRNE _0x387
; 0000 0D54         {
; 0000 0D55 
; 0000 0D56             rtc_get_date(&week,&day,&month,&year);
	CALL SUBOPT_0x7
; 0000 0D57             rtc_get_time(&hour,&minute,&sec);
	CALL SUBOPT_0x4
; 0000 0D58              keep_year = year;
	LDS  R30,_year
	LDI  R26,LOW(_keep_year)
	LDI  R27,HIGH(_keep_year)
	CALL __EEPROMWRB
; 0000 0D59              keep_month = month;
	LDS  R30,_month
	LDI  R26,LOW(_keep_month)
	LDI  R27,HIGH(_keep_month)
	CALL __EEPROMWRB
; 0000 0D5A              keep_day = day;
	LDS  R30,_day
	LDI  R26,LOW(_keep_day)
	LDI  R27,HIGH(_keep_day)
	CALL __EEPROMWRB
; 0000 0D5B              keep_hour = hour;
	LDS  R30,_hour
	LDI  R26,LOW(_keep_hour)
	LDI  R27,HIGH(_keep_hour)
	CALL __EEPROMWRB
; 0000 0D5C              keep_minute = minute;
	LDS  R30,_minute
	LDI  R26,LOW(_keep_minute)
	LDI  R27,HIGH(_keep_minute)
	CALL __EEPROMWRB
; 0000 0D5D              keep_sec = sec;
	LDS  R30,_sec
	LDI  R26,LOW(_keep_sec)
	LDI  R27,HIGH(_keep_sec)
	CALL __EEPROMWRB
; 0000 0D5E            time_data_get = 0;
	LDI  R30,LOW(0)
	STS  _time_data_get,R30
; 0000 0D5F         }
; 0000 0D60 
; 0000 0D61 
; 0000 0D62 
; 0000 0D63         if((((sw_status == 1)||(sw_status == 2))&&((dt_err_act_buzzer == ON) || (ge_err_act_buzzer == ON) ||
_0x387:
; 0000 0D64         (batt_err_1_act_buzzer == ON) || (batt_err_2_act_buzzer == ON) ||(power_link1_err_act_buzzer == ON) ||
; 0000 0D65         (power_link2_err_act_buzzer == ON)))&&(buzzer_out_wait == 1))
	LDS  R26,_sw_status
	CPI  R26,LOW(0x1)
	BREQ _0x389
	CPI  R26,LOW(0x2)
	BRNE _0x38B
_0x389:
	LDS  R26,_dt_err_act_buzzer
	CPI  R26,LOW(0x1)
	BREQ _0x38C
	LDS  R26,_ge_err_act_buzzer
	CPI  R26,LOW(0x1)
	BREQ _0x38C
	LDS  R26,_batt_err_1_act_buzzer
	CPI  R26,LOW(0x1)
	BREQ _0x38C
	LDS  R26,_batt_err_2_act_buzzer
	CPI  R26,LOW(0x1)
	BREQ _0x38C
	LDS  R26,_power_link1_err_act_buzzer
	CPI  R26,LOW(0x1)
	BREQ _0x38C
	LDS  R26,_power_link2_err_act_buzzer
	CPI  R26,LOW(0x1)
	BRNE _0x38B
_0x38C:
	RJMP _0x38E
_0x38B:
	RJMP _0x38F
_0x38E:
	LDS  R26,_buzzer_out_wait
	CPI  R26,LOW(0x1)
	BREQ _0x390
_0x38F:
	RJMP _0x388
_0x390:
; 0000 0D66       //  { buzzer_on = ON;}else{buzzer_on = OFF;};
; 0000 0D67         {
; 0000 0D68          buzzer_count++;
	LDI  R26,LOW(_buzzer_count)
	LDI  R27,HIGH(_buzzer_count)
	CALL SUBOPT_0xC
; 0000 0D69          if(buzzer_count >= buzzer_err_delay)       //부저 소리나오는거 수정한부분    191222
	LDS  R26,_buzzer_count
	LDS  R27,_buzzer_count+1
	CPI  R26,LOW(0xBB8)
	LDI  R30,HIGH(0xBB8)
	CPC  R27,R30
	BRLO _0x391
; 0000 0D6A          {
; 0000 0D6B             buzzer_count =  buzzer_err_delay;
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	STS  _buzzer_count,R30
	STS  _buzzer_count+1,R31
; 0000 0D6C             buzzer_on = ON;
	SBI  0x1E,0
; 0000 0D6D          }
; 0000 0D6E         }
_0x391:
; 0000 0D6F          else
	RJMP _0x394
_0x388:
; 0000 0D70          {
; 0000 0D71             buzzer_on = OFF;
	CBI  0x1E,0
; 0000 0D72             buzzer_count = 0;
	LDI  R30,LOW(0)
	STS  _buzzer_count,R30
	STS  _buzzer_count+1,R30
; 0000 0D73          }
_0x394:
; 0000 0D74 
; 0000 0D75 
; 0000 0D76         if(BUZZER_STOP_KEY == 0)
	SBIC 0x3,4
	RJMP _0x397
; 0000 0D77         {
; 0000 0D78           buzzer_clear_all();
	CALL _buzzer_clear_all
; 0000 0D79         }
; 0000 0D7A 
; 0000 0D7B        if(buzzer_on == ON){if(led_flash == ON){BUZZER_HIGH = 1;}else{BUZZER_HIGH = 0;}}else{BUZZER_HIGH = 0;}
_0x397:
	SBIS 0x1E,0
	RJMP _0x398
	LDS  R26,_led_flash
	CPI  R26,LOW(0x1)
	BRNE _0x399
	SBI  0x5,5
	RJMP _0x39C
_0x399:
	CBI  0x5,5
_0x39C:
	RJMP _0x39F
_0x398:
	CBI  0x5,5
_0x39F:
; 0000 0D7C 
; 0000 0D7D        if(send_process_count == 1){if(Common_CHeckLink_act == 1){Response_Common_CHeckLink();fnd_init();}}  //링크 확인
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3A2
	LDS  R26,_Common_CHeckLink_act
	CPI  R26,LOW(0x1)
	BRNE _0x3A3
	CALL _Response_Common_CHeckLink
	CALL _fnd_init
_0x3A3:
; 0000 0D7E 
; 0000 0D7F        if(send_process_count == 2){if(Distributor_TimeSyncAck_act == 1){Response_Distributor_TimeSyncAck();}}
_0x3A2:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3A4
	LDS  R26,_Distributor_TimeSyncAck_act
	CPI  R26,LOW(0x1)
	BRNE _0x3A5
	CALL _Response_Distributor_TimeSyncAck
_0x3A5:
; 0000 0D80 
; 0000 0D81        if(send_process_count == 3){if(Distributor_BITDetailResponse_act == 1){Response_Distributor_BITDetailResponse();} ...
_0x3A4:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3A6
	LDS  R26,_Distributor_BITDetailResponse_act
	CPI  R26,LOW(0x1)
	BRNE _0x3A7
	RCALL _Response_Distributor_BITDetailResponse
_0x3A7:
; 0000 0D82 
; 0000 0D83        if(send_process_count == 8){if(Distributor_ShutdownResponse_act == 1){Response_Distributor_ShutdownResponse();}}  ...
_0x3A6:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3A8
	LDS  R26,_Distributor_ShutdownResponse_act
	CPI  R26,LOW(0x1)
	BRNE _0x3A9
	CALL _Response_Distributor_ShutdownResponse
_0x3A9:
; 0000 0D84 
; 0000 0D85        if(send_process_count == 5){if(Distributor_ShutdownErroResponse_act == 1){Response_Distributor_ShutdownErroRespon ...
_0x3A8:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3AA
	LDS  R26,_Distributor_ShutdownErroResponse_act
	CPI  R26,LOW(0x1)
	BRNE _0x3AB
	CALL _Response_Distributor_ShutdownErroResponse
_0x3AB:
; 0000 0D86 
; 0000 0D87        if(send_process_count == 6){if(Distributor_PoBIT_act == 1){Response_Distributor_PoBITResponse();}}
_0x3AA:
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3AC
	LDS  R26,_Distributor_PoBIT_act
	CPI  R26,LOW(0x1)
	BRNE _0x3AD
	CALL _Response_Distributor_PoBITResponse
_0x3AD:
; 0000 0D88 
; 0000 0D89        if(send_process_count == 7){if(Distributor_PoBIT_act_pre == 1){Response_Distributor_PoBITResponse_pre();}}
_0x3AC:
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3AE
	LDS  R26,_Distributor_PoBIT_act_pre
	CPI  R26,LOW(0x1)
	BRNE _0x3AF
	CALL _Response_Distributor_PoBITResponse_pre
_0x3AF:
; 0000 0D8A 
; 0000 0D8B        if(send_process_count == 4){if((Distributor_PBIT_act == 1) && (ADDRESS_3 == 1)){Response_Distributor_PBIT();}}  / ...
_0x3AE:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3B0
	LDS  R26,_Distributor_PBIT_act
	CPI  R26,LOW(0x1)
	BRNE _0x3B2
	LDS  R30,259
	ANDI R30,LOW(0x1)
	LDI  R26,LOW(1)
	CALL __EQB12
	CPI  R30,LOW(0x1)
	BREQ _0x3B3
_0x3B2:
	RJMP _0x3B1
_0x3B3:
	CALL _Response_Distributor_PBIT
_0x3B1:
; 0000 0D8C 
; 0000 0D8D        if((send_process_count == 9)&&((Distributor_TimeSyncAck_act == 0)&&(Distributor_ShutdownResponse_act == 0)&&(Dist ...
_0x3B0:
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	CP   R30,R7
	CPC  R31,R8
	BRNE _0x3B5
	LDS  R26,_Distributor_TimeSyncAck_act
	CPI  R26,LOW(0x0)
	BRNE _0x3B6
	LDS  R26,_Distributor_ShutdownResponse_act
	CPI  R26,LOW(0x0)
	BRNE _0x3B6
	LDS  R26,_Distributor_ShutdownErroResponse_act
	CPI  R26,LOW(0x0)
	BREQ _0x3B7
_0x3B6:
	RJMP _0x3B5
_0x3B7:
	RJMP _0x3B8
_0x3B5:
	RJMP _0x3B4
_0x3B8:
	SBIS 0x1E,1
	RJMP _0x3BA
	LDS  R30,259
	ANDI R30,LOW(0x8)
	LDI  R26,LOW(8)
	CALL __EQB12
	CPI  R30,LOW(0x1)
	BREQ _0x3BB
_0x3BA:
	RJMP _0x3B9
_0x3BB:
	RCALL _Report_Distributor_DeviceStatus
	CBI  0x1E,1
_0x3B9:
; 0000 0D8E 
; 0000 0D8F       // if((send_process_count == 9)&&((Distributor_TimeSyncAck_act == 0)&&(Distributor_ShutdownResponse_act == 0)&&(Di ...
; 0000 0D90 
; 0000 0D91         //if(PoBITResult_act == 1){Response_Distributor_PoBITResponse();}
; 0000 0D92 
; 0000 0D93 
; 0000 0D94         //발전기
; 0000 0D95         if(send_to_ge_active == 1){send_to_ge();}
_0x3B4:
	LDS  R26,_send_to_ge_active
	CPI  R26,LOW(0x1)
	BRNE _0x3BE
	CALL _send_to_ge
; 0000 0D96         //분배반
; 0000 0D97         if(send_to_div_info_act == 1){Request_div_info();}
_0x3BE:
	LDS  R26,_send_to_div_info_act
	CPI  R26,LOW(0x1)
	BRNE _0x3BF
	CALL _Request_div_info
; 0000 0D98 
; 0000 0D99 
; 0000 0D9A 
; 0000 0D9B       }
_0x3BF:
	RJMP _0x307
; 0000 0D9C  }
_0x3C0:
	RJMP _0x3C0
; .FEND

	.CSEG
_rtc_init:
; .FSTART _rtc_init
	CALL SUBOPT_0x30
	ANDI R19,LOW(3)
	CPI  R16,0
	BREQ _0x2000003
	ORI  R19,LOW(16)
_0x2000003:
	CPI  R17,0
	BREQ _0x2000004
	ORI  R19,LOW(128)
_0x2000004:
	CALL SUBOPT_0x31
	LDI  R26,LOW(7)
	CALL _i2c_write
	MOV  R26,R19
	RJMP _0x20A0001
; .FEND
_rtc_get_time:
; .FSTART _rtc_get_time
	CALL SUBOPT_0x32
	LDI  R26,LOW(0)
	CALL SUBOPT_0x33
	MOV  R26,R30
	RCALL _bcd2bin
	MOVW R26,R16
	CALL SUBOPT_0x34
	CALL SUBOPT_0x35
	MOVW R26,R20
	ST   X,R30
	CALL _i2c_stop
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
_rtc_set_time:
; .FSTART _rtc_set_time
	CALL SUBOPT_0x30
	CALL SUBOPT_0x31
	LDI  R26,LOW(0)
	CALL SUBOPT_0x36
	MOV  R26,R16
	CALL _bin2bcd
	MOV  R26,R30
	CALL SUBOPT_0x37
_0x20A0001:
	CALL _i2c_write
	CALL _i2c_stop
	CALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
_rtc_get_date:
; .FSTART _rtc_get_date
	CALL SUBOPT_0x32
	LDI  R26,LOW(3)
	CALL SUBOPT_0x33
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CALL SUBOPT_0x34
	MOVW R26,R20
	CALL SUBOPT_0x34
	CALL SUBOPT_0x35
	MOVW R26,R16
	ST   X,R30
	CALL _i2c_stop
	CALL __LOADLOCR6
	ADIW R28,12
	RET
; .FEND
_rtc_set_date:
; .FSTART _rtc_set_date
	CALL SUBOPT_0x30
	LDD  R18,Y+6
	CALL SUBOPT_0x31
	LDI  R26,LOW(3)
	CALL _i2c_write
	MOV  R26,R18
	CALL SUBOPT_0x37
	CALL _i2c_write
	MOV  R26,R16
	CALL _bin2bcd
	MOV  R26,R30
	CALL SUBOPT_0x36
	CALL _i2c_stop
	CALL __LOADLOCR4
	ADIW R28,7
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_putchar:
; .FSTART _putchar
	ST   -Y,R17
	MOV  R17,R26
_0x2020003:
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BREQ _0x2020003
	STS  198,R17
	LD   R17,Y+
	RET
; .FEND

	.CSEG
_bcd2bin:
; .FSTART _bcd2bin
	ST   -Y,R26
    ld   r30,y
    swap r30
    andi r30,0xf
    mov  r26,r30
    lsl  r26
    lsl  r26
    add  r30,r26
    lsl  r30
    ld   r26,y+
    andi r26,0xf
    add  r30,r26
    ret
; .FEND
_bin2bcd:
; .FSTART _bin2bcd
	ST   -Y,R26
    ld   r26,y+
    clr  r30
bin2bcd0:
    subi r26,10
    brmi bin2bcd1
    subi r30,-16
    rjmp bin2bcd0
bin2bcd1:
    subi r26,-10
    add  r30,r26
    ret
; .FEND

	.CSEG

	.CSEG

	.DSEG
_temp_b:
	.BYTE 0x2
_temp_c:
	.BYTE 0x2
_temp_out_to_pc_count:
	.BYTE 0x2
_temp_out_pbit_count:
	.BYTE 0x2
_bat_volt_1:
	.BYTE 0x2
_bat_volt_2:
	.BYTE 0x2
_year:
	.BYTE 0x1
_month:
	.BYTE 0x1
_week:
	.BYTE 0x1
_day:
	.BYTE 0x1
_hour:
	.BYTE 0x1
_minute:
	.BYTE 0x1
_sec:
	.BYTE 0x1

	.ESEG

	.ORG 0x2
_keep_year:
	.BYTE 0x1

	.ORG 0x0

	.ORG 0x4
_keep_month:
	.BYTE 0x1

	.ORG 0x0

	.ORG 0x6
_keep_day:
	.BYTE 0x1

	.ORG 0x0

	.ORG 0x7
_keep_hour:
	.BYTE 0x1

	.ORG 0x0

	.ORG 0x9
_keep_minute:
	.BYTE 0x1

	.ORG 0x0

	.ORG 0xB
_keep_sec:
	.BYTE 0x1

	.ORG 0x0

	.DSEG
_voltage_1:
	.BYTE 0x2
_currunt_1:
	.BYTE 0x2
_voltage_2:
	.BYTE 0x2
_currunt_2:
	.BYTE 0x2
_voltage_ch1_1:
	.BYTE 0x2
_voltage_ch2_1:
	.BYTE 0x2
_voltage_ch3_1:
	.BYTE 0x2
_voltage_ch4_1:
	.BYTE 0x2
_voltage_ch5_1:
	.BYTE 0x2
_voltage_ch6_1:
	.BYTE 0x2
_voltage_ch7_1:
	.BYTE 0x2
_voltage_m48_1:
	.BYTE 0x2
_voltage_fan_1:
	.BYTE 0x2
_currunt_ch1_1:
	.BYTE 0x2
_currunt_ch2_1:
	.BYTE 0x2
_currunt_ch3_1:
	.BYTE 0x2
_currunt_ch4_1:
	.BYTE 0x2
_currunt_ch5_1:
	.BYTE 0x2
_currunt_ch6_1:
	.BYTE 0x2
_currunt_ch7_1:
	.BYTE 0x2
_voltage_m24_1:
	.BYTE 0x2
_currunt_fan_1:
	.BYTE 0x2
_voltage_ch1_2:
	.BYTE 0x2
_voltage_ch2_2:
	.BYTE 0x2
_voltage_ch3_2:
	.BYTE 0x2
_voltage_ch4_2:
	.BYTE 0x2
_voltage_ch5_2:
	.BYTE 0x2
_voltage_ch6_2:
	.BYTE 0x2
_voltage_ch7_2:
	.BYTE 0x2
_voltage_m48_2:
	.BYTE 0x2
_voltage_fan_2:
	.BYTE 0x2
_currunt_ch1_2:
	.BYTE 0x2
_currunt_ch2_2:
	.BYTE 0x2
_currunt_ch3_2:
	.BYTE 0x2
_currunt_ch4_2:
	.BYTE 0x2
_currunt_ch5_2:
	.BYTE 0x2
_currunt_ch6_2:
	.BYTE 0x2
_currunt_ch7_2:
	.BYTE 0x2
_voltage_m24_2:
	.BYTE 0x2
_currunt_fan_2:
	.BYTE 0x2
_div_48v:
	.BYTE 0x2
_ac48_ovp:
	.BYTE 0x1
_ac48_lvp:
	.BYTE 0x1
_dc48_ovp:
	.BYTE 0x1
_dc48_lvp:
	.BYTE 0x1
_deiver_48_err:
	.BYTE 0x1
_buzzer_count:
	.BYTE 0x2
_data_buffer1_temp:
	.BYTE 0x5C
_data_buffer2_temp:
	.BYTE 0x5C
_data_buffer_ge_temp:
	.BYTE 0xA
_batt_level_1:
	.BYTE 0x1
_err_main_1:
	.BYTE 0x1
_err1_1:
	.BYTE 0x1
_err2_1:
	.BYTE 0x1
_status_1:
	.BYTE 0x1
_batt_level_2:
	.BYTE 0x1
_err_main_2:
	.BYTE 0x1
_err1_2:
	.BYTE 0x1
_err2_2:
	.BYTE 0x1
_status_2:
	.BYTE 0x1
_CRC_H:
	.BYTE 0x1
_CRC_L:
	.BYTE 0x1
_ge_voltage_h:
	.BYTE 0x1
_ge_voltage_l:
	.BYTE 0x1
_ge_currunt_h:
	.BYTE 0x1
_ge_currunt_l:
	.BYTE 0x1
_ge_err_data:
	.BYTE 0x1
_voltage_ge:
	.BYTE 0x2
_currunt_ge:
	.BYTE 0x2
_ge_err_act:
	.BYTE 0x1
_ge_err_latch:
	.BYTE 0x1
_pobit_result:
	.BYTE 0x1
_pbit_result:
	.BYTE 0x1
_batt_charge_1:
	.BYTE 0x1
_batt_charge_2:
	.BYTE 0x1
_batt_discharge_1:
	.BYTE 0x1
_batt_discharge_2:
	.BYTE 0x1
_err_fan_1:
	.BYTE 0x1
_err_fan_2:
	.BYTE 0x1
_time_data_get_act:
	.BYTE 0x1
_led_flash:
	.BYTE 0x1
_time_data_get:
	.BYTE 0x1
_temp_control_1:
	.BYTE 0x1
_temp_control_2:
	.BYTE 0x1
_temp_control_1_:
	.BYTE 0x1
_temp_control_2_:
	.BYTE 0x1
_temp_control_1_old:
	.BYTE 0x1
_temp_control_2_old:
	.BYTE 0x1
_temp_control_sel:
	.BYTE 0x1
_send_to_div_act:
	.BYTE 0x1
_send_to_div_info_act:
	.BYTE 0x1
_dt_err_act_buzzer:
	.BYTE 0x1
_ge_err_act_buzzer:
	.BYTE 0x1
_batt_err_1_act:
	.BYTE 0x1
_batt_err_2_act:
	.BYTE 0x1
_batt_err_1_act_buzzer:
	.BYTE 0x1
_batt_err_2_act_buzzer:
	.BYTE 0x1
_power_link1_err_act_buzzer:
	.BYTE 0x1
_power_link2_err_act_buzzer:
	.BYTE 0x1
_sw_status:
	.BYTE 0x1
_power_link_1:
	.BYTE 0x1
_power_link_2:
	.BYTE 0x1
_power_link1_err:
	.BYTE 0x1
_power_link2_err:
	.BYTE 0x1
_loss_count_a:
	.BYTE 0x2
_loss_count_ge:
	.BYTE 0x2
_link_err_detail:
	.BYTE 0x2
_div_err_detail:
	.BYTE 0x1
_power_1_err_detail:
	.BYTE 0x1
_power_2_err_detail:
	.BYTE 0x1
_bat_1_err_detail:
	.BYTE 0x1
_bat_2_err_detail:
	.BYTE 0x1
_gen_err_detail:
	.BYTE 0x1
_power_1_err:
	.BYTE 0x1
_power_2_err:
	.BYTE 0x1
_err_bat1_temp:
	.BYTE 0x1
_err_bat2_temp:
	.BYTE 0x1
_err_bat1_volt:
	.BYTE 0x1
_err_bat2_volt:
	.BYTE 0x1
_err_bat1_curr:
	.BYTE 0x1
_err_bat2_curr:
	.BYTE 0x1
_Common_CheckLink_number:
	.BYTE 0x1
_Distributor_ShutdownErroResponse_number:
	.BYTE 0x1
_Distributor_BITBetailResponse_number:
	.BYTE 0x1
_Distributor_PBIT_number:
	.BYTE 0x1
_Distributor_TimeSyncAck_number:
	.BYTE 0x1
_Distributor_ShutdownResponse_number:
	.BYTE 0x1
_PoBITResult_number:
	.BYTE 0x1
_PoBITResult_number_ack:
	.BYTE 0x1
_Distributor_devicestatus_number:
	.BYTE 0x1
_Common_CHeckLink_act:
	.BYTE 0x1
_Distributor_PBIT_act:
	.BYTE 0x1
_Distributor_ShutdownResponse_act:
	.BYTE 0x1
_Distributor_ShutdownErroResponse_act:
	.BYTE 0x1
_Distributor_TimeSyncAck_act:
	.BYTE 0x1
_Distributor_BITDetailResponse_act:
	.BYTE 0x1
_Distributor_PoBIT_act:
	.BYTE 0x1
_Distributor_PoBIT_act_pre:
	.BYTE 0x1
_send_to_ge_active:
	.BYTE 0x1
_po_bit_recive_data_detail:
	.BYTE 0x1
_ge_data_kind:
	.BYTE 0x1
_mode_change_and_init:
	.BYTE 0x1
_mode_change_count:
	.BYTE 0x1
_buzzer_out_wait:
	.BYTE 0x1
_init_mod_switch:
	.BYTE 0x1
_rx_buffer0:
	.BYTE 0x8
_rx_wr_index0:
	.BYTE 0x1
_rx_rd_index0:
	.BYTE 0x1
_rx_counter0:
	.BYTE 0x1
_rx_buffer1:
	.BYTE 0x8
_rx_wr_index1:
	.BYTE 0x1
_rx_rd_index1:
	.BYTE 0x1
_rx_counter1:
	.BYTE 0x1
_rx_buffer2:
	.BYTE 0x8
_rx_wr_index2:
	.BYTE 0x1
_rx_rd_index2:
	.BYTE 0x1
_rx_counter2:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x0:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 39 TIMES, CODE SIZE REDUCTION:149 WORDS
SUBOPT_0x1:
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	STS  _voltage_1,R30
	STS  _voltage_1+1,R30
	STS  _currunt_1,R30
	STS  _currunt_1+1,R30
	STS  _bat_volt_1,R30
	STS  _bat_volt_1+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	STS  _currunt_1,R30
	STS  _currunt_1+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(_hour)
	LDI  R31,HIGH(_hour)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_minute)
	LDI  R31,HIGH(_minute)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_sec)
	LDI  R27,HIGH(_sec)
	JMP  _rtc_get_time

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(0)
	STS  _voltage_2,R30
	STS  _voltage_2+1,R30
	STS  _currunt_2,R30
	STS  _currunt_2+1,R30
	STS  _bat_volt_2,R30
	STS  _bat_volt_2+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	STS  _currunt_2,R30
	STS  _currunt_2+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(_week)
	LDI  R31,HIGH(_week)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_day)
	LDI  R31,HIGH(_day)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_month)
	LDI  R31,HIGH(_month)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_year)
	LDI  R27,HIGH(_year)
	JMP  _rtc_get_date

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(0)
	__PUTB1MN _data_buffer2_temp,13
	__PUTB1MN _data_buffer2_temp,12
	__PUTB1MN _data_buffer2_temp,11
	__PUTB1MN _data_buffer2_temp,10
	__PUTB1MN _data_buffer2_temp,9
	__PUTB1MN _data_buffer2_temp,8
	__PUTB1MN _data_buffer2_temp,7
	__PUTB1MN _data_buffer2_temp,6
	__PUTB1MN _data_buffer2_temp,5
	__PUTB1MN _data_buffer2_temp,4
	__PUTB1MN _data_buffer2_temp,3
	__PUTB1MN _data_buffer2_temp,2
	__PUTB1MN _data_buffer2_temp,1
	STS  _data_buffer2_temp,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:129 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(0)
	__PUTB1MN _data_buffer2_temp,7
	__PUTB1MN _data_buffer2_temp,6
	__PUTB1MN _data_buffer2_temp,5
	__PUTB1MN _data_buffer2_temp,4
	__PUTB1MN _data_buffer2_temp,3
	__PUTB1MN _data_buffer2_temp,2
	__PUTB1MN _data_buffer2_temp,1
	STS  _data_buffer2_temp,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(0)
	__PUTB1MN _data_buffer2_temp,8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xB:
	__GETB1MN _data_buffer_ge_temp,1
	STS  _CRC_H,R30
	LDS  R30,_data_buffer_ge_temp
	STS  _CRC_L,R30
	LDI  R30,LOW(0)
	STS  _loss_count_ge,R30
	STS  _loss_count_ge+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xC:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(1)
	CALL _putchar2
	LDI  R26,LOW(3)
	CALL _putchar2
	LDI  R26,LOW(35)
	JMP  _putchar2

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xE:
	CALL _putchar2
	LDI  R26,LOW(0)
	CALL _putchar2
	LDI  R26,LOW(1)
	JMP  _putchar2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(127)
	CALL _putchar
	LDI  R26,LOW(254)
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x10:
	LDI  R26,LOW(0)
	CALL _putchar
	LDI  R26,LOW(0)
	CALL _putchar
	LDI  R26,LOW(0)
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	LDI  R26,LOW(13)
	CALL _putchar
	LDI  R26,LOW(10)
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x12:
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x13:
	MOV  R4,R30
	MOV  R26,R16
	CALL _num_convert
	CLR  R0
	CP   R0,R11
	CPC  R0,R12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x14:
	LDI  R30,LOW(11)
	MOV  R4,R30
	LDI  R30,LOW(5)
	MOV  R3,R30
	LDI  R26,LOW(3)
	LDI  R27,0
	CALL _fnd_out
	LDI  R30,LOW(10)
	MOV  R4,R30
	LDI  R30,LOW(3)
	MOV  R3,R30
	LDI  R26,LOW(3)
	LDI  R27,0
	CALL _fnd_out
	LDI  R30,LOW(9)
	MOV  R4,R30
	CLR  R3
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _fnd_out

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	MOV  R4,R30
	LDI  R30,LOW(1)
	MOV  R3,R30
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _fnd_out

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x16:
	ST   -Y,R30
	MOV  R26,R11
	JMP  _digit1

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	ST   -Y,R30
	MOV  R26,R11
	JMP  _digit2

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	ST   -Y,R30
	MOV  R26,R11
	JMP  _digit4

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x19:
	ST   -Y,R30
	MOV  R26,R11
	JMP  _digit5

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1A:
	LDS  R26,_voltage_1
	LDS  R27,_voltage_1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1B:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1C:
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	LDI  R26,LOW(100)
	LDI  R27,HIGH(100)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	SUB  R26,R30
	SBC  R27,R31
	RJMP SUBOPT_0x1B

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1F:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x20:
	LDS  R26,_voltage_2
	LDS  R27,_voltage_2+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x21:
	RCALL SUBOPT_0x20
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x22:
	LDS  R26,_currunt_1
	LDS  R27,_currunt_1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x23:
	RCALL SUBOPT_0x22
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x24:
	LDS  R26,_currunt_2
	LDS  R27,_currunt_2+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x25:
	RCALL SUBOPT_0x24
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	LDS  R26,_bat_volt_1
	LDS  R27,_bat_volt_1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x27:
	LDS  R26,_bat_volt_2
	LDS  R27,_bat_volt_2+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x28:
	CALL _putchar1
	LDI  R26,LOW(40)
	CALL _putchar1
	LDI  R26,LOW(32)
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x29:
	CALL _putchar1
	LDI  R26,LOW(36)
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2A:
	LDI  R26,LOW(0)
	CALL _putchar1
	LDI  R26,LOW(0)
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2B:
	LDI  R26,LOW(1)
	CALL _putchar1
	LDI  R26,LOW(0)
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2C:
	CALL _putchar1
	LDI  R26,LOW(0)
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2D:
	CALL __EEPROMRDB
	MOV  R26,R30
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2E:
	LDI  R26,LOW(56)
	CALL _putchar1
	LDI  R26,LOW(1)
	RJMP SUBOPT_0x28

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x2F:
	LDS  R30,_link_err_detail
	LDS  R31,_link_err_detail+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x30:
	RCALL __SAVELOCR4
	MOV  R17,R26
	LDD  R16,Y+4
	LDD  R19,Y+5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x31:
	CALL _i2c_start
	LDI  R26,LOW(208)
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x32:
	RCALL __SAVELOCR6
	MOVW R16,R26
	__GETWRS 18,19,6
	__GETWRS 20,21,8
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x33:
	CALL _i2c_write
	CALL _i2c_stop
	CALL _i2c_start
	LDI  R26,LOW(209)
	CALL _i2c_write
	LDI  R26,LOW(1)
	JMP  _i2c_read

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x34:
	ST   X,R30
	LDI  R26,LOW(1)
	CALL _i2c_read
	MOV  R26,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x35:
	MOVW R26,R18
	ST   X,R30
	LDI  R26,LOW(0)
	CALL _i2c_read
	MOV  R26,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x36:
	CALL _i2c_write
	MOV  R26,R17
	CALL _bin2bcd
	MOV  R26,R30
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x37:
	CALL _i2c_write
	MOV  R26,R19
	CALL _bin2bcd
	MOV  R26,R30
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	NEG  R27
	NEG  R26
	SBCI R27,0
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

	.equ __scl_bit=1
	.equ __sda_bit=2
	.equ __i2c_port_scl=0x11
	.equ __i2c_dir_scl=__i2c_port_scl-1
	.equ __i2c_pin_scl=__i2c_port_scl-2
	.equ __i2c_port_sda=0x11
	.equ __i2c_dir_sda=__i2c_port_sda-1
	.equ __i2c_pin_sda=__i2c_port_sda-2

_i2c_init:
	cbi  __i2c_port_scl,__scl_bit
	cbi  __i2c_port_sda,__sda_bit
	sbi  __i2c_dir_scl,__scl_bit
	cbi  __i2c_dir_sda,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir_sda,__sda_bit
	cbi  __i2c_dir_scl,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin_sda,__sda_bit
	ret
	sbis __i2c_pin_scl,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir_sda,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir_scl,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,7
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir_sda,__sda_bit
	sbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir_sda,__sda_bit
__i2c_delay2:
	ldi  r22,14
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin_scl,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin_sda,__sda_bit
	sec
	sbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	mov  r23,r26
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir_sda,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir_sda,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir_sda,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ldi  r23,8
__i2c_write0:
	lsl  r26
	brcc __i2c_write1
	cbi  __i2c_dir_sda,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir_sda,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin_scl,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir_scl,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir_sda,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir_scl,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin_sda,__sda_bit
	clr  r30
	sbi  __i2c_dir_scl,__scl_bit
	rjmp __i2c_delay1

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xACD
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
