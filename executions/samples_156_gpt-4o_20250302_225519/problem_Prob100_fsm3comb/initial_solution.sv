module TopModule (
    input logic clk,
    input logic rst_n,
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    // State Encoding
    localparam logic [1:0] STATE_A = 2'b00,
                           STATE_B = 2'b01,
                           STATE_C = 2'b10,
                           STATE_D = 2'b11;

    // Combinational logic for state transitions and output generation
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                    out = 1'b0;
                end else begin
                    next_state = STATE_B;
                    out = 1'b0;
                end
            end
            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                    out = 1'b0;
                end else begin
                    next_state = STATE_B;
                    out = 1'b0;
                end
            end
            STATE_C: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                    out = 1'b0;
                end else begin
                    next_state = STATE_D;
                    out = 1'b0;
                end
            end
            STATE_D: begin
                if (in == 1'b0) begin
                    next_state = STATE_C;
                    out = 1'b1;
                end else begin
                    next_state = STATE_B;
                    out = 1'b1;
                end
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= STATE_A;
        end
    end

endmodule