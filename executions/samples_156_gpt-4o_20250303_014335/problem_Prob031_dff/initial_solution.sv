module TopModule (
    input logic clk,  // Clock input
    input logic d,    // Data input
    output logic q    // Data output
);

    always_ff @(posedge clk) begin
        q <= d;  // On positive edge of clock, capture input `d` into `q`
    end

endmodule