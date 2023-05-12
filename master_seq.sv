class master_seq extends uvm_sequence #(master_seq_i);

    `uvm_object_utils(master_seq)

    function new( string name="master_seq");
        super.new(name);
    endfunction

   virtual task body();
        `uvm_do(req)
    endtask

    endclass