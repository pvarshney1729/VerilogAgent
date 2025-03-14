module TopModule(
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        START = 2'b01,
        DATA_RECEIVE = 2'b10,
        STOP = 2'b11
    } state_t;

    // Internal registers
    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;
    logic done_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            shift_reg <= 8'b0;
            done_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_RECEIVE) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state;
        done_reg = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit
                    next_state = START;
                end
            end
            
            START: begin
                next_state = DATA_RECEIVE;
                bit_count = 3'd0;
            end
            
            DATA_RECEIVE: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    done_reg = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = IDLE; // Wait for stop bit if not correct
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output assignments
    assign out_byte = done_reg ? shift_reg : 8'bxxxx_xxxx;
    assign done = done_reg;

endmodule