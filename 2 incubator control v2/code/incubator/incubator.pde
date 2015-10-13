#include <LiquidCrystal.h>
#include <math.h>
#include "hardware.h"


float vcc = 5.06;
float pad = 9850;
float thermr = 10000;
LiquidCrystal lcd(rs,en,d4,d5,d6,d7);
int t1,t2,t3,t4;
byte s1,s2,s3,s4,l1,l2,l3,l4,mota,m1,m2,m3,m4;
void setup() 
{
  lcd.begin(16,2);
  definepin();
}


void loop()
{
readtemp();
switchread();

lcd.begin(16,2);
lcdprint();

lampdecide();
lampwrite();
time();
motor();
 
 
}

///////////////////////////////////////////////////////////////
unsigned long a;
int seconds,minutes,hour,m;
void time()
{
  a= millis()/(500);
  seconds=a%60;
  minutes=a/(60);
  minutes=minutes%60;
  hour= a/(60*60);
  hour=hour%24;
   m=hour%2;

 /* 
 lcd.setCursor(0,0);
 lcd.print(hour);
 lcd.print(" ");
 lcd.print(minutes);
 lcd.print(" ");
 lcd.print(seconds);
 lcd.setCursor(0,1);
 lcd.print(m);
 */
 
  
}

void motor()
{  
  m1=(!m)*(minutes==0)*(seconds<=34);
  m2=(!m)*(minutes==1)*(seconds<=34);
  m3=(!m)*(minutes==2)*(seconds<=34);
  m4=(!m)*(minutes==3)*(seconds<=34);

      
        digitalWrite(mot1a,m1*s1);//digitalWrite(mot1b,motb*s1);
        digitalWrite(mot2a,m2*s2);//digitalWrite(mot2b,motb*s2);
        digitalWrite(mot3a,m3*s3);//digitalWrite(mot3b,motb*s3);
        digitalWrite(mot4a,m4*s4);//digitalWrite(mot4b,motb*s4);                                  
                                
                                
}

void lampwrite()
{ 
digitalWrite(lamp1,l1);
digitalWrite(lamp2,l2);
digitalWrite(lamp3,l3);
digitalWrite(lamp4,l4);
}

void switchread()
{
  s1=digitalRead(sw1);
  s2=digitalRead(sw2);
  s3=digitalRead(sw3);
  s4=digitalRead(sw4);
}


void readtemp()
{
  t1=Thermistor(analogRead(ntc1));
  t2=Thermistor(analogRead(ntc2));
  t3=Thermistor(analogRead(ntc3));
  t4=Thermistor(analogRead(ntc4));
}

void lampdecide()
{
  if(t1>htemp)      {l1=0;}
  if(t1<ltemp)      {l1=1;}
    if(t2>htemp)      {l2=0;}
    if(t2<ltemp)      {l2=1;}
  if(t3>htemp)      {l3=0;}
  if(t3<ltemp)      {l3=1;}
    if(t4>htemp)      {l4=0;}
    if(t4<ltemp)      {l4=1;}
      l1=l1*s1;
      l2=l2*s2;
      l3=l3*s3;
      l4=l4*s4;
}

int Thermistor(int RawADC) 
{
  long Resistance;  
  float Temp;
  Resistance=pad*((1024.0 / RawADC) - 1); 
  Temp = log(Resistance);
  Temp = 1 / (0.001129148 + (0.000234125 * Temp) + (0.0000000876741 * Temp * Temp * Temp));
  Temp = Temp - 273.15;
  Temp=Temp-7;
  return Temp;
}


void lcdprint()
{
  lcd.setCursor(0,0);
  lcd.print("T1:");
  lcd.print(t1);
    //lcd.setCursor(6,0);
    //lcd.print(s1);
  lcd.setCursor(8,0);
  lcd.print("T2:");
  lcd.print(t2);
    //lcd.setCursor(15,0);
    //lcd.print(s2);
  lcd.setCursor(0,1);
  lcd.print("T3:");
  lcd.print(t3);
    //lcd.setCursor(6,1);
    //lcd.print(s3);
  lcd.setCursor(8,1);
  lcd.print("T4:");
  lcd.print(t4); 
     //lcd.setCursor(15,1);
     //lcd.print(s4); 
  
  delay(400);
  //lcd.clear();
}

void definepin()
{ 
  pinMode(sw1,INPUT);pinMode(sw2,INPUT);pinMode(sw3,INPUT);pinMode(sw4,INPUT);//enable disable switches  
  pinMode(lamp1,OUTPUT);pinMode(lamp2,OUTPUT);pinMode(lamp3,OUTPUT);pinMode(lamp4,OUTPUT);//lamp o/ps
  pinMode(mot1a,OUTPUT);
  pinMode(mot2a,OUTPUT);
  pinMode(mot3a,OUTPUT);
  pinMode(mot4a,OUTPUT);
}
