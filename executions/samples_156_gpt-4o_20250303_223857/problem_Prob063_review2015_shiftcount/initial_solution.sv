module TopModule (
    input wire clk,              // Clock signal, positive-edge triggered
    input wire reset_n,          // Asynchronous active-low reset
    input wire shift_ena,        // Shift enable control signal
    input wire count_ena,        // Count enable control signal
    input wire data,             // Data input to the shift register
    output reg [3:0] q           // 4-bit output from the shift register
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 4'b0000;
        end else begin
            if (shift_ena) begin
                q <= {data, q[3:1]};
            end else if (count_ena) begin
                q <= q - 1;
            end
        end
    end

endmodule