module TopModule (
    input logic clk,       // 1-bit clock signal, positive edge-triggered
    input logic rst,       // 1-bit synchronous reset signal
    input logic a,         // 1-bit input, unsigned
    input logic b,         // 1-bit input, unsigned
    output logic out_assign,       // 1-bit output, result of combinational XOR using assign
    output logic out_always_comb,  // 1-bit output, result of combinational XOR using always_comb
    output logic out_always_ff     // 1-bit output, result of sequential XOR using always_ff
);

    // Combinational logic using assign
    assign out_assign = a ^ b;

    // Combinational logic using always_comb
    always_comb begin
        out_always_comb = a ^ b;
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        if (rst) begin
            out_always_ff <= 1'b0;
        end else begin
            out_always_ff <= a ^ b;
        end
    end

endmodule