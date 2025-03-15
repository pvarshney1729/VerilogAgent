module TopModule (
    input logic clk,
    input logic areset,
    input logic load,
    input logic ena,
    input logic [3:0] data,
    output logic [3:0] q
);

    // Synchronous reset and shift register logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset to zero
        end else if (load) begin
            q <= data; // Load data into q
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Right shift operation
        end
    end

endmodule