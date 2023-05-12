class master_driver extends uvm_driver #(master_seq_i);
 `uvm_component_utils(master_driver)

    //virtual interface
    function new (string name="master_driver",uvm_component parent=null);
        super.new(name,parent);
    endfunction
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // config data line
    endfunction
    task run_phase(uvm_phase phase);

    endtask

endclass