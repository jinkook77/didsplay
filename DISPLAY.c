//*******************************************************
//This program was created by the CodeWizardAVR V3.35
//Automatic Program Generator
//Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
//http://www.hpinfotech.com
//
//Project :
//Version :
//Date    : 2019-08-15                                                3Author  :
//Company :
//Comments:
//
//
//Chip type               : ATmega2560
//Program type            : Application
//AVR Core Clock frequency: 11.059200 MHz
//Memory model            : Small
//External RAM size       : 0
//Data Stack size         : 2048
//*******************************************************/

#include <mega2560.h>
#include <delay.h>

 // Bit-Banged I2C Bus functions
#include <i2c.h>

// DS1307 Real Time Clock functions
#include <ds1307.h>


//PORT DEFINE
#define DT_NORMAL PORTA.4
#define DT_ERR PORTA.5
#define GE_NORMAL PORTA.6
#define GE_ERR PORTA.7
#define BAT_RUN_1 PORTE.4
#define BAT_RUN_2 PORTE.5
#define BAT_ERR_1 PORTE.6
#define BAT_ERR_2 PORTE.7

//TEST LED
#define TEST_LED_1 PORTC.5
#define TEST_LED_2 PORTC.6

//BUZZER
#define BUZZER_HIGH PORTB.5
#define BUZZER_STOP PINB.4


// BUZZER STOP KEY
#define BUZZER_STOP_KEY PINB.4

//ADDRESS
#define ADDRESS_0 (PINJ & 0X08) == 0X08
#define ADDRESS_1 (PINJ & 0X04) == 0X04
#define ADDRESS_2 (PINJ & 0X02) == 0X02
#define ADDRESS_3 (PINJ & 0X01) == 0X01

//FND
#define LED_DIN PORTC.4
#define LED_CLK PORTC.3
#define LED_LOAD PORTC.2
#define LED_LOAD_A PORTC.1
#define LED_LOAD_B PORTC.0

//RE_DE
#define RE_DE0 PORTE.2
#define RE_DE1 PORTE.3

//LAN
#define LAN_RESET PORTD.0
#define LAN_STS PIND.1
#define LAN_CTS PIND.5
#define LAN_ISP PORTD.4
#define LAN_RTS PIND.6
#define LAN_TSP PIND.7

// HOT SWAP
#define DIS_HOT_SWAP PINB.0


//VALUE DEFIEN
#define ON 1
#define OFF 0

#define ERR 1
#define NOR 0


#define buzzer_err_delay 3000 //부저 울리는 딜레이 시간 처리

// Declare your global variables here
char command;
char fnd_data;
int count_temp;
int send_process_count;
int digit_num;
int digit;

//timer
int temp_a;
int temp_b;
int temp_c;
int temp_out_to_pc_count;
int temp_out_pbit_count;
// 데이터 변수
int bat_volt_1;
int bat_volt_2;

// rtc변수
//unsigned char week_day,day,month,year;
unsigned char year;
unsigned char month;
unsigned char week;
unsigned char day;
unsigned char hour;
unsigned char minute;
unsigned char sec;

//time
eeprom unsigned char keep_year @0x02;
eeprom unsigned char keep_month @0x04;
eeprom unsigned char keep_day @0x06;
eeprom unsigned char keep_hour @0x07;
eeprom unsigned char keep_minute @0x09;
eeprom unsigned char keep_sec @0x0b;



//버퍼
unsigned int voltage_1;
unsigned int currunt_1;
unsigned int voltage_2;
unsigned int currunt_2;


//전압
unsigned int voltage_ch1_1;
unsigned int voltage_ch2_1;
unsigned int voltage_ch3_1;
unsigned int voltage_ch4_1;
unsigned int voltage_ch5_1;
unsigned int voltage_ch6_1;
unsigned int voltage_ch7_1;

unsigned int voltage_m48_1;
unsigned int voltage_fan_1;

//전류
unsigned int currunt_ch1_1;
unsigned int currunt_ch2_1;
unsigned int currunt_ch3_1;
unsigned int currunt_ch4_1;
unsigned int currunt_ch5_1;
unsigned int currunt_ch6_1;
unsigned int currunt_ch7_1;

unsigned int voltage_m24_1;
unsigned int currunt_fan_1;

//전압
unsigned int voltage_ch1_2;
unsigned int voltage_ch2_2;
unsigned int voltage_ch3_2;
unsigned int voltage_ch4_2;
unsigned int voltage_ch5_2;
unsigned int voltage_ch6_2;
unsigned int voltage_ch7_2;

unsigned int voltage_m48_2;
unsigned int voltage_fan_2;

//전류
unsigned int currunt_ch1_2;
unsigned int currunt_ch2_2;
unsigned int currunt_ch3_2;
unsigned int currunt_ch4_2;
unsigned int currunt_ch5_2;
unsigned int currunt_ch6_2;
unsigned int currunt_ch7_2;

unsigned int voltage_m24_2;
unsigned int currunt_fan_2;

//div  48v
unsigned int div_48v;
unsigned char ac48_ovp = 0;
unsigned char ac48_lvp = 0;
unsigned char dc48_ovp = 0;
unsigned char dc48_lvp = 0;
unsigned char deiver_48_err = 0;


// buzzer
bit buzzer_on;
unsigned int buzzer_count = 0;
unsigned char data_buffer1_temp[92] = "";
unsigned char data_buffer2_temp[92] = "";
unsigned char data_buffer_ge_temp[10] = "";
//battery 1
unsigned char batt_level_1 = 0;
unsigned char err_main_1 = 0;
unsigned char err1_1 = 0;
unsigned char err2_1 = 0;
unsigned char status_1 = 0;

//battery 2
unsigned char batt_level_2 = 0;
unsigned char err_main_2 = 0;
unsigned char err1_2 = 0;
unsigned char err2_2 = 0;
unsigned char status_2 = 0;

//battery data
//unsigned char batt_record_data = 0;

//GENERATOR
unsigned char CRC_H = 0;
unsigned char CRC_L = 0;
unsigned char ge_voltage_h  = 0;
unsigned char ge_voltage_l = 0;
unsigned char ge_currunt_h  = 0;
unsigned char ge_currunt_l = 0;
unsigned char ge_err_data  = 0;
unsigned int voltage_ge = 0;
unsigned int currunt_ge = 0;
unsigned char ge_err_act = 0;
unsigned char ge_err_latch = 0;

//pc transmmit confirm
bit send_to_pc_active;


//BIT RESULT
unsigned char pobit_result = 0;
unsigned char pbit_result = 0;

//
unsigned char batt_charge_1 = 0;
unsigned char batt_charge_2 = 0;
unsigned char batt_discharge_1 = 0;
unsigned char batt_discharge_2 = 0;
unsigned char err_fan_1 = 0;
unsigned char err_fan_2 = 0;

//battery
bit batt_link_err_act_1 = 0;
bit batt_link_err_act_2 = 0;
bit batt_run_act_1 = 0;
bit batt_run_act_2 = 0;

//시간 기록 한번만 처리
unsigned char time_data_get_act = 0;

//hot swap
bit dt_err_act;
unsigned char led_flash = 0;
// 시간명령 입력
unsigned char time_data_get = 0;

//control temp
unsigned char temp_control_1 = 0;
unsigned char temp_control_2 = 0;
unsigned char temp_control_1_ = 0;
unsigned char temp_control_2_ = 0;

unsigned char temp_control_1_old = 0xff;
unsigned char temp_control_2_old = 0xff;

unsigned char temp_control_sel = 0;

//send to div 데이터 전송 실시
unsigned char send_to_div_act = 0;
unsigned char send_to_div_info_act = 0;

//부저 한번만 울림
unsigned char dt_err_act_buzzer = 0;
unsigned char ge_err_act_buzzer = 0;
unsigned char batt_err_1_act = 0;
unsigned char batt_err_2_act = 0;
unsigned char batt_err_1_act_buzzer = 0;
unsigned char batt_err_2_act_buzzer = 0;
unsigned char power_link1_err_act_buzzer = 0;
unsigned char power_link2_err_act_buzzer = 0;

// switch _status
unsigned char sw_status = 0;

//power_link for div
unsigned char power_link_1 = 0;;
unsigned char power_link_2 = 0;
unsigned char power_link1_err = 0;
unsigned char power_link2_err = 0;

// 통신단절 카운트
unsigned int loss_count_a, loss_count_ge = 0;
bit comm_err = 0;
bit comm_ge_err = 0;
const int loss_active_delay_time = 40;//40 //30; //10
const int loss_ge_active_delay_time = 20;//발전기 링크 에러 처리
//unsigned char comm_err_temp = 0;
//unsigned int comm_err_count = 0;
//unsigned char error_item = 0;

//detail error
unsigned int link_err_detail;
unsigned char div_err_detail = 0;
unsigned char power_1_err_detail = 0;
unsigned char power_2_err_detail = 0;
unsigned char bat_1_err_detail = 0;
unsigned char bat_2_err_detail = 0;
unsigned char gen_err_detail = 0;

unsigned char power_1_err = 0;
unsigned char power_2_err = 0;

unsigned char err_bat1_temp = 0;
unsigned char err_bat2_temp = 0;
unsigned char err_bat1_volt = 0;
unsigned char err_bat2_volt = 0;
unsigned char err_bat1_curr = 0;
unsigned char err_bat2_curr = 0;

// message_count
unsigned char Common_CheckLink_number = 0;
unsigned char Distributor_ShutdownErroResponse_number = 0;
//unsigned char Distributor_PoBITResponse_number = 0;
unsigned char Distributor_BITBetailResponse_number = 0;
unsigned char Distributor_PBIT_number = 0;
unsigned char Distributor_TimeSyncAck_number = 0;
unsigned char Distributor_ShutdownResponse_number = 0;
//unsigned char Distributor_PoBITResponse = 0;
unsigned char PoBITResult_number = 0;
unsigned char PoBITResult_number_ack = 0;
unsigned char Distributor_devicestatus_number = 0;

unsigned char Common_CHeckLink_act = 0;
unsigned char Distributor_PBIT_act = 0;
unsigned char Distributor_ShutdownResponse_act = 0;
unsigned char Distributor_ShutdownErroResponse_act = 0;
unsigned char Distributor_TimeSyncAck_act = 0;
//unsigned char Distributor_PoBITResponse_act_pre = 0;
unsigned char Distributor_BITDetailResponse_act = 0;
unsigned char Distributor_PoBIT_act = 0;
unsigned char Distributor_PoBIT_act_pre = 0;
unsigned char send_to_ge_active = 0;//485 발전기와 통신
unsigned char po_bit_recive_data_detail = 0; //수신데이터
//unsigned char po_bit_set_recive_data = 0;

unsigned char ge_data_kind = 1;

//초기 부저 안울리게 처리
#define mode_change_count_max 80    //10
unsigned char mode_change_and_init = 0;
unsigned char mode_change_count = 0;
unsigned char buzzer_out_wait = 0;
unsigned char init_mod_switch = 0;
#define DATA_REGISTER_EMPTY (1<<UDRE0)
#define RX_COMPLETE (1<<RXC0)
#define FRAMING_ERROR (1<<FE0)
#define PARITY_ERROR (1<<UPE0)
#define DATA_OVERRUN (1<<DOR0)

// USART0 Receiver buffer
#define RX_BUFFER_SIZE0 8
char rx_buffer0[RX_BUFFER_SIZE0];

#if RX_BUFFER_SIZE0 <= 256
volatile unsigned char rx_wr_index0=0,rx_rd_index0=0;
#else
volatile unsigned int rx_wr_index0=0,rx_rd_index0=0;
#endif

#if RX_BUFFER_SIZE0 < 256
volatile unsigned char rx_counter0=0;
#else
volatile unsigned int rx_counter0=0;
#endif

// This flag is set on USART0 Receiver buffer overflow
bit rx_buffer_overflow0;

void buzzer_clear_all(void)
{
    dt_err_act_buzzer = OFF;
    ge_err_act_buzzer = OFF;
    batt_err_1_act_buzzer = OFF;
    batt_err_2_act_buzzer = OFF;
    power_link1_err_act_buzzer = OFF;
    power_link2_err_act_buzzer = OFF;
    buzzer_on = OFF;
}


void data_clear()
{
         voltage_ch1_2 = 0;
         currunt_ch1_2 = 0;
         voltage_ch2_2 = 0;
         currunt_ch2_2 = 0;
         voltage_ch3_2 = 0;
         currunt_ch3_2 = 0;
         voltage_ch4_2 = 0;
         currunt_ch4_2 = 0;
         voltage_ch5_2 = 0;
         currunt_ch5_2 = 0;
         voltage_ch6_2 = 0;
         currunt_ch6_2 = 0;
         voltage_ch7_2 = 0;
         currunt_ch7_2 = 0;

         voltage_m48_2 = 0;
         voltage_m24_2 = 0;

         voltage_fan_2 = 0;
         currunt_fan_2 = 0;

         batt_level_2 = 0;
         err_main_2 = 0;
         err1_2 = 0;
         err2_2 = 0;
         status_2 = 0;

         voltage_ch1_1 = 0;
         currunt_ch1_1 = 0;
         voltage_ch2_1 = 0;
         currunt_ch2_1 = 0;
         voltage_ch3_1 = 0;
         currunt_ch3_1 = 0;
         voltage_ch4_1 = 0;
         currunt_ch4_1 = 0;
         voltage_ch5_1 = 0;
         currunt_ch5_1 = 0;
         voltage_ch6_1 = 0;
         currunt_ch6_1 = 0;
         voltage_ch7_1 = 0;
         currunt_ch7_1 = 0;

         voltage_m48_1 = 0;
         voltage_m24_1 = 0;

         voltage_fan_1 = 0;
         currunt_fan_1 = 0;

         batt_level_1 = 0;
         err_main_1 = 0;
         err1_1 = 0;
         err2_1 = 0;
         status_1 = 0;
}




// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
unsigned char status;
char data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer0[rx_wr_index0++]=data;
#if RX_BUFFER_SIZE0 == 256
   // special case for receiver buffer size=256
   if (++rx_counter0 == 0) rx_buffer_overflow0=1;
#else
   if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
   if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      }
