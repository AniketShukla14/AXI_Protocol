class slave_seq_i extends uvm_sequence_item;
    static int WRITE_DATA_TRANS=0;
    static int NO_OF_TRANS=5;
  
       bit [3:0]  AWID;
       bit [31:0] AWADDR;
       bit [3:0]  AWLEN;
       bit [2:0]  AWSIZE;
       bit [1:0]  AWBURST;
  
      bit AWVALID;
      bit AWREADY;
    
        bit [3:0]  ARID;
       bit [31:0] ARADDR;
       bit [3:0]  ARLEN;
       bit [2:0]  ARSIZE;
       bit [1:0]  ARBURST;
    
    bit ARVALID;
    bit ARREADY;
    
     bit [3:0] WSTRB[$];
       bit [31:0]  WDATA[$];
       bit [3:0] WID;
    
    //Delays 
    
     randc bit [3:0] a_delay;
    randc bit[2:0] d_delay;
      randc bit [3:0] rd_d_delay;
  
  //   `uvm_object_utils_begin(master_seq_i)
  //   `uvm_field_int(AWID,UVM_ALL_ON)
  //   `uvm_field_int(AWADDR,UVM_ALL_ON)
  //   `uvm_field_int(AWLEN,UVM_ALL_ON)
  //   `uvm_field_int(AWSIZE,UVM_ALL_ON)
  //   `uvm_field_int(AWBURST,UVM_ALL_ON)
  //     `uvm_object_utils_end
  
      function new(string name="slave_seq_i");
          super.new(name);
      endfunction
      
  
  endclass