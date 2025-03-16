[BEGIN]
module TopModule(
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

    // State Encoding
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

    // Output Logic
    always @(*) begin
        B3_next = (state == B2);
        S_next = ((state == S) && (d == 1'b0)) || 
                 ((state == S1) && (d == 1'b0)) || 
                 ((state == S110) && (d == 1'b0)) || 
                 ((state == Wait) && (ack == 1'b1));
        S1_next = (state == S) && (d == 1'b1);
        Count_next = (state == B3);
        Wait_next = (state == Count) && (done_counting == 1'b1);
        done = (state == Wait);
        counting = (state == Count);
        shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);
    end

endmodule
[DONE]