#endif
   }



  if(data == 0x0a )
   {
       //시험용 삭제요망
//       if(data_buffer2_temp[5] == 0x7f && data_buffer2_temp[4] == 0x77 && data_buffer2_temp[0] == 0x0d)
//       {
//        voltage_1 = data_buffer2_temp[3];
//        voltage_2 = data_buffer2_temp[2];
//
//       }


       //채널상태 및 에러정보 요청
     if(data_buffer2_temp[91] == 0x7f && data_buffer2_temp[90] == 0xfe && data_buffer2_temp[0] == 0x0d)      // data_buffer2_temp[90] == 0xfe로 수정 필요
      {
         //전원반 #2
         voltage_ch1_2 = (data_buffer2_temp[89] * 256) + data_buffer2_temp[88];   //v ch1
         currunt_ch1_2 = (data_buffer2_temp[87] * 256) + data_buffer2_temp[86];
         voltage_ch2_2 = (data_buffer2_temp[85] * 256) + data_buffer2_temp[84];   //v ch2
         currunt_ch2_2 = (data_buffer2_temp[83] * 256) + data_buffer2_temp[82];
         voltage_ch3_2 = (data_buffer2_temp[81] * 256) + data_buffer2_temp[80];   //v ch3
         currunt_ch3_2 = (data_buffer2_temp[79] * 256) + data_buffer2_temp[78];
         voltage_ch4_2 = (data_buffer2_temp[77] * 256) + data_buffer2_temp[76];   //v ch4
         currunt_ch4_2 = (data_buffer2_temp[75] * 256) + data_buffer2_temp[74];
         voltage_ch5_2 = (data_buffer2_temp[73] * 256) + data_buffer2_temp[72];   //v ch5
         currunt_ch5_2 = (data_buffer2_temp[71] * 256) + data_buffer2_temp[70];
         voltage_ch6_2 = (data_buffer2_temp[69] * 256) + data_buffer2_temp[68];   //v ch6
         currunt_ch6_2 = (data_buffer2_temp[67] * 256) + data_buffer2_temp[66];
         voltage_ch7_2 = (data_buffer2_temp[65] * 256) + data_buffer2_temp[64];   //v ch7
         currunt_ch7_2 = (data_buffer2_temp[63] * 256) + data_buffer2_temp[62];
         voltage_m48_2 = (data_buffer2_temp[61] * 256) + data_buffer2_temp[60];
         voltage_m24_2 = (data_buffer2_temp[59] * 256) + data_buffer2_temp[58];
         voltage_fan_2 = (data_buffer2_temp[57] * 256) + data_buffer2_temp[56];
         currunt_fan_2 = (data_buffer2_temp[55] * 256) + data_buffer2_temp[54];

         batt_level_2 = data_buffer2_temp[53];
         err_main_2 = data_buffer2_temp[52];
         if((err_main_2 & 0x20)==0x20){err_bat2_temp = ERR;}else{err_bat2_temp = NOR;}
         if((err_main_2 & 0x10)==0x10){err_bat2_volt = ERR;}else{err_bat2_volt = NOR;}
         if((err_main_2 & 0x08)==0x08){err_bat2_curr = ERR;}else{err_bat2_curr = NOR;}
         if((err_main_2 & 0x40)==0x40){batt_link_err_act_2 = ON;}else{batt_link_err_act_2 = OFF;}
         if((err_main_2 & 0x04)==0x04){batt_charge_2 = ON;}else{batt_charge_2 = OFF;}
         if((err_main_2 & 0x02)==0x02){batt_discharge_2 = ON;}else{batt_discharge_2 = OFF;}
         if((batt_discharge_2 == ON)&&(batt_charge_2 == OFF)){batt_run_act_2 = ON;}else{batt_run_act_2 = OFF;}

         //******************************
         //
         if(batt_link_err_act_2 == ON){batt_level_2 = 0;}
         //
         //******************************


         if((err_main_2 & 0x01)==0x01){err_fan_2 = ON;}else{err_fan_2 = OFF;}

         err1_2 = data_buffer2_temp[51];
         err2_2 = data_buffer2_temp[50];
         if((err1_2 != 0x00)||(err2_2 != 0x00)){power_2_err = 0x01;}else{power_2_err = 0x00;}
         status_2 = data_buffer2_temp[49];

         power_link_2 = data_buffer2_temp[48];
         if((power_link_2 & 0x80) == 0x80)
         {
          power_link2_err = 0;
          power_link2_err_act_buzzer = OFF;
         }
         else
         {
          if((power_link2_err == 0)&&(power_link2_err_act_buzzer == OFF)) {power_link2_err_act_buzzer = ON;}
          power_link2_err = 1;
         }
//         if(ADDRESS_0)
//         {
//             voltage_1  = voltage_m24_2;
//             currunt_1  = currunt_ch1_2 + currunt_ch2_2 + currunt_ch3_2 + currunt_ch4_2 + currunt_ch5_2 + currunt_ch6_2 + currunt_ch7_2;
//             bat_volt_1 = batt_level_2;
//         }
//         else
//         {
//             rtc_get_time(&hour,&minute,&sec);
//             //rtc_get_date(&week,&day,&month,&year);
//             voltage_1  = hour;
//             currunt_1  = minute;
//             bat_volt_1 = sec;
//         }


         //전원반 #1
         voltage_ch1_1 = (data_buffer2_temp[47] * 256) + data_buffer2_temp[46];   //v ch1
         currunt_ch1_1 = (data_buffer2_temp[45] * 256) + data_buffer2_temp[44];
         voltage_ch2_1 = (data_buffer2_temp[43] * 256) + data_buffer2_temp[42];   //v ch2
         currunt_ch2_1 = (data_buffer2_temp[41] * 256) + data_buffer2_temp[40];
         voltage_ch3_1 = (data_buffer2_temp[39] * 256) + data_buffer2_temp[38];   //v ch3
         currunt_ch3_1 = (data_buffer2_temp[37] * 256) + data_buffer2_temp[36];
         voltage_ch4_1 = (data_buffer2_temp[35] * 256) + data_buffer2_temp[34];   //v ch4
         currunt_ch4_1 = (data_buffer2_temp[33] * 256) + data_buffer2_temp[32];
         voltage_ch5_1 = (data_buffer2_temp[31] * 256) + data_buffer2_temp[30];   //v ch5
         currunt_ch5_1 = (data_buffer2_temp[29] * 256) + data_buffer2_temp[28];
         voltage_ch6_1 = (data_buffer2_temp[27] * 256) + data_buffer2_temp[26];   //v ch6
         currunt_ch6_1 = (data_buffer2_temp[25] * 256) + data_buffer2_temp[24];
         voltage_ch7_1 = (data_buffer2_temp[23] * 256) + data_buffer2_temp[22];   //v ch7
         currunt_ch7_1 = (data_buffer2_temp[21] * 256) + data_buffer2_temp[20];
         voltage_m48_1 = (data_buffer2_temp[19] * 256) + data_buffer2_temp[18];
         voltage_m24_1 = (data_buffer2_temp[17] * 256) + data_buffer2_temp[16];
         voltage_fan_1 = (data_buffer2_temp[15] * 256) + data_buffer2_temp[14];
         currunt_fan_1 = (data_buffer2_temp[13] * 256) + data_buffer2_temp[12];

         batt_level_1 = data_buffer2_temp[11];
         err_main_1 = data_buffer2_temp[10];

         if((err_main_1 & 0x40)==0x40){batt_link_err_act_1 = ERR;}else{batt_link_err_act_1 = NOR;}
         if((err_main_1 & 0x20)==0x20){err_bat1_temp = ERR;}else{err_bat1_temp = NOR;}
         if((err_main_1 & 0x10)==0x10){err_bat1_volt = ERR;}else{err_bat1_volt = NOR;}
         if((err_main_1 & 0x08)==0x08){err_bat1_curr = ERR;}else{err_bat1_curr = NOR;}
         if((err_main_1 & 0x04)==0x04){batt_charge_1 = ON;}else{batt_charge_1 = OFF;}
         if((err_main_1 & 0x02)==0x02){batt_discharge_1 = ON;}else{batt_discharge_1 = OFF;}

         //******************************
         //
         if(batt_link_err_act_1 == ERR){batt_level_1 = 0;}
         //
         //****



         if((batt_discharge_1 == ON)&&(batt_charge_1 == OFF)){batt_run_act_1 = ON;}else{batt_run_act_1 = OFF;}

         if((err_main_1 & 0x01)==0x01){err_fan_1 = ON;}else{err_fan_1 = OFF;}

         err1_1 = data_buffer2_temp[9];
         err2_1 = data_buffer2_temp[8];
         if((err1_1 != 0x00)||(err2_1 != 0x00)){power_1_err = 0x01;}else{power_1_err = 0x00;}
         status_1 = data_buffer2_temp[7];

         power_link_1 = data_buffer2_temp[6];

         if((power_link_1 & 0x80) == 0x80)
         {
          power_link1_err_act_buzzer = OFF;
          power_link1_err = 0;
         }
         else
         {
          if((power_link1_err == 0)&&(power_link1_err_act_buzzer == OFF)) {power_link1_err_act_buzzer = ON;}
          power_link1_err = 1;
         }
        //devive info
        if((data_buffer2_temp[5] & 0x80) == 0x80){ac48_ovp = ERR;}else{ac48_ovp = NOR;}
        if((data_buffer2_temp[5] & 0x40) == 0x40){ac48_lvp = ERR;}else{ac48_lvp = NOR;}
        if((data_buffer2_temp[5] & 0x20) == 0x20){dc48_ovp = ERR;}else{dc48_ovp = NOR;}
        if((data_buffer2_temp[5] & 0x10) == 0x10){dc48_lvp = ERR;}else{dc48_lvp = NOR;}

       if((ac48_ovp == ERR)||(ac48_lvp == ERR)||(dc48_ovp == ERR)||(dc48_lvp == ERR)){deiver_48_err = ERR;}else{deiver_48_err = NOR;}

        if((data_buffer2_temp[5] & 0x08) == 0x08)
        {
         if(time_data_get_act == 0){time_data_get = 1;}
         time_data_get_act = 1;
        }
        else
        {
          time_data_get = 0;
          time_data_get_act = 0;
        }

         //switch
         sw_status = data_buffer2_temp[4];

         //분배반 48V
         div_48v = (data_buffer2_temp[3] * 256) + data_buffer2_temp[2];

          if(ADDRESS_0)
         {
            if(DT_ERR == ERR)
            {
                voltage_1 = 0;
                currunt_1 = 0;
                bat_volt_1 = 0;
            }
            else
            {
             voltage_1  = voltage_m24_2;//(ge_rx_data_h*256)+ge_rx_data_l;//
             //currunt_1  = currunt_ch1_1 + currunt_ch2_1 + currunt_ch3_1 + currunt_ch4_1 + currunt_ch3_2 + currunt_ch4_2 + currunt_ch7_2 ;
             //currunt_1  =  (currunt_ch1_2 + currunt_ch2_2+ currunt_ch3_2 + currunt_ch4_2+currunt_ch5_2 + currunt_ch6_2+  currunt_ch7_2)/10 ;
             currunt_1  =  (currunt_ch1_2 + currunt_ch2_2+ currunt_ch3_2 + currunt_ch4_2+currunt_ch5_2 + currunt_ch6_2+  currunt_ch7_2) ; //191226
             bat_volt_1 = batt_level_2;
            }
         }
         else
         {
             rtc_get_time(&hour,&minute,&sec);
             //rtc_get_date(&week,&day,&month,&year);
             voltage_1  = hour;
             currunt_1  = minute;
             bat_volt_1 = sec;
         }


         if(ADDRESS_0)
         {
            if(DT_ERR == ERR)
            {
                voltage_2 = 0;
                currunt_2 = 0;
                bat_volt_2 = 0;
            }
            else
            {
                voltage_2  = voltage_m24_1;//(ge_rx_data_err1 * 256)+ge_rx_data_err2; //sw_status;
                //currunt_2  = currunt_ch1_2 + currunt_ch2_2+ currunt_ch5_2 + currunt_ch6_2+ currunt_ch5_1 + currunt_ch6_1 + currunt_ch7_1 ;// div_48v;
                //currunt_2  = (currunt_ch1_1 + currunt_ch2_1 + currunt_ch3_1 + currunt_ch4_1  +currunt_ch5_1 + currunt_ch6_1 + currunt_ch7_1)/10 ;// div_48v;
                currunt_2  = (currunt_ch1_1 + currunt_ch2_1 + currunt_ch3_1 + currunt_ch4_1  +currunt_ch5_1 + currunt_ch6_1 + currunt_ch7_1);// 191226
                bat_volt_2 = batt_level_1;
            }
         }
         else
         {
            //rtc_get_time(&hour,&minute,&sec);
            rtc_get_date(&week,&day,&month,&year);
            voltage_2  = year;
            currunt_2  = month;
            bat_volt_2 = day;
         }


         data_buffer2_temp[91] = '';
         data_buffer2_temp[90] = '';
         data_buffer2_temp[89] = '';
         data_buffer2_temp[88] = '';
         data_buffer2_temp[87] = '';
         data_buffer2_temp[86] = '';
         data_buffer2_temp[85] = '';
         data_buffer2_temp[84] = '';
         data_buffer2_temp[83] = '';
         data_buffer2_temp[82] = '';
         data_buffer2_temp[81] = '';
         data_buffer2_temp[80] = '';
         data_buffer2_temp[79] = '';
         data_buffer2_temp[78] = '';
         data_buffer2_temp[77] = '';
         data_buffer2_temp[76] = '';
         data_buffer2_temp[75] = '';
         data_buffer2_temp[74] = '';
         data_buffer2_temp[73] = '';
         data_buffer2_temp[72] = '';
         data_buffer2_temp[71] = '';
         data_buffer2_temp[70] = '';
         data_buffer2_temp[69] = '';
         data_buffer2_temp[68] = '';
         data_buffer2_temp[67] = '';
         data_buffer2_temp[66] = '';
         data_buffer2_temp[65] = '';
         data_buffer2_temp[64] = '';
         data_buffer2_temp[63] = '';
         data_buffer2_temp[62] = '';
         data_buffer2_temp[61] = '';
         data_buffer2_temp[60] = '';
         data_buffer2_temp[59] = '';
         data_buffer2_temp[58] = '';
         data_buffer2_temp[57] = '';
         data_buffer2_temp[56] = '';
         data_buffer2_temp[55] = '';
         data_buffer2_temp[54] = '';
         data_buffer2_temp[53] = '';
         data_buffer2_temp[52] = '';
         data_buffer2_temp[51] = '';
         data_buffer2_temp[50] = '';
         data_buffer2_temp[49] = '';
         data_buffer2_temp[48] = '';
         data_buffer2_temp[47] = '';
         data_buffer2_temp[46] = '';
         data_buffer2_temp[45] = '';
         data_buffer2_temp[44] = '';
         data_buffer2_temp[43] = '';
         data_buffer2_temp[42] = '';
         data_buffer2_temp[41] = '';
         data_buffer2_temp[40] = '';
         data_buffer2_temp[39] = '';
         data_buffer2_temp[38] = '';
         data_buffer2_temp[37] = '';
         data_buffer2_temp[36] = '';
         data_buffer2_temp[35] = '';
         data_buffer2_temp[34] = '';
         data_buffer2_temp[33] = '';
         data_buffer2_temp[32] = '';
         data_buffer2_temp[31] = '';
         data_buffer2_temp[30] = '';
         data_buffer2_temp[29] = '';
         data_buffer2_temp[28] = '';
         data_buffer2_temp[27] = '';
         data_buffer2_temp[26] = '';
         data_buffer2_temp[25] = '';
         data_buffer2_temp[24] = '';
         data_buffer2_temp[23] = '';
         data_buffer2_temp[22] = '';
         data_buffer2_temp[21] = '';
         data_buffer2_temp[20] = '';
         data_buffer2_temp[19] = '';
         data_buffer2_temp[18] = '';
         data_buffer2_temp[17] = '';
         data_buffer2_temp[16] = '';
         data_buffer2_temp[15] = '';
         data_buffer2_temp[14] = '';
         data_buffer2_temp[13] = '';
         data_buffer2_temp[12] = '';
         data_buffer2_temp[11] = '';
         data_buffer2_temp[10] = '';
         data_buffer2_temp[9] = '';
         data_buffer2_temp[8] = '';
         data_buffer2_temp[7] = '';
         data_buffer2_temp[6] = '';
         data_buffer2_temp[5] = '';
         data_buffer2_temp[4] = '';
         data_buffer2_temp[3] = '';
         data_buffer2_temp[2] = '';
         data_buffer2_temp[1] = '';
         data_buffer2_temp[0] = '';
        loss_count_a=0;
       }
       // loss_count_a=0;
   }
   else
   {
         data_buffer2_temp[91] = data_buffer2_temp[90];
         data_buffer2_temp[90] = data_buffer2_temp[89];
         data_buffer2_temp[89] = data_buffer2_temp[88];
         data_buffer2_temp[88] = data_buffer2_temp[87];
         data_buffer2_temp[87] = data_buffer2_temp[86];
         data_buffer2_temp[86] = data_buffer2_temp[85];
         data_buffer2_temp[85] = data_buffer2_temp[84];
         data_buffer2_temp[84] = data_buffer2_temp[83];
         data_buffer2_temp[83] = data_buffer2_temp[82];
         data_buffer2_temp[82] = data_buffer2_temp[81];
         data_buffer2_temp[81] = data_buffer2_temp[80];
         data_buffer2_temp[80] = data_buffer2_temp[79];
         data_buffer2_temp[79] = data_buffer2_temp[78];
         data_buffer2_temp[78] = data_buffer2_temp[77];
         data_buffer2_temp[77] = data_buffer2_temp[76];
         data_buffer2_temp[76] = data_buffer2_temp[75];
         data_buffer2_temp[75] = data_buffer2_temp[74];
         data_buffer2_temp[74] = data_buffer2_temp[73];
         data_buffer2_temp[73] = data_buffer2_temp[72];
         data_buffer2_temp[72] = data_buffer2_temp[71];
         data_buffer2_temp[71] = data_buffer2_temp[70];
         data_buffer2_temp[70] = data_buffer2_temp[69];
         data_buffer2_temp[69] = data_buffer2_temp[68];
         data_buffer2_temp[68] = data_buffer2_temp[67];
         data_buffer2_temp[67] = data_buffer2_temp[66];
         data_buffer2_temp[66] = data_buffer2_temp[65];
         data_buffer2_temp[65] = data_buffer2_temp[64];
         data_buffer2_temp[64] = data_buffer2_temp[63];
         data_buffer2_temp[63] = data_buffer2_temp[62];
         data_buffer2_temp[62] = data_buffer2_temp[61];
         data_buffer2_temp[61] = data_buffer2_temp[60];
         data_buffer2_temp[60] = data_buffer2_temp[59];
         data_buffer2_temp[59] = data_buffer2_temp[58];
         data_buffer2_temp[58] = data_buffer2_temp[57];
         data_buffer2_temp[57] = data_buffer2_temp[56];
         data_buffer2_temp[56] = data_buffer2_temp[55];
         data_buffer2_temp[55] = data_buffer2_temp[54];
         data_buffer2_temp[54] = data_buffer2_temp[53];
         data_buffer2_temp[53] = data_buffer2_temp[52];
         data_buffer2_temp[52] = data_buffer2_temp[51];
         data_buffer2_temp[51] = data_buffer2_temp[50];
         data_buffer2_temp[50] = data_buffer2_temp[49];
         data_buffer2_temp[49] = data_buffer2_temp[48];
         data_buffer2_temp[48] = data_buffer2_temp[47];
         data_buffer2_temp[47] = data_buffer2_temp[46];
         data_buffer2_temp[46] = data_buffer2_temp[45];
         data_buffer2_temp[45] = data_buffer2_temp[44];
         data_buffer2_temp[44] = data_buffer2_temp[43];
         data_buffer2_temp[43] = data_buffer2_temp[42];
         data_buffer2_temp[42] = data_buffer2_temp[41];
         data_buffer2_temp[41] = data_buffer2_temp[40];
         data_buffer2_temp[40] = data_buffer2_temp[39];
         data_buffer2_temp[39] = data_buffer2_temp[38];
         data_buffer2_temp[38] = data_buffer2_temp[37];
         data_buffer2_temp[37] = data_buffer2_temp[36];
         data_buffer2_temp[36] = data_buffer2_temp[35];
         data_buffer2_temp[35] = data_buffer2_temp[34];
         data_buffer2_temp[34] = data_buffer2_temp[33];
         data_buffer2_temp[33] = data_buffer2_temp[32];
         data_buffer2_temp[32] = data_buffer2_temp[31];
         data_buffer2_temp[31] = data_buffer2_temp[30];
         data_buffer2_temp[30] = data_buffer2_temp[29];
         data_buffer2_temp[29] = data_buffer2_temp[28];
         data_buffer2_temp[28] = data_buffer2_temp[27];
         data_buffer2_temp[27] = data_buffer2_temp[26];
         data_buffer2_temp[26] = data_buffer2_temp[25];
         data_buffer2_temp[25] = data_buffer2_temp[24];
         data_buffer2_temp[24] = data_buffer2_temp[23];
         data_buffer2_temp[23] = data_buffer2_temp[22];
         data_buffer2_temp[22] = data_buffer2_temp[21];
         data_buffer2_temp[21] = data_buffer2_temp[20];
         data_buffer2_temp[20] = data_buffer2_temp[19];
         data_buffer2_temp[19] = data_buffer2_temp[18];
         data_buffer2_temp[18] = data_buffer2_temp[17];
         data_buffer2_temp[17] = data_buffer2_temp[16];
         data_buffer2_temp[16] = data_buffer2_temp[15];
         data_buffer2_temp[15] = data_buffer2_temp[14];
         data_buffer2_temp[14] = data_buffer2_temp[13];
         data_buffer2_temp[13] = data_buffer2_temp[12];
         data_buffer2_temp[12] = data_buffer2_temp[11];
         data_buffer2_temp[11] = data_buffer2_temp[10];
         data_buffer2_temp[10] = data_buffer2_temp[9];
         data_buffer2_temp[9] = data_buffer2_temp[8];
         data_buffer2_temp[8] = data_buffer2_temp[7];
         data_buffer2_temp[7] = data_buffer2_temp[6];
         data_buffer2_temp[6] = data_buffer2_temp[5];
         data_buffer2_temp[5] = data_buffer2_temp[4];
         data_buffer2_temp[4] = data_buffer2_temp[3];
         data_buffer2_temp[3] = data_buffer2_temp[2];
         data_buffer2_temp[2] = data_buffer2_temp[1];
         data_buffer2_temp[1] = data_buffer2_temp[0];
         data_buffer2_temp[0] = data;
   }
}

