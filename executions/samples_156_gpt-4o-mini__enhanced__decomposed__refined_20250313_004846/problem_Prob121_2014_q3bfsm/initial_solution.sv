```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    // State encoding
    localparam logic [2:0] 
        S000 = 3'b000,
        S001 = 3'b001,
        S010 = 3'b010,
        S011 = 3'b011,
        S100 = 3'b100;

    logic [2:0] current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (current_state)
            S000: begin
                next_state = (x == 1'b0) ? S000 : S001;
                z = 1'b0;
            end
            S001: begin
                next_state = (x == 1'b0) ? S001 : S100;
                z = 1'b0;
            end
            S010: begin
                next_state = (x == 1'b0) ? S010 : S001;
                z = 1'b0;
            end
            S011: begin
                next_state = (x == 1'b0) ? S001 : S010;
                z = 1'b1;
            end
            S100: begin
                next_state = (x == 1'b0) ? S011 : S100;
                z = 1'b1;
            end
            default: begin
                next_state = S000;
                z = 1'b0;
            end
        endcase
    end

endmodule
[DONE]
```