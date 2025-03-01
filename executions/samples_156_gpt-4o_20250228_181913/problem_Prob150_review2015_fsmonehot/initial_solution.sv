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

    // Next state logic
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        
        case (state)
            S: begin
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            S1: begin
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            S11: begin
                if (d)
                    S11_next = 1'b1;
                else
                    S110_next = 1'b1;
            end
            S110: begin
                if (d)
                    B0_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            B0: B1_next = 1'b1;
            B1: B2_next = 1'b1;
            B2: B3_next = 1'b1;
            B3: Count_next = 1'b1;
            Count: begin
                if (done_counting)
                    Wait_next = 1'b1;
                else
                    Count_next = 1'b1;
            end
            Wait: begin
                if (ack)
                    S_next = 1'b1;
                else
                    Wait_next = 1'b1;
            end
            default: S_next = 1'b1;
        endcase
    end

    // Output logic
    always @(*) begin
        shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);
        counting = (state == Count);
        done = (state == Wait);
    end

endmodule