// Get a character from the USART0 Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0++];
#if RX_BUFFER_SIZE0 != 256
if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
#endif
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-

// USART1 Receiver buffer
#define RX_BUFFER_SIZE1 8
char rx_buffer1[RX_BUFFER_SIZE1];

#if RX_BUFFER_SIZE1 <= 256
unsigned char rx_wr_index1=0,rx_rd_index1=0;
#else
unsigned int rx_wr_index1=0,rx_rd_index1=0;
#endif

#if RX_BUFFER_SIZE1 < 256
unsigned char rx_counter1=0;
#else
unsigned int rx_counter1=0;
#endif

// This flag is set on USART1 Receiver buffer overflow
bit rx_buffer_overflow1;

// USART1 Receiver interrupt service routine
interrupt [USART1_RXC] void usart1_rx_isr(void)
{
unsigned char status;
char data;
status=UCSR1A;
data=UDR1;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer1[rx_wr_index1++]=data;
#if RX_BUFFER_SIZE1 == 256
   // special case for receiver buffer size=256
   if (++rx_counter1 == 0) rx_buffer_overflow1=1;
#else
   if (rx_wr_index1 == RX_BUFFER_SIZE1) rx_wr_index1=0;
   if (++rx_counter1 == RX_BUFFER_SIZE1)
      {
      rx_counter1=0;
      rx_buffer_overflow1=1;
      }
#endif
   }
         data_buffer1_temp[91] = data_buffer1_temp[90];
         data_buffer1_temp[90] = data_buffer1_temp[89];
         data_buffer1_temp[89] = data_buffer1_temp[88];
         data_buffer1_temp[88] = data_buffer1_temp[87];
         data_buffer1_temp[87] = data_buffer1_temp[86];
         data_buffer1_temp[86] = data_buffer1_temp[85];
         data_buffer1_temp[85] = data_buffer1_temp[84];
         data_buffer1_temp[84] = data_buffer1_temp[83];
         data_buffer1_temp[83] = data_buffer1_temp[82];
         data_buffer1_temp[82] = data_buffer1_temp[81];
         data_buffer1_temp[81] = data_buffer1_temp[80];
         data_buffer1_temp[80] = data_buffer1_temp[79];
         data_buffer1_temp[79] = data_buffer1_temp[78];
         data_buffer1_temp[78] = data_buffer1_temp[77];
         data_buffer1_temp[77] = data_buffer1_temp[76];
         data_buffer1_temp[76] = data_buffer1_temp[75];
         data_buffer1_temp[75] = data_buffer1_temp[74];
         data_buffer1_temp[74] = data_buffer1_temp[73];
         data_buffer1_temp[73] = data_buffer1_temp[72];
         data_buffer1_temp[72] = data_buffer1_temp[71];
         data_buffer1_temp[71] = data_buffer1_temp[70];
         data_buffer1_temp[70] = data_buffer1_temp[69];
         data_buffer1_temp[69] = data_buffer1_temp[68];
         data_buffer1_temp[68] = data_buffer1_temp[67];
         data_buffer1_temp[67] = data_buffer1_temp[66];
         data_buffer1_temp[66] = data_buffer1_temp[65];
         data_buffer1_temp[65] = data_buffer1_temp[64];
         data_buffer1_temp[64] = data_buffer1_temp[63];
         data_buffer1_temp[63] = data_buffer1_temp[62];
         data_buffer1_temp[62] = data_buffer1_temp[61];
         data_buffer1_temp[61] = data_buffer1_temp[60];
         data_buffer1_temp[60] = data_buffer1_temp[59];
         data_buffer1_temp[59] = data_buffer1_temp[58];
         data_buffer1_temp[58] = data_buffer1_temp[57];
         data_buffer1_temp[57] = data_buffer1_temp[56];
         data_buffer1_temp[56] = data_buffer1_temp[55];
         data_buffer1_temp[55] = data_buffer1_temp[54];
         data_buffer1_temp[54] = data_buffer1_temp[53];
         data_buffer1_temp[53] = data_buffer1_temp[52];
         data_buffer1_temp[52] = data_buffer1_temp[51];
         data_buffer1_temp[51] = data_buffer1_temp[50];
         data_buffer1_temp[50] = data_buffer1_temp[49];
         data_buffer1_temp[49] = data_buffer1_temp[48];
         data_buffer1_temp[48] = data_buffer1_temp[47];
         data_buffer1_temp[47] = data_buffer1_temp[46];
         data_buffer1_temp[46] = data_buffer1_temp[45];
         data_buffer1_temp[45] = data_buffer1_temp[44];
         data_buffer1_temp[44] = data_buffer1_temp[43];
         data_buffer1_temp[43] = data_buffer1_temp[42];
         data_buffer1_temp[42] = data_buffer1_temp[41];
         data_buffer1_temp[41] = data_buffer1_temp[40];
         data_buffer1_temp[40] = data_buffer1_temp[39];
         data_buffer1_temp[39] = data_buffer1_temp[38];
         data_buffer1_temp[38] = data_buffer1_temp[37];
         data_buffer1_temp[37] = data_buffer1_temp[36];
         data_buffer1_temp[36] = data_buffer1_temp[35];
         data_buffer1_temp[35] = data_buffer1_temp[34];
         data_buffer1_temp[34] = data_buffer1_temp[33];
         data_buffer1_temp[33] = data_buffer1_temp[32];
         data_buffer1_temp[32] = data_buffer1_temp[31];
         data_buffer1_temp[31] = data_buffer1_temp[30];
         data_buffer1_temp[30] = data_buffer1_temp[29];
         data_buffer1_temp[29] = data_buffer1_temp[28];
         data_buffer1_temp[28] = data_buffer1_temp[27];
         data_buffer1_temp[27] = data_buffer1_temp[26];
         data_buffer1_temp[26] = data_buffer1_temp[25];
         data_buffer1_temp[25] = data_buffer1_temp[24];
         data_buffer1_temp[24] = data_buffer1_temp[23];
         data_buffer1_temp[23] = data_buffer1_temp[22];
         data_buffer1_temp[22] = data_buffer1_temp[21];
         data_buffer1_temp[21] = data_buffer1_temp[20];
         data_buffer1_temp[20] = data_buffer1_temp[19];
         data_buffer1_temp[19] = data_buffer1_temp[18];
         data_buffer1_temp[18] = data_buffer1_temp[17];
         data_buffer1_temp[17] = data_buffer1_temp[16];
         data_buffer1_temp[16] = data_buffer1_temp[15];
         data_buffer1_temp[15] = data_buffer1_temp[14];
         data_buffer1_temp[14] = data_buffer1_temp[13];
         data_buffer1_temp[13] = data_buffer1_temp[12];
         data_buffer1_temp[12] = data_buffer1_temp[11];
         data_buffer1_temp[11] = data_buffer1_temp[10];
         data_buffer1_temp[10] = data_buffer1_temp[9];
         data_buffer1_temp[9] = data_buffer1_temp[8];
         data_buffer1_temp[8] = data_buffer1_temp[7];
         data_buffer1_temp[7] = data_buffer1_temp[6];
         data_buffer1_temp[6] = data_buffer1_temp[5];
         data_buffer1_temp[5] = data_buffer1_temp[4];
         data_buffer1_temp[4] = data_buffer1_temp[3];
         data_buffer1_temp[3] = data_buffer1_temp[2];
         data_buffer1_temp[2] = data_buffer1_temp[1];
         data_buffer1_temp[1] = data_buffer1_temp[0];
         data_buffer1_temp[0] = data;

   //링크 확인
   if((data_buffer1_temp[7] == 0x00)&&(data_buffer1_temp[6] == 0xf1)&&(data_buffer1_temp[5] == 0x20)&&(data_buffer1_temp[4] == 0xcb)&&(data_buffer1_temp[2] == 0x24) &&(data_buffer1_temp[1] == 0x00)&& (data_buffer1_temp[0] == 0x00))
   {
      Common_CHeckLink_act = 1;
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
   }


   //배전기 셧다운 요청
   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x60)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp[5] == 0x28)&&(data_buffer1_temp[3] == 0x24) &&(data_buffer1_temp[2] == 0x01) &&(data_buffer1_temp[1] == 0x00)&& (data_buffer1_temp[0] == 0x00))
   {
      Distributor_ShutdownResponse_act = 1;
     //   11/08 한화요청에 의거 삭제 셧다운은 메인에서 주변장치 off후 차단
     // temp_control_1 = 0x00;
     // temp_control_2 = 0x00;

         //***************************
     // send_to_div_act = 1;
      data_buffer2_temp[8] = '';
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
   }

   //배전기 PO-BIT 초기설정
   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x61)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp[5] == 0x28)&&(data_buffer1_temp[3] == 0x24) && (data_buffer1_temp[2] == 0x01) && (data_buffer1_temp[1] == 0x00)&& (data_buffer1_temp[0] == 0x00))
   {
      //po_bit_set_recive_data = data_buffer1_temp[0];
      Distributor_PoBIT_act_pre = 1;
      data_buffer2_temp[8] = '';
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
   }

   //배전기 PO-BIT설정
   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x61)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp[5] == 0x28)&&(data_buffer1_temp[3] == 0x24) && (data_buffer1_temp[2] == 0x01) && (data_buffer1_temp[1] == 0x00)&& (data_buffer1_temp[0] == 0x04))
   {
     // po_bit_set_recive_data = data_buffer1_temp[0];
      Distributor_PoBIT_act = 1;
      data_buffer2_temp[8] = '';
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
   }
