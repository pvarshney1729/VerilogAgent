module TopModule(
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (shift_ena) begin
            // Shift operation: shift in data into MSB
            q <= {data, q[3:1]};
        end else if (count_ena) begin
            // Count operation: decrement the current value
            q <= q - 1;
        end
    end

endmodule