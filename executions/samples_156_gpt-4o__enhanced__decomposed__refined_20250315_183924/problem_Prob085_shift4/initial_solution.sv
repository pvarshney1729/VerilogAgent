module TopModule (
    input logic clk,
    input logic areset,
    input logic load,
    input logic ena,
    input logic [3:0] data,
    output logic [3:0] q
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 4'b0000; // Asynchronous reset
    end else if (load) begin
        q <= data;    // Load data into the shift register
    end else if (ena) begin
        q <= {1'b0, q[3:1]}; // Shift right, insert 0 at MSB
    end
end

endmodule