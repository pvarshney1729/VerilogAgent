module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        PROCESS = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [7:0] input_register; // Assuming an 8-bit input for demonstration
    logic [7:0] twos_complement;
    logic [2:0] bit_counter; // To count the number of bits processed

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            input_register <= 8'b0;
            bit_counter <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PROCESS) begin
                input_register <= {x, input_register[7:1]};
                bit_counter <= bit_counter + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (x) // Start processing when x is high
                    next_state = PROCESS;
                else
                    next_state = IDLE;
            end
            PROCESS: begin
                if (bit_counter == 3'b111) // Assuming 8 bits
                    next_state = IDLE;
                else
                    next_state = PROCESS;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        if (current_state == PROCESS && bit_counter == 3'b111) begin
            twos_complement = ~input_register + 1'b1;
            z = twos_complement[0]; // Output LSB of 2's complement
        end else begin
            z = 1'b0;
        end
    end

endmodule