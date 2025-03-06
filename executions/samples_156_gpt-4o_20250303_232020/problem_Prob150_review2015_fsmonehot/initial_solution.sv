module TopModule(
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state, // One-hot encoded current state
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    // Next-State Logic
    always @(*) begin
        S_next = (state == 10'b0000000001);
        S1_next = (state == 10'b0000000010);
        B3_next = (state == 10'b0010000000);
        Count_next = (state == 10'b0100000000);
        Wait_next = (state == 10'b1000000000);
    end

    // Output Logic
    always @(*) begin
        shift_ena = (state == 10'b0000010000) || (state == 10'b0000100000) || 
                    (state == 10'b0001000000) || (state == 10'b0010000000);
        counting = (state == 10'b0100000000);
        done = (state == 10'b1000000000);
    end

endmodule