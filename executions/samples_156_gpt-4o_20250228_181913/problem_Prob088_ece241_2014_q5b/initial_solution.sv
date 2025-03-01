```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // Define state encoding
    localparam logic [1:0] A = 2'b01;
    localparam logic [1:0] B = 2'b10;

    logic [1:0] state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

endmodule
```