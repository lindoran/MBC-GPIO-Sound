module sound;
{This is an includable file and not designed to run on its own,
(C) 2020 D. Collins Z-80 Dad, search youtube for more.  This is
provided without any warentee from damage or loss. use at your
own risk.  This is designed to work with a YL-44 buzzer module
or its clones, this includes the GPIO Game Addapter board.  
This will sound a buzzer hooked to pin 8 of Port
B when it is also hooked to ground and +5V of the Z80-MBC2
expansion port This is acompished by swtiching the GPIO pin on 
and off very fast to create a square wave.  The module has a 
transsistor that allows for the buzzer to draw more current 
from the curcut without risk of dammage and at 5v it gets fairly
loud.  It's important to remember you need to use a passive buzzer
as we are creating the PWM square wave with logic swtiching, an active
buzzer sounds at the same frequency as it contains a occilating circut
to sound the buzzer when a logic high is provided however always at 
the same frequency.

MIT License

Copyright (c) 2021 Dave Collins

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.}

 {     MBC Expansion Port      
       GPIO GAME ADDAPTER CONN.  
     UP = U  DOWN = D lEFT = l   
        RIGHT = R  FIRE = F      
	555 TRIGGER = TRG (HIGH TRIGGERS)	
	555 EXPIRED = EXP (LOW = EXPIRED
	                   HIGH = RUNNING) 
    PASSIVE BUZZER = SND
	
        VCC   F U D L R   GND       
        |     | | | | |   |			  
       +5 1 2 3 4 5 6 7 8 GND    
        * * * * * * * * * * GPIO PORT A  
        * * * * * * * * * * GPIO PORT B  
          |           | |      
    	 EXP        TRG SND     
		 
      you can hook a yl-44 passive buzzer module 
	  signal pin to pin 8 of GPIO Port B allong with
	  VCC and GND                                     }
	  
	  
const
 IODIRB_WriteOpcode = 6;
 IODIRB_BuzzerMask = 63;
 
 GPIOB_WriteOpcode = 4;
 BuzzerPin_PortB = 128;


{Sets up the port for use}
procedure SndSetPort; 
begin
 out[1] := IODIRB_WriteOpcode;
 out[0] := IODIRB_BuzzerMask; (* 00111111 - Ena. bits 7,6 for writeing on port B*)
end;

procedure tone (frq,delaymax :integer);
{produce tone of frq units (this is not hz) each note is 3 apart, half steps
 are 1 or 2 apart This is as fast as I can write the loop without switching to 
 full on mechine code. I don't know that this would make a huge difference; 
 basically because the pascal library is already loaded.}
var
   I,A : integer;
begin
 for A := 1 to delaymax do    (* this is how long the note sounds *) 
  begin
    out[1] := GPIOB_WriteOpcode;
    out[0] := BuzzerPin_PortB;   {pin 8 is high}
    for I := 1 to frq do; {NOP loop}
    out[1] := GPIOB_WriteOpcode;
    out[0] := IODIRB_BuzzerMask; {pin 8 is low}
    for I := 1 to frq do; {NOP loop}
  end;

end;
modend.

