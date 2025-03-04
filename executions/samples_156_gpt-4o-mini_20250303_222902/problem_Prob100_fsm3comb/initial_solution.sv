module TopModule (
    input logic in,
    input logic [1:0] state,
    input logic clk,
    input logic rst_n,
    output logic [1:0] next_state,
    output logic out
);

always @(*) begin
    case (state)
        2'b00: begin
            next_state = (in == 1'b0) ? 2'b00 : 2'b01;
            out = 1'b0;
        end
        2'b01: begin
            next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            out = 1'b0;
        end
        2'b10: begin
            next_state = (in == 1'b0) ? 2'b00 : 2'b11;
            out = 1'b0;
        end
        2'b11: begin
            next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00; // Default to State A if in an undefined state
            out = 1'b0;
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        next_state <= 2'b00; // Initialize to State A on reset
        out <= 1'b0; // Output is 0 on reset
    end else begin
        next_state <= next_state; // Update state on clock edge
    end
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly