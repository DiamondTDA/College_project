#line 1 "F:/College project/Code/College project.c"
char fl = 0;
int i = 0;
int arr[]= {0,1,2,3,4,5,6,7,8,9,16,17,18,19,20,21,22,23,24,25,32,33,34,35};
void interrupt()
{if(intf_bit==1)
 {intf_bit=0;
 if(fl==3)
 fl=-1;
 fl++;}}
void automatic();
void manual();
void main() {
trisb.b0 = 1;
portd = 0;
gie_bit=1;
inte_bit=1;
intedg_bit=1;
trisd = 0b00000000;
trisc = 0b00000000;
adcon1 = 7;
trisa = 0b111001;
porta = 0;
portd = 0;
portc = 0b11111111;
while(1)
 {if(fl%2==0){
 manual();
 }
 else{
 automatic();}}
}
void automatic(){
while(1){
 porta =0;
 portc = 0b11000011;
 for(i = 20;i > 0;i--){
 if(fl%2==0) {return;}
 portd = arr[i];
 delay_ms(1000);
 }
 portc = 0b10101100;
 for(i = 3;i > 0;i--){
 if(fl%2==0) {return;}
 portd = arr[i];
 delay_ms(1000);
 }
 porta = 0b000100;
 portc = 0b00011100;
 for(i = 15;i > 0;i--){
 if(fl%2==0) {return;}
 if(i == 3){
 porta = 0b000010;}
 portd = arr[i];
 delay_ms(1000);
 }
 porta = 0;
 }
}
void manual(){
 trisb.b1 = 1;
 portc = 0b10101100;
 porta = 0b110000;
while(1){
for(i = 3;i > 0;i--){
 {if(fl%2==1)
 {return;}
 portd = arr[i];
 delay_ms(1000);}}
 portc = 0b11000000;
 porta = 0b111001;
 while(portb.b1!=1){if(fl%2==1) return;}
 portc = 0b00011100;
 porta = 0b000010;
 for(i = 3;i > 0;i--){
 {if(fl%2==1)
 {return;}
 portd = arr[i];
 delay_ms(1000);}}
 portc =0b00010000;
 porta = 0b000100;
 while(portb.b1!=1){if(fl%2==1) return;};
 portc = 0b10101100;
 porta = 0b000000;
 }}
