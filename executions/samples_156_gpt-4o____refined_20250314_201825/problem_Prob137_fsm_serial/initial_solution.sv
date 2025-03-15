[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    typedef enum logic [3:0] {
        IDLE    = 4'b0000,
        START   = 4'b0001,
        DATA0   = 4'b0010,
        DATA1   = 4'b0011,
        DATA2   = 4'b0100,
        DATA3   = 4'b0101,
        DATA4   = 4'b0110,
        DATA5   = 4'b0111,
        DATA6   = 4'b1000,
        DATA7   = 4'b1001,
        STOP    = 4'b1010,
        ERROR   = 4'b1011
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_byte;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                next_state = DATA0;
            end
            DATA0: begin
                next_state = DATA1;
            end
            DATA1: begin
                next_state = DATA2;
            end
            DATA2: begin
                next_state = DATA3;
            end
            DATA3: begin
                next_state = DATA4;
            end
            DATA4: begin
                next_state = DATA5;
            end
            DATA5: begin
                next_state = DATA6;
            end
            DATA6: begin
                next_state = DATA7;
            end
            DATA7: begin
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            data_byte <= 8'b0;
        end else begin
            done <= 1'b0; // Ensure done is reset in non-STOP states
            case (current_state)
                DATA0: data_byte[0] <= in;
                DATA1: data_byte[1] <= in;
                DATA2: data_byte[2] <= in;
                DATA3: data_byte[3] <= in;
                DATA4: data_byte[4] <= in;
                DATA5: data_byte[5] <= in;
                DATA6: data_byte[6] <= in;
                DATA7: data_byte[7] <= in;
                STOP: done <= (in == 1'b1);
            endcase
        end
    end

endmodule
[END]