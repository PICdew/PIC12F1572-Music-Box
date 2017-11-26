# PIC12F1572 Music Box

This is a proof of concept project for the case study in Hackaday.io: https://hackaday.io/project/28016-case-study-a-polyphonic-pic18f-music-box

It uses three independent PWM as square wave generators. Since it is a small microcontroller, all I could do is to put a short song inside. The song is converted from midi and parsed by using Len Shustek's miditones. https://github.com/LenShustek/miditones

This is using MikroC for PIC and compiles within the demo limit.

Todo:
- Add decay hardware that is from the case study.

Issues:
- Higher note frequencies may be off. 
