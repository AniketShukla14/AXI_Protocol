class slave_seq extends uvm_sequence#(slave_seq_i);

    function new(string name="slave_seq");
        super.new(name);
    endfunction

    task body();
    `uvm_do(req)
    endtask


endclass