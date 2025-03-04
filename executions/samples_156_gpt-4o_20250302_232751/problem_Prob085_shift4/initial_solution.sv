module TopModule (
    input logic clk,          // Clock signal
    input logic areset,       // Asynchronous reset signal
    input logic load,         // Load enable signal
    input logic ena,          // Shift enable signal
    input logic [3:0] data,   // 4-bit data input
    output logic [3:0] q      // 4-bit shift register output
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