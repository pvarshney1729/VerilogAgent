module TopModule (
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    // State encoding
    localparam logic [1:0] STATE_A = 2'b00;
    localparam logic [1:0] STATE_B = 2'b01;
    localparam logic [1:0] STATE_C = 2'b10;
    localparam logic [1:0] STATE_D = 2'b11;

    // State register
    logic [1:0] current_state, next_state;

    // State flip-flops with synchronous reset logic
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational block for next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (r[0] == 1'b1)
                    next_state = STATE_B;
                else if (r[1] == 1'b1)
                    next_state = STATE_C;
                else if (r[2] == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[0] == 1'b1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[1] == 1'b1)
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (r[2] == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_A; // Default to STATE_A for safety
        endcase
    end

    // Output logic to set g based on the current state
    always @(*) begin
        // Default values for g
        g = 3'b000;
        
        case (current_state)
            STATE_B: g = 3'b001; // Set g0=1 in state B
            STATE_C: g = 3'b010; // Set g1=1 in state C
            STATE_D: g = 3'b100; // Set g2=1 in state D
            default: g = 3'b000;  // Default case for other states
        endcase
    end

endmodule