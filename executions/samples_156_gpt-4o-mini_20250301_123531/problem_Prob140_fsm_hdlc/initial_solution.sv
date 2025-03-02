module TopModule (
    input logic clk,            // Clock signal
    input logic reset,          // Synchronous active-high reset
    input logic in,             // Serial data input
    output logic disc,          // Discard signal
    output logic flag,          // Frame boundary signal
    output logic err            // Error signal
);

    typedef enum logic [3:0] {
        State0 = 4'b0000,
        State1 = 4'b0001,
        State2 = 4'b0010,
        State3 = 4'b0011,
        State4 = 4'b0100,
        State5 = 4'b0101,
        State6 = 4'b0110,
        State7 = 4'b0111,
        Error  = 4'b1000
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= State0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;

        case (current_state)
            State0: begin
                if (in == 1'b0) begin
                    next_state <= State1;
                end else begin
                    next_state <= State0;
                end
            end
            State1: begin
                if (in == 1'b1) begin
                    next_state <= State2;
                end else begin
                    next_state <= State0;
                end
            end
            State2: begin
                if (in == 1'b1) begin
                    next_state <= State3;
                end else begin
                    next_state <= State0;
                end
            end
            State3: begin
                if (in == 1'b1) begin
                    next_state <= State4;
                end else begin
                    next_state <= State0;
                end
            end
            State4: begin
                if (in == 1'b1) begin
                    next_state <= State5;
                end else begin
                    next_state <= State0;
                end
            end
            State5: begin
                if (in == 1'b1) begin
                    next_state <= State6;
                end else begin
                    next_state <= State0;
                end
            end
            State6: begin
                if (in == 1'b0) begin
                    disc <= 1'b1;
                    next_state <= State7;
                end else begin
                    next_state <= Error;
                end
            end
            State7: begin
                if (in == 1'b0) begin
                    flag <= 1'b1;
                    next_state <= State1;
                end else begin
                    next_state <= State0;
                end
            end
            Error: begin
                err <= 1'b1;
                next_state <= State0;
            end
            default: begin
                next_state <= State0;
            end
        endcase
    end

endmodule