module ModuleB (
    input logic clk,
    input logic reset,
    input logic [3:0] data_in,
    output logic [3:0] data_out
);

    logic [3:0] state;

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;
        end else begin
            state <= data_in;
        end
    end

    // Combinational logic for output
    always_comb begin
        data_out = state;
    end

endmodule

module TopLevel (
    input logic clk,
    input logic reset,
    input logic [3:0] data_in,
    output logic [3:0] data_out
);

    // Instantiate ModuleB
    ModuleB module_b_inst (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out)
    );

endmodule