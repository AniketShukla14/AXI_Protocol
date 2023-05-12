class slave_mon extends uvm_phase ;

    `uvm_component_utils(slave_mon)
    function new(string name="slave_mon",uvm_component parent=null);
super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //config db;
    endfunction

    // task run_phase(uvm_phase phase);


    // endtask

endclass