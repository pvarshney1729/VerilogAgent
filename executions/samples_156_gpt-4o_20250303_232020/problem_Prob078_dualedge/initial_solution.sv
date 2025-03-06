module TopModule (
    input wire clk,     // Clock signal, assumed to be a standard square wave
    input wire d,       // Data input, single bit
    output reg q        // Data output, single bit, carrying the latched value
);

reg d_posedge, d_negedge;

always @(posedge clk) begin
    d_posedge <= d;
end

always @(negedge clk) begin
    d_negedge <= d;
end

always @(*) begin
    q = d_posedge | d_negedge; // Combine the values captured on both edges
end

endmodule