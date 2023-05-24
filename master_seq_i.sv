class master_seq_i extends uvm_sequence_item;
    static int WRITE_DATA_TRANS;
      static int NO_OF_TRANS=5;
       randc bit [3:0]  AWID;
       randc bit [31:0] AWADDR;
       randc bit [3:0]  AWLEN;
       randc bit [2:0]  AWSIZE;
       randc bit [1:0]  AWBURST;
   
       bit AWVALID;
       bit AWREADY;
     
         randc bit [3:0]  ARID;
       randc bit [31:0] ARADDR;
       randc bit [3:0]  ARLEN;
       randc bit [2:0]  ARSIZE;
       randc bit [1:0]  ARBURST;
     
       randc bit [3:0]  WID;
         randc bit  [31:0]  WDATA ; //Data Holder 
           randc bit [3:0]  WSTRB;
           randc bit 	     WLAST;
           //bit 	     WUSER;
           bit  	     WVALID;
           bit 	     WREADY;
     //Delays 
     
      randc bit [3:0] a_delay;
     randc bit [3:0] d_delay;
     randc bit [3:0] rd_a_delay;
     randc bit [3:0] rd_d_delay;
     
     randc bit[4:0] BURST_LENGTH;
   
   
   
     `uvm_object_utils_begin(master_seq_i)
     `uvm_field_int(AWID,UVM_ALL_ON)
     `uvm_field_int(AWADDR,UVM_ALL_ON)
     `uvm_field_int(AWLEN,UVM_ALL_ON)
     `uvm_field_int(AWSIZE,UVM_ALL_ON)
     `uvm_field_int(AWBURST,UVM_ALL_ON)
       `uvm_object_utils_end
   
   
       function new (string name="master_seq_i");
       super.new(name);
       endfunction
   
   endclass