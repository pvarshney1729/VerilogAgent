module TopModule (
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential block for state register
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational block for state transition logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (r[0]) begin
                    next_state = STATE_B;
                end else if (r[1]) begin
                    next_state = STATE_C;
                end else if (r[2]) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (r[0]) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_C: begin
                if (r[1]) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Combinational block for output logic
    always_comb begin
        case (current_state)
            STATE_A: g = 3'b000;
            STATE_B: g = 3'b001;
            STATE_C: g = 3'b010;
            STATE_D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end

endmodule