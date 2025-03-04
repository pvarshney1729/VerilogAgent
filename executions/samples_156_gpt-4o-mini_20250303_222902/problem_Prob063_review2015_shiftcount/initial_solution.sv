module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            if (shift_ena && !count_ena) begin
                q <= {data, q[3:1]}; // Shift in data to MSB
            end else if (!shift_ena && count_ena) begin
                q <= (q == 4'b0000) ? 4'b1111 : (q - 1); // Decrement with wrap around
            end
            // If both shift_ena and count_ena are high, do nothing (no operation)
        end
    end

endmodule