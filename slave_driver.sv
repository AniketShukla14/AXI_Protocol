class slave_driver extends uvm_driver #(slave_seq_i);

    `uvm_component_utils(slave_driver)
  memory mem;
  
  slave_seq_i q1[$];
  slave_seq_i q2[$];
  slave_seq_i q3[$];
  slave_seq_i q4[$];
  
  bit [31:0] data;
	bit [3:0] strobe;
	bit [3:0] d_delay;
  bit [3:0] BID[$];
  
  virtual axi_if.M_DRV_MP vif;
  virtual axi_if.S_DRV_MP vit;
function new(string name="slave_driver",uvm_component parent=null);

    super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//config db
endfunction

task run_phase(uvm_phase phase);


endtask

    task send_to_dut(slave_seq_i seqi);
      
      semaphore s1=new(1);
      semaphore s2=new(1);
      semaphore s3=new(1);
      semaphore s4=new(1);
      
      q1.push_front(seqi);
      q2.push_front(seqi);
      q3.push_front(seqi);
      q4.push_front(seqi);
      
      fork 
        begin 
          s1.get(1);
          write_addr(q1.pop_back);
          s1.put(1);
          s3.put(1);
        end
        
        begin
          s2.get(1);
          write_data(q2.pop_back);
          s2.put(1);
        end
        
        begin 
          s2.get(1);
          s3.get(1);
          if(seqi.WRITE_DATA_TRANS==seqi.NO_OF_TRANS) begin 
            write_resp(q3.pop_back);
            s2.put(1);
            s3.put(1);
          end 
        end
        
        begin 
          s4.get(1);
          read_addr(q4.pop_back);
          s4.put(1);
        end
        
      join 
    
  endtask
  
  task write_data(slave_seq_i seqi);
    while(!vit.s_drv_cb.WLAST)
   begin
	
	repeat(d_delay)
      @(vit.s_drv_cb);

		vit.s_drv_cb.WREADY<=1'b1;

     wait(vit.s_drv_cb.WVALID)

		begin
		
		data=vit.s_drv_cb.WDATA;
			
		seqi.WDATA.push_front(data);

		strobe=vit.s_drv_cb.WSTRB;

		seqi.WSTRB.push_front(strobe);
	
          @(vit.s_drv_cb);

		vit.s_drv_cb.WREADY<=1'b0;	

		d_delay=$urandom;

        end
end

	
	d_delay=$urandom;

	repeat(d_delay)

		vit.s_drv_cb.WREADY<=1'b1;

    wait(vit.s_drv_cb.WVALID)

		begin
		
		data=vit.s_drv_cb.WDATA;
			
		seqi.WDATA.push_front(data);

		strobe=vit.s_drv_cb.WSTRB;
		
		end
	
    @(vit.s_drv_cb);

		vit.s_drv_cb.WREADY<=1'b0;
	
  endtask
  
    task read_data(slave_seq_i seqi);
      repeat(seqi.rd_d_delay)
        @(vif.m_drv_cb)
    vif.m_drv_cb.RREADY <= 1'b1;
  endtask
  
  task write_addr(slave_seq_i seqi);
  
    
    repeat(seqi.a_delay)
      @(vit.s_drv_cb);
    
     vit.s_drv_cb.AWREADY <=1'b1;
    wait(vit.s_drv_cb.AWVALID)
      seqi.AWID = vit.s_drv_cb.AWID;
      seqi.AWADDR= vit.s_drv_cb.AWADDR;
      seqi.AWLEN= vit.s_drv_cb.AWLEN;
     seqi.AWBURST = vit.s_drv_cb.AWBURST;
      seqi.AWSIZE=vit.s_drv_cb.AWSIZE;
    @(vit.s_drv_cb);
     vit.s_drv_cb.ARREADY <=1'b0;
    
    
    
  endtask
  
  task write_resp(slave_seq_i seqi);
	 foreach(BID[i])
      begin
		
        repeat(d_delay)
          @(vit.s_drv_cb);
  	  
        vit.s_drv_cb.BVALID<=1;
  
        vit.s_drv_cb.BID<=BID[i];	
        
		
       
        wait(vit.s_drv_cb.BREADY)
        
        @(vit.s_drv_cb);
        
        vit.s_drv_cb.BID<=4'b0;
     
        vit.s_drv_cb.BVALID<=0;
        
        d_delay=$urandom;
        if(d_delay==0)
          	d_delay=2;
      end
  
  endtask
  
  task read_addr(slave_seq_i seqi);
    
    @(vif.m_drv_cb);
    vif.m_drv_cb.ARVALID<=1'b1;
    vif.m_drv_cb.ARID <= seqi.ARID;
    vif.m_drv_cb.ARADDR <= seqi.ARADDR;
    vif.m_drv_cb.ARLEN<= seqi.ARLEN;
    vif.m_drv_cb.ARSIZE<=seqi.ARSIZE;
    vif.m_drv_cb.ARBURST<=seqi.ARBURST;
     
    `uvm_info("Slave driver", "This is slave driver",UVM_LOW)
    
  endtask
  


endclass


/* To create a memory model, Where we store data and retrieve.*/