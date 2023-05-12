class slave_env extends uvm_environment;

    `uvm_component_utils(slave_env)
    slave_agent agnt;
//slave scb;

    function new(string name="slave_env",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt=slave_agent::type_id::create("agnt",this);
        //scb
    endfunction


    // function void connect_phase(uvm_phase phase);


    // endfunction

endclass 