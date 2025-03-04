module TopModule (
    input logic clk,            // Clock input
    input logic reset_n,        // Asynchronous active-low reset
    input logic shift_ena,      // Enable signal for shifting operation
    input logic count_ena,      // Enable signal for counting operation
    input logic data,           // Serial data input for the shift register
    output logic [3:0] q        // 4-bit output representing the current state of the shift register/counter
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 4'b0000; // Initialize q to zero on reset
        end else begin
            if (shift_ena && !count_ena) begin
                q <= {q[2:0], data}; // Shift left and input data into q[3]
            end else if (count_ena && !shift_ena) begin
                q <= q - 1; // Decrement the value in q
            end
            // Undefined behavior if both shift_ena and count_ena are high
        end
    end

endmodule