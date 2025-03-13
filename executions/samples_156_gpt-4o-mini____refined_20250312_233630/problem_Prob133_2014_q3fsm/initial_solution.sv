```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] w_count;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_count <= {w_count[1:0], w}; // Shift in new w value
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to hold current state
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                end
            end
            B: begin
                // Stay in B until we have 3 values
                // State B does not change unless reset or s is pressed
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        z = 1'b0; // Default output
        if (current_state == B && (w_count == 3'b011 || w_count == 3'b110 || w_count == 3'b101)) begin
            z = 1'b1; // Set z if exactly two w's are 1
        end
    end

endmodule
```