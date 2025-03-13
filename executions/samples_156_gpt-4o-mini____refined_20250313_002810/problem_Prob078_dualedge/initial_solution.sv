[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    logic d_latched;

    always @(*) begin
        d_latched = d; // Latch the input d
    end

    always @(posedge clk) begin
        q <= d_latched; // Update q on rising edge
    end

    always @(negedge clk) begin
        q <= d_latched; // Update q on falling edge emulation
    end

    initial begin
        q = 1'b0; // Initialize q to zero
    end
endmodule
[DONE]