//
//   //부저 울림 원격 중지 191226
//   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x61)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp[5] == 0x28)&&(data_buffer1_temp[3] == 0x24) && (data_buffer1_temp[2] == 0x01) && (data_buffer1_temp[1] == 0x00)&& (data_buffer1_temp[0] == 0x08))
//   {
//      buzzer_clear_all();
//      data_buffer2_temp[8] = '';
//      data_buffer2_temp[7] = '';
//      data_buffer2_temp[6] = '';
//      data_buffer2_temp[5] = '';
//      data_buffer2_temp[4] = '';
//      data_buffer2_temp[3] = '';
//      data_buffer2_temp[2] = '';
//      data_buffer2_temp[1] = '';
//      data_buffer2_temp[0] = '';
//   }

   //배전기 PO-BIT 결과  상세정보 요구
   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x62)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp[5] == 0x28)&&(data_buffer1_temp[3] == 0x24)&&(data_buffer1_temp[2] == 0x01) && (data_buffer1_temp[1] == 0x00))
   {
      po_bit_recive_data_detail = data_buffer1_temp[0];
      Distributor_BITDetailResponse_act = 1;
      data_buffer2_temp[8] = '';
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
   }

   //배전기 장치설정
   if((data_buffer1_temp[10] == 0x00)&&(data_buffer1_temp[9] == 0x63)&&(data_buffer1_temp[8] == 0x20)&&(data_buffer1_temp[7] == 0x28)&&(data_buffer1_temp[5] == 0x24) &&(data_buffer1_temp[4] == 0x03) &&  (data_buffer1_temp[3] == 0x00))
   {
      temp_control_sel = data_buffer1_temp[2];
      if(temp_control_sel == 0x20)
      {
        buzzer_clear_all();
      }
      else
      {
        temp_control_1 = data_buffer1_temp[1];
        temp_control_2 = data_buffer1_temp[0];
        //***************************
        send_to_div_act = 1;
        //**************************
      }

      // Distributor_DeviceRequest = 1;
      data_buffer2_temp[10] = '';
      data_buffer2_temp[9] = '';
      data_buffer2_temp[8] = '';
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
    }

   //임무처리기 셧다운 오류 요청
   if((data_buffer1_temp[8] == 0x00)&&(data_buffer1_temp[7] == 0x64)&&(data_buffer1_temp[6] == 0x20)&&(data_buffer1_temp[5] == 0x28)&&(data_buffer1_temp[3] == 0x24) && (data_buffer1_temp[2] == 0x01)&& (data_buffer1_temp[1] == 0x00)&& (data_buffer1_temp[0] == 0x01))
   {
     //shoutdown_request_recive_data = data_buffer1_temp[0];

      Distributor_ShutdownErroResponse_act = 1;
      data_buffer2_temp[8] = '';
      data_buffer2_temp[7] = '';
      data_buffer2_temp[6] = '';
      data_buffer2_temp[5] = '';
      data_buffer2_temp[4] = '';
      data_buffer2_temp[3] = '';
      data_buffer2_temp[2] = '';
      data_buffer2_temp[1] = '';
      data_buffer2_temp[0] = '';
    }


   //시간 설정
   if((data_buffer1_temp[13] == 0x00)&&(data_buffer1_temp[12] == 0x65)&&(data_buffer1_temp[11] == 0x20)&&(data_buffer1_temp[10] == 0x28)&&(data_buffer1_temp[8] == 0x24) &&(data_buffer1_temp[7] == 0x06) &&(data_buffer1_temp[6] == 0x00))
   {
     year = data_buffer1_temp[5];
     month = data_buffer1_temp[4];
     day = data_buffer1_temp[3];
     hour = data_buffer1_temp[2];
     minute = data_buffer1_temp[1];
     sec = data_buffer1_temp[0];
//
   rtc_set_time(hour,minute,sec);
//   if(year > 12)
//   {
//   year = (year - 12);
//   year = 0x1f | (year & 0x0f);
//   }
//   else
//   {
//   year = year & 0x0f;
//   }
//     year = 0x1f & year;
     rtc_set_date(0x05,day,month,year);

     Distributor_TimeSyncAck_act = 1;

     //time_data_get = 1;
     //buffer clear
     data_buffer2_temp[13] = '';
     data_buffer2_temp[12] = '';
     data_buffer2_temp[11] = '';
     data_buffer2_temp[10] = '';
     data_buffer2_temp[9] = '';
     data_buffer2_temp[8] = '';
     data_buffer2_temp[7] = '';
     data_buffer2_temp[6] = '';
     data_buffer2_temp[5] = '';
     data_buffer2_temp[4] = '';
     data_buffer2_temp[3] = '';
     data_buffer2_temp[2] = '';
     data_buffer2_temp[1] = '';
     data_buffer2_temp[0] = '';
   }


 /*

  if(data == 0x0a )
   {
       //채널상태 및 에러정보 요청
     if(data_buffer2_temp[91] == 0x7f && data_buffer2_temp[90] == 0xfe && data_buffer2_temp[0] == 0x0d)
      {


         data_buffer2_temp[91] = '';
         data_buffer2_temp[90] = '';
         data_buffer2_temp[89] = '';
         data_buffer2_temp[88] = '';
         data_buffer2_temp[87] = '';
         data_buffer2_temp[86] = '';
         data_buffer2_temp[85] = '';
         data_buffer2_temp[84] = '';
         data_buffer2_temp[83] = '';
         data_buffer2_temp[82] = '';
         data_buffer2_temp[81] = '';
         data_buffer2_temp[80] = '';
         data_buffer2_temp[79] = '';
         data_buffer2_temp[78] = '';
         data_buffer2_temp[77] = '';
         data_buffer2_temp[76] = '';
         data_buffer2_temp[75] = '';
         data_buffer2_temp[74] = '';
         data_buffer2_temp[73] = '';
         data_buffer2_temp[72] = '';
         data_buffer2_temp[71] = '';
         data_buffer2_temp[70] = '';
         data_buffer2_temp[69] = '';
         data_buffer2_temp[68] = '';
         data_buffer2_temp[67] = '';
         data_buffer2_temp[66] = '';
         data_buffer2_temp[65] = '';
         data_buffer2_temp[64] = '';
         data_buffer2_temp[63] = '';
         data_buffer2_temp[62] = '';
         data_buffer2_temp[61] = '';
         data_buffer2_temp[60] = '';
         data_buffer2_temp[59] = '';
         data_buffer2_temp[58] = '';
         data_buffer2_temp[57] = '';
         data_buffer2_temp[56] = '';
         data_buffer2_temp[55] = '';
         data_buffer2_temp[54] = '';
         data_buffer2_temp[53] = '';
         data_buffer2_temp[52] = '';
         data_buffer2_temp[51] = '';
         data_buffer2_temp[50] = '';
         data_buffer2_temp[49] = '';
         data_buffer2_temp[48] = '';
         data_buffer2_temp[47] = '';
         data_buffer2_temp[46] = '';
         data_buffer2_temp[45] = '';
         data_buffer2_temp[44] = '';
         data_buffer2_temp[43] = '';
         data_buffer2_temp[42] = '';
         data_buffer2_temp[41] = '';
         data_buffer2_temp[40] = '';
         data_buffer2_temp[39] = '';
         data_buffer2_temp[38] = '';
         data_buffer2_temp[37] = '';
         data_buffer2_temp[36] = '';
         data_buffer2_temp[35] = '';
         data_buffer2_temp[34] = '';
         data_buffer2_temp[33] = '';
         data_buffer2_temp[32] = '';
         data_buffer2_temp[31] = '';
         data_buffer2_temp[30] = '';
         data_buffer2_temp[29] = '';
         data_buffer2_temp[28] = '';
         data_buffer2_temp[27] = '';
         data_buffer2_temp[26] = '';
         data_buffer2_temp[25] = '';
         data_buffer2_temp[24] = '';
         data_buffer2_temp[23] = '';
         data_buffer2_temp[22] = '';
         data_buffer2_temp[21] = '';
         data_buffer2_temp[20] = '';
         data_buffer2_temp[19] = '';
         data_buffer2_temp[18] = '';
         data_buffer2_temp[17] = '';
         data_buffer2_temp[16] = '';
         data_buffer2_temp[15] = '';
         data_buffer2_temp[14] = '';
         data_buffer2_temp[13] = '';
         data_buffer2_temp[12] = '';
         data_buffer2_temp[11] = '';
         data_buffer2_temp[10] = '';
         data_buffer2_temp[9] = '';
         data_buffer2_temp[8] = '';
         data_buffer2_temp[7] = '';
         data_buffer2_temp[6] = '';
         data_buffer2_temp[5] = '';
         data_buffer2_temp[4] = '';
         data_buffer2_temp[3] = '';
         data_buffer2_temp[2] = '';
         data_buffer2_temp[1] = '';
         data_buffer2_temp[0] = '';
       }
   }
   else
   {

   }
*/

}

// Get a character from the USART1 Receiver buffer
#pragma used+
char getchar1(void)
{
char data;
while (rx_counter1==0);
data=rx_buffer1[rx_rd_index1++];
#if RX_BUFFER_SIZE1 != 256
if (rx_rd_index1 == RX_BUFFER_SIZE1) rx_rd_index1=0;
#endif
#asm("cli")
--rx_counter1;
#asm("sei")
return data;
}
#pragma used-
// Write a character to the USART1 Transmitter
#pragma used+
void putchar1(char c)
{
while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
UDR1=c;
}
#pragma used-

// USART2 Receiver buffer
#define RX_BUFFER_SIZE2 8
char rx_buffer2[RX_BUFFER_SIZE2];

#if RX_BUFFER_SIZE2 <= 256
unsigned char rx_wr_index2=0,rx_rd_index2=0;
#else
unsigned int rx_wr_index2=0,rx_rd_index2=0;
#endif

#if RX_BUFFER_SIZE2 < 256
unsigned char rx_counter2=0;
#else
unsigned int rx_counter2=0;
#endif

// This flag is set on USART2 Receiver buffer overflow
bit rx_buffer_overflow2;

// USART2 Receiver interrupt service routine
interrupt [USART2_RXC] void usart2_rx_isr(void)
{
unsigned char status;
char data;
status=UCSR2A;
data=UDR2;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer2[rx_wr_index2++]=data;
#if RX_BUFFER_SIZE2 == 256
   // special case for receiver buffer size=256
   if (++rx_counter2 == 0) rx_buffer_overflow2=1;
#else
   if (rx_wr_index2 == RX_BUFFER_SIZE2) rx_wr_index2=0;
   if (++rx_counter2 == RX_BUFFER_SIZE2)
      {
      rx_counter2=0;
      rx_buffer_overflow2=1;
      }
#endif
   }
         data_buffer_ge_temp[9] = data_buffer_ge_temp[8];
         data_buffer_ge_temp[8] = data_buffer_ge_temp[7];
         data_buffer_ge_temp[7] = data_buffer_ge_temp[6];
         data_buffer_ge_temp[6] = data_buffer_ge_temp[5];
         data_buffer_ge_temp[5] = data_buffer_ge_temp[4];
         data_buffer_ge_temp[4] = data_buffer_ge_temp[3];
         data_buffer_ge_temp[3] = data_buffer_ge_temp[2];
         data_buffer_ge_temp[2] = data_buffer_ge_temp[1];
         data_buffer_ge_temp[1] = data_buffer_ge_temp[0];
         data_buffer_ge_temp[0] = data;

   //발전기 전압
   if((data_buffer_ge_temp[6] == 0x01)&&(data_buffer_ge_temp[5] == 0x03)&&(data_buffer_ge_temp[4] == 0x02)&&(ge_data_kind == 1))
   {
      ge_voltage_h = data_buffer_ge_temp[3];
      ge_voltage_l = data_buffer_ge_temp[2];
      voltage_ge = (ge_voltage_h * 256) + ge_voltage_l;
      CRC_H = data_buffer_ge_temp[1];
      CRC_L = data_buffer_ge_temp[0];
      loss_count_ge = 0;

   }
   //발전기 전류
   if((data_buffer_ge_temp[6] == 0x01)&&(data_buffer_ge_temp[5] == 0x03)&&(data_buffer_ge_temp[4] == 0x02)&&(ge_data_kind == 2))
   {
      ge_currunt_h = data_buffer_ge_temp[3];
      ge_currunt_l = data_buffer_ge_temp[2];
      currunt_ge = ((ge_currunt_h * 256) + ge_currunt_l)*10;
      CRC_H = data_buffer_ge_temp[1];
      CRC_L = data_buffer_ge_temp[0];
      loss_count_ge = 0;
   }

   //발전기 에러상태 표시
   if((data_buffer_ge_temp[6] == 0x01)&&(data_buffer_ge_temp[5] == 0x03)&&(data_buffer_ge_temp[4] == 0x02)&&(data_buffer_ge_temp[3] == 0x00)&&(ge_data_kind == 3))
   {
      ge_err_data = data_buffer_ge_temp[2];

      if((ge_err_data & 0x1f) == 0x00){ge_err_act = NOR;}else{ge_err_act = ERR;}

      CRC_H = data_buffer_ge_temp[1];
      CRC_L = data_buffer_ge_temp[0];
      loss_count_ge = 0;
   }


}

// Get a character from the USART2 Receiver buffer
#pragma used+
char getchar2(void)
{
char data;
while (rx_counter2==0);
data=rx_buffer2[rx_rd_index2++];
#if RX_BUFFER_SIZE2 != 256
if (rx_rd_index2 == RX_BUFFER_SIZE2) rx_rd_index2=0;
#endif
#asm("cli")
--rx_counter2;
#asm("sei")
return data;
}
#pragma used-

// Write a character to the USART2 Transmitter
#pragma used+
void putchar2(char c)
{
while ((UCSR2A & DATA_REGISTER_EMPTY)==0);
UDR2=c;
}
#pragma used-

// Standard Input/Output functions
#include <stdio.h>

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
 temp_a++;
 if(temp_a >= 722)
    {
     temp_b++;
     temp_a = 0;
     temp_out_to_pc_count++;

    }

  if(temp_b > 9)//60
  {
    temp_b = 0;
    temp_out_pbit_count++;
    if(loss_count_a >= loss_active_delay_time){loss_count_a = loss_active_delay_time;comm_err = 1;}else{loss_count_a++;comm_err = 0;}// 통신 단절시 에러발생

//    if(loss_count_a >= loss_active_delay_time){loss_count_a = loss_active_delay_time;comm_err_temp = 1;}else{loss_count_a++;comm_err_temp = 0;}// 통신 단절시 에러발생
//
////    if(comm_err_count >= 10)
//    {
//        comm_err = 1;
//        comm_err_count = 10;
//    }
//    else
//    {
//        comm_err = 0;
//        if(comm_err_temp == 1){comm_err_count++;}else{comm_err_temp = 0; comm_err_count = 0;}
//    }
//
    //if(loss_count_ge >= loss_active_delay_time){loss_count_ge = loss_active_delay_time;comm_ge_err = 1;}else{loss_count_a++;comm_ge_err = 0;}//발전기 통신 단절시 에러발생
   if(loss_count_ge >= loss_ge_active_delay_time){loss_count_ge = loss_ge_active_delay_time;comm_ge_err = 1;}else{loss_count_ge++;comm_ge_err = 0;}//발전기 통신 단절시 에러발생
   if(led_flash == 0){led_flash = 1;}else{led_flash = 0;}
   // send_to_div_act = 1;
  }

  if(temp_out_pbit_count > 5) //   distributo_pbit 10hz
  {
    temp_out_pbit_count = 0;
    TEST_LED_1 = ~TEST_LED_1;
    send_to_div_info_act = 1;

    //send to pc pbit정보
    Distributor_PBIT_act = 1;

    send_to_pc_active = 1;
  }
  else
  {
       if(send_process_count > 8)
       {
        send_process_count = 0;
       }
       else
       {
        send_process_count++;
       }
  }



  if(temp_out_to_pc_count > 5)//60  //  distributo_device_status 1hz
  {
    //send to pc
  TEST_LED_2 = ~TEST_LED_2;
    temp_out_to_pc_count = 0;

    send_to_ge_active = 1;


    if(mode_change_and_init == 1)
    {
      if(mode_change_count >= mode_change_count_max)
      {
        buzzer_out_wait = 1;
        mode_change_count = mode_change_count_max;
        mode_change_and_init = 0;
      }
      else
      {
        mode_change_count++;
      }
    }
    else
    {
      mode_change_count = 0;
    }
  }
}

void pulse(void)
{
    delay_us(1);
    LED_CLK = 1;
    delay_us(1);
    LED_CLK = 0;
}


void send_to_ge(void)
{
 RE_DE1 = 1;
 delay_us(30);

 if(ge_data_kind > 3){ge_data_kind = 1;}else{ge_data_kind++;}

 // ge_data_kind = 3;


 if(ge_data_kind == 1)  //발전기 전압
 {
 putchar2(0x01);  //control address
 putchar2(0x03);  //modebus function number
 putchar2(0x23);  //object number
 putchar2(0xc8);  //object number
 putchar2(0x00);  //length
 putchar2(0x01);  //length
 putchar2(0x0e);  //under of crc
 putchar2(0x70);  //upper of crc
 }


 if(ge_data_kind == 2) //발전기 전류
 {
 putchar2(0x01);  //control address
 putchar2(0x03);  //modebus function number
 putchar2(0x23);  //object number
 putchar2(0xc4);  //object number
 putchar2(0x00);  //length
 putchar2(0x01);  //length
 putchar2(0xce);  //under of crc
 putchar2(0x73);  //upper of crc
 }

 if(ge_data_kind == 3) //발전기 에러
 {
 putchar2(0x01);  //control address
 putchar2(0x03);  //modebus function number
 putchar2(0x2d);  //object number
 putchar2(0x73);  //object number
 putchar2(0x00);  //length
 putchar2(0x01);  //length
 putchar2(0x7c);  //under of crc
 putchar2(0xbd);  //upper of crc
 }

// if(ge_data_kind == 3) // 엔진 과속도 보호
// {
// putchar2(0x01);  //control address
// putchar2(0x03);  //modebus function number
// putchar2(0x20);  //object number
// putchar2(0x47);  //object number
// putchar2(0x00);  //length
// putchar2(0x01);  //length
// putchar2(0x3f);  //under of crc
// putchar2(0xdf);  //upper of crc
// }
//
// if(ge_data_kind == 4)  // 엔진 오일압력 보호/경고
// {
// putchar2(0x01);  //control address
// putchar2(0x03);  //modebus function number
// putchar2(0x09);  //object number
// putchar2(0x41);  //object number
// putchar2(0x00);  //length
// putchar2(0x01);  //length
// putchar2(0xd7);  //under of crc
// putchar2(0x82);  //upper of crc
// }
//
// if(ge_data_kind == 5) //과전압 bit
// {
// putchar2(0x01);  //control address
// putchar2(0x03);  //modebus function number
// putchar2(0x2c);  //object number
// putchar2(0x5f);  //object number
// putchar2(0x00);  //length
// putchar2(0x01);  //length
// putchar2(0xbc);  //under of crc
// putchar2(0x88);  //upper of crc
// }
//
// if(ge_data_kind == 6)//저전압 bit
// {
// putchar2(0x01);  //control address
// putchar2(0x03);  //modebus function number
// putchar2(0x2c);  //object number
// putchar2(0x63);  //object number
// putchar2(0x00);  //length
// putchar2(0x01);  //length
// putchar2(0x7c);  //under of crc
// putchar2(0x84);  //upper of crc
// }
//
// if(ge_data_kind == 7) // 과전류 bit
// {
// putchar2(0x01);  //control address
// putchar2(0x03);  //modebus function number
// putchar2(0x36);  //object number
// putchar2(0x5c);  //object number
// putchar2(0x00);  //length
// putchar2(0x01);  //length
// putchar2(0x4b);  //under of crc
// putchar2(0x90);  //upper of crc
// }
//
//  if(ge_data_kind == 8) //발전기 전압 voltage
// {
// putchar2(0x01);  //control address
// putchar2(0x03);  //modebus function number
// putchar2(0x20);  //object number
// putchar2(0x15);  //object number
// putchar2(0x00);  //length
// putchar2(0x01);  //length
// putchar2(0x9e);  //under of crc
// putchar2(0x0e);  //upper of crc
// }

 delay_us(350);

  RE_DE1 = 0;
 send_to_ge_active = 0;
}

