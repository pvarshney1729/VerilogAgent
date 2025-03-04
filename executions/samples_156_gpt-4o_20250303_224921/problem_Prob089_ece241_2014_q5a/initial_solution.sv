```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        PASS = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic invert_flag;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            invert_flag <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (x == 1'b1) begin
                    next_state = INVERT;
                end else begin
                    next_state = PASS;
                end
            end
            INVERT: begin
                next_state = PASS;
            end
            PASS: begin
                next_state = PASS;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    z <= x;
                end
                INVERT: begin
                    z <= ~x;
                    invert_flag <= 1'b1;
                end
                PASS: begin
                    if (invert_flag) begin
                        z <= ~x;
                    end else begin
                        z <= x;
                    end
                end
                default: begin
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule
```