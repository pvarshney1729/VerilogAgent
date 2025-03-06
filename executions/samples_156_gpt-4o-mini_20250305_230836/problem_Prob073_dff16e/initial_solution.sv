```verilog
module TopModule (
    input  logic        clk,        // Clock signal, positive edge-triggered
    input  logic        resetn,     // Synchronous active-low reset
    input  logic [1:0]  byteena,    // Byte enable signals
    input  logic [15:0] d,          // 16-bit data input
    output logic [15:0] q           // 16-bit data output
);

always @(posedge clk) begin
    if (!resetn) begin
        q <= 16'b0;
    end else begin
        if (byteena[1]) 
            q[15:8] <= d[15:8];
        if (byteena[0]) 
            q[7:0] <= d[7:0];
    end
end

endmodule
```