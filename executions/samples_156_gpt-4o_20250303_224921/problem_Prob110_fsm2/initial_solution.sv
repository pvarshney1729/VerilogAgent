module TopModule (
    input wire clk,          // Clock signal
    input wire areset,       // Active-high asynchronous reset
    input wire j,            // Input signal j
    input wire k,            // Input signal k
    output reg out           // Output signal out
);

    // State encoding
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;

    // State register
    reg state;

    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
            out <= 1'b0;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                        out <= 1'b1;
                    end
                end
                ON: begin
                    if (k) begin
                        state <= OFF;
                        out <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule