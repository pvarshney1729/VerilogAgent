module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);
    // State encoding
    localparam A = 2'b01, B = 2'b10;
    logic [1:0] state, next_state;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: next_state = A; // Default case
        endcase
    end

    // Output logic (Mealy)
    always @(*) begin
        case (state)
            A: z = x; // z = 1 if x = 1
            B: z = ~x; // z = 1 if x = 0
            default: z = 0; // Default case
        endcase
    end
endmodule