module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic areset,        // Asynchronous reset signal, active high
    input logic x,             // Serial input bit stream
    output logic z             // Output bit stream representing 2's complement
);

    typedef enum logic [1:0] {
        IDLE,
        PROCESS,
        COMPLEMENT
    } state_t;

    state_t current_state, next_state;
    logic [1:0] bit_count; // Counter for bits processed
    logic [7:0] input_reg; // Register to store input bits
    logic [7:0] complement_reg; // Register to store 2's complement

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            bit_count <= 2'b00;
            input_reg <= 8'b0;
            complement_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PROCESS) begin
                input_reg <= {input_reg[6:0], x};
                bit_count <= bit_count + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (x) begin
                    next_state = PROCESS;
                end else begin
                    next_state = IDLE;
                end
            end
            PROCESS: begin
                if (bit_count == 2'b11) begin
                    next_state = COMPLEMENT;
                end else begin
                    next_state = PROCESS;
                end
            end
            COMPLEMENT: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (current_state == COMPLEMENT) begin
            complement_reg = ~input_reg + 1;
            z = complement_reg[0];
        end else begin
            z = 1'b0;
        end
    end

endmodule