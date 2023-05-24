class slave_mon extends uvm_monitor #(slave_seq_i);

    `uvm_component_utils(slave_mon)
  
	virtual axi_if.S_MON_MP vif;
  
  slave_seq_i store[int][int];
  int ID[int];
  
    function new(string name="slave_mon",uvm_component parent=null);
    super.new(name,parent);
    endfunction

  function void build_phase(uvm_phase phase);
    
    
  endfunction 
  
  
  function void connect_phase(uvm_phase phase);
    
    
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  
  task collect();
    
    
  endtask
  
  task collect_data();
    
    
  endtask
  
  task collect_resp();
    
  endtask
  
  

endclass