void send_to_div(void)
{
   RE_DE0 = 1;
   delay_ms(1);

    putchar(0x7f);  //9
    putchar(0xfe);  //8
    putchar(0x00);  //7

//
//    if(!ADDRESS_3)
//    {
//    if(ADDRESS_1){temp_control_2 = temp_control_2 | 0x80;}else{temp_control_2 = temp_control_2 & ~0x80;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x40;}else{temp_control_2 = temp_control_2 & ~0x40;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x20;}else{temp_control_2 = temp_control_2 & ~0x20;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x10;}else{temp_control_2 = temp_control_2 & ~0x10;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x08;}else{temp_control_2 = temp_control_2 & ~0x08;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x04;}else{temp_control_2 = temp_control_2 & ~0x04;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x02;}else{temp_control_2 = temp_control_2 & ~0x02;}
//    if(ADDRESS_2){temp_control_2 = temp_control_2 | 0x01;}else{temp_control_2 = temp_control_2 & ~0x01;}
//
//    if(ADDRESS_1){temp_control_1 = temp_control_1 | 0x80;}else{temp_control_1 = temp_control_1 & ~0x80;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x40;}else{temp_control_1 = temp_control_1 & ~0x40;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x20;}else{temp_control_1 = temp_control_1 & ~0x20;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x10;}else{temp_control_1 = temp_control_1 & ~0x10;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x08;}else{temp_control_1 = temp_control_1 & ~0x08;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x04;}else{temp_control_1 = temp_control_1 & ~0x04;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x02;}else{temp_control_1 = temp_control_1 & ~0x02;}
//    if(ADDRESS_2){temp_control_1 = temp_control_1 | 0x01;}else{temp_control_1 = temp_control_1 & ~0x01;}
//    }

//    if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x10;} //13
//    if((temp_control_2 & 0x10) == 0x10){temp_control_2_ |= 0x40;} //12
//    if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x20;} //11
//    if((temp_control_2 & 0x04) == 0x04){temp_control_2_ |= 0x08;} //10
//    if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x40;} //09
//    if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x08;} //08
//
//    if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x04;} //07
//    if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x10;} //06
//    if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x04;} //05
//    if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x20;} //04
//    if((temp_control_1 & 0x08) == 0x08){temp_control_1_ |= 0x02;} //03
//    if((temp_control_1 & 0x04) == 0x04){temp_control_1_ |= 0x01;} //02
//    if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x02;} //01
//    if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x01;} //00
//
//    if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x10;} //13
//    if((temp_control_2 & 0x10) == 0x10){temp_control_2_ |= 0x40;} //12
//    if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x20;} //11
//    if((temp_control_2 & 0x04) == 0x04){temp_control_2_ |= 0x08;} //10
//    if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x40;} //09
//    if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x08;} //08
//
//    if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x04;} //07
//    if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x10;} //06
//    if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x04;} //05 //////
//    if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x20;} //04
//    if((temp_control_1 & 0x08) == 0x08){temp_control_1_ |= 0x02;} //03
//    if((temp_control_1 & 0x04) == 0x04){temp_control_1_ |= 0x01;} //02
//    if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x02;} //01  운용처리기2 전시기2
//    if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x01;} //00  임무처리기 조정기 2

    if(temp_control_sel == 0xff)  //전체 셧다운 또는 전체 켜기 명령
    {
//       temp_control_1_ = temp_control_1_old;
//       temp_control_2_ = temp_control_2_old;
        if((temp_control_1 == 0xff)&&(temp_control_2 == 0xff))
        {
          temp_control_1_ = 0xff;
          temp_control_2_ = 0xff;
        }

        if((temp_control_1 == 0x00)&&(temp_control_2 == 0x00))
        {
          temp_control_1_ = 0x00;
          temp_control_2_ = 0x00;
        }
    }
    else
    {
//    if(temp_control_1_ != 0x00){temp_control_1_ = temp_control_1_old;} //10/12/26
//    if(temp_control_2_ != 0x00){temp_control_2_ = temp_control_2_old;}
    temp_control_1_ = temp_control_1_old;
    temp_control_2_ = temp_control_2_old;
    if(temp_control_sel == 14){if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x10;}else{temp_control_1_ &= ~0x10;}}//13
    if(temp_control_sel == 13){if((temp_control_2 & 0x10) == 0x10){temp_control_2_ |= 0x40;}else{temp_control_2_ &= ~0x40;}} //12
    if(temp_control_sel == 12){if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x20;}else{temp_control_1_ &= ~0x20;}} //11
    if(temp_control_sel == 11){if((temp_control_2 & 0x04) == 0x04){temp_control_2_ |= 0x08;}else{temp_control_2_ &= ~0x08;}} //10
    if(temp_control_sel == 10){if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x40;}else{temp_control_1_ &= ~0x40;}} //09
    if(temp_control_sel == 9){if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x08;}else{temp_control_1_ &= ~0x08;}}//08

    if(temp_control_sel == 8){if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x04;}else{temp_control_1_ &= ~0x04;}} //07
    if(temp_control_sel == 7){if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x10;}else{temp_control_2_ &= ~0x10;}} //06
    if(temp_control_sel == 6){if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x04;}else{temp_control_2_ &= ~0x04;}} //05
    if(temp_control_sel == 5){if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x20;}else{temp_control_2_ &= ~0x20;}} //04
    if(temp_control_sel == 4){if((temp_control_1 & 0x08) == 0x08){temp_control_1_ |= 0x02;}else{temp_control_1_ &= ~0x02;}} //03
    if(temp_control_sel == 3){if((temp_control_1 & 0x04) == 0x04){temp_control_1_ |= 0x01;}else{temp_control_1_ &= ~0x01;}} //02
    if(temp_control_sel == 2){if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x02;}else{temp_control_2_ &= ~0x02;}} //01  운용처리기2 전시기2
    if(temp_control_sel == 1){if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x01;}else{temp_control_2_ &= ~0x01;}} //00  임무처리기 조정기 2
    }
    temp_control_1_old = temp_control_1_;
    temp_control_2_old = temp_control_2_;



//   한화시험 최종
//    if((temp_control_2 & 0x20) == 0x20){temp_control_1_ |= 0x01;} //13  40
//    if((temp_control_2 & 0x10) == 0x10){temp_control_1_ |= 0x02;} //12  20
//    if((temp_control_2 & 0x08) == 0x08){temp_control_1_ |= 0x04;} //11  10
//    if((temp_control_2 & 0x04) == 0x04){temp_control_1_ |= 0x08;} //10  08
//    if((temp_control_2 & 0x02) == 0x02){temp_control_1_ |= 0x10;} //09  04
//    if((temp_control_2 & 0x01) == 0x01){temp_control_1_ |= 0x20;} //08  02
//
//    if((temp_control_1 & 0x80) == 0x80){temp_control_1_ |= 0x40;} //07   01
//    if((temp_control_1 & 0x40) == 0x40){temp_control_2_ |= 0x01;} //06   40
//    if((temp_control_1 & 0x20) == 0x20){temp_control_2_ |= 0x02;} //05  20
//    if((temp_control_1 & 0x10) == 0x10){temp_control_2_ |= 0x04;} //04    10
//    if((temp_control_1 & 0x08) == 0x08){temp_control_2_ |= 0x08;} //03
//    if((temp_control_1 & 0x04) == 0x04){temp_control_2_ |= 0x10;} //02   04
//    if((temp_control_1 & 0x02) == 0x02){temp_control_2_ |= 0x20;} //01 02 운용처리기2 전시기2
//    if((temp_control_1 & 0x01) == 0x01){temp_control_2_ |= 0x40;} //00  01 임무처리기 조정기 2


    putchar(temp_control_1_);  //6   temp_control_2
    putchar(temp_control_2_);  //5

    temp_control_2_ = 0x00;
    temp_control_1_ = 0x00;

    temp_control_2 = 0x00;
    temp_control_1 = 0x00;

    putchar(0x00);  //4
    putchar(0x00);  //3
    putchar(0x00);  //2
    putchar(0x0d);  //1
    putchar(0x0a);  //0

    delay_ms(1);
    RE_DE0 = 0;

    send_to_div_act = 0;
}

void Request_div_info(void)
{
//send to div
  RE_DE0 = 1;
  delay_us(100);
  putchar(0x7f);  //9
  putchar(0xfe);  //8
  putchar(0x55);  //7
  putchar(0xaa);  //6
  putchar(0x00);  //5
  putchar(0x00);  //4
  putchar(0x00);  //3
  putchar(0x00);  //2
  putchar(0x0d);  //1
  putchar(0x0a);  //0
  delay_us(200);
  RE_DE0 = 0;
  send_to_div_info_act = 0;
}


