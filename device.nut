//Servo controller turns http calls into servo movement.
 
g_minDutyCycle <- 0.03
g_maxDutyCycle <- 0.10
g_position <- 0.0;
 
// Convert a position value between 0.0 and 1.0 to a duty cycle for the PWM.
function pos2dc( value )
{
    return g_minDutyCycle + (value*(g_maxDutyCycle-g_minDutyCycle));
}
 
function move_1_to( pos )
{
    g_position = pos;
    hardware.pin1.write( pos2dc(g_position) );
    server.log(format("Servo moved to %.2f, duty cycle=%.3f", g_position, pos2dc(g_position)));
}
function move_2_to( pos )
{
    g_position = pos;
    hardware.pin2.write( pos2dc(g_position) );
    server.log(format("Servo moved to %.2f, duty cycle=%.3f", g_position, pos2dc(g_position)));
} 

// Handlers for messages from the Agent.
agent.on("slider1", function (data) {
    server.log("Device received position request: "+ data);
    move_1_to(data.tofloat());
    agent.send("slider1", "Servo 1 moved to: " + data)
});
agent.on("slider2", function (data) {
    server.log("Device received position request: "+ data);
    move_2_to(data.tofloat());
    agent.send("slider2", "Servo 2 moved to: " + data)
}); 
function configureHardware()
{
    // Configure hardware:
    // the servos used in this example have ~170 degrees of range. Each servo has three pins: power, ground, and pulse in
    // The width of the pulse determines the position of the servo
    // The servo expects a pulse every 20 to 30 ms
    // 0.03 ms pulse -> fully counterclockwise
    // 0.10 ms pulse -> fully clockwise
    // set up PWM on pin1 at a period of 20 ms, and initialize the duty cycle
    hardware.pin1.configure(PWM_OUT, 0.02, pos2dc(g_position));
    hardware.pin2.configure(PWM_OUT, 0.02, pos2dc(g_position));
    server.log("Hardware Configured");
}
 
// imp.configure registers us with the Imp Service
// The first parameter Sets the text shown on the top line of the node in the planner - i.e., what this node is
// The second parameter is a list of input ports in square brackets
// The third parameter is a list of output ports in square brackets
imp.configure("Servo Control", [], []);
configureHardware();
move_1_to(0.5);//Center Servo 1
move_2_to(0.5);//Center Servo 2
