module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    // Rising edge capture
    always_ff @(posedge clk) begin
        q <= d;
    end

    // Falling edge capture
    always_ff @(negedge clk) begin
        q <= d;
    end

endmodule