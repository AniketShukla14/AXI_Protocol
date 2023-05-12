class slave_agent extends uvm_agent;
 `uvm_component_utils(slave_agent)

    slave_seq_r seqr;
    slave_driver drv;
    slave_mon mon;
    
    function new(string name="slave_agent",uvm_component parent=null);
    super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr=slave_seq_r::type_id::create("seqr",this);
        drv=slave_driver::type_id::create("drv",this);
        mon=slave_mon::type_id::create("mon",this);
    endfunction

    // function void connect_phase(uvm_phase phase);


    // endfunction


endclass