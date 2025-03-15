module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    // State encoding using a localparam
    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic to register the state
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic to determine the next state
    always_comb begin
        // Default assignments
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 1'b1; // Signal done after 3rd byte
                next_state = IDLE;
            end
        endcase
    end

endmodule