module TopModule (
    input logic clk,                  // Clock input, rising edge triggered
    input logic reset_n,              // Active-low asynchronous reset
    input logic [7:0] in,             // 8-bit input vector, unsigned
    output logic [7:0] pedge          // 8-bit output vector
);

    logic [7:0] prev_in;              // Register to store previous state of 'in'

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            pedge <= (in & ~prev_in);
            prev_in <= in;
        end
    end

endmodule