module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {data, q[3:1]}; // Shift in data MSB first
        end else if (count_ena) begin
            q <= q - 1; // Decrement the counter
        end
    end

endmodule