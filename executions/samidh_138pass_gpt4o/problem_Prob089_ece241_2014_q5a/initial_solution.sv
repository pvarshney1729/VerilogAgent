```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        EXPECT_LSB = 2'b00,
        PROCESSING = 2'b01,
        COMPLEMENT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [7:0] input_register;
    logic [7:0] complement_register;
    logic carry;

    // State transition logic
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= EXPECT_LSB;
            input_register <= 8'b0;
            complement_register <= 8'b0;
            carry <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state;
        z = 1'b0; // Default output

        case (current_state)
            EXPECT_LSB: begin
                input_register = {x, input_register[7:1]};
                if (x) begin
                    next_state = PROCESSING;
                end
            end

            PROCESSING: begin
                complement_register = ~input_register + 8'b1;
                carry = complement_register[7];
                next_state = COMPLEMENT;
            end

            COMPLEMENT: begin
                z = complement_register[0];
                complement_register = {carry, complement_register[7:1]};
                if (complement_register == 8'b0) begin
                    next_state = EXPECT_LSB;
                end
            end

            default: begin
                next_state = EXPECT_LSB;
            end
        endcase
    end

endmodule
[DONE]
```