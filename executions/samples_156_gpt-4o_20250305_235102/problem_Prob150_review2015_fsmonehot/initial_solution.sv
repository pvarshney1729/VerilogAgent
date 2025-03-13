[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    // State encoding
    localparam logic [9:0] S     = 10'b0000000001;
    localparam logic [9:0] S1    = 10'b0000000010;
    localparam logic [9:0] S11   = 10'b0000000100;
    localparam logic [9:0] S110  = 10'b0000001000;
    localparam logic [9:0] B0    = 10'b0000010000;
    localparam logic [9:0] B1    = 10'b0000100000;
    localparam logic [9:0] B2    = 10'b0001000000;
    localparam logic [9:0] B3    = 10'b0010000000;
    localparam logic [9:0] Count = 10'b0100000000;
    localparam logic [9:0] Wait  = 10'b1000000000;

    logic [9:0] next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S:     next_state = (d) ? S1 : S;
            S1:    next_state = (d) ? S11 : S;
            S11:   next_state = (d) ? S11 : S110;
            S110:  next_state = (d) ? B0 : S;
            B0:    next_state = B1;
            B1:    next_state = B2;
            B2:    next_state = B3;
            B3:    next_state = Count;
            Count: next_state = (done_counting) ? Wait : Count;
            Wait:  next_state = (ack) ? S : Wait;
            default: next_state = S; // Handle invalid state
        endcase
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (!reset_n) begin
            next_state <= S;
        end else begin
            next_state <= next_state;
        end
    end

    // Output logic
    assign B3_next = (next_state == B3);
    assign S_next = (next_state == S);
    assign S1_next = (next_state == S1);
    assign Count_next = (next_state == Count);
    assign Wait_next = (next_state == Wait);

    assign done = (state == Wait);
    assign counting = (state == Count);
    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);

endmodule
```
[DONE]