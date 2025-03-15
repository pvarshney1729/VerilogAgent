module TopModule(
    input  logic       clk,     // Clock signal
    input  logic       areset,  // Asynchronous reset, active high
    input  logic [7:0] d,       // 8-bit data input
    output logic [7:0] q        // 8-bit data output
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000;  // Asynchronously reset output to 0
        end else begin
            q <= d;            // Capture the input data 'd' on clock's rising edge
        end
    end

endmodule