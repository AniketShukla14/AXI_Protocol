class environment extends uvm_env;

    `uvm_component_utils(environment)
    master_agent agnt;
    //master_scb scb;
    //configuration file

 function new(string name="environment",uvm_component parent=null);
    super.new(name,parent);
 endfunction

//  function void connect_phase(uvm_phase phase);

//  endfunction
 
 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt=master_agent::type_id::create("agnt",this);
    //scb=master_scb::type_id::create("scb",this);
 endfunction

endclass