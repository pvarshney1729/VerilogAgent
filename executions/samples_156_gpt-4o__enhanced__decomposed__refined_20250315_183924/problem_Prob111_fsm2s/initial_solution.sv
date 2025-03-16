module TopModule (
    input  logic clk,   // Clock signal
    input  logic reset, // Active-high synchronous reset
    input  logic j,     // Input signal j
    input  logic k,     // Input signal k
    output logic out    // Output signal
);
    // State encoding
    localparam logic OFF = 1'b0, ON = 1'b1;
    
    // State register
    logic state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF; // Synchronous reset to OFF state
        end else begin
            state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF; // Default to OFF state
            end
        endcase
    end

    // Output logic (Moore machine)
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0; // Default output
        endcase
    end
endmodule