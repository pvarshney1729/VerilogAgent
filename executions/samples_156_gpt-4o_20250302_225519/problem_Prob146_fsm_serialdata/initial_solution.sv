module TopModule (
    input  logic       clk,        // Clock signal, positive edge-triggered
    input  logic       in,         // Serial data input
    input  logic       reset,      // Active-high synchronous reset
    output logic [7:0] out_byte,   // 8-bit output data byte
    output logic       done        // Done flag, indicates a valid byte has been received
);

    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        RECEIVE = 2'b01,
        VERIFY  = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [7:0] shift_reg;
    logic [3:0] bit_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            shift_reg <= 8'b0;
            bit_count <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == DONE) begin
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
                if (in == 1'b0) // Start bit detected
                    next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 4'd8)
                    next_state = VERIFY;
            end
            VERIFY: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = DONE;
                else
                    next_state = IDLE; // Error, go back to IDLE
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule