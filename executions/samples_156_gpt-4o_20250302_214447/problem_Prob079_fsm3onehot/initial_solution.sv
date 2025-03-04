module TopModule (
    input logic in,
    input logic [3:0] state,
    input logic clk,
    input logic rst_n,
    output logic [3:0] next_state,
    output logic out
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= 4'b0001; // Reset to state A
        end else begin
            case (state)
                4'b0001: next_state <= (in == 1'b0) ? 4'b0001 : 4'b0010; // State A
                4'b0010: next_state <= (in == 1'b0) ? 4'b0100 : 4'b0010; // State B
                4'b0100: next_state <= (in == 1'b0) ? 4'b0001 : 4'b1000; // State C
                4'b1000: next_state <= (in == 1'b0) ? 4'b0100 : 4'b0010; // State D
                default: next_state <= 4'b0001; // Default to state A
            endcase
        end
    end

    always_comb begin
        out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output logic
    end

endmodule