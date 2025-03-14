[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (shift_ena) begin
            q <= {q[2:0], data}; // Shift left and input data into MSB
        end else if (count_ena) begin
            q <= q - 4'b0001; // Decrement the counter
        end
    end

endmodule
[Done]