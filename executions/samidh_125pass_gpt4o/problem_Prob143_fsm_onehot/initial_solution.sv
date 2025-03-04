module TopModule (
    input logic in,
    input logic [9:0] state,
    input logic clk,
    input logic rst,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

    // State encoding
    localparam logic [9:0] S0 = 10'b0000000001;
    localparam logic [9:0] S1 = 10'b0000000010;
    localparam logic [9:0] S2 = 10'b0000000100;
    localparam logic [9:0] S3 = 10'b0000001000;
    localparam logic [9:0] S4 = 10'b0000010000;
    localparam logic [9:0] S5 = 10'b0000100000;
    localparam logic [9:0] S6 = 10'b0001000000;
    localparam logic [9:0] S7 = 10'b0010000000;
    localparam logic [9:0] S8 = 10'b0100000000;
    localparam logic [9:0] S9 = 10'b1000000000;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (rst) begin
            next_state <= S0;
        end else begin
            case (state)
                S0: next_state <= (in) ? S1 : S0;
                S1: next_state <= (in) ? S2 : S0;
                S2: next_state <= (in) ? S3 : S0;
                S3: next_state <= (in) ? S4 : S0;
                S4: next_state <= (in) ? S5 : S0;
                S5: next_state <= (in) ? S6 : S8;
                S6: next_state <= (in) ? S7 : S9;
                S7: next_state <= (in) ? S7 : S0;
                S8: next_state <= (in) ? S1 : S0;
                S9: next_state <= (in) ? S1 : S0;
                default: next_state <= S0;
            endcase
        end
    end

    // Combinational logic for outputs
    always_comb begin
        out1 = 1'b0;
        out2 = 1'b0;
        case (state)
            S7: out2 = 1'b1;
            S8: out1 = 1'b1;
            S9: begin
                out1 = 1'b1;
                out2 = 1'b1;
            end
            default: begin
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end

endmodule