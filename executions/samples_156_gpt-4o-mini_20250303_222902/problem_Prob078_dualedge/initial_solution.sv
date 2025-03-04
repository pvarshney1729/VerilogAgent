module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    logic d_rise, d_fall;

    always @(posedge clk) begin
        d_rise <= d;
    end

    always @(negedge clk) begin
        d_fall <= d;
    end

    always @(*) begin
        q = d_rise | d_fall; // Combine the sampled values
    end

    initial begin
        q = 1'b0; // Initialize q to 0
    end

endmodule