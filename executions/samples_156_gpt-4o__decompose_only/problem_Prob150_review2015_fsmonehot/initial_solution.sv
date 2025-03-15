module TopModule (
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
    localparam S     = 10'b0000000001;
    localparam S1    = 10'b0000000010;
    localparam S11   = 10'b0000000100;
    localparam S110  = 10'b0000001000;
    localparam B0    = 10'b0000010000;
    localparam B1    = 10'b0000100000;
    localparam B2    = 10'b0001000000;
    localparam B3    = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait  = 10'b1000000000;

    // Next state logic
    assign S_next     = (state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1);
    assign S1_next    = (state == S && d == 1);
    assign B3_next    = (state == B2);
    assign Count_next = (state == B3);
    assign Wait_next  = (state == Count && done_counting == 1);

    // Output logic
    assign done       = (state == Wait);
    assign counting   = (state == Count);
    assign shift_ena  = (state == B0) || (state == B1) || (state == B2) || (state == B3);

endmodule