```verilog
module TopModule (
    input logic clk,        // Clock signal, positive edge triggered
    input logic areset,     // Asynchronous reset signal, active high
    input logic [7:0] d,    // 8-bit data input, unsigned
    output logic [7:0] q    // 8-bit data output, unsigned
);

    // Initial block to set the initial state of q
    initial begin
        q = 8'b00000000;
    end

    // Sequential logic with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000; // Asynchronous reset
        end else begin
            q <= d;           // Update q with d on clock edge
        end
    end

endmodule
```