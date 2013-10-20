electric_imp_servo_control_pitchfork
====================================

Control two servos using an Electric Imp, and the slider controls on the iOS Pitchfork app.

Thanks to Dr Tom Allen for the PWM device code. I modified it a bit and added agent code to use with my Pitchfork app.

Pins 1&2 are used on the Imp.

I tested using the Analog Feedback Servos from Adafruit, and they will operate on 3.3v, though I am also powering them with
an Amber board that has a lot more available current than the April. I do not know if the buck regulator on the April will
be sufficient.
