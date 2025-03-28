module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVING = 2'b01,
        DONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [23:0] buffer;
    logic [1:0] byte_count;

    // Sequential logic for state transition and output
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            buffer <= 24'b0;
            byte_count <= 2'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVING) begin
                buffer <= {buffer[15:0], in}; // Shift in the new byte
                byte_count <= byte_count + 2'b1;
            end
            if (current_state == DONE) begin
                done <= 1'b1; // Signal done after receiving 3 bytes
            end else begin
                done <= 1'b0; // Reset done signal
            end
        end
    end

    // Combinational logic for next state and outputs
    always_comb begin
        next_state = current_state;
        out_bytes = buffer; // Default out_bytes to buffer
        case (current_state)
            IDLE: begin
                if (in[3]) begin
                    next_state = RECEIVING;
                    byte_count = 2'b0; // Reset byte count
                end
            end
            RECEIVING: begin
                if (byte_count == 2'b10) begin // 3 bytes received
                    next_state = DONE;
                end
            end
            DONE: begin
                next_state = IDLE; // Go back to IDLE after signaling done
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly