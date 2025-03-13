module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0, // Initial state
        S1, // State to capture input bit
        S2  // State to output the result
    } state_t;

    state_t current_state, next_state;
    logic [31:0] input_buffer; // Buffer to hold input bits
    logic [31:0] twos_complement; // Buffer for 2's complement result
    logic count_done;

    // State transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= S0;
            input_buffer <= 32'b0;
            twos_complement <= 32'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (!areset) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                input_buffer = {x, input_buffer[31:1]}; // Shift in new bit
                if (input_buffer[31] == 1'b1) begin
                    next_state = S2; // Move to output state if input is complete
                end else begin
                    next_state = S1; // Stay in input state
                end
            end
            S2: begin
                next_state = S2; // Stay in output state
            end
            default: next_state = S0;
        endcase
    end

    // Output logic for 2's complement
    always @(*) begin
        if (current_state == S2) begin
            twos_complement = ~input_buffer + 1'b1; // Compute 2's complement
            z = twos_complement[0]; // Output the least significant bit
        end else begin
            z = 1'b0; // Default output
        end
    end

endmodule