module TopModule (
    input logic clk,
    input logic rst_n,
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

    logic [9:0] current_state, next_state;

    // State encoding
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (current_state)
            S: begin
                if (d) begin
                    next_state = S1;
                    S1_next = 1'b1;
                end
            end
            S1: begin
                if (d) begin
                    next_state = S11;
                    S1_next = 1'b1;
                end else begin
                    next_state = S;
                    S_next = 1'b1;
                end
            end
            S11: begin
                if (~d) begin
                    next_state = S110;
                end
            end
            S110: begin
                if (~d) begin
                    next_state = S;
                    S_next = 1'b1;
                end else begin
                    next_state = B0;
                    B3_next = 1'b1; // Not used here, but kept for consistency
                end
            end
            B0: begin
                next_state = B1;
                shift_ena = 1'b1;
            end
            B1: begin
                next_state = B2;
                shift_ena = 1'b1;
            end
            B2: begin
                next_state = B3;
                shift_ena = 1'b1;
            end
            B3: begin
                next_state = B0;
                shift_ena = 1'b1;
            end
            Count: begin
                if (done_counting) begin
                    next_state = Wait;
                    Wait_next = 1'b1;
                end
            end
            Wait: begin
                if (ack) begin
                    next_state = S;
                    S_next = 1'b1;
                end
            end
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (~rst_n) begin
            current_state <= S; // Reset to state S
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign counting = (current_state == Count);
    assign done = (current_state == Wait);

endmodule