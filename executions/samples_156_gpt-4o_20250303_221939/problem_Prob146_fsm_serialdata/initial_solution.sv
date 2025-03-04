module TopModule (
    input logic clk,           // System clock, positive edge triggered
    input logic in,            // Serial data input
    input logic reset,         // Active-high synchronous reset
    output logic [7:0] out_byte, // 8-bit output byte, unsigned
    output logic done           // Indicates a byte has been received correctly
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;
    logic [7:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 4'b0;
            shift_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == STOP && in == 1'b1) begin
                out_byte <= shift_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 4'd8) begin
                    next_state = STOP;
                end
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
                end
            end
        endcase
    end

endmodule