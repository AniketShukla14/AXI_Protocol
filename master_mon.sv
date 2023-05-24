class master_mon extends uvm_monitor;

   `uvm_component_utils(master_mon)
   //configuration port.
 uvm_analysis_port#(master_seq_i) monitor_port;
 
   virtual axi_if.M_MON_MP vif;
 master_seq_i store[int][int];
 
   function new (string name="master_mon",uvm_component parent=null);
   super.new(name,parent);
   monitor_port=new("monitor_port",this);
   endfunction

function void build_phase(uvm_phase phase);
   super.build_phase(phase);
 
   //config line 
endfunction

 function void connect_phase(uvm_phase phase);
   
   //configuration file connection.
   
 endfunction 
 
  virtual task run_phase(uvm_phase phase);
// commands 
  endtask
 
 task collect();
 
   master_seq_i seqi;
   semaphore s1=new(1);
   semaphore s2=new(1);
   
   fork 
     begin 
       s1.get(1);
       collect_data();
       s1.put(1);
     end
     
     if(seqi.WRITE_DATA_TRANS==seqi.NO_OF_TRANS)
     begin 
       s2.get(1);
       collect_resp();
       s2.put(1);
       
     end
     
   join 
   
 endtask
 
 task collect_data();
master_seq_i data_rcv;
   data_rcv=master_seq_i::type_id::create("data_rcv");
   fork 
     begin 
       @(posedge vif.m_mon_cb.AWVALID)
       data_rcv.AWADDR=vif.m_mon_cb.AWADDR;
     data_rcv.AWLEN=vif.m_mon_cb.AWLEN;
     data_rcv.AWBURST=vif.m_mon_cb.AWBURST;
     data_rcv.AWSIZE=vif.m_mon_cb.AWSIZE;
       data_rcv.AWID=vif.m_mon_cb.AWID;
     end
     
     begin 
       while(~vif.m_mon_cb.WLAST)
        begin
             @(posedge vif.m_mon_cb.WREADY or posedge vif.m_mon_cb.WVALID or posedge vif.m_mon_cb.WLAST );
             wait(vif.m_mon_cb.WVALID && vif.m_mon_cb.WREADY)
           data_rcv.WID=vif.m_mon_cb.WID;
           
           @(vif.m_mon_cb);
        end

       
       end
     
   join
   
   store[data_rcv.AWADDR][data_rcv.AWID] = master_seq_i::type_id::create($sformatf("data_rcv[%0d][%0d]", data_rcv.AWADDR, data_rcv.AWID));

 endtask

 
 task collect_resp();
   
   
 endtask
 
endclass