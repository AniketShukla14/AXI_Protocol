class slave_driver extends uvm_driver/* #(slave_seq_i)*/;

    `uvm_component_utils(slave_driver)
function new(string name="slave_driver",uvm_component parent=null);

    super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//config db
endfunction

// task run_phase(uvm_phase phase);


// endtask

endclass