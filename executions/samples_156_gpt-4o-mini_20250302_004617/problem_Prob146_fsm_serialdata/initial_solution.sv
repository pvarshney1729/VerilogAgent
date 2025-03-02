```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [7:0] data_out,
    output logic valid
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVING = 2'b01,
        VALIDATING = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [7:0] shift_reg;
    logic [3:0] bit_count;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (serial_in) 
                    next_state = RECEIVING;
                else 
                    next_state = IDLE;
            end
            RECEIVING: begin
                if (bit_count == 4'b0111) 
                    next_state = VALIDATING;
                else 
                    next_state = RECEIVING;
            end
            VALIDATING: begin
                next_state = IDLE; // Transition back to IDLE after validation
            end
            default: next_state = IDLE;
        endcase
    end

    // Sequential logic for state and shift register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 8'b00000000;
            bit_count <= 4'b0000;
            valid <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                RECEIVING: begin
                    shift_reg <= {shift_reg[6:0], serial_in};
                    bit_count <= bit_count + 4'b0001;
                end
                VALIDATING: begin
                    valid <= 1'b1; // Set valid signal when data is ready
                    data_out <= shift_reg; // Output the received data
                end
                default: begin
                    valid <= 1'b0; // Reset valid signal in other states
                end
            endcase
        end
    end

endmodule
```