<h2>Pascal/MT+ GPIO Sound Module For MBC type computers</h2>
<p>(C) D. Collins 2021</p>
<p>This is a simple module for driving a transistor assisted passive buzzer module with a mbc type computer.&nbsp; The specific buzzer module this is meant to support is a YL-44 however it should work with its many clones includeing the GPIO games adapter board.&nbsp; This is all accomplished by rapidly switching a GPIO pin on and off to drive a buzzer which produces a tone.&nbsp; all of this is coded using for loops and the port aray for speed.&nbsp; The results even though written in Pascal are about the same frequency response as a loop coded in assembly language. The module is written without specific timeing in mind so you will have to do your own math to determine how many NOP iterations will produce a given tone / frequency. but in general:</p>
<p>&nbsp;</p>
<p>FRQ = number of NOP to wait at high &amp; low before re-looping</p>
<p>delaymax = number of iterations which are (FRQ*2 in length)</p>
<p>&nbsp;</p>
<p>You should refrence your specific part's datasheet to prevent from switching it too quickly, however i should state, even under the most stress i could put the buzzer, I did not manage it cause it to fail.&nbsp; Obviously your milage will vary but even then these parts a very inexpensive if there is a issue.</p>
<p>&nbsp;</p>
<p><strong>Hooking up the Games Adapter or Buzzer:</strong></p>
<p>You can atatch the signal pin of a YL-44 buzzer module to position 8 of port b to produce sound with this module.&nbsp; The games adapter should be connectied as follows:</p>
<pre>MBC Expansion Port <br />GPIO GAME ADDAPTER CONN. <br />UP = U DOWN = D LEFT = l <br />RIGHT = R FIRE = F <br />555 TRIGGER = TRG (HIGH TRIGGERS) <br />555 EXPIRED = EXP (LOW = EXPIRED<br />                   HIGH = RUNNING) <br />PASSIVE BUZZER = SND<br /><br />VCC    F U D L R   GND <br /> |     | | | | |   | <br />+5 1 2 3 4 5 6 7 8 GND <br /> * * * * * * * * * * GPIO PORT A <br /> * * * * * * * * * * GPIO PORT B <br />   |           | | <br /> EXP         TRG SND </pre>
<p>should you chage the position of the buzzer this can effect the operation of the timer on the game adapter pay attention to specific connections so that there are not issues.</p>
<p><strong>Symbol Defintion:</strong></p>
<p><em>SndSetPort - &lt;procedure&gt; </em></p>
<p>Call this to set up GPIO B for the buzzer for the module to work.&nbsp; You may notice that this is basically the same port set up for the timer module, This is done for compatiblity.</p>
<p>&nbsp;</p>
<p><em>tone (frq : integer,&nbsp; delaymax:integer) &lt;procedure&gt;</em></p>
<p>creates a tone from the buzzer the specific tone will depend on your CPU that is driving the module the math is as follows:</p>
<p>FRQ = number of NOP to wait at high &amp; low before re-looping</p>
<p>delaymax = number of iterations which are (FRQ*2 in length)</p>
<p>I've not done alot of testing at 8mhz to speciffically determine what the tone frequencys are however I can say that the results are very similar between the Z80 and the V20 versions of the board.</p>
<p>&nbsp;</p>
<p>MIT License</p>
<p>Copyright (c) 2021 Dave Collins</p>
<p>Permission is hereby granted, free of charge, to any person obtaining a copy<br />of this software and associated documentation files (the "Software"), to deal<br />in the Software without restriction, including without limitation the rights<br />to use, copy, modify, merge, publish, distribute, sublicense, and/or sell<br />copies of the Software, and to permit persons to whom the Software is<br />furnished to do so, subject to the following conditions:</p>
<p>The above copyright notice and this permission notice shall be included in all<br />copies or substantial portions of the Software.</p>
<p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<br />IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<br />FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<br />AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br />LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,<br />OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE<br />SOFTWARE.</p>
<p>&nbsp;</p>
