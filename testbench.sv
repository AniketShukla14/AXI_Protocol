`include "interface.sv"
    module tb;
        import elv_pkg::*;
        import uvm_pkg::*;
        bit clock;
        always begin 
 #10 clock=~clock;
        end
 axi_if in0(clock);

 initial begin
    uvm_config_db#(virtual axi_if)::set(null,"*","vif",in0);
    run_test("base_test");
 end

 initial begin
$dumpfile("dump.vcd");
$dumpvars(1);
end

endmodule 
/*Why we using a clock here*/      
/*the clock signal declaration and toggling in the provided code enable the simulation of a clocking mechanism
and facilitate the correct timing behavior of the AXI interface during testing and verification.*/


/* what we dont have in our code*/
/* axi_master_config extends uvm_object
axi_slave_config extends uvm_object
axi_scoreboard extends uvm_scoreboard
axi_env_config extends uvm_object
*/