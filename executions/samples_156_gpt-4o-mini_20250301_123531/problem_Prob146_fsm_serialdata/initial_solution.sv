module TopModule (
    input logic clk,                // Clock input, positive edge-triggered
    input logic in,                 // Serial data input
    input logic reset,              // Active-high synchronous reset
    output logic [7:0] out_byte,    // Output byte, valid when `done` is high
    output logic done               // Output flag, high when a byte is correctly received
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE,
        VERIFY,
        COMPLETE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                out_byte <= {in, out_byte[7:1]};
                bit_count <= bit_count + 1;
            end else if (current_state == COMPLETE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = RECEIVE;
                else
                    next_state = IDLE;
            end
            RECEIVE: begin
                if (bit_count == 4'd8)
                    next_state = VERIFY;
                else
                    next_state = RECEIVE;
            end
            VERIFY: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = COMPLETE;
                else
                    next_state = IDLE; // Incorrect stop bit
            end
            COMPLETE: begin
                next_state = IDLE; // Return to IDLE after done
            end
            default: next_state = IDLE;
        endcase
    end

endmodule