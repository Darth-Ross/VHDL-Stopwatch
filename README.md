**VHDL-Stopwatch**

This is a hardware description for a digital stopwatch written in VHDL. The repo was originally created to store my school assignment but I also figured someone else might have a use for this.


The software used for this project is Vivado 2014.3 and the configuration is made for the basys 3(Artix 7 FPGA) development board.

The source files are located in [projectname].srcs/sources.
You may use the source files in your own project or use the project itself as you see fit.




**Specifications**


The stopwatch consists of two components, the finite state machine controller and the timer.
The finite state machine controls the stopwatch using the following buttons:
- System reset  (Resets the state machine)
- Watch reset   (Resets the watch time if paused)
- Start/Pause   (Starts or pauses the watch)

The timer outputs the current time in binary with the time split into seconds and minutes.

