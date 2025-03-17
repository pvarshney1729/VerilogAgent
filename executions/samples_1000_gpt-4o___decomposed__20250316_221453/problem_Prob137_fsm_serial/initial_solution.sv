module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [3:0] {
        IDLE = 4'b0000,
        START = 4'b0001,
        DATA0 = 4'b0010,
        DATA1 = 4'b0011,
        DATA2 = 4'b0100,
        DATA3 = 4'b0101,
        DATA4 = 4'b0110,
        DATA5 = 4'b0111,
        DATA6 = 4'b1000,
        DATA7 = 4'b1001,
        STOP = 4'b1010,
        DONE = 4'b1011
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state; // Default to hold state
        done = 1'b0; // Default done to 0

        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
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
                    next_state = DONE;
                end else begin
                    next_state = IDLE;
                end
            end
            DONE: begin
                done = 1'b1;
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule