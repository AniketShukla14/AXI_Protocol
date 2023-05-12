class master_mon extends uvm_monitor;

    `uvm_component_utils(master_mon)
    // sequence item handle 
    // analysis port 
    // interface 
    function new (string name="master_mon",uvm_component parent=null);
    super.new(name,parent);
    endfunction

 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //space alloted to the handle
    // interface space
    //config line 
 endfunction

   virtual task run_phase(uvm_phase phase);
// commands 
   endtask
endclass