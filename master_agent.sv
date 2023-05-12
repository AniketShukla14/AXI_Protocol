class master_agent extends uvm_agent;

    `uvm_component_utils(master_agent)
    //configuration file handle
    master_seq_r seqr;
    master_driver drv;
    master_mon mon;

    function new(string name="master_agent",uvm_component parent=null);
    super.new(name,parent);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr=master_seq_r::type_id::create("seqr",this);
    drv=master_driver::type_id::create("drv",this);
    mon=master_mon::type_id::create("mon",this);
    endfunction

endclass