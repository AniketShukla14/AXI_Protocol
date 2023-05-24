class slave_mon extends uvm_monitor #(slave_seq_i);

  `uvm_component_utils(slave_mon)

virtual axi_if.S_MON_MP vif;


slave_seq_i store[int][int];
int ID[int];

  function new(string name="slave_mon",uvm_component parent=null);
  super.new(name,parent);
  endfunction

function void build_phase(uvm_phase phase);
  
  super.build_phase(phase);
  
endfunction 


function void connect_phase(uvm_phase phase);
  
  
endfunction


task run_phase(uvm_phase phase);
  
endtask


task collect();
  semaphore s1=new(1);
  semaphore s2=new(1);
  slave_seq_i seqi;
  fork
    begin
      s1.get(1);
      collect_data();
      s1.put(1);
    end
    
    begin 
      s2.get(1);
      if(seqi.WRITE_DATA_TRANS==seqi.NO_OF_TRANS)
        begin
        collect_resp();
        end
      s2.put(1);
    end
  join
  
  
  
endtask

task collect_data();
  
data_rcv= slave_seq_i::type_id::create("data_rcv");

fork
  begin

       
        @(posedge vif.s_mon_cb.AWREADY or posedge vif.s_mon_cb.AWVALID);
       
        wait(vif.s_mon_cb.AWREADY && vif.s_mon_cb.AWVALID)
        
    data_rcv.AWID=vif.s_mon_cb.AWID;
    data_rcv.AWADDR=vif.s_mon_cb.AWADDR;
    data_rcv.AWLEN=vif.s_mon_cb.AWLEN;
    data_rcv.AWBURST=vif.s_mon_cb.AWBURST;
    data_rcv.AWSIZE=vif.s_mon_cb.AWSIZE;
      
  end

  begin
      
       
        while(~vif.s_mon_cb.WLAST)
          
    begin:B1
         
            @(posedge vif.s_mon_cb.WREADY or posedge vif.s_mon_cb.WVALID or posedge vif.s_mon_cb.WLAST );
            if(vif.s_mon_cb.WLAST)
              begin
                
                wait(vif.s_mon_cb.WREADY && vif.s_mon_cb.WVALID)
                
                  begin
              data_rcv.WID=vif.s_mon_cb.WID;
                    data_rcv.WSTRB.push_back(vif.s_mon_cb.WSTRB);
                     data_rcv.WDATA.push_back(vif.s_mon_cb.WDATA);
                          @(vif.s_mon_cb); 
                      end
                
                
              end
            else
 
            wait(vif.s_mon_cb.WREADY && vif.s_mon_cb.WVALID)
            begin
             
      data_rcv.WID=vif.s_mon_cb.WID;
            data_rcv.WSTRB.push_back(vif.s_mon_cb.WSTRB);
            data_rcv.WDATA.push_back(vif.s_mon_cb.WDATA);
            
            @(vif.s_mon_cb);  
            end
            
           
    end
       
  end

join

store[data_rcv.AWADDR][data_rcv.AWID]=write_xtn_slave::type_id::create($sformatf("data_rcv[%0d][%0d]",data_rcv.AWADDR,data_rcv.AWID));

foreach(data_rcv.WDATA[i])
  begin
    store[data_rcv.AWADDR][data_rcv.AWID].WDATA.push_back(data_rcv.WDATA[i]);
   
  end


`uvm_info("SLAVE_MONITOR",$sformatf("printing from slave monitor \n %s", store[data_rcv.AWADDR][data_rcv.WID].sprint()),UVM_LOW) 
  
endtask

task collect_resp();
  
endtask



endclass