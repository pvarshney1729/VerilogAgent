module TopModule (
    input logic clk,                      // Clock input (1 bit)
    input logic reset,                    // Asynchronous active high reset (1 bit)
    input logic [7:0] input_byte,        // Input byte (8 bits)
    output logic [23:0] out_bytes,       // Output bytes (24 bits)
    output logic done                     // Output signal indicating message received (1 bit)
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVING
    } state_t;

    state_t current_state, next_state;
    logic [7:0] byte_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
            byte_count <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVING) begin
                if (byte_count < 3) begin
                    out_bytes[(byte_count * 8) +: 8] <= input_byte;
                    byte_count <= byte_count + 1;
                end
                if (byte_count == 2) begin
                    done <= 1'b1;
                end else begin
                    done <= 1'b0;
                end
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (input_byte[3] == 1'b1) begin
                    next_state = RECEIVING;
                    byte_count = 0;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVING: begin
                if (byte_count < 3) begin
                    next_state = RECEIVING;
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule