```verilog
module water_level_controller (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MEDIUM = 2'b01,
        HIGH = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            LOW: begin
                if (s == 3'b111)
                    next_state = HIGH;
                else if (s >= 3'b100)
                    next_state = MEDIUM;
                else
                    next_state = LOW;
            end
            MEDIUM: begin
                if (s == 3'b111)
                    next_state = HIGH;
                else if (s < 3'b100)
                    next_state = LOW;
                else
                    next_state = MEDIUM;
            end
            HIGH: begin
                if (s < 3'b100)
                    next_state = LOW;
                else if (s < 3'b111)
                    next_state = MEDIUM;
                else
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // State register
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= LOW;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;
        case (current_state)
            LOW: begin
                fr0 = 1'b1;
            end
            MEDIUM: begin
                fr1 = 1'b1;
            end
            HIGH: begin
                fr2 = 1'b1;
                dfr = 1'b1;
            end
        endcase
    end

endmodule
```