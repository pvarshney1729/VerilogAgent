module TopModule(
    input logic clk,
    input logic d,
    output logic q
);
    // Sequential logic to implement a D flip-flop
    always_ff @(posedge clk) begin
        q <= d; // On every positive edge of clock, update q with d
    end
endmodule