module TopModule (
    input logic clk,        // 1-bit clock input
    input logic reset,      // 1-bit active high synchronous reset
    input logic slowena,    // 1-bit slow enable signal
    output logic [3:0] q    // 4-bit output representing the counter value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0000;
            end else begin
                q <= q + 4'b0001;
            end
        end
    end

endmodule