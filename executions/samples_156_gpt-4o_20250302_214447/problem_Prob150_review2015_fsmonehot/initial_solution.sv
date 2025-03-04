module TopModule (
    input wire clk,                   // Clock signal for sequential operation
    input wire reset_n,               // Active-low reset signal
    input wire d,                     // 1-bit input signal
    input wire done_counting,         // 1-bit input signal
    input wire ack,                   // 1-bit input signal
    input wire [9:0] state,           // 10-bit input, one-hot encoded current state
    output wire B3_next,              // Next state is B3
    output wire S_next,               // Next state is S
    output wire S1_next,              // Next state is S1
    output wire Count_next,           // Next state is Count
    output wire Wait_next,            // Next state is Wait
    output wire done,                 // Output signal
    output wire counting,             // Output signal
    output wire shift_ena             // Output signal
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

    reg [9:0] next_state;

    // State transition logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            next_state <= S;
        end else begin
            case (state)
                S:     next_state <= (d) ? S1 : S;
                S1:    next_state <= (d) ? S11 : S1;
                S11:   next_state <= (d) ? S11 : S110;
                S110:  next_state <= (d) ? B0 : S110;
                B0:    next_state <= B1;
                B1:    next_state <= B2;
                B2:    next_state <= B3;
                B3:    next_state <= Count;
                Count: next_state <= (done_counting) ? Wait : Count;
                Wait:  next_state <= (ack) ? S : Wait;
                default: next_state <= S;
            endcase
        end
    end

    // Next state signals
    assign B3_next = (next_state == B3);
    assign S_next = (next_state == S);
    assign S1_next = (next_state == S1);
    assign Count_next = (next_state == Count);
    assign Wait_next = (next_state == Wait);

    // Output logic
    assign done = (state == Wait);
    assign counting = (state == Count);
    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);

endmodule