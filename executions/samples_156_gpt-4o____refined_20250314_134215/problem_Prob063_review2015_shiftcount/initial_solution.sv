[BEGIN]
module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // Shift in data MSB first
        end else if (count_ena) begin
            q <= q - 4'b0001; // Decrement the counter
        end
    end

endmodule
[DONE]