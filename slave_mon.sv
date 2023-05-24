class slave_mon extends uvm_monitor #(slave_seq_i);

    `uvm_component_utils(slave_mon)
  

  
    function new(string name="slave_mon",uvm_component parent=null);
    super.new(name,parent);
    endfunction

  

    // task run_phase(uvm_phase phase);


    // endtask

endclass