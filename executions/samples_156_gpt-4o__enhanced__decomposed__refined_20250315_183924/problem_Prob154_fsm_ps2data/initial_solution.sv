[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] out_bytes_reg;
    logic done_reg;

    // State Transition Logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes_reg <= 24'hx;
            done_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE3) begin
                out_bytes_reg <= {out_bytes_reg[23:8], in};
                done_reg <= 1'b1;
            end else begin
                done_reg <= 1'b0;
            end
        end
    end

    // Next State Logic and Output Logic
    always_comb begin
        // Default assignments
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                out_bytes_reg[23:16] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                out_bytes_reg[15:8] = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                out_bytes_reg[7:0] = in;
                next_state = IDLE;
            end
        endcase
    end

    // Output Assignments
    assign out_bytes = out_bytes_reg;
    assign done = done_reg;

endmodule
[DONE]