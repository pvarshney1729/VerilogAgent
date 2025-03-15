module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE        = 4'b0000,
        START_BIT   = 4'b0001,
        DATA_BIT_0  = 4'b0010,
        DATA_BIT_1  = 4'b0011,
        DATA_BIT_2  = 4'b0100,
        DATA_BIT_3  = 4'b0101,
        DATA_BIT_4  = 4'b0110,
        DATA_BIT_5  = 4'b0111,
        DATA_BIT_6  = 4'b1000,
        DATA_BIT_7  = 4'b1001,
        STOP_BIT    = 4'b1010
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BIT_0 || current_state == DATA_BIT_1 ||
                current_state == DATA_BIT_2 || current_state == DATA_BIT_3 ||
                current_state == DATA_BIT_4 || current_state == DATA_BIT_5 ||
                current_state == DATA_BIT_6 || current_state == DATA_BIT_7) begin
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BIT_0;
            end
            DATA_BIT_0: begin
                next_state = DATA_BIT_1;
            end
            DATA_BIT_1: begin
                next_state = DATA_BIT_2;
            end
            DATA_BIT_2: begin
                next_state = DATA_BIT_3;
            end
            DATA_BIT_3: begin
                next_state = DATA_BIT_4;
            end
            DATA_BIT_4: begin
                next_state = DATA_BIT_5;
            end
            DATA_BIT_5: begin
                next_state = DATA_BIT_6;
            end
            DATA_BIT_6: begin
                next_state = DATA_BIT_7;
            end
            DATA_BIT_7: begin
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) // Verify stop bit
                    next_state = IDLE;
                else
                    next_state = STOP_BIT; // Wait for stop bit
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
        end else if (current_state == STOP_BIT && in == 1'b1) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

endmodule