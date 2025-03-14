module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE,
        READ,
        COMPLEMENT
    } state_t;

    state_t current_state, next_state;
    logic [31:0] number; // Assuming a maximum of 32 bits for the input number
    logic [31:0] twos_complement;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            number <= 32'b0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == READ) begin
                number <= {x, number[31:1]}; // Shift in the new bit
            end
            if (current_state == COMPLEMENT) begin
                z <= twos_complement[0]; // Output the LSB of the 2's complement
            end
        end
    end

    always_comb begin
        next_state = current_state;
        twos_complement = ~number + 1; // Calculate 2's complement

        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = READ; // Transition to READ state when reset is released
                end
            end
            READ: begin
                if (areset) begin
                    next_state = IDLE; // Go back to IDLE on reset
                end else begin
                    next_state = READ; // Stay in READ state
                end
            end
            COMPLEMENT: begin
                if (areset) begin
                    next_state = IDLE; // Go back to IDLE on reset
                end else begin
                    next_state = COMPLEMENT; // Stay in COMPLEMENT state
                end
            end
        endcase
    end

endmodule