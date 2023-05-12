class master_seq_i extends uvm_sequence_item;

    

    /* variable declaration 
    
    
    */


    `uvm_object_utils_begin(master_seq_i)
    `uvm_field_int(,UVM_ALL_ON)
    `uvm_object_utils_end


    function new (string name="master_seq_i");
    super.new(name);
    endfunction

endclass