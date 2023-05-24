class master_driver extends uvm_driver #(master_seq_i);
    `uvm_component_utils(master_driver)
   
       //configuration port...
     
      master_seq_i q1[$];
      master_seq_i q2[$];
      master_seq_i q3[$];
      master_seq_i q4[$];
     
     bit [3:0] BID[$];
     
     virtual axi_if.M_DRV_MP vif;
       function new (string name="master_driver",uvm_component parent=null);
           super.new(name,parent);
       endfunction
    
       function void build_phase(uvm_phase phase);
           super.build_phase(phase);
   
       endfunction
       task run_phase(uvm_phase phase);
         `uvm_info("Master Driver", "This is Master Driver",UVM_LOW)
         forever 
           begin 
             seq_item_port.get_next_item(req);
             //start send to dut with req
             seq_item_port.item_done();
           end
       endtask
   
     task send_to_dut(master_seq_i seqi);
       //`uvm_info("send to dut", "This is send to dut ",UVM_LOW)
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
           if(seqi.WRITE_DATA_TRANS==seqi.NO_OF_TRANS)
             begin
               write_resp(q3.pop_back);
             end
           s2.put(1);
           s3.put(1);
         end
         
         begin 
           s4.get(1);
           read_addr(q4.pop_back);
           s4.put(1);
         end
       join
     
     endtask
     
     task write_data(master_seq_i seqi);
       
       for(int i=0;i<seqi.BURST_LENGTH;i++)
         begin 
           
           repeat(seqi.d_delay[i])
             @(vif.m_drv_cb);
            vif.m_drv_cb.WVALID<=1'b1;
           vif.m_drv_cb.WID <= seqi.WID;
           
           if(i==seqi.BURST_LENGTH-1)
               vif.m_drv_cb.WLAST<=1'b1;
           else 
             vif.m_drv_cb.WLAST<=1'b0;
           
           vif.m_drv_cb.WSTRB <= seqi.WSTRB[i];
           
           case(seqi.WSTRB[i])
             
             4'b0001: vif.m_drv_cb.WDATA <= seqi.WDATA[7:0];
             4'b0010: vif.m_drv_cb.WDATA <= seqi.WDATA[15:8];
             4'b0100:vif.m_drv_cb.WDATA <= seqi.WDATA[23:16];
             4'b1000: vif.m_drv_cb.WDATA <= seqi.WDATA[31:24];
             4'b0011:vif.m_drv_cb.WDATA <= seqi.WDATA[15:0];
             4'b1100:vif.m_drv_cb.WDATA <= seqi.WDATA[31:16];
             4'b1111: vif.m_drv_cb.WDATA <= seqi.WDATA[31:0];
             
             endcase
           
               wait(vif.m_drv_cb.WREADY)
   
               @(vif.m_drv_cb);
   
               vif.m_drv_cb.WDATA<=32'b0;
       
               vif.m_drv_cb.WVALID<=1'b0; 
   
               vif.m_drv_cb.WLAST<=1'b0;
   
           
           `uvm_info("Master Driver", "This is Master Driver write_data",UVM_LOW)
         end
         endtask
     
     task write_addr(master_seq_i seqi);
       repeat(seqi.a_delay)
         
         @(vif.m_drv_cb);
         vif.m_drv_cb.AWVALID <=1'b1;
         vif.m_drv_cb.AWADDR <= seqi.AWADDR;
         vif.m_drv_cb.AWBURST <= seqi.AWBURST;
         vif.m_drv_cb.AWLEN <=seqi.AWLEN;
         vif.m_drv_cb.AWSIZE <=seqi.AWSIZE;
         vif.m_drv_cb.AWID <=seqi.AWID;
   //       vif.m_drv_cb.AWLOCK <=seqi.AWLOCK;
   //       vif.m_drv_cb.AWCACHE <=seqi.AWCACHE;
   //       vif.m_drv_cb.AWPROT <=seqi.AWPROT;
       wait(vif.m_drv_cb.AWREADY)
               @(vif.m_drv_cb);
              vif.m_drv_cb.AWVALID <=1'b0;
       
       `uvm_info("Master Driver", "This is Master Driver write_addr",UVM_LOW)
       
     endtask
     
     task write_resp(master_seq_i seqi);
       begin 
         repeat(seqi.d_delay)
       @(vif.m_drv_cb);
       vif.m_drv_cb.BREADY<=1'b1;
   
       wait(vif.m_drv_cb.BVALID)
         begin
         BID.push_back(vif.m_drv_cb.BID);
         @(vif.m_drv_cb);
         vif.m_drv_cb.BREADY<=1'b0;
       end
         
         
       end
   
     endtask
     
     task read_addr(master_seq_i seqi);
       repeat(seqi.a_delay)
       @(vif.m_drv_cb);
       
       vif.m_drv_cb.ARVALID <= 1'b1;
       
       vif.m_drv_cb.ARID <= seqi.ARID;
       vif.m_drv_cb.ARADDR <= seqi.ARADDR;
       vif.m_drv_cb.ARLEN <= seqi.ARLEN;
       vif.m_drv_cb.ARSIZE <= seqi.ARSIZE;
       vif.m_drv_cb.ARBURST <= seqi.ARBURST;
       
       wait(vif.m_drv_cb.ARREADY)
           @(vif.m_drv_cb);
           vif.m_drv_cb.ARVALID <=1'b0;
       
     endtask
     
     task read_data(master_seq_i seqi);
       repeat(seqi.rd_a_delay)
       @(vif.m_drv_cb)
       vif.m_drv_cb.RREADY <= 1'b1;
     endtask
     
   endclass