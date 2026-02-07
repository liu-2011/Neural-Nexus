module neural_nexus_soc (
    input sys_clk,
    input sys_rst_n
);
    wire [31:0] instruction;
    wire [31:0] program_counter;
    
    // Instantiate Core
    nexus_riscv_core u_core (
        .clk(sys_clk),
        .rst_n(sys_rst_n),
        .instr_i(instruction),
        .pc_o(program_counter)
    );
    
    // Instantiate Accelerator
    neural_flow_unit u_npu (
        .clk(sys_clk),
        .frame_data_i(128'b0),
        .interpolated_frame_o()
    );
endmodule