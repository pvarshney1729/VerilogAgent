[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding using one-hot
    logic [1:0] state, next_state;
    localparam A = 2'b01;
    localparam B = 2'b10;

    // Asynchronous reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Transition to state A
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default output
        z = 1'b0; 
        case (state)
            A: begin
                next_state = A;
                if (x == 1'b1) begin
                    next_state = B;
                    z = 1'b1;
                end
            end
            B: begin
                next_state = B;
                if (x == 1'b0) begin
                    z = 1'b1;
                end else begin
                    z = 1'b0;
                end
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
[DONE]