void fnd_out(int digit_num)
{
       switch(digit_num)
       {
       case 0:
       LED_LOAD = 0;
       LED_LOAD_A = 1;
       LED_LOAD_B = 1;
       break;

       case 1:
       LED_LOAD = 1;
       LED_LOAD_A = 0;
       LED_LOAD_B = 1;
       break;

       case 2:
       LED_LOAD = 1;
       LED_LOAD_A = 1;
       LED_LOAD_B = 0;
       break;

       case 3:
       LED_LOAD = 0;
       LED_LOAD_A = 0;
       LED_LOAD_B = 0;
       break;

       default:
       LED_LOAD = 0;
       LED_LOAD_A = 1;
       LED_LOAD_B = 1;
       break;
       }


       delay_us(1);

       LED_DIN = 1;
       for(count_temp = 0; count_temp <4; count_temp++)
        {
         pulse();
        }

        //command digit 3
        if((command & 0x08) == 0x08){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //command digit 2
        if((command & 0x04) == 0x04){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //command digit 1
        if((command & 0x02) == 0x02){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //command digit 0
        if((command & 0x01) == 0x01){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();


         //data digit 7
        if((fnd_data & 0x80) == 0x80){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 6
        if((fnd_data & 0x40) == 0x40){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 5
        if((fnd_data & 0x20) == 0x20){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 4
        if((fnd_data & 0x10) == 0x10){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 3
        if((fnd_data & 0x08) == 0x08){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 2
        if((fnd_data & 0x04) == 0x04){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 1
        if((fnd_data & 0x02) == 0x02){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();

        //data digit 0
        if((fnd_data & 0x01) == 0x01){LED_DIN = 1;} else{LED_DIN = 0;}
        pulse();


         delay_us(1);
       LED_LOAD = 1;
       LED_LOAD_A = 1;
       LED_LOAD_B = 1;
       delay_us(1);
}

void num_convert(char num)
{
      switch(num)
      {
       case 0:
         fnd_data = 0x7e;
       break;

       case 1:
         fnd_data = 0x30;
       break;

       case 2:
         fnd_data = 0x6d;
       break;

       case 3:
         fnd_data = 0x79;
       break;

       case 4:
         fnd_data = 0x33;
       break;

       case 5:
         fnd_data = 0x5b;
       break;

       case 6:
         fnd_data = 0x5f;
       break;

       case 7:
         fnd_data = 0x70;
       break;

       case 8:
         fnd_data = 0x7f;
       break;

       case 9:
         fnd_data = 0x7b;
       break;

       default:
         fnd_data = 0x00;
       break;
      }
}




void digit1(char temp,char num)
{
       command = 0x03;
       num_convert(temp);
       digit_num = num;
       fnd_out(digit_num);
}


void digit2(char temp,char num)
{
       command = 0x02;
       num_convert(temp);
       if(digit == 0 || digit == 1){fnd_data = fnd_data | 0x80;} //전류 소수점 표시
       if(digit == 0){fnd_data = fnd_data | 0x80;}
       digit_num = num;
       fnd_out(digit_num);
}


void digit3(char temp,char num)
{
       command = 0x01;
       num_convert(temp);
       digit_num = num;
       fnd_out(digit_num);

}


void digit4(char temp,char num)
{
       command = 0x06;
       num_convert(temp);
       digit_num = num;
       fnd_out(digit_num);
}

void digit5(char temp,char num)
{
       command = 0x05;
       num_convert(temp);
       if(digit == 0 || digit == 1){fnd_data = fnd_data | 0x80;}
       if(digit == 0){fnd_data = fnd_data | 0x80;}
       digit_num = num;
       fnd_out(digit_num);
}

void digit6(char temp,char num)
{
       command = 0x04;
       num_convert(temp);
       digit_num = num;
       fnd_out(digit_num);
}


void fnd_init(void)
{
   LED_LOAD = 1;
        LED_LOAD_A = 1;
        LED_LOAD_B = 1;
//// fnd test
//       command = 0x0f;
//       fnd_data = 0x01;
//       fnd_out(3);


// scan limit
       command = 0x0b;
       fnd_data = 0x05;
       fnd_out(3);

// intensity
       command = 0x0a;
       fnd_data = 0x03; //0x07
       fnd_out(3);

// decode mode
       command = 0x09;
       //fnd_data = 0xff;
      fnd_data = 0x00;
       fnd_out(3);

//  // shut down
//       command = 0x0c;
//       fnd_data = 0x01;
//       fnd_out(3);

//// fnd test normar
//       command = 0x0f;
//       fnd_data = 0x00;
//       fnd_out(3);
//
//       digit = 3;
//       digit1(8,digit);
//       digit2(8,digit);
//       digit3(8,digit);
//       digit4(8,digit);
//       digit5(8,digit);
//       digit6(8,digit);
}

void init(void)
{
//led_bit test
        LAN_RESET = 1;
        LAN_ISP = 1;


        LED_LOAD = 1;
        LED_LOAD_A = 1;
        LED_LOAD_B = 1;
// fnd test
       command = 0x0f;
       fnd_data = 0x01;
       fnd_out(3);


// scan limit
       command = 0x0b;
       fnd_data = 0x05;
       fnd_out(3);

// intensity
       command = 0x0a;
       fnd_data = 0x03; //0x07
       fnd_out(3);

// decode mode
       command = 0x09;
       //fnd_data = 0xff;
      fnd_data = 0x00;
       fnd_out(3);

  // shut down
       command = 0x0c;
       fnd_data = 0x01;
       fnd_out(3);

// fnd test normar
       command = 0x0f;
       fnd_data = 0x00;
       fnd_out(3);

       digit = 3;
       digit1(8,digit);
       digit2(8,digit);
       digit3(8,digit);
       digit4(8,digit);
       digit5(8,digit);
       digit6(8,digit);

        BUZZER_HIGH = 1;
        DT_NORMAL  = OFF;
        DT_ERR = ON;
        GE_NORMAL  = OFF;
        GE_ERR = ON;
        BAT_RUN_1  = OFF;
        BAT_RUN_2  = OFF;
        BAT_ERR_1  = ON;
        BAT_ERR_2  = ON;
        TEST_LED_1 = ON;
        TEST_LED_2 = ON;

        delay_ms(250);
        BUZZER_HIGH = 0; //LAN RESET
        delay_ms(750);
        DT_NORMAL  = ON;
        DT_ERR = OFF;
        GE_NORMAL  = ON;
        GE_ERR = OFF;
        BAT_RUN_1  = ON;
        BAT_RUN_2  = ON;
        BAT_ERR_1  = OFF;
        BAT_ERR_2  = OFF;

        LAN_RESET = 0;
       // delay_ms(500);
       delay_ms(1000);
        DT_NORMAL  = OFF;
        DT_ERR = OFF;
        GE_NORMAL  = OFF;
        GE_ERR = OFF;
        BAT_ERR_1  = OFF;
        BAT_ERR_2  = OFF;
        BAT_RUN_1  = OFF;
        BAT_RUN_2  = OFF;

        LAN_RESET = 1;  //LAN RESET

        RE_DE0 = 0;
        RE_DE1 = 0;

        buzzer_on = 1;
        mode_change_and_init = 1; //초기 경보 대기

        temp_control_1_old = 0xff;
        temp_control_2_old = 0xff;
}

void display_out()
{
        if(DT_ERR == ERR)
        {
         voltage_1 = 0;
         currunt_1 = 0;
         bat_volt_1 = 0;
         voltage_2 = 0;
         currunt_2 = 0;
         bat_volt_2 = 0;
        }
        digit = 0;
            if(voltage_1 < 100)
            {
              digit1(0,digit);
               if(voltage_1<10)
                {
                   digit2(0,digit);
                }
                else
                {
                   digit2(voltage_1/10,digit);
                }
            }
            else
            {
              if( voltage_1/100 < 10)
              {
                digit1(voltage_1/100,digit);
              }
              else
              {
                digit1(0,digit);
              }
              digit2((voltage_1 - ((voltage_1/100)*100))/10,digit);
            }
            if(voltage_1 == 0){ digit3(0,digit);}else{digit3(voltage_1%10,digit);}


            if(voltage_2 < 100)
            {
              digit4(0,digit);
               if(voltage_2<10)
                {
                   digit5(0,digit);
                }
                else
                {
                   digit5(voltage_2/10,digit);
                }
            }
            else
            {
              if( voltage_2/100 < 10)
              {
                digit4(voltage_2/100,digit);
              }
              else
              {
                digit4(0,digit);
              }
              digit5((voltage_2 - ((voltage_2/100)*100))/10,digit);
            }
            if(voltage_2 == 0){ digit6(0,digit);}else{digit6(voltage_2%10,digit);}


            digit = 1;

            if(currunt_1 < 100)
            {
              digit1(0,digit);
               if(currunt_1<10)
                {
                   digit2(0,digit);
                }
                else
                {
                   digit2(currunt_1/10,digit);
                }
            }
            else
            {

              if( currunt_1/100 < 10)
              {
                digit1(currunt_1/100,digit);        //입력 값이 1000 넘을 경우  처리
              }
              else
              {
                digit1(0,digit);
              }
              digit2((currunt_1- ((currunt_1/100)*100))/10,digit);
            }
            if(currunt_1 == 0){ digit3(0,digit);}else{digit3(currunt_1%10,digit);}

            if(currunt_2 < 100)
            {
              digit4(0,digit);
               if(currunt_2<10)
                {
                   digit5(0,digit);
                }
                else
                {
                   digit5(currunt_2/10,digit);
                }
            }
            else
            {
                if( currunt_2/100 < 10)
                {
                digit4(currunt_2/100,digit);
                }
                else
                {
                digit4(0,digit);
                }
                digit5((currunt_2 - ((currunt_2/100)*100))/10,digit);
            }
            if(currunt_2 == 0){ digit6(0,digit);}else{digit6(currunt_2%10,digit);}


            digit = 2;
            if(bat_volt_1 < 100)
            {
              digit1(0,digit);
               if(bat_volt_1<10)
                {
                   digit2(0,digit);
                }
                else
                {
                   digit2(bat_volt_1/10,digit);
                }
            if(bat_volt_1 == 0){ digit3(0,digit);}else{digit3(bat_volt_1%10,digit);}
            }
            else
            {
                digit1(1,digit);
                digit2(0,digit);
                digit3(0,digit);
            }

            if(bat_volt_2 < 100)
            {
              digit4(0,digit);
               if(bat_volt_2<10)
                {
                   digit5(0,digit);
                }
                else
                {
                   digit5(bat_volt_2/10,digit);
                }
            if(bat_volt_2 == 0){ digit6(0,digit);}else{digit6(bat_volt_2%10,digit);}
            }
            else
            {
                digit4(1,digit);
                digit5(0,digit);
                digit6(0,digit);
            }


}

void Response_Common_CHeckLink(void)
{
 putchar1(0x38);//type
 putchar1(0xf1);//id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Common_CheckLink_number);//number
 putchar1(0x24);//style
 putchar1(0x00);//length
 putchar1(0x00);//length
 if(Common_CheckLink_number >= 0xff){Common_CheckLink_number = 0;}else{Common_CheckLink_number++;}
 Common_CHeckLink_act = 0;
}

//void Response_PoBITResult(void)
//{
// putchar1(0x38); //type
// putchar1(0x01); //id
// putchar1(0x28); //sol_data
// putchar1(0x20); //dest_data
// putchar1(PoBITResult_number);
// putchar1(0x25); //tm
// putchar1(0x00);//length_1
// putchar1(0x02);//length_2
// putchar1(0x05);//po bit상태
//
// if(gen_err == 1){pobit_result |= 0x40;}else{pobit_result &= ~0x40;}
// if(batt_link_err_act_1 == 1){pobit_result |= 0x20;}else{pobit_result &= ~0x20;}
// if(batt_link_err_act_1 == 1){pobit_result |= 0x10;}else{pobit_result &= ~0x10;}
// if(batt_link_err_act_2 == 1){pobit_result |= 0x08;}else{pobit_result &= ~0x08;}
// if(power_link_1 & 0x80 != 0x80){pobit_result |= 0x04;}else{pobit_result &= ~0x04;}
// if(power_link_2 & 0x80 != 0x80){pobit_result |= 0x02;}else{pobit_result &= ~0x02;}
// if(DT_ERR == 1){pobit_result |= 0x01;}else{pobit_result &= ~0x01;}
// if(PoBITResult_number >= 0xff){PoBITResult_number = 0;}else{PoBITResult_number++;}
//
// PoBITResult_act = 0;
//}

//배전기 PBIT응답
void Response_Distributor_PBIT(void)
{
 putchar1(0x38); //type
 putchar1(0xf3); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Distributor_PBIT_number);
 putchar1(0x24); //tm
 putchar1(0x01);//length_1
 putchar1(0x00);//length_2
 pbit_result = 0x00;//초기

 //통신상태
 //bit 5 reserve
 if((comm_ge_err == ERR)||(power_link1_err == 1)||(power_link2_err == 1)||(batt_link_err_act_1 == 1)||
 (batt_link_err_act_2 == 1)||(DT_ERR == 1)){pbit_result |= 0x80;}else{pbit_result &= ~0x80;}//batt 온도 불량///batt 전류 불량  //batt 전압 불량

 if((ge_err_act == ERR)&&(comm_ge_err == NOR)){pbit_result |= 0x20;}else{pbit_result &= ~0x20;}//통신단절시 에러표시 0으로
 if((err_bat2_volt == 1)||(err_bat2_temp == 1)||(err_bat2_curr == 1)){pbit_result |= 0x10;}else{pbit_result &= ~0x10;}
 if((err_bat1_volt == 1)||(err_bat1_temp == 1)||(err_bat1_curr == 1)){pbit_result |= 0x08;}else{pbit_result &= ~0x08;}
 if(power_2_err == 1){pbit_result |= 0x04;}else{pbit_result &= ~0x04;}
 if(power_1_err == 1){pbit_result |= 0x02;}else{pbit_result &= ~0x02;}
 if(deiver_48_err == ERR){pbit_result |= 0x01;}else{pbit_result &= ~0x01;}

 putchar1(pbit_result);//pobit결과
 if(Distributor_PBIT_number >= 0xff){Distributor_PBIT_number = 0;}else{Distributor_PBIT_number++;}
 Distributor_PBIT_act = 0;
}

void Response_Distributor_ShutdownResponse(void)
{
 putchar1(0x38); //type
 putchar1(0x00); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Distributor_ShutdownResponse_number);
 putchar1(0x24); //tm
 putchar1(0x01);//length_1
 putchar1(0x00);//length_2
 putchar1(0x00);//pobit결과
 if(Distributor_ShutdownResponse_number >= 0xff){Distributor_ShutdownResponse_number = 0;}else{Distributor_ShutdownResponse_number++;}
 Distributor_ShutdownResponse_act = 0;
}

void Response_Distributor_ShutdownErroResponse(void)
{
 putchar1(0x38); //type
 putchar1(0x03); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Distributor_ShutdownErroResponse_number);
 putchar1(0x24); //tm
 putchar1(0x07); //length 1
 putchar1(0x00); //length 2
 putchar1(keep_year);//year
 putchar1(keep_month);//month
 putchar1(keep_day);//day
 putchar1(keep_hour);//hour
 putchar1(keep_minute);//minute
 putchar1(keep_sec);//sec
 putchar1(0x01);//error device
 if(Distributor_ShutdownErroResponse_number >= 0xff){Distributor_ShutdownErroResponse_number = 0;}else{Distributor_ShutdownErroResponse_number++;}
 Distributor_ShutdownErroResponse_act = 0;
}

void Response_Distributor_TimeSyncAck(void)
{
 putchar1(0x38); //type
 putchar1(0x04); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Distributor_TimeSyncAck_number);
 putchar1(0x24); //tm
 putchar1(0x01); //length 1
 putchar1(0x00); //length 2
 putchar1(0x01); //설정 완료 응답
 if(Distributor_TimeSyncAck_number >= 0xff){Distributor_TimeSyncAck_number = 0;}else{Distributor_TimeSyncAck_number++;}
 Distributor_TimeSyncAck_act = 0;
}


void Response_Distributor_PoBITResponse_pre(void)
{
 //ack처리
 putchar1(0x38); //type
 putchar1(0x01); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(PoBITResult_number_ack);
 putchar1(0x24); //tm
 putchar1(0x02);//length_1
 putchar1(0x00);//length_2
 putchar1(0x01);//ack
 putchar1(0x00);//데이터 없음
 if(PoBITResult_number_ack >= 0xff){PoBITResult_number_ack = 0;}else{PoBITResult_number_ack++;}
 Distributor_PoBIT_act_pre= 0;
}

void Response_Distributor_PoBITResponse(void)
{
 putchar1(0x38); //type
 putchar1(0x01); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(PoBITResult_number);
 putchar1(0x24); //tm
 putchar1(0x02);//length_1
 putchar1(0x00);//length_2
 putchar1(0x05);//po bit상태
 if(PoBITResult_number >= 0xff){PoBITResult_number = 0;}else{PoBITResult_number++;}
 //통신상태
 //bit 5 reserve
 if((comm_ge_err == ERR)||(power_link1_err == 1)||(power_link2_err == 1)||(batt_link_err_act_1 == 1)||(batt_link_err_act_2 == 1)||(DT_ERR == 1)){pbit_result |= 0x80;}else{pbit_result &= ~0x80;}//batt 온도 불량///batt 전류 불량  //batt 전압 불량
 if(ge_err_act == ERR){pbit_result |= 0x20;}else{pbit_result &= ~0x20;}
 if((err_bat2_volt == 1)||(err_bat2_temp == 1)||(err_bat2_curr == 1)){pbit_result |= 0x10;}else{pbit_result &= ~0x10;}
 if((err_bat1_volt == 1)||(err_bat1_temp == 1)||(err_bat1_curr == 1)){pbit_result |= 0x08;}else{pbit_result &= ~0x08;}
 if(power_2_err == 1){pbit_result |= 0x04;}else{pbit_result &= ~0x04;}
 if(power_1_err == 1){pbit_result |= 0x02;}else{pbit_result &= ~0x02;}
 if(deiver_48_err == ERR){pbit_result |= 0x01;}else{pbit_result &= ~0x01;}

 putchar1(pobit_result);//pobit결과
 if(PoBITResult_number >= 0xff){PoBITResult_number = 0;}else{PoBITResult_number++;}
 Distributor_PoBIT_act= 0;
}

void Response_Distributor_BITDetailResponse(void)
{
 putchar1(0x38); //type
 putchar1(0x02); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Distributor_BITBetailResponse_number);
 putchar1(0x24); //tm
 putchar1(0x02); //length 1
 putchar1(0x00); //length 2
 //통신상태
 //bit 5 reserve
// if(gen_err  == 1){pbit_result |= 0x20;}else{pbit_result &= ~0x20;}//5
// if(batt_link_err_act_2 == 1){pbit_result |= 0x10;}else{pbit_result &= ~0x10;}
// if(batt_link_err_act_1 == 1){pbit_result |= 0x08;}else{pbit_result &= ~0x08;}
// if(power_link2_err == 1){pbit_result |= 0x04;}else{pbit_result &= ~0x04;}
// if(power_link1_err == 1){pbit_result |= 0x02;}else{pbit_result &= ~0x02;}
// if(DT_ERR == 1){pbit_result |= 0x01;}else{pbit_result &= ~0x01;}
 putchar1(po_bit_recive_data_detail);//pobit결과

// //데이터 초기화
// link_err_detail = 0x00;
// div_err_detail = 0x00;
// power_1_err_detail = 0x00;
// power_2_err_detail = 0x00;
// bat_1_err_detail = 0x00;
// bat_2_err_detail = 0x00;
// gen_err_detail = 0x00;

 //*****************
 //에러 데이터 정렬
 //*****************

 //링크에러
// link_err_detail = 0x00;

 if(comm_ge_err == ERR){link_err_detail |= 0x20;}else{link_err_detail &= ~0x20;} //발전기 링크 에러
 if(batt_link_err_act_2 == ERR){link_err_detail |= 0x10;}else{link_err_detail &= ~0x10;} //배터리1 링크 에러
 if(batt_link_err_act_1 == ERR){link_err_detail |= 0x08;}else{link_err_detail &= ~0x08;} //배터리2 링크 에러
 if((power_link_2 & 0x80) != 0x80){link_err_detail |= 0x04;}else{link_err_detail &= ~0x04;} //전원반1 링크 에러
 if((power_link_1 & 0x80) != 0x80){link_err_detail |= 0x02;}else{link_err_detail &= ~0x02;} //전원반2 링크 에러
 if((comm_err == 1)||(dt_err_act == 1)){link_err_detail |= 0x01;}else{link_err_detail &= ~0x01;} //분배기 링크 에러

 //발전기
 if(comm_ge_err == ERR)
 {
  gen_err_detail = 0x00;
 }
 else
 {
 if((ge_err_data & 0x10) == 0x10){gen_err_detail |= 0x10;}else{gen_err_detail &= ~0x10;} //발전기 오일 압력
 if((ge_err_data & 0x08) == 0x08){gen_err_detail |= 0x08;}else{gen_err_detail &= ~0x08;} //발전기 과속도
 if((ge_err_data & 0x04) == 0x04){gen_err_detail |= 0x04;}else{gen_err_detail &= ~0x04;} //발전기 엔진과온도
 if((ge_err_data & 0x02) == 0x02){gen_err_detail |= 0x02;}else{gen_err_detail &= ~0x02;} //발전기 전압이상
 if((ge_err_data & 0x01) == 0x01){gen_err_detail |= 0x01;}else{gen_err_detail &= ~0x01;} //발전기 과전류
 }

  //배터리2
 if(err_bat2_temp == 1){bat_2_err_detail |= 0x04;}else{bat_2_err_detail &= ~0x04;} //batt 온도 불량
 if(err_bat2_curr == 1){bat_2_err_detail |= 0x02;}else{bat_2_err_detail &= ~0x02;} //batt 전류 불량
 if(err_bat2_volt == 1){bat_2_err_detail |= 0x01;}else{bat_2_err_detail &= ~0x01;} //batt 전압 불량

// if((err_main_2 & 0x40) == 0x40){bat_2_err_detail |= 0x04;}else{bat_1_err_detail &= ~0x04;} //batt 온도 불량
// if((err_main_2 & 0x08) == 0x08){bat_2_err_detail |= 0x02;}else{bat_1_err_detail &= ~0x02;} //batt 전류 불량
// if((err_main_2 & 0x10) == 0x10){bat_2_err_detail |= 0x01;}else{bat_1_err_detail &= ~0x01;} //batt 전압 불량

 //배터리1
 if(err_bat1_temp == 1){bat_1_err_detail |= 0x04;}else{bat_1_err_detail &= ~0x04;} //batt 온도 불량
 if(err_bat1_curr == 1){bat_1_err_detail |= 0x02;}else{bat_1_err_detail &= ~0x02;} //batt 전류 불량
 if(err_bat1_volt == 1){bat_1_err_detail |= 0x01;}else{bat_1_err_detail &= ~0x01;} //batt 전압 불량


// if((err_main_1 & 0x40) == 0x40){bat_1_err_detail |= 0x04;}else{bat_1_err_detail &= ~0x04;} //batt 온도 불량
// if((err_main_1 & 0x08) == 0x08){bat_1_err_detail |= 0x02;}else{bat_1_err_detail &= ~0x02;} //batt 전류 불량
// if((err_main_1 & 0x10) == 0x10){bat_1_err_detail |= 0x01;}else{bat_1_err_detail &= ~0x01;} //batt 전압 불량

 //전원반 2 에러
  if((err_main_2 & 0x80)==0x80){power_2_err_detail = 0x01;}else{power_2_err_detail = 0x00;}  //전원반2이 하나라도 에러만 에러로 처리(채널정보 포함)
// if((power_link_2 & 0x80) != 0x80){power_2_err_detail = 0x01;}else{power_2_err_detail = 0x00;}

 //전원반 1 에러
   if((err_main_1 & 0x80)==0x80){power_1_err_detail = 0x01;}else{power_1_err_detail = 0x00;}  //전원반1이 하나라도 에러만 에러로 처리(채널정보 포함)
//  if((power_link_1 & 0x80)!=0x80){power_1_err_detail = 0x01;}else{power_1_err_detail = 0x00;}  //전원반1이 하나라도 에러만 에러로 처리(채널정보 포함)

 //분배기 에러
 if(deiver_48_err == ERR){div_err_detail = 0x01;}else{div_err_detail = 0x00;}

 //*****************
 //시험용 데이터 출력
 //****************
 if(ADDRESS_2 == 0)
 {
     link_err_detail = 0x80;
     gen_err_detail = 0x20;
     bat_2_err_detail = 0x10;
     bat_1_err_detail = 0x08;
     power_2_err_detail = 0x04;
     power_1_err_detail = 0x02;
     div_err_detail = 0x01;
 }


 //reserve
 if((po_bit_recive_data_detail & 0x80) == 0x80){putchar1(link_err_detail);} //link connection    임무처리기 고장(1)
 if((po_bit_recive_data_detail & 0x20) == 0x20){putchar1(gen_err_detail);} //general device 발전기 오일압력(4) 엔진 과속도(3) 엔진 과온도(2) 전압이상(1) 과전류(0)
 if((po_bit_recive_data_detail & 0x10) == 0x10){putchar1(bat_2_err_detail);} //nattery device #2 배터리2 온도(2) 전류(1) 전압(0)
 if((po_bit_recive_data_detail & 0x08) == 0x08){putchar1(bat_1_err_detail);} //battery device #1 배터리1 온도(2) 전류(1) 전압(0)
 if((po_bit_recive_data_detail & 0x04) == 0x04){putchar1(power_2_err_detail);} //power device#2  전원공급기2 고장(1)
 if((po_bit_recive_data_detail & 0x02) == 0x02){putchar1(power_1_err_detail);} //power device#1  전원공급기1 고장(1)
 if((po_bit_recive_data_detail & 0x01) == 0x01){putchar1(div_err_detail);} //배전기 상태   배전기 상태 고장(1)

 if(Distributor_BITBetailResponse_number >= 0xff){Distributor_BITBetailResponse_number = 0;}else{Distributor_BITBetailResponse_number++;}
 Distributor_BITDetailResponse_act = 0;
}

void Report_Distributor_DeviceStatus(void) //장치 상태 출력 10hz 주기적
{
 putchar1(0x38); //type
 putchar1(0xf6); //id
 putchar1(0x28); //sol_data
 putchar1(0x20); //dest_data
 putchar1(Distributor_devicestatus_number);
 putchar1(0x24); //tm
 putchar1(0x2a); //length 1
 putchar1(0x00); //length 2 //39바이트

 //switch_상태 사용 전원 구분
 if((batt_run_act_1 == ON)||(batt_run_act_2 == ON))
 {
  putchar1(0x04);
 }
 else
 {
  putchar1(sw_status);//배터리(2) 외부전원(1) 발전기(0)
 }
 //****************
 //시험용 데이터 출력
 //****************
 if(ADDRESS_1 == 0)
 {
  voltage_ge = 450;
  currunt_ge = 100;

  voltage_m24_1 = 280;
  currunt_1 = 101;

  voltage_m24_2 = 280;
  currunt_2 = 102;

  voltage_ch1_1 = 281;
  voltage_ch2_1 = 282;
  voltage_ch3_1 = 283;
  voltage_ch4_1 = 284;
  voltage_ch5_1 = 285;
  voltage_ch6_1 = 286;
  voltage_ch7_1 = 287;

  voltage_ch1_2 = 281;
  voltage_ch2_2 = 282;
  voltage_ch3_2 = 283;
  voltage_ch4_2 = 284;
  voltage_ch5_2 = 285;
  voltage_ch6_2 = 286;
  voltage_ch7_2 = 287;

  currunt_ch1_1 = 151;
  currunt_ch2_1 = 152;
  currunt_ch3_1 = 153;
  currunt_ch4_1 = 154;
  currunt_ch5_1 = 155;
  currunt_ch6_1 = 156;
  currunt_ch7_1 = 157;

  currunt_ch1_2 = 151;
  currunt_ch2_2 = 152;
  currunt_ch3_2 = 153;
  currunt_ch4_2 = 154;
  currunt_ch5_2 = 155;
  currunt_ch6_2 = 156;
  currunt_ch7_2 = 157;

  batt_level_1 = 40;
  batt_level_2 = 80;
 }



 //전원공급기 #1 전압 전류
 if((voltage_m24_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_m24_1 - 150);}else{putchar1(0x00);}    // current1
 if(DT_ERR == NOR)
 {
 putchar1(currunt_2%256);
 putchar1(currunt_2/256);
 }
 else
 {
 putchar1(0x00);
 putchar1(0x00);
 }


 //전원공급기 #2 전압 전류
 if((voltage_m24_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_m24_2 - 150);}else{putchar1(0x00);}     // current2
  if(DT_ERR == NOR)
  {
  putchar1(currunt_1%256);
  putchar1(currunt_1/256);
  }
  else
  {
  putchar1(0x00);
  putchar1(0x00);
  }

 //MCU POWER
 if((voltage_ch1_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch1_2 - 150);}else{putchar1(0x00);}   //1-2  7-1

  if(DT_ERR == NOR){putchar1(currunt_ch1_2);}else{putchar1(0x00);}

 //OPU1 POWER
 if((voltage_ch2_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch2_2 - 150);}else{putchar1(0x00);}  //2-2 6-1
  if(DT_ERR == NOR){putchar1(currunt_ch2_2);}else{putchar1(0x00);}

 //ODU1 POWER
 if((voltage_ch1_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch1_1 - 150);}else{putchar1(0x00);}  //1-1 7-2
  if(DT_ERR == NOR){putchar1(currunt_ch1_1);}else{putchar1(0x00);}

 //OCU1 POWER
 if((voltage_ch2_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch2_1 - 150);}else{putchar1(0x00);}  //2-1 6-2
  if(DT_ERR == NOR){ putchar1(currunt_ch2_1);}else{putchar1(0x00);}

 //OPU2 POWER
 if((voltage_ch6_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch6_2 - 150);}else{putchar1(0x00);}  // 6-2 2-1
  if(DT_ERR == NOR){ putchar1(currunt_ch6_2);}else{putchar1(0x00);}

 //ODU2 POWER
 if((voltage_ch3_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch3_2 - 150);}else{putchar1(0x00);}   //3-2 5-1
   if(DT_ERR == NOR){putchar1(currunt_ch3_2);}else{putchar1(0x00);}

 //OCU2
 if((voltage_ch5_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch5_2 - 150);}else{putchar1(0x00);}   //5-2 3-1
   if(DT_ERR == NOR){putchar1(currunt_ch5_2);}else{putchar1(0x00);}



 //MAIN LINK POWER
 if((voltage_ch3_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch3_1 - 150);}else{putchar1(0x00);}  //3- 1 5-2
 if(DT_ERR == NOR){putchar1(currunt_ch3_1);}else{putchar1(0x00);}

 if(DT_ERR == NOR)
 {
 if(voltage_fan_1 <= 150){putchar1(0x00);}else{putchar1(voltage_fan_1 - 150);} //main fan 전압 전류 수정 191212
 if(currunt_fan_1 >= 255){putchar1(0xff);}else{putchar1(currunt_fan_1);}
 }
 else
 {
  putchar1(0x00);
  putchar1(0x00);
 }


 //SUB LINK POWER
 if((voltage_ch4_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch4_1 - 150);}else{putchar1(0x00);}  //4-1 4-2
   if(DT_ERR == NOR){ putchar1(currunt_ch4_1);}else{putchar1(0x00);}

 //ANT MAST POWER
 if((voltage_ch7_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch7_1 - 150);}else{putchar1(0x00);}  //7-1 1-2
   if(DT_ERR == NOR){ putchar1(currunt_ch7_1);}else{putchar1(0x00);}

 if(DT_ERR == NOR)
 {
 if(voltage_fan_2 <= 150){putchar1(0x00);}else{putchar1(voltage_fan_2 - 150);}  //ant fan 전압 전류 수정 191212
 if(currunt_fan_2 >= 255){putchar1(0xff);}else{putchar1(currunt_fan_2);}
 }
 else
 {
  putchar1(0x00);
  putchar1(0x00);
 }


 //INS POWER
 if((voltage_ch4_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch4_2 - 150);}else{putchar1(0x00);} //4-2 4-1
   if(DT_ERR == NOR){ putchar1(currunt_ch4_2);}else{putchar1(0x00);}

 //C2VREC POWER
 if((voltage_ch6_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch6_1 - 150);}else{putchar1(0x00);}  //6-1 2-2
   if(DT_ERR == NOR){ putchar1(currunt_ch6_1);}else{putchar1(0x00);}

 //ROUTER POWER
 if((voltage_ch7_2 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch7_2 - 150);}else{putchar1(0x00);}  //7-2 1-1
  if(DT_ERR == NOR){ putchar1(currunt_ch7_2); }else{putchar1(0x00);}

 //SWITCH POWER
 if((voltage_ch5_1 > 150)&&(DT_ERR == NOR)){putchar1(voltage_ch5_1 - 150);}else{putchar1(0x00);} //5-1  3-2
   if(DT_ERR == NOR){ putchar1(currunt_ch5_1);}else{putchar1(0x00);}

 //BTTERY 1 STATUS
  if(DT_ERR == NOR){putchar1(batt_level_1);}else{putchar1(0x00);}

 //BATTERY 2 STATUS
  if(DT_ERR == NOR){putchar1(batt_level_2);}else{putchar1(0x00);}

 //발전기 전압 및 전류
if(comm_ge_err == ERR)
{
voltage_ge = 0;
putchar1(voltage_ge);
putchar1(0x00);  //전류를 0으로 처리
putchar1(0x00);  //전류를 0으로 처리
}
else
{
if(voltage_ge > 350){putchar1(voltage_ge - 350);}else{putchar1(0x00);}
 putchar1(currunt_ge % 256);   //리틀인디언 적용
 putchar1(currunt_ge / 255);
}
  if(Distributor_devicestatus_number >= 0xff){Distributor_devicestatus_number = 0;}else{Distributor_devicestatus_number++;}
}

void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=(1<<CLKPCE);
CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRB=(0<<DDB7) | (1<<DDB6) | (1<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (1<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=Out Bit5=Out Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRC=(0<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=T Bit6=0 Bit5=0 Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (1<<DDD4) | (0<<DDD3) | (0<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Port E initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
DDRE=(1<<DDE7) | (1<<DDE6) | (1<<DDE5) | (1<<DDE4) | (1<<DDE3) | (1<<DDE2) | (0<<DDE1) | (0<<DDE0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
PORTE=(0<<PORTE7) | (0<<PORTE6) | (0<<PORTE5) | (0<<PORTE4) | (0<<PORTE3) | (0<<PORTE2) | (0<<PORTE1) | (0<<PORTE0);

// Port F initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRF=(0<<DDF7) | (0<<DDF6) | (0<<DDF5) | (0<<DDF4) | (0<<DDF3) | (0<<DDF2) | (0<<DDF1) | (0<<DDF0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF3) | (0<<PORTF2) | (0<<PORTF1) | (0<<PORTF0);

// Port G initialization
// Function: Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRG=(0<<DDG5) | (0<<DDG4) | (0<<DDG3) | (0<<DDG2) | (0<<DDG1) | (0<<DDG0);
// State: Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTG=(0<<PORTG5) | (0<<PORTG4) | (0<<PORTG3) | (0<<PORTG2) | (0<<PORTG1) | (0<<PORTG0);

// Port H initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRH=(0<<DDH7) | (0<<DDH6) | (0<<DDH5) | (0<<DDH4) | (0<<DDH3) | (0<<DDH2) | (0<<DDH1) | (0<<DDH0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTH=(0<<PORTH7) | (0<<PORTH6) | (0<<PORTH5) | (0<<PORTH4) | (0<<PORTH3) | (0<<PORTH2) | (0<<PORTH1) | (0<<PORTH0);

// Port J initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRJ=(0<<DDJ7) | (0<<DDJ6) | (0<<DDJ5) | (0<<DDJ4) | (0<<DDJ3) | (0<<DDJ2) | (0<<DDJ1) | (0<<DDJ0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTJ=(0<<PORTJ7) | (0<<PORTJ6) | (0<<PORTJ5) | (0<<PORTJ4) | (0<<PORTJ3) | (0<<PORTJ2) | (0<<PORTJ1) | (0<<PORTJ0);

// Port K initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRK=(0<<DDK7) | (0<<DDK6) | (0<<DDK5) | (0<<DDK4) | (0<<DDK3) | (0<<DDK2) | (0<<DDK1) | (0<<DDK0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTK=(0<<PORTK7) | (0<<PORTK6) | (0<<PORTK5) | (0<<PORTK4) | (0<<PORTK3) | (0<<PORTK2) | (0<<PORTK1) | (0<<PORTK0);

// Port L initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
DDRL=(0<<DDL7) | (0<<DDL6) | (0<<DDL5) | (0<<DDL4) | (0<<DDL3) | (0<<DDL2) | (0<<DDL1) | (0<<DDL0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
PORTL=(0<<PORTL7) | (0<<PORTL6) | (0<<PORTL5) | (0<<PORTL4) | (0<<PORTL3) | (0<<PORTL2) | (0<<PORTL1) | (0<<PORTL0);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 11059.200 kHz
// Mode: Normal top=0xFF
// OC0A output: Disconnected
// OC0B output: Disconnected
// Timer Period: 0.023148 ms
TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (1<<CS00);
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 11059.200 kHz
// Mode: Fast PWM top=OCR1A
// OC1A output: Disconnected
// OC1B output: Non-Inverted PWM
// OC1C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 0.50004 ms
// Output Pulse(s):
// OC1B Period: 0.50004 ms Width: 0.24997 ms
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (1<<WGM11) | (1<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (1<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x15;
OCR1AL=0x99;
OCR1BH=0x0A;
OCR1BL=0xCC;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2A output: Disconnected
// OC2B output: Disconnected
ASSR=(0<<EXCLK) | (0<<AS2);
TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer3 Stopped
// Mode: Normal top=0xFFFF
// OC3A output: Disconnected
// OC3B output: Disconnected
// OC3C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// Timer/Counter 4 initialization
// Clock source: System Clock
// Clock value: Timer4 Stopped
// Mode: Normal top=0xFFFF
// OC4A output: Disconnected
// OC4B output: Disconnected
// OC4C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer4 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR4A=(0<<COM4A1) | (0<<COM4A0) | (0<<COM4B1) | (0<<COM4B0) | (0<<COM4C1) | (0<<COM4C0) | (0<<WGM41) | (0<<WGM40);
TCCR4B=(0<<ICNC4) | (0<<ICES4) | (0<<WGM43) | (0<<WGM42) | (0<<CS42) | (0<<CS41) | (0<<CS40);
TCNT4H=0x00;
TCNT4L=0x00;
ICR4H=0x00;
ICR4L=0x00;
OCR4AH=0x00;
OCR4AL=0x00;
OCR4BH=0x00;
OCR4BL=0x00;
OCR4CH=0x00;
OCR4CL=0x00;

// Timer/Counter 5 initialization
// Clock source: System Clock
// Clock value: Timer5 Stopped
// Mode: Normal top=0xFFFF
// OC5A output: Disconnected
// OC5B output: Disconnected
// OC5C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer5 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR5A=(0<<COM5A1) | (0<<COM5A0) | (0<<COM5B1) | (0<<COM5B0) | (0<<COM5C1) | (0<<COM5C0) | (0<<WGM51) | (0<<WGM50);
TCCR5B=(0<<ICNC5) | (0<<ICES5) | (0<<WGM53) | (0<<WGM52) | (0<<CS52) | (0<<CS51) | (0<<CS50);
TCNT5H=0x00;
TCNT5L=0x00;
ICR5H=0x00;
ICR5L=0x00;
OCR5AH=0x00;
OCR5AL=0x00;
OCR5BH=0x00;
OCR5BL=0x00;
OCR5CH=0x00;
OCR5CL=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (1<<TOIE0);

// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=(0<<ICIE1) | (0<<OCIE1C) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);

// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);

// Timer/Counter 3 Interrupt(s) initialization
TIMSK3=(0<<ICIE3) | (0<<OCIE3C) | (0<<OCIE3B) | (0<<OCIE3A) | (0<<TOIE3);

// Timer/Counter 4 Interrupt(s) initialization
TIMSK4=(0<<ICIE4) | (0<<OCIE4C) | (0<<OCIE4B) | (0<<OCIE4A) | (0<<TOIE4);

// Timer/Counter 5 Interrupt(s) initialization
TIMSK5=(0<<ICIE5) | (0<<OCIE5C) | (0<<OCIE5B) | (0<<OCIE5A) | (0<<TOIE5);

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
EICRB=(0<<ISC71) | (0<<ISC70) | (0<<ISC61) | (0<<ISC60) | (0<<ISC51) | (0<<ISC50) | (0<<ISC41) | (0<<ISC40);
EIMSK=(0<<INT7) | (0<<INT6) | (0<<INT5) | (0<<INT4) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
// PCINT0 interrupt: Off
// PCINT1 interrupt: Off
// PCINT2 interrupt: Off
// PCINT3 interrupt: Off
// PCINT4 interrupt: Off
// PCINT5 interrupt: Off
// PCINT6 interrupt: Off
// PCINT7 interrupt: Off
// PCINT8 interrupt: Off
// PCINT9 interrupt: Off
// PCINT10 interrupt: Off
// PCINT11 interrupt: Off
// PCINT12 interrupt: Off
// PCINT13 interrupt: Off
// PCINT14 interrupt: Off
// PCINT15 interrupt: Off                                                                             y
// PCINT16 interrupt: Off
// PCINT17 interrupt: Off
// PCINT18 interrupt: Off
// PCINT19 interrupt: Off
// PCINT20 interrupt: Off
// PCINT21 interrupt: Off
// PCINT22 interrupt: Off
// PCINT23 interrupt: Off
PCMSK0=(0<<PCINT7) | (0<<PCINT6) | (0<<PCINT5) | (0<<PCINT4) | (0<<PCINT3) | (0<<PCINT2) | (0<<PCINT1) | (0<<PCINT0);
PCMSK1=(0<<PCINT15) | (0<<PCINT14) | (0<<PCINT13) | (0<<PCINT12) | (0<<PCINT11) | (0<<PCINT10) | (0<<PCINT9) | (0<<PCINT8);
PCMSK2=(0<<PCINT23) | (0<<PCINT22) | (0<<PCINT21) | (0<<PCINT20) | (0<<PCINT19) | (0<<PCINT18) | (0<<PCINT17) | (0<<PCINT16);
PCICR=(0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 115200
UCSR0A=(0<<RXC0) | (0<<TXC0) | (0<<UDRE0) | (0<<FE0) | (0<<DOR0) | (0<<UPE0) | (0<<U2X0) | (0<<MPCM0);
UCSR0B=(1<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (1<<RXEN0) | (1<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
UCSR0C=(0<<UMSEL01) | (0<<UMSEL00) | (0<<UPM01) | (0<<UPM00) | (0<<USBS0) | (1<<UCSZ01) | (1<<UCSZ00) | (0<<UCPOL0);
UBRR0H=0x00;
UBRR0L=0x05;

// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud Rate: 115200
UCSR1A=(0<<RXC1) | (0<<TXC1) | (0<<UDRE1) | (0<<FE1) | (0<<DOR1) | (0<<UPE1) | (0<<U2X1) | (0<<MPCM1);
UCSR1B=(1<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (1<<RXEN1) | (1<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
UCSR1C=(0<<UMSEL11) | (0<<UMSEL10) | (0<<UPM11) | (0<<UPM10) | (0<<USBS1) | (1<<UCSZ11) | (1<<UCSZ10) | (0<<UCPOL1);
UBRR1H=0x00;
UBRR1L=0x05;


// USART2 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART2 Receiver: On
// USART2 Transmitter: On
// USART2 Mode: Asynchronous
// USART2 Baud Rate: 57600
UCSR2A=(0<<RXC2) | (0<<TXC2) | (0<<UDRE2) | (0<<FE2) | (0<<DOR2) | (0<<UPE2) | (0<<U2X2) | (0<<MPCM2);
UCSR2B=(1<<RXCIE2) | (0<<TXCIE2) | (0<<UDRIE2) | (1<<RXEN2) | (1<<TXEN2) | (0<<UCSZ22) | (0<<RXB82) | (0<<TXB82);
UCSR2C=(0<<UMSEL21) | (0<<UMSEL20) | (0<<UPM21) | (0<<UPM20) | (0<<USBS2) | (1<<UCSZ21) | (1<<UCSZ20) | (0<<UCPOL2);
UBRR2H=0x00;
UBRR2L=0x0B;

/*
// USART2 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART2 Receiver: On
// USART2 Transmitter: On
// USART2 Mode: Asynchronous
// USART2 Baud Rate: 115200
UCSR2A=(0<<RXC2) | (0<<TXC2) | (0<<UDRE2) | (0<<FE2) | (0<<DOR2) | (0<<UPE2) | (0<<U2X2) | (0<<MPCM2);
UCSR2B=(1<<RXCIE2) | (0<<TXCIE2) | (0<<UDRIE2) | (1<<RXEN2) | (1<<TXEN2) | (0<<UCSZ22) | (0<<RXB82) | (0<<TXB82);
UCSR2C=(0<<UMSEL21) | (0<<UMSEL20) | (0<<UPM21) | (0<<UPM20) | (0<<USBS2) | (1<<UCSZ21) | (1<<UCSZ20) | (0<<UCPOL2);
UBRR2H=0x00;
UBRR2L=0x05;
*/

// USART3 initialization
// USART3 disabled
UCSR3B=(0<<RXCIE3) | (0<<TXCIE3) | (0<<UDRIE3) | (0<<RXEN3) | (0<<TXEN3) | (0<<UCSZ32) | (0<<RXB83) | (0<<TXB83);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
ADCSRB=(0<<ACME);
// Digital input buffer on AIN0: On
// Digital input buffer on AIN1: On
DIDR1=(0<<AIN0D) | (0<<AIN1D);

// ADC initialization
// ADC disabled
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

// Globally enable interrupts
#asm("sei")

// Bit-Banged I2C Bus initialization
// SDA signal: PORTF bit: 2
// SCL signal: PORTA bit: 1
// Bit Rate: 100 kHz
// Note: I2C settings are specified in the
// Project|Configure|C Compiler|Libraries|I2C menu.
i2c_init();

// DS1307 Real Time Clock initialization for Bit-Banged I2C
// Square wave output on pin SQW/OUT: On
// Square wave frequency: 1 Hz
rtc_init(0,1,0);

//날짜초기 설정

/* Set time 00:00:00 */
rtc_set_time(0,0,0);

/* Set date Monday 23/07/2018   week,day,month,yea*/
rtc_set_date(1,1,1,20);



init();

while (1)
      {
            temp_c++;
            if(temp_c>2){temp_c = 0;display_out();}

       //LED
          if(((comm_err == 0) && (DIS_HOT_SWAP == 0))&&(power_link1_err == 0)&&(buzzer_out_wait == 1)&&((sw_status == 1)||(sw_status == 2)))
          //if((power_link_1 & 0x80) == 0x80)
           {
                if((batt_link_err_act_1 == 1)||((err_main_1 & 0x80)==0x80)||(err_bat1_temp == ERR)||(err_bat1_volt == ERR)||(err_bat1_curr == ERR))
                {
                BAT_ERR_1 = ON;
                BAT_RUN_1 = OFF;
                if((batt_err_1_act == OFF)&&(batt_err_1_act_buzzer == OFF)){batt_err_1_act_buzzer = ON;}
                batt_err_1_act = ON;
                }
                else
                {
                BAT_ERR_1 = OFF;
                if(batt_run_act_1 == 1){BAT_RUN_1 = ON;}else{if(led_flash == 1){BAT_RUN_1 = ON;}else{BAT_RUN_1 = OFF;}}
                batt_err_1_act = OFF;
                batt_err_1_act_buzzer = OFF;
                }
           }
           else
           {
                BAT_ERR_1 = OFF;
                BAT_RUN_1 = OFF;
           }

          // if((power_link_2 & 0x80) == 0x80)// 전원반 1,2 핫스왑결과 1이면 정상 0이면 에러로 처리


           if(((comm_err == 0) && (DIS_HOT_SWAP == 0))&&(power_link2_err == 0)&&(buzzer_out_wait == 1)&&((sw_status == 1)||(sw_status == 2)))
           {
                if((batt_link_err_act_2 == 1)||((err_main_2 & 0x80)==0x80)||(err_bat2_temp == ERR)||(err_bat2_volt == ERR)||(err_bat2_curr == ERR))
                {
                BAT_ERR_2 = ON;
                BAT_RUN_2 = OFF;
                if((batt_err_2_act == OFF)&&(batt_err_2_act_buzzer == OFF)){batt_err_2_act_buzzer = ON;}
                batt_err_2_act = ON;
                }
                else
                {
                BAT_ERR_2 = OFF;
                if(batt_run_act_2 == 1){BAT_RUN_2 = ON;}else{if(led_flash == 1){BAT_RUN_2 = ON;}else{BAT_RUN_2 = OFF;}}
                batt_err_2_act = OFF;
                batt_err_2_act_buzzer = OFF;
                }
           }
           else
           {
                BAT_ERR_2 = OFF;
                BAT_RUN_2 = OFF;
           }


           //****************
           // comm_ge_err = 0; //임시처리 시험 및 납품시 삭제 필요
           //****************

            if((sw_status == 1)||(sw_status == 2))
            {
                if((((comm_err == 1)||(deiver_48_err == ERR))&&(buzzer_out_wait == 1))||(DIS_HOT_SWAP == 1))
                {
                DT_NORMAL = 0;
                DT_ERR = 1;
                if((dt_err_act == OFF)&&(dt_err_act_buzzer == OFF)){dt_err_act_buzzer = ON;}
                dt_err_act = ON;
                }
                else
                {
                DT_NORMAL = 1;
                DT_ERR = 0;
                dt_err_act = OFF;
                dt_err_act_buzzer = OFF;
                }


                if(((comm_ge_err == ERR)||(ge_err_act == ERR))&&(buzzer_out_wait == 1))
                {
                 GE_ERR = 1;GE_NORMAL = 0;
                 if((ge_err_latch == OFF)&&(ge_err_act_buzzer == OFF)){ge_err_act_buzzer = ON;}
                 ge_err_latch = ON;
                }
                else
                {
                 GE_NORMAL = 1;GE_ERR = 0;
                 ge_err_act_buzzer = OFF;
                 ge_err_latch = OFF;
                }



               if(init_mod_switch == 0)
               {
                mode_change_and_init = 1; //초기 부저 경보 발생
                init_mod_switch = 1;
               }
            }
            else
            {
              DT_NORMAL = 0;
              DT_ERR = 0;
              GE_ERR = 0;
              GE_NORMAL = 0;
              buzzer_clear_all();
              init_mod_switch = 0;
              mode_change_and_init = 0;
              buzzer_out_wait = 0;
            }



            //if(LAN_STS == 1){DT_NORMAL = 1;}else{DT_NORMAL = 0;}
            //if(LAN_STS == 1){GE_NORMAL = 1;}else{GE_NORMAL = 0;}
            //if(LAN_STS == 1){DT_ERR = 1;}else{DT_ERR = 0;}
            //if(LAN_STS == 1){GE_ERR = 1;}else{GE_ERR = 0;}

            //        //COMM ERROR PROCESS of dt
            //        if(comm_err == 1) //통신 loss시 검출
            //        {
            //         data_clear();
            //         if(ADDRESS_0){voltage_1 = 0;}
            //        if(ADDRESS_0){ voltage_2 = 0;}
            //
            //        if(ADDRESS_0){ currunt_1 = 0;}
            //        if(ADDRESS_0){ currunt_2 = 0;}
            //
            //        if(ADDRESS_0){ bat_volt_1 = 0;}
            //        if(ADDRESS_0){ bat_volt_2 = 0;}
            //        }



       if(send_to_div_act == 1){send_to_div();}

        //셧다운 시간 기록
       if(time_data_get == 1)
        {

            rtc_get_date(&week,&day,&month,&year);
            rtc_get_time(&hour,&minute,&sec);
             keep_year = year;
             keep_month = month;
             keep_day = day;
             keep_hour = hour;
             keep_minute = minute;
             keep_sec = sec;
           time_data_get = 0;
        }



        if((((sw_status == 1)||(sw_status == 2))&&((dt_err_act_buzzer == ON) || (ge_err_act_buzzer == ON) ||
        (batt_err_1_act_buzzer == ON) || (batt_err_2_act_buzzer == ON) ||(power_link1_err_act_buzzer == ON) ||
        (power_link2_err_act_buzzer == ON)))&&(buzzer_out_wait == 1))
      //  { buzzer_on = ON;}else{buzzer_on = OFF;};
        {
         buzzer_count++;
         if(buzzer_count >= buzzer_err_delay)       //부저 소리나오는거 수정한부분    191222
         {
            buzzer_count =  buzzer_err_delay;
            buzzer_on = ON;
         }
        }
         else
         {
            buzzer_on = OFF;
            buzzer_count = 0;
         }


        if(BUZZER_STOP_KEY == 0)
        {
          buzzer_clear_all();
        }

       if(buzzer_on == ON){if(led_flash == ON){BUZZER_HIGH = 1;}else{BUZZER_HIGH = 0;}}else{BUZZER_HIGH = 0;}

       if(send_process_count == 1){if(Common_CHeckLink_act == 1){Response_Common_CHeckLink();fnd_init();}}  //링크 확인

       if(send_process_count == 2){if(Distributor_TimeSyncAck_act == 1){Response_Distributor_TimeSyncAck();}}

       if(send_process_count == 3){if(Distributor_BITDetailResponse_act == 1){Response_Distributor_BITDetailResponse();}}

       if(send_process_count == 8){if(Distributor_ShutdownResponse_act == 1){Response_Distributor_ShutdownResponse();}} //배전기 셧다운 요청

       if(send_process_count == 5){if(Distributor_ShutdownErroResponse_act == 1){Response_Distributor_ShutdownErroResponse();}} //임무처리기 셧다운 오류 요청

       if(send_process_count == 6){if(Distributor_PoBIT_act == 1){Response_Distributor_PoBITResponse();}}

       if(send_process_count == 7){if(Distributor_PoBIT_act_pre == 1){Response_Distributor_PoBITResponse_pre();}}

       if(send_process_count == 4){if((Distributor_PBIT_act == 1) && (ADDRESS_3 == 1)){Response_Distributor_PBIT();}}  //배전기 PO-BIT설정

       if((send_process_count == 9)&&((Distributor_TimeSyncAck_act == 0)&&(Distributor_ShutdownResponse_act == 0)&&(Distributor_ShutdownErroResponse_act == 0)) ){if((send_to_pc_active == 1) && (ADDRESS_0 == 1)){Report_Distributor_DeviceStatus();send_to_pc_active = 0;}}

      // if((send_process_count == 9)&&((Distributor_TimeSyncAck_act == 0)&&(Distributor_ShutdownResponse_act == 0)&&(Distributor_ShutdownErroResponse_act == 0){Report_Distributor_DeviceStatus();send_to_pc_active = 0;}

        //if(PoBITResult_act == 1){Response_Distributor_PoBITResponse();}


        //발전기
        if(send_to_ge_active == 1){send_to_ge();}
        //분배반
        if(send_to_div_info_act == 1){Request_div_info();}



      }
 }
