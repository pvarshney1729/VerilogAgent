module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        START       = 3'b001,
        DATA        = 3'b010,
        STOP        = 3'b011,
        DONE        = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter; // Counter for 8 data bits

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 3'b000;
            end
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111) // 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) begin // Verify stop bit
                    next_state = DONE;
                end else begin
                    next_state = STOP; // Wait for stop bit
                end
            end
            DONE: begin
                done = 1'b1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule