class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    master_env env;
    master_seq seq;

    
    function new(string name="base_test",uvm_component parent=null);
    super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     env=master_env::type_id::create("env",this);
     seq=master_seq::type_id::create("seq",this);
    endfunction

    task run_phase(uvm_phase phase);
     phase.raise_objection(this);
      //seq.start(env.agnt.seqr)
   phase.drop_objection(this);

    endtask

endclass