module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0, // State to read input bit
        S1  // State to output the result
    } state_t;

    state_t current_state, next_state;
    logic [31:0] num; // Assuming a maximum of 32 bits for input
    logic [31:0] twos_complement;

    // Two's complement calculation
    assign twos_complement = ~num + 1'b1;

    // State transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= S0;
            num <= 32'b0;
        end else begin
            current_state <= next_state;
            if (current_state == S0) begin
                num <= {x, num[31:1]}; // Shift in the new bit
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                next_state = (areset) ? S0 : S1; // Move to S1 after reading input
            end
            S1: begin
                next_state = S0; // Go back to S0 to read next bit
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        z = (current_state == S1) ? twos_complement[0] : 1'b0; // Output LSB of 2's complement
    end

endmodule