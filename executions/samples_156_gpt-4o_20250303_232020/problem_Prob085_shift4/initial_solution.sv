module TopModule (
    input logic clk,         // Clock input, triggers on the positive edge
    input logic areset,      // Asynchronous reset input, active high
    input logic load,        // Synchronous load control input, active high
    input logic ena,         // Synchronous enable control input, active high
    input logic [3:0] data,  // 4-bit input data, indexed from 3 (MSB) to 0 (LSB)
    output logic [3:0] q     // 4-bit output representing the shift register state, indexed from 3 (MSB) to 0 (LSB)
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            q <= {1'b0, q[3:1]};
        end
    end

endmodule