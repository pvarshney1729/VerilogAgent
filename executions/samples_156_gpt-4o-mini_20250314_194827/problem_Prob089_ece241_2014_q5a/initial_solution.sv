```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    typedef enum logic [1:0] {
        IDLE,
        INVERT,
        ADD_ONE,
        OUTPUT
    } state_t;

    state_t current_state, next_state;
    logic [7:0] inverted_data;
    logic [7:0] result;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: next_state = INVERT;
            INVERT: next_state = ADD_ONE;
            ADD_ONE: next_state = OUTPUT;
            OUTPUT: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Invert the input data
    always @(*) begin
        inverted_data = ~data_in;
    end

    // Add one to the inverted data
    always @(*) begin
        result = inverted_data + 8'b1;
    end

    // Output logic based on the current state
    always @(*) begin
        case (current_state)
            OUTPUT: data_out = result;
            default: data_out = 8'b0;
        endcase
    end

endmodule
```