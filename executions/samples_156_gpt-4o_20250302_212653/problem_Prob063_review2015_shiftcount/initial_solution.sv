module TopModule (
    input logic clk,            // Clock input, positive edge-triggered
    input logic reset_n,        // Active-low asynchronous reset
    input logic shift_ena,      // Enable signal for shift operation
    input logic count_ena,      // Enable signal for count operation
    input logic data,           // Data input for shift register
    output logic [3:0] q        // 4-bit output from shift register/counter
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 4'b0000;
        end else if (shift_ena && !count_ena) begin
            q <= {data, q[3:1]};
        end else if (count_ena && !shift_ena) begin
            q <= q - 1;
        end
    end

endmodule