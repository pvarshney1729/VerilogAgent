module TopModule (
    input logic clk,
    input logic reset,
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

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            S_next <= 1'b1;
            S1_next <= 1'b0;
            B3_next <= 1'b0;
            Count_next <= 1'b0;
            Wait_next <= 1'b0;
        end else begin
            S_next <= (state == 10'b0000000001 && d == 0) || 
                      (state == 10'b0000000010 && d == 0) || 
                      (state == 10'b0000010000 && ack == 1);
            S1_next <= (state == 10'b0000000001 && d == 1);
            B3_next <= (state == 10'b0000001000);
            Count_next <= (state == 10'b0000100000 && done_counting == 0);
            Wait_next <= (state == 10'b0000100000 && done_counting == 1);
        end
    end

    // Output Logic
    always_comb begin
        shift_ena = (state == 10'b0000001000) || 
                    (state == 10'b0000010000) || 
                    (state == 10'b0000100000) || 
                    (state == 10'b0001000000);
        counting = (state == 10'b0000100000);
        done = (state == 10'b1000000000);
    end

endmodule