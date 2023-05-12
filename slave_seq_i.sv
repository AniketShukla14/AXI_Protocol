class slave_seq_i extends uvm_seq_item;

 /* variable declaration 
    .
    .
    */

    `uvm_object_utils_begin(slave_seq_i)
        `uvm_field_int(,UVM_ALL_ON)

    `uvm_component_utils_end


    function new(string name="slave_seq_i");
        super.new(name);
    endfunction
    

endclass