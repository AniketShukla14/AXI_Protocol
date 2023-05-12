class master_driver extends uvm_driver #(master_seq_i);
 `uvm_component_utils(master_driver)

    //virtual interface
    function new (string name="master_driver",uvm_component parent=null);
        super.new(name,parent);
    endfunction
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // config data line
    endfunction

    function void connect_phase(uvm_phase phase);

    endfunction

    task run_phase(uvm_phase phase);

    endtask

    function send_to_dut(master_seq_i seqi);
        
    endfunction
    function write_addr(master_seq_i seqi);

    endfunction

    function write_data(master_seq_i seqi);

    endfunction

    function read_addr(master_seq_i seqi);

    endfunction
    function write_resp(master_seq_i seqi);

    endfunction
    function read_data(master_seq_i seqi);

    endfunction

endclass