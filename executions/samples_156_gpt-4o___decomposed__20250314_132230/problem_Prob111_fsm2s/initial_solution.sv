module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic j,
    input  logic k,
    output logic out
);

    // State encoding
    localparam logic OFF = 1'b0;
    localparam logic ON  = 1'b1;

    // State registers
    logic current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            OFF: if (j)
                     next_state = ON;
                 else
                     next_state = OFF;
            ON:  if (k)
                     next_state = OFF;
                 else
                     next_state = ON;
            default: next_state = OFF; // default state
        endcase
    end

    // Output logic based on the current state
    always @(*) begin
        case (current_state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0; // Default case to handle undefined states
        endcase
    end

endmodule