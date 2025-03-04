module TopModule (
    input  logic clk,        // Clock input, positive edge-triggered
    input  logic reset,      // Reset input, active high
    input  logic w,          // Input signal w
    output logic z           // Output signal z
);

    // State encoding
    parameter [2:0] STATE_A = 3'b000;
    parameter [2:0] STATE_B = 3'b001;
    parameter [2:0] STATE_C = 3'b010;
    parameter [2:0] STATE_D = 3'b011;
    parameter [2:0] STATE_E = 3'b100;
    parameter [2:0] STATE_F = 3'b101;

    // State register
    logic [2:0] current_state;

    // Sequential logic for state transitions and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 0;
        end else begin
            case (current_state)
                STATE_A: if (w) current_state <= STATE_A; else current_state <= STATE_B;
                STATE_B: if (w) current_state <= STATE_D; else current_state <= STATE_C;
                STATE_C: if (w) current_state <= STATE_D; else current_state <= STATE_E;
                STATE_D: if (w) current_state <= STATE_A; else current_state <= STATE_F;
                STATE_E: if (w) current_state <= STATE_D; else current_state <= STATE_E;
                STATE_F: if (w) current_state <= STATE_D; else current_state <= STATE_C;
                default: current_state <= STATE_A;
            endcase

            // Output logic
            case (current_state)
                STATE_E, STATE_F: z <= 1;
                default: z <= 0;
            endcase
        end
    end

endmodule