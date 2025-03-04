module TopModule (
    input wire clk,        // Clock signal, triggers on the positive edge
    input wire resetn,     // Active-low, synchronous reset
    input wire in,         // 1-bit input signal
    output reg out         // 1-bit output signal
);

    reg [3:0] shift_reg;   // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            // Reset condition: initialize all flip-flops to 0
            shift_reg <= 4'b0000;
        end else begin
            // Shift operation
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    always @(posedge clk) begin
        if (!resetn) begin
            out <= 1'b0;
        end else begin
            out <= shift_reg[3];
        end
    end

endmodule