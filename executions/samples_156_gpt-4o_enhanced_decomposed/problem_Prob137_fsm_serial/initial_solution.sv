module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        DONE  = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end
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
        endcase
    end

endmodule