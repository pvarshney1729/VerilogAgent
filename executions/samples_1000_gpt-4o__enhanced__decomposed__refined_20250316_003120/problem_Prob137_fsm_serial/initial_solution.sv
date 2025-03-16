module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE      = 4'b0000,
        START_BIT = 4'b0001,
        DATA_BIT0 = 4'b0010,
        DATA_BIT1 = 4'b0011,
        DATA_BIT2 = 4'b0100,
        DATA_BIT3 = 4'b0101,
        DATA_BIT4 = 4'b0110,
        DATA_BIT5 = 4'b0111,
        DATA_BIT6 = 4'b1000,
        DATA_BIT7 = 4'b1001,
        STOP_BIT  = 4'b1010,
        ERROR     = 4'b1011
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        next_state = current_state; // Default to hold state
        done = 1'b0; // Default output

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BIT0;
            end
            DATA_BIT0: begin
                next_state = DATA_BIT1;
            end
            DATA_BIT1: begin
                next_state = DATA_BIT2;
            end
            DATA_BIT2: begin
                next_state = DATA_BIT3;
            end
            DATA_BIT3: begin
                next_state = DATA_BIT4;
            end
            DATA_BIT4: begin
                next_state = DATA_BIT5;
            end
            DATA_BIT5: begin
                next_state = DATA_BIT6;
            end
            DATA_BIT6: begin
                next_state = DATA_BIT7;
            end
            DATA_BIT7: begin
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Verify stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Error, wait for stop bit
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Return to idle after error
                end
            end
        endcase
    end

endmodule