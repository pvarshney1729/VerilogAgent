module TopModule(
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    // State encoding
    typedef enum logic [1:0] {
        BELOW_S0  = 2'b00,
        BETWEEN_S0_S1 = 2'b01,
        BETWEEN_S1_S2 = 2'b10,
        ABOVE_S2  = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= BELOW_S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (s)
            3'b111: next_state = ABOVE_S2;
            3'b011: next_state = BETWEEN_S1_S2;
            3'b001: next_state = BETWEEN_S0_S1;
            default: next_state = BELOW_S0; // 3'b000
        endcase
    end

    // Output logic based on current state and water level
    always_comb begin
        // Default all outputs to deasserted
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;
        
        case (current_state)
            ABOVE_S2: begin
                // All outputs remain deasserted
            end
            BETWEEN_S1_S2: begin
                fr0 = 1'b1;
            end
            BETWEEN_S0_S1: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                if (next_state != current_state) begin
                    dfr = 1'b1; // Open supplemental valve if transitioning from a lower level
                end
            end
            BELOW_S0: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                fr2 = 1'b1;
                dfr = 1'b1;
            end
        endcase
    end